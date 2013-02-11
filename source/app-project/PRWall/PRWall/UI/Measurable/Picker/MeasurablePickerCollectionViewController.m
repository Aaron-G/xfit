//
//  MeasurablePickerCollectionViewController.m
//  PR Wall
//
//  Created by Cleo Barretto on 1/2/13.
//
//

#import "MeasurablePickerCollectionViewController.h"
#import "UIHelper.h"
#import "MeasurablePickerCollectionViewCell.h"
#import "MeasurablePickerTableViewController.h"

@interface MeasurablePickerCollectionViewController ()

@property id<MeasurablePickerDelegate> delegate;
@property NSArray* measurables;
@property MeasurableCategory* measurableCategory;

@property (readonly) NSArray* pickerScreenPredicates;
@property (readonly) NSArray* pickerScreenTitles;
@property (readonly) NSArray* pickerScreenImages;
@property (readonly) NSArray* pickerScreenEmptyMessages;

@property NSInteger indexOfMostRelevantScreen;

@end

@implementation MeasurablePickerCollectionViewController

static NSInteger FAVORITE_MEASURABLES_INDEX = 0;
static NSInteger RECENT_MEASURABLES_INDEX = 1;
static NSInteger USER_MEASURABLES_INDEX = 2;
static NSInteger SYSTEM_MEASURABLES_INDEX = 3;

@synthesize pickerScreenTitles = _pickerScreenTitles;
@synthesize pickerScreenImages = _pickerScreenImages;
@synthesize pickerScreenPredicates = _pickerScreenPredicates;
@synthesize pickerScreenEmptyMessages = _pickerScreenEmptyMessages;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  
  if(self) {
    self.indexOfMostRelevantScreen = -1;
  }
  return self;
}

- (void) pickMeasurableOfType:(MeasurableCategory*) measurableCategory fromMeasurables:(NSArray*) measurables withDelegate:(id<MeasurablePickerDelegate>) delegate {
  self.measurables = measurables;
  self.delegate = delegate;
  self.measurableCategory = measurableCategory;
}

- (NSArray*) pickerScreenPredicates {

  if(!_pickerScreenPredicates) {
    
    NSPredicate* favoritePredicate = [NSPredicate predicateWithFormat:@"(metadata.favorite == YES)"];
    NSDate* twoWeeksAgo = [NSDate dateWithTimeInterval:(-2*7*24*60*60) sinceDate:[NSDate date]];
    NSPredicate* recentPredicate = [NSPredicate predicateWithFormat:@"(data.date >= %@)", twoWeeksAgo];
    NSPredicate* userPredicate = [NSPredicate predicateWithFormat:@"(metadata.source == %i)", MeasurableSourceUser];
    NSPredicate* systemPredicate = [NSPredicate predicateWithFormat:@"(metadata.source == %i)", MeasurableSourceApp];
    NSPredicate* allPredicate = [NSPredicate predicateWithFormat:@"(TRUEPREDICATE)"];

    _pickerScreenPredicates = [NSArray arrayWithObjects:favoritePredicate, recentPredicate, userPredicate, systemPredicate, allPredicate, nil];
  }
  
  return _pickerScreenPredicates;
}

- (NSArray*) pickerScreenTitles {
  
  if(!_pickerScreenTitles) {
    
    NSString* favoriteTitle = NSLocalizedString(@"favorite-label", @"Favorite");
    NSString* recentTitle = NSLocalizedString(@"recent-label", @"Recent");
    NSString* userTitle = [NSString stringWithFormat:NSLocalizedString(@"measurable-picker-user-label-format", @"My %@"), self.measurableCategory.namePlural];
    NSString* systemTitle = self.measurableCategory.namePlural;
    NSString* allTitle = [NSString stringWithFormat:NSLocalizedString(@"measurable-picker-all-label-format", @"All %@"), self.measurableCategory.namePlural];
    
    _pickerScreenTitles = [NSArray arrayWithObjects:favoriteTitle, recentTitle, userTitle, systemTitle, allTitle, nil];
  }
  
  return _pickerScreenTitles;
}

- (NSArray*) pickerScreenImages {
  
  if(!_pickerScreenImages) {
    
    NSString* favoriteImage = @"favorite-icon";
    NSString* recentImage = @"recent-icon";
    NSString* userImage = @"default-user-profile-image";
    NSString* systemImage = @"Icon";
    NSString* allImage = @"blank-icon";
    
    _pickerScreenImages = [NSArray arrayWithObjects:favoriteImage, recentImage, userImage, systemImage, allImage, nil];
  }
  
  return _pickerScreenImages;
}

- (NSArray*) pickerScreenEmptyMessages {
  
  if(!_pickerScreenEmptyMessages) {
    
    NSString* favoriteMessage = [NSString stringWithFormat:NSLocalizedString(@"measurable-picker-favorite-empty-message-format", @"There are no %@ marked as Favorite"), self.measurableCategory.namePlural];
    NSString* recentMessage = [NSString stringWithFormat:NSLocalizedString(@"measurable-picker-recent-empty-message-format", @"There are no %@ logged in the last 2 weeks"), self.measurableCategory.namePlural];
    NSString* userMessage = [NSString stringWithFormat:NSLocalizedString(@"measurable-picker-user-empty-message-format", @"There are no %@ created by you" ), self.measurableCategory.namePlural];
    
    _pickerScreenEmptyMessages = [NSArray arrayWithObjects:favoriteMessage, recentMessage, userMessage, nil];
  }
  
  return _pickerScreenEmptyMessages;
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  MeasurablePickerCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MeasurablePickerCollectionViewCell" forIndexPath:indexPath];
  
  //Configure Table View Controller
  MeasurablePickerTableViewController* measurablePickerTableViewController = [[MeasurablePickerTableViewController alloc] init];
  measurablePickerTableViewController.measurablePickerDelegate = self.delegate;
  measurablePickerTableViewController.measurables = self.measurables;
  measurablePickerTableViewController.tablePredicate = [self.pickerScreenPredicates objectAtIndex:indexPath.item];

  //Link up the table view
  cell.measurablePickerTableViewController = measurablePickerTableViewController;
  cell.tableView.delegate = measurablePickerTableViewController;
  cell.tableView.dataSource = measurablePickerTableViewController;
  cell.title.text = [self.pickerScreenTitles objectAtIndex:indexPath.item];
  
  UIImage* image = [UIImage imageNamed:[self.pickerScreenImages objectAtIndex:indexPath.item]];
  [cell.image setImage: image forState:UIControlStateNormal];

  //Update most relevant index
  [self updateIndexOfMostRelevantScreenWithMeasurables:measurablePickerTableViewController.measurables atIndex:indexPath.item];
  
  //Update message
  [self updateMessageTextForMeasurablePickerCollectionViewCell:cell atIndex:indexPath.item];

  //Display the data
  [cell.tableView reloadData];
  
  return cell;
}

-(void) updateIndexOfMostRelevantScreenWithMeasurables:(NSArray*) measurables atIndex:(NSInteger) index {

  //Any of these is cool - no need to further update the index.
  if(self.indexOfMostRelevantScreen == FAVORITE_MEASURABLES_INDEX || self.indexOfMostRelevantScreen == RECENT_MEASURABLES_INDEX || self.indexOfMostRelevantScreen == USER_MEASURABLES_INDEX || self.indexOfMostRelevantScreen == SYSTEM_MEASURABLES_INDEX) {
    return;
  }
  
  if(measurables.count > 0) {
    self.indexOfMostRelevantScreen = index;
  } else {
    dispatch_async(dispatch_get_main_queue(), ^{
      [self scrollToScreeAtIndex:(index+1) animated:NO];
    });
  }
}

- (void)scrollToScreeAtIndex:(NSInteger)index animated:(BOOL)animated {
  
  NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
  
  [self.collectionView scrollToItemAtIndexPath:indexPath
                              atScrollPosition:UICollectionViewScrollPositionNone
                                      animated:animated];
}

- (void) updateMessageTextForMeasurablePickerCollectionViewCell:(MeasurablePickerCollectionViewCell*) cell atIndex:(NSInteger) index {

  if(index >= SYSTEM_MEASURABLES_INDEX) {
    cell.message.hidden = YES;
    return;
  }

  if(cell.measurablePickerTableViewController.measurables.count == 0) {
    cell.message.hidden = NO;
    cell.message.text = [self.pickerScreenEmptyMessages objectAtIndex:index];
  } else {
    cell.message.hidden = YES;
  }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  
  //Update the page control
  self.pickerPageControl.currentPage = scrollView.contentOffset.x/scrollView.bounds.size.width;
}

@end
