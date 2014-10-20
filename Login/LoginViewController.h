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
    NSMutableString* _ltStr;
    NSMutableString* _exeuStr;
    NSMutableString* _subStr;
}

@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *pwdName;
@property (strong) NSMutableString* ltStr;
@property (strong) NSMutableString* exeuStr;
@property (strong) NSMutableString* subStr;

- (IBAction)login:(id)sender;
- (void) getForms;
- (void) postForms;


@end
