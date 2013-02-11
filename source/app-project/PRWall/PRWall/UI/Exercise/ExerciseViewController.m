//
//  ExerciseViewController.m
//  PR Wall
//
//  Created by Cleo Barretto on 8/8/12.
//
//

#import "ExerciseViewController.h"
#import "AppViewController.h"
#import "ExerciseScreenSwitchDelegate.h"
#import "UIHelper.h"
#import "App.h"
#import "Exercise.h"
#import "MeasurableHelper.h"
#import "MeasurablePickerCollectionViewController.h"
#import "MeasurablePickerContainerViewController.h"
#import "MeasurablePickerDelegate.h"
#import "ModelHelper.h"

@interface ExerciseViewController () <MeasurableInfoEditViewControllerDelegate, MeasurablePickerDelegate, MeasurableDataEntryDelegate> {
}

@property AppViewController* appViewController;

//The version of the exercise list being displayed
//This is different than the one from User Profile
//because the list can be sorted by different criteria
@property NSArray* exercises;
@property MeasurableSortCriterion sortCriterion;
@property IBOutlet UITableView* tableView;
@property IBOutlet UISegmentedControl* sortSegmentedControl;

- (IBAction) changeSortCriterion:(id)sender;

@end


@implementation ExerciseViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  
  if(self) {
    self.appScreenSwitchDelegate = [[ExerciseScreenSwitchDelegate alloc]initWithViewController:self];
    self.appViewController = [UIHelper appViewController];
    self.sortCriterion = MeasurableSortCriterionName;
  }
  
  return self;
}

-(void)viewDidLoad {
  
  //Register custom cell
  [self.tableView registerNib: [UINib nibWithNibName:@"MeasurableTableViewCell" bundle:nil] forCellReuseIdentifier:@"MeasurableTableViewCell"];
  
  [super viewDidLoad];

  //Configure the segmented control
  [self.sortSegmentedControl setTitle:NSLocalizedString(@"sort-by-name-label", @"Name") forSegmentAtIndex:0];
  [self.sortSegmentedControl setTitle:NSLocalizedString(@"sort-by-date-label", @"Date") forSegmentAtIndex:1];
  [UIHelper applyFontToSegmentedControl:self.sortSegmentedControl];

  [self.appScreenSwitchDelegate initialize];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  [self reloadView];
  
  [self.appScreenSwitchDelegate updateBars];
}

- (void) reloadView {
  [self reloadViewWithExercises:[MeasurableHelper measurablesWithData:[App sharedInstance].userProfile.exercises]];
}

- (void) reloadViewWithExercises:(NSArray*) exercises {

  self.exercises = [MeasurableHelper sortMeasurables:exercises byMeasurableSortCriterion:self.sortCriterion];
  
  [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  return [MeasurableHelper tableViewCellForMeasurable:[self.exercises objectAtIndex:indexPath.item] inTableView:tableView];
}

//Add proper behavior to cell selection
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
  MeasurableViewController* measurableViewController = [UIHelper measurableViewController];
  measurableViewController.measurable = [self.exercises objectAtIndex:indexPath.item];
  measurableViewController.delegate = self;
  
  [UIHelper showViewController:measurableViewController asModal:NO withTransitionTitle:@"Exercises to Exercise"];
  
  //Hide it after a bit
  [self clearCurrentSelectionInABit];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.exercises.count;
}

- (void) clearCurrentSelectionInABit {
  [UIHelper clearSelectionInTableView:self.tableView afterDelay:0.1];
}

- (void)newExerciseAction {
  MeasurableInfoEditViewController* measurableInfoEditViewController
    = [MeasurableHelper measurableInfoEditViewControllerForMeasurableCategoryIdentifier:MeasurableCategoryIdentifierExercise];
  measurableInfoEditViewController.delegate = self;
  
  [measurableInfoEditViewController createMeasurableInfo];
}

- (void)logExerciseAction {
  
  MeasurableCategory* measurableCategory = [MeasurableCategory measurableCategoryWithMeasurableCategoryIdentifier:MeasurableCategoryIdentifierExercise];
  
  MeasurablePickerContainerViewController* measurablePickerContainerViewController = [MeasurableHelper measurablePickerContainerViewController];
  [measurablePickerContainerViewController pickMeasurableOfCategory: measurableCategory fromMeasurables:[ModelHelper userProfile].exercises withTitle:[NSString stringWithFormat:NSLocalizedString(@"logger-screen-title-format", @"Log %@"), measurableCategory.name] withDelegate:self];

}

- (IBAction) changeSortCriterion:(id)sender {
  
  dispatch_async(dispatch_get_main_queue(), ^{

    //Determine the new sort criterion
    NSInteger index = ((UISegmentedControl*)sender).selectedSegmentIndex;
    
    MeasurableSortCriterion sortCriterion = -1;
    
    if(index == 0) {
      sortCriterion = MeasurableSortCriterionName;
    } else if(index == 1) {
      sortCriterion = MeasurableSortCriterionDate;
    }
    
    assert(sortCriterion != -1);

    //Update property
    self.sortCriterion = sortCriterion;
    
    //Reload view
    [self reloadViewWithExercises:self.exercises];
  });
}


#pragma mark - MeasurableInfoEditViewControllerDelegate
- (void)didCreateMeasurableInfoForMeasurable:(Measurable*)measurable {
  [self loadNewExercise:measurable];
}

- (void)didEditMeasurableInfoForMeasurable:(Measurable*)measurable {
  //Not used
}

- (void) didDeleteMeasurableInfoForMeasurable:(Measurable*) measurable {
  //Not used
}

#pragma mark - MeasurableViewControllerDelegate

- (void)didChangeMeasurable:(Measurable*)measurable {
  
  //Some aspect of the measurable was changed, but it still has data entries
  if(measurable.data.values.count > 0) {
    [self reloadViewWithExercises:self.exercises];
  }
  
  //No more data entries - so reload the view
  else {
    [self reloadView];
  }
}

- (void)didDeleteMeasurable:(Measurable*)measurable {
  [self reloadView];
}

- (void)didCreateMeasurable:(Measurable*)measurable {
  [self loadNewExercise:(Exercise*)measurable];
}

- (void)loadNewExercise:(Measurable*)exercise {

  if(![MeasurableHelper updateDataStructureForNewMeasurable:exercise]) {
    NSLog(@"COULD NOT SAVE NEW EXERCISE");
    //CXB_HANDLE
    return;
  }
  
  [self reloadView];
}

#pragma mark - MeasurablePickerDelegate

- (void)didPickMeasurable:(Measurable*)measurable {
  MeasurableDataEntryViewController* measurableDataEntryViewController = [MeasurableHelper measurableDataEntryViewController];
  [measurableDataEntryViewController createMeasurableDataEntryInMeasurable:measurable withDelegate:self];
}

-(void)didFinishCreatingMeasurableDataEntry:(MeasurableDataEntry *)measurableDataEntry inMeasurable: (Measurable*) measurable {
  
  [[UIHelper appViewController].navigationController popToRootViewControllerAnimated:YES];
  
  [self reloadView];
}

-(void)didCancelCreatingMeasurableDataEntry:(MeasurableDataEntry *)measurableDataEntry inMeasurable: (Measurable*) measurable {
}

-(void)didFinishEditingMeasurableDataEntry:(MeasurableDataEntry *)measurableDataEntry inMeasurable: (Measurable*) measurable {
}

@end
