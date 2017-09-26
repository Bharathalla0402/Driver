//
//  ViewController.m
//  GetUsDriver
//
//  Created by bharat on 06/04/16.
//  Copyright © 2016 Bharat. All rights reserved.
//


#import "ViewController.h"
#import "UserInformation.h"
#import "DejalActivityView.h"
#import "ForgotPasswordViewController.h"
#import "RegistrationViewController.h"
#import "SidebarViewController.h"
#import "GetUsHere.pch"
#import "RiderRequestConformViewController.h"
#import "UpcomingRidesViewController.h"
#import "CancelledViewController.h"
#import "Api.h"
#import "Reachability.h"

@interface ViewController ()
{
    UserInformation *userInfo;
    
}
@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
  
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back.jpg"]];
        
    arrname=[[NSMutableArray alloc]init];
    str=[[NSString alloc]init];
    
    NSAttributedString *strname = [[NSAttributedString alloc] initWithString:@"Enter Your Mobile number/Email Id" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtUserName.attributedPlaceholder = strname;
    _txtUserName.textColor=[UIColor purpleColor];
    
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtPwd.attributedPlaceholder = str1;
     self.txtPwd.textColor = [UIColor purpleColor];
    
    _loginbutt.layer.cornerRadius = 10; // this value vary as per your desire
    _loginbutt.clipsToBounds = YES;
    _loginbutt.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _emailview.layer.masksToBounds = YES;
    _emailview.layer.cornerRadius = 19.0;
    _emailview.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
    
    _passwordview.layer.masksToBounds = YES;
    _passwordview.layer.cornerRadius = 19.0;
    _passwordview.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
      _forgotbutt.tintColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
//    _txtUserName.textColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
//    _txtPwd.textColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    
        self.title = @"SIGN IN";
       self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
//                                       
//                                       initWithTarget:self
//                                       
//                                       action:@selector(dismissKeyboard)];
//        
//        [self.view addGestureRecognizer:tap];
    
        [[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        
        
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
        
        
        strdevicetoken=[[NSUserDefaults standardUserDefaults]valueForKey:@"devicetoken"];
        
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        
        self.txtUserName.delegate =self;
        self.txtPwd.delegate = self;
    
    [self.revealViewController.view removeGestureRecognizer:self.revealViewController.panGestureRecognizer];
//    SWRevealViewController *reveal = self.revealViewController;
//    reveal.panGestureRecognizer.enabled = NO;
    
//        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Remember"]) {
//            self.txtUserName.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"Email"];
//            self.txtPwd.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
//            checked =YES;
//            
//            [Checkbox setImage:[UIImage imageNamed:@"remember check2.png"] forState:UIControlStateNormal];
//        }else
//        {
//            self.txtUserName.text=@"";
//            self.txtPwd.text=@"";
//            checked =NO;
//            [Checkbox setImage:[UIImage imageNamed:@"remember Check.png"] forState:UIControlStateNormal];
//        }
    
        name=[[NSMutableArray alloc]init];
        userInfo=[[UserInformation alloc] init];
    
     [self setupOutlets];
}

- (void)setupOutlets
{
    self.txtUserName.delegate = self;
    self.txtUserName.tag = 1;
    
    self.txtPwd.delegate = self;
    self.txtPwd.tag = 2;
}

#pragma mark -- checkNetworkStatus
-(void)checkNetworkStatus{
    Reachability* internetAvailable = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [internetAvailable currentReachabilityStatus];
    switch (internetStatus)
    {
        case NotReachable:{
            NSLog(@"The internet is down.");
            _isInternetConnectionAvailable = NO;
            break;
        }
        case ReachableViaWiFi:{
            _isInternetConnectionAvailable = YES;
            NSLog(@"The internet is working via WIFI.");
            break;
        }
        case ReachableViaWWAN:{
            _isInternetConnectionAvailable = YES;
            NSLog(@"The internet is working via WWAN.");
            break;
        }
    }
}
#pragma mark -- UIAlertView Method
-(void)showMessage:(NSString*)message withTitle:(NSString *)title{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
    });
}


- (void)jumpToNextTextField:(UITextField *)textField withTag:(NSInteger)tag
{
    UIResponder *nextResponder = [self.view viewWithTag:tag];
    
    if ([nextResponder isKindOfClass:[UITextField class]])
    {
        [nextResponder becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
}


- (void)dismissKeyboard
{
    [self.txtUserName resignFirstResponder];
    
    [self.txtPwd resignFirstResponder];
}


- (IBAction)LoginClicked:(id)sender
{
    _txtUserName.text =[_txtUserName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    _txtPwd.text=[_txtPwd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    
    if (_txtUserName.text.length==0)
    {
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Warning" message:@"Please Enter Your EmailId/Mobile Number" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *button=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:button];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
    
    else if (_txtPwd.text.length==0)
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Warning" message:@"Please Enter Your Password" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *button=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:button];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
    else
    {
        
        [self checkNetworkStatus];
        
        if (_isInternetConnectionAvailable == NO)  {
            
            [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
             
                    withTitle:@"message"];
            
        }else
        {
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        [self next];
            
        }
    }
    
}


-(void)next
{
//     NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,loginform]]];
//    
//    request.HTTPMethod = @"POST";
//    
//    NSMutableString* profile = [NSMutableString string];
//    
//    [profile appendString:[NSString stringWithFormat:@"mobile_no=%@", self.txtUserName.text]];
//    [profile appendString:[NSString stringWithFormat:@"&password=%@", self.txtPwd.text]];
//    [profile appendString:[NSString stringWithFormat:@"&device_id=%@", [[NSUserDefaults standardUserDefaults]valueForKey:@"devicetoken"]]];
//    [profile appendString:[NSString stringWithFormat:@"&os=%@", @"ios"]];
//    [profile appendString:[NSString stringWithFormat:@"&user_type=%@", @"driver"]];
//    
//    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
//    
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//                               if (error) {
//                                   // Handle error
//                                   //[self handleError:error];
//                               } else {
//                                   [self parseJSONResponse:data];
//                               }
//                           }];
    
    NSString *post = [NSString stringWithFormat:@"mobile_no=%@&password=%@&device_id=%@&os=%@&user_type=%@",self.txtUserName.text,self.txtPwd.text,[[NSUserDefaults standardUserDefaults]valueForKey:@"devicetoken"],@"ios", @"driver"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *strurl=[NSString stringWithFormat:@"%@%@",BaseUrl,loginform];
    [request setURL:[NSURL URLWithString:strurl]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
          
            if (error)
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Check the Internet Settings and Try again" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
            } else
            {
                 [self parseJSONResponse:data];
            }
            
        });
    }] resume];
}

-(void)parseJSONResponse:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
    
    
 //   NSLog(@"*****login details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    NSString *code=[responseJSON valueForKey:@"message"];
   
 //   NSLog(@"%@",code);
   
    
   
    // NSLog(@"%@",DataArray);
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        if (([[NSString stringWithFormat:@"%@",code] isEqualToString:@"0"]))
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"message" message:[responseJSON valueForKey:@"code"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
            [alert show];
        }
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        
        str=[[responseJSON valueForKey:@"data"]valueForKey:@"name"];
        strNmae=[[responseJSON valueForKey:@"data"]valueForKey:@"email"];
        deviceid=[[responseJSON valueForKey:@"data"]valueForKey:@"device_id"];
        riderid=[[responseJSON valueForKey:@"data"]valueForKey:@"user_id"];
        strtotaltrips=[[responseJSON valueForKey:@"data"]valueForKey:@"total_trip"];
        strcancelltrips=[[responseJSON valueForKey:@"data"]valueForKey:@"canceled_trip"];
        mobile=[[responseJSON valueForKey:@"data"]valueForKey:@"mobile_no"];
        strimageurl=[[responseJSON valueForKey:@"data"]valueForKey:@"image"];
        NSLog(@"name:   %@",str);
        
        [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"named"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:strNmae forKey:@"email"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:deviceid forKey:@"device"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:riderid forKey:@"rid"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:riderid forKey:@"UID"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:mobile forKey:@"phone"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:strtotaltrips forKey:@"total"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:strcancelltrips forKey:@"cancelled"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:strimageurl forKey:@"imag"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[UserInformation sharedController] updateuserinfo:responseJSON];
        
        NSData *encode = [NSKeyedArchiver archivedDataWithRootObject:[UserInformation sharedController]];
        [[NSUserDefaults standardUserDefaults] setObject:encode forKey:@"name"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        //  [self performSegueWithIdentifier:@"rider" sender:nil];
        
        
        [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"Login"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        

        
        SidebarViewController *side=[self.storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"];
        [self.navigationController pushViewController:side animated:YES];
        
    }
}

- (IBAction)ForgotPasswordClicked:(id)sender
{
    ForgotPasswordViewController *bookTax=[self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordViewController"];
    [self.navigationController pushViewController:bookTax animated:YES];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nextTag = textField.tag + 1;
    [self jumpToNextTextField:textField withTag:nextTag];
    return NO;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -50; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}


-(void)viewWillAppear:(BOOL)animated
{
    
     self.title = @"SIGN IN";
    strdevicetoken=[[NSUserDefaults standardUserDefaults]valueForKey:@"devicetoken"];
    NSLog(@"%@",strdevicetoken);
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewDidDisappear:(BOOL)animated
{
    self.title = @"";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
     [DejalBezelActivityView removeView];
    
    [self.revealViewController.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
//    SWRevealViewController *reveal = self.revealViewController;
//    reveal.panGestureRecognizer.enabled = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
