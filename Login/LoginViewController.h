//
//  LoginViewController.h
//  Login
//
//  Created by Ge-Yunsheng on 2014/09/11.
//
//

#import <UIKit/UIKit.h>
//#import "ASIFormDataRequest.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate>
{
   
}

@property (strong, nonatomic) IBOutlet UITextField *userName;

- (IBAction)login:(id)sender;


@end
