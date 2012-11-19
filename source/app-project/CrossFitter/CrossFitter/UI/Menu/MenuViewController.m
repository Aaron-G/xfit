//
//  MenuViewController.m
//  CrossFitter
//
//  Created by Cleo Barretto on 8/10/12.
//
//
#import "MenuViewController.h"
#import "MenuCell.h"
#import "AppScreen.h"
#import "App.h"
#import "AppViewController.h"
#import "UIHelper.h"

@interface MenuViewController () {
}

@property NSString *homeImageName;
@property NSString *prwallImageName;
@property NSString *wodImageName;
@property NSString *workoutImageName;
@property NSString *moveImageName;
@property NSString *mybodyImageName;
@property NSString *infoImageName;

@end

@implementation MenuViewController 

-(id)initWithCoder:(NSCoder *)aDecoder {
  
  self = [super initWithCoder:aDecoder];
  if(self) {
    
    self.homeImageName = @"home-screen-app-menu.png";
    self.prwallImageName = @"prwall-screen-app-menu.png";
    self.wodImageName = @"wod-screen-app-menu.png";
    self.workoutImageName = @"workout-screen-app-menu.png";
    self.moveImageName = @"move-screen-app-menu.png";
    self.mybodyImageName = @"mybody-screen-app-menu.png";
    self.infoImageName = @"info-screen-app-menu.png";
  }
  return self;
}

-(void)viewDidLoad
{
  [super viewDidLoad];
  
  [self.collectionView registerClass:[MenuCell class] forCellWithReuseIdentifier:@"MenuCell"];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
  if(section == 0) {
    //7 App Menu options
    return 7;
  } else {
    return 0;
  }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
  MenuCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MenuCell" forIndexPath:indexPath];
  
  NSString *imageName = nil;  
  SEL action = nil;
  
  AppScreenIdentifier screenIdentifier = [AppScreen appScreenForScreenIndex:indexPath.item];
  
  if(screenIdentifier == AppScreenIdentifierHome) {
    imageName = self.homeImageName;
    action = @selector(displayHome);
  } else if(screenIdentifier == AppScreenIdentifierPRWall) {
    imageName = self.prwallImageName;
    action = @selector(displayPRWall);
  } else if(screenIdentifier == AppScreenIdentifierWOD) {
    imageName = self.wodImageName;
    action = @selector(displayWOD);
  } else if(screenIdentifier == AppScreenIdentifierWorkout) {
    imageName = self.workoutImageName;
    action = @selector(displayWorkout);
  } else if(screenIdentifier == AppScreenIdentifierMove) {
    imageName = self.moveImageName;
    action = @selector(displayMove);
  } else if(screenIdentifier == AppScreenIdentifierMyBody) {
    imageName = self.mybodyImageName;
    action = @selector(displayMyBody);
  } else if(screenIdentifier == AppScreenIdentifierInfo) {
    imageName = self.infoImageName;
    action = @selector(displayInfo);
  }
  
  if(imageName) {
    UIImage *image = [UIImage imageNamed:imageName];
    [cell.button setBackgroundImage:image forState:UIControlStateNormal];
    
    //Remove the previous target
    [cell.button removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
    
    //Add the new target
    [cell.button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
  }
  
  return cell;
}

- (void) displayAppScreen: (AppScreenIdentifier) appScreen {
  AppViewController* appViewController = [UIHelper appViewController];
  [appViewController displayScreen:appScreen];
}

- (void) displayPRWall {
  [self displayAppScreen: AppScreenIdentifierPRWall];
}

- (void) displayMyBody {
  [self displayAppScreen: AppScreenIdentifierMyBody];
}

- (void) displayWorkout {
  [self displayAppScreen: AppScreenIdentifierWorkout];
}

- (void) displayWOD {
  [self displayAppScreen: AppScreenIdentifierWOD];
}

- (void) displayMove {
  [self displayAppScreen: AppScreenIdentifierMove];
}

- (void) displayInfo {
  [self displayAppScreen: AppScreenIdentifierInfo];
}

- (void) displayHome {
  [self displayAppScreen: AppScreenIdentifierHome];
}

@end

