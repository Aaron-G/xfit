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
  UserProfile* userProfile = [App sharedInstance].userProfile;
  [self reloadViewWithExercises:[MeasurableHelper measurablesWithData:[userProfile.exercises allValues]]];
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
    = [MeasurableHelper measurableInfoEditViewControllerForMeasurableTypeIdentifier:MeasurableTypeIdentifierExercise];
  measurableInfoEditViewController.delegate = self;
  
  [measurableInfoEditViewController createMeasurableInfo];
}

- (void)logExerciseAction {
  
  MeasurableType* measurableType = [MeasurableType measurableTypeWithMeasurableTypeIdentifier:MeasurableTypeIdentifierExercise];
  
  MeasurablePickerContainerViewController* measurablePickerContainerViewController = [MeasurableHelper measurablePickerContainerViewController];
  [measurablePickerContainerViewController pickMeasurableOfType: measurableType fromMeasurables:[App sharedInstance].userProfile.exercises.allValues withTitle:[NSString stringWithFormat:NSLocalizedString(@"logger-screen-title-format", @"Log %@"), measurableType.displayName] withDelegate:self];

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
- (void)didCreateMeasurableInfoForMeasurable:(id<Measurable>)measurable {
  [self loadNewExercise:(Exercise*)measurable];
}

- (void)didEditMeasurableInfoForMeasurable:(id<Measurable>)measurable {
  //Not used
}

- (void) didDeleteMeasurableInfoForMeasurable:(id<Measurable>) measurable {
  //Not used
}

#pragma mark - MeasurableViewControllerDelegate

- (void)didChangeMeasurable:(id<Measurable>)measurable {
  [self reloadViewWithExercises:self.exercises];
}

- (void)didDeleteMeasurable:(id<Measurable>)measurable {
  [self reloadView];
}

- (void)didCreateMeasurable:(id<Measurable>)measurable {
  [self loadNewExercise:(Exercise*)measurable];
}

- (void)loadNewExercise:(Exercise*)exercise {

  [MeasurableHelper updateDataStructureForNewMeasurable:exercise];
  
  [self reloadView];
}

#pragma mark - MeasurablePickerDelegate

- (void)didPickMeasurable:(id<Measurable>)measurable {
  MeasurableDataEntryViewController* measurableDataEntryViewController = [MeasurableHelper measurableDataEntryViewController];
  [measurableDataEntryViewController createMeasurableDataEntryInMeasurable:measurable withDelegate:self];
}

-(void)didFinishCreatingMeasurableDataEntry:(MeasurableDataEntry *)measurableDataEntry inMeasurable: (id<Measurable>) measurable {

  NSInteger index = [MeasurableHelper indexForMeasurableDataEntry:measurableDataEntry inMeasurable:measurable];
  
  NSMutableArray* newDataArray = [NSMutableArray arrayWithArray:measurable.dataProvider.values];
  
  [newDataArray insertObject:measurableDataEntry atIndex:index];
  
  measurable.dataProvider.values = newDataArray;
  
  [[UIHelper appViewController].navigationController popToRootViewControllerAnimated:YES];
  
  [self reloadView];
}
-(void)didCancelCreatingMeasurableDataEntry:(MeasurableDataEntry *)measurableDataEntry inMeasurable: (id<Measurable>) measurable {
}
-(void)didFinishEditingMeasurableDataEntry:(MeasurableDataEntry *)measurableDataEntry inMeasurable: (id<Measurable>) measurable {
}

@end
