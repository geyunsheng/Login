//
//  UserViewController.h
//  Login
//
//  Created by Ge-Yunsheng on 2014/09/12.
//
//

#import <UIKit/UIKit.h>
#import "UserEntry.h"
#import "SCNavigationController.h"

#define CAMERA 1

#if CAMERA
@interface UserViewController : UIViewController <SCNavigationControllerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, UIPopoverControllerDelegate>
#else
@interface UserViewController : UIViewController <SCNavigationControllerDelegate>

#endif
- (IBAction)cameToCamera:(id)sender;
- (IBAction)cancelButton:(id)sender;
- (IBAction)goToMap:(id)sender;

@property (retain, nonatomic) IBOutlet UILabel *userOn;
@property (retain, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (strong) UserEntry* userEntry;

@end
