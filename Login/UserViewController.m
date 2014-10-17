//
//  UserViewController.m
//  Login
//
//  Created by Ge-Yunsheng on 2014/09/12.
//
//

#import "UserViewController.h"
#import "ASIFormDataRequest.h"
#import "LoginViewController.h"
#import "MapViewController.h"

@interface UserViewController ()

@end

@implementation UserViewController

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
    // Do any additional setup after loading the view.
    self.userOn.text = self.userEntry.loginName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)logout:(id)sender
{
    ASIFormDataRequest* _request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"https://auth.cloudeven.com/logout"]];
    [_request setDelegate:self];
    [_request setValidatesSecureCertificate:NO];
    [_request setDidFinishSelector:@selector(Success:)];
    [_request setDidFailSelector:@selector(fail:)];
    [_request startAsynchronous];
}

- (IBAction)cancelButton:(id)sender
{
    if ([self.userOn.text isEqualToString:@"No User Login"])
    {
       /* UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController* loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:loginViewController ]autorelease];
        loginViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:nav animated:YES completion:NULL];
        */
        [self dismissViewControllerAnimated:YES completion:NULL];
    } else {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Need To Logout First" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
    }
}

- (IBAction)goToMap:(id)sender
{
    if ([self.userOn.text isEqualToString:@"No User Login"])
    {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Need To Login First" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
    } else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MapViewController* mapView = [storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
        [self.navigationController pushViewController:mapView animated:YES];
    }
 
}

- (void)Success:(ASIHTTPRequest *)request
{
/*
    NSData *data =[request responseData];
    NSString *htmlStr = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"%@",htmlStr);
*/
    if (![self.userOn.text isEqualToString:@"No User Login"])
    {
        self.userOn.text = @"No User Login";
        self.welcomeLabel.text = @"";
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Succeed to Logout" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
    }
}

- (void)fail:(ASIHTTPRequest *)request
{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Failed to Logout" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}

- (void)dealloc {
    [_userOn release];
    [_welcomeLabel release];
    [super dealloc];
}
@end
