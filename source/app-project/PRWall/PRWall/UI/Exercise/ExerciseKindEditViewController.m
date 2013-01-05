//
//  ExerciseKindEditViewController.m
//  PR Wall
//
//  Created by Cleo Barretto on 12/27/12.
//
//

#import "ExerciseKindEditViewController.h"
#import "UIHelper.h"

@interface ExerciseKindEditViewController ()

@property NSArray* exerciseKinds;

@property ExerciseKind* selectedExerciseKind;

@end

@implementation ExerciseKindEditViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
  
  self = [super initWithCoder:aDecoder];
  if (self) {
    self.exerciseKinds = [ExerciseKind exerciseKinds];
    self.title = NSLocalizedString(@"exercise-edit-kind-label", @"What kind");
  }
  return self;
}

- (void)viewDidLoad {
  
  [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  NSInteger indexOfSelectedKind = [self.exerciseKinds indexOfObject:self.selectedExerciseKind];
  if(indexOfSelectedKind >= 0) {
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:indexOfSelectedKind inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
  }
}

- (NSUInteger)supportedInterfaceOrientations {
  return [UIHelper supportedInterfaceOrientations];
}

- (void) editExerciseKind:(ExerciseKind*) exerciseKind {
  
  self.selectedExerciseKind = exerciseKind;
  [UIHelper showViewController:self asModal:NO withTransitionTitle:@"To Edit Exercise Kind"];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.exerciseKinds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"KindCell" forIndexPath:indexPath];
  
  ExerciseKind* exerciseKind = [self.exerciseKinds objectAtIndex: indexPath.item];
  
  if(exerciseKind == self.selectedExerciseKind) {
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
  } else {
    cell.accessoryType = UITableViewCellAccessoryNone;
  }
  
  cell.textLabel.text = exerciseKind.name;
  cell.detailTextLabel.text = exerciseKind.description;
  
  return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  ExerciseKind* newSelection = [self.exerciseKinds objectAtIndex:indexPath.item];
  
  if(newSelection != self.selectedExerciseKind) {
    
    NSArray* indexesToUpdate = [NSArray arrayWithObjects:[NSIndexPath indexPathForItem: [self.exerciseKinds indexOfObject:self.selectedExerciseKind] inSection:0], indexPath, nil];
    
    self.selectedExerciseKind = newSelection;
    
    [self.tableView reloadRowsAtIndexPaths:indexesToUpdate withRowAnimation:NO];
    
    [self.delegate didChangeExerciseKind: self.selectedExerciseKind];    
  }
}

@end
