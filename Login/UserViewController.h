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

@interface UserViewController : UIViewController <SCNavigationControllerDelegate>
- (IBAction)cameToCamera:(id)sender;
- (IBAction)cancelButton:(id)sender;
- (IBAction)goToMap:(id)sender;

@property (retain, nonatomic) IBOutlet UILabel *userOn;
@property (retain, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (strong) UserEntry* userEntry;

@end
