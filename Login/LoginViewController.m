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
//    if ((_userName.text.length == 0))
//    {
//        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil message:@"用户名不能为空" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alertView show];
//        [alertView release];
//        return;
//    }
//    [self.loginWait startAnimating];
//    
//    UserEntry* userEntry = [[[UserEntry alloc]init]autorelease];
//    userEntry.loginName = self.userName.text;
//
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UserViewController* userViewController = [storyboard instantiateViewControllerWithIdentifier:@"userhome"];
//    userViewController.userEntry = userEntry;
//    [self.navigationController pushViewController:userViewController animated:YES];
//
//    [self.loginWait stopAnimating];
    
    
//    NSRange range = {0,2};
//    NSMutableArray* array = [NSMutableArray arrayWithCapacity:10];
//    [array addObject:@"hello"];
//    [array addObject:@"hello2"];
//    [array addObject:@"hello3"];
//    [array addObject:@"hello4"];
//    [array addObject:@"hello5"];
//    [array addObject:@"hello6"];
//    [array replaceObjectAtIndex:2 withObject:@"replace"];
//    [array insertObject:@"insertObject" atIndex:1];
//    [array removeObjectsInRange:range];
//    for (NSString* str in array)
//    {
//        NSLog(@"%@",str);
//    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"obj1",@"key1",@"obj2",@"key2", nil];
    NSLog(@"%lu",(unsigned long)[dic count]);
    NSLog(@"the object of key1 is %@",[dic objectForKey:@"key1"]);
    NSEnumerator *enumKey = [dic keyEnumerator];
    for (NSObject* obj in enumKey)
    {
        NSLog(@"key is %@",obj);
        NSLog(@"object is %@",[dic objectForKey:obj]);
    }
    
}


- (void)dealloc
{
    [_userName release];
    [super dealloc];
}
@end
