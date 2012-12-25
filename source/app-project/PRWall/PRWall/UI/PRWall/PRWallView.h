//
//  PRWallView.h
//  PR Wall
//
//  Created by Cleo Barretto on 8/8/12.
//
//

#import <UIKit/UIKit.h>

/* View that displays the "gym" whiteboard.
 
 It will require 6 images:
 - Board top (landscape and portrait)
 - Board bottom (landscape and portrait)
 - Board middle stripe (landscape and portrait)
 
 It will compute the height needed based on the content and
 determine the number of stripes needed to fill in between
 the top and bottom parts.
 
 It will need to recompute itself during:
 - Orientation change
 - Content is added or removed from it (PRWall setting is
 changed for a given workout/exercise)
 
 It may contain 1 sub view that contains the text. This subview can provide easy access to the hight requirements that the main view can use to compute itself.
 */

@interface PRWallView : UIView

@end
