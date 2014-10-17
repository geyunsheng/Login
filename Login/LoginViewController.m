//
//  LoginViewController.m
//  Login
//
//  Created by Ge-Yunsheng on 2014/09/11.
//
//

#import "LoginViewController.h"
#import "UserViewController.h"
#import "UserEntry.h"

@interface LoginViewController ()

@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *loginWait;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _userName.delegate = self;
    _pwdName.delegate =self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 50 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
    {
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    }
    [UIView commitAnimations];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)login:(id)sender
{

   // NSString *title=[NSString stringWithContentsOfURL:[NSURL URLWithString:@"https://developer.apple.com/library/ios/navigation/"] encoding:NSUTF8StringEncoding error:nil];

    if ((_userName.text.length == 0)||(_pwdName.text.length == 0))
    {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil message:@"用户名或者密码不能为空" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
        return;
    }
    [self.loginWait startAnimating];
    [self getForms];
/*
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserViewController* userViewController = [storyboard instantiateViewControllerWithIdentifier:@"userhome"];
    UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:userViewController ]autorelease];
    userViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nav animated:YES completion:NULL];
 */
}

- (void) getForms
{
    ASIFormDataRequest* _request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"https://auth.cloudeven.com"]];
    [_request setDelegate:self];
    [_request setValidatesSecureCertificate:NO];
    [_request setDidFinishSelector:@selector(getSucceed:)];
    [_request setDidFailSelector:@selector(fail:)];
    [_request startAsynchronous];

}

- (void) postForms
{
    ASIFormDataRequest* _request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"https://auth.cloudeven.com/login"]];
    [_request setDelegate:self];
    [_request setValidatesSecureCertificate:NO];
    [_request setPostValue:_userName.text forKey:@"username"];
    [_request setPostValue:_pwdName.text forKey:@"password"];
    [_request setPostValue:self.ltStr forKey:@"lt"];
    [_request setPostValue:self.exeuStr forKey:@"execution"];
    [_request setPostValue:self.subStr forKey:@"_eventId"];
    
  //  [_request addRequestHeader:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
  //                       value:@"Accept"];
  //  [_request addRequestHeader:@"Mozila/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20100101 FireFox/17.0"
  //                       value:@"User-Agent"];
    
    [_request setDidFinishSelector:@selector(postSucceed:)];
    [_request setDidFailSelector:@selector(fail:)];
    [_request startAsynchronous];
}

- (void) getSucceed:(ASIHTTPRequest *)request
{
    NSData *data =[request responseData];
    NSString *htmlStr = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
// get lt
    NSRange rangeLt1 = [htmlStr rangeOfString:@"name=\"lt\" value=\""];
    NSMutableString* htmlLt = [[[NSMutableString alloc]initWithString:[htmlStr substringFromIndex:rangeLt1.location + rangeLt1.length] ] autorelease];
    NSRange rangeLt2 = [htmlLt rangeOfString:@"\" />"];
    self.ltStr = [[[NSMutableString alloc]initWithString:[htmlLt substringToIndex:rangeLt2.location] ] autorelease];
//  NSLog(@"%@",self.ltStr);
// get execution
    NSRange rangeExe1 = [htmlStr rangeOfString:@"name=\"execution\" value=\""];
    NSMutableString* htmlExe = [[[NSMutableString alloc]initWithString:[htmlStr substringFromIndex:rangeExe1.location + rangeExe1.length] ] autorelease];
    NSRange rangeExe2 = [htmlExe rangeOfString:@"\" />"];
    self.exeuStr = [[[NSMutableString alloc]initWithString:[htmlExe substringToIndex:rangeExe2.location] ] autorelease];
//   NSLog(@"%@",self.exeuStr);
// get _eventID
    NSRange rangeSub1 = [htmlStr rangeOfString:@"name=\"_eventId\" value=\""];
    NSMutableString* htmlSub = [[[NSMutableString alloc]initWithString:[htmlStr substringFromIndex:rangeSub1.location + rangeSub1.length] ] autorelease];
    NSRange rangeSub2 = [htmlSub rangeOfString:@"\" />"];
    self.subStr = [[[NSMutableString alloc]initWithString:[htmlSub substringToIndex:rangeSub2.location] ] autorelease];
//  NSLog(@"%@",self.subStr);
    
    [self postForms];
}

- (void) postSucceed:(ASIHTTPRequest *)request
{
  //  NSData *data =[request responseData];
 //   NSString *htmlStr = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
 //   NSLog(@"%@",htmlStr);
  //  UIAlertView* alertView;
   // if ([htmlStr rangeOfString:@"您已经成功登录中央认证系统"].location != NSNotFound)
   // {
        //登录成功，画面迁移到下一页面
        [self.loginWait stopAnimating];
        
        UserEntry* userEntry = [[UserEntry alloc]init];
        userEntry.loginName = self.userName.text;
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UserViewController* userViewController = [storyboard instantiateViewControllerWithIdentifier:@"userhome"];
        userViewController.userEntry = userEntry;
        UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:userViewController ]autorelease];
        userViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:nav animated:YES completion:NULL];
       
        // push
    //  [self.navigationController pushViewController:userViewController animated:YES];
        [userEntry release];
  /*
    } else {
        alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Failed To Login" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
        [self.loginWait stopAnimating];
    }
   */
}

- (void)fail:(ASIHTTPRequest *)request
{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Fail" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
    [self.loginWait stopAnimating];
}


- (void)dealloc
{
    [_userName release];
    [_pwdName release];
    [_loginWait release];
    [super dealloc];
}
@end
