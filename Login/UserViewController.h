//
//  UserViewController.h
//  Login
//
//  Created by Ge-Yunsheng on 2014/09/12.
//
//

#import <UIKit/UIKit.h>
#import "UserEntry.h"
//#import "SCNavigationController.h"

@interface UserViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, UIPopoverControllerDelegate>

- (IBAction)cameToCamera:(id)sender;
- (IBAction)cancelButton:(id)sender;
- (IBAction)goToMap:(id)sender;
- (IBAction)cameIntoPhoto:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imageCamera;
@property (retain, nonatomic) IBOutlet UILabel *userOn;
@property (strong) UserEntry* userEntry;

@end
