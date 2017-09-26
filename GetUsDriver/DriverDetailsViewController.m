//
//  DriverDetailsViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 28/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "DriverDetailsViewController.h"
#import "UpcomingCancelViewController.h"
#import "BookcancelViewController.h"
#import "GPSViewController.h"
#import "ChatVController.h"
#import "GetUsHere.pch"
#import "DejalActivityView.h"
#import "StartRideViewController.h"
#import "BookcancelViewController.h"
#import "SidebarViewController.h"
#import "UpcomingRidesViewController.h"
#import "StartRideViewController.h"
#import "UIImageView+WebCache.h"
#import "SplachscreenViewController.h"
#import "Reachability.h"

@interface DriverDetailsViewController ()

@end

@implementation DriverDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title=@"Rider Details";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];

    arrdetails=[[NSMutableArray alloc]init];
    arrdriverinfo=[[NSUserDefaults standardUserDefaults]objectForKey:@"driverinfo"];
    _txtname.text=[arrdriverinfo valueForKey:@"name"];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"b" style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(barButtonBackPressed:)];
    [backButton setImage:[UIImage imageNamed:@"Untitled-1-2.png"]];
    
    self.navigationItem.leftBarButtonItem = backButton;
  
    tripinfo=[[NSMutableArray alloc]init];
    Driverlocationdetails=[[NSMutableArray alloc]init];
    
    _topview.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _locationtitleView.textColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _locationlineview.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _profileImage.layer.cornerRadius = _profileImage.frame.size.height /2;
    _profileImage.layer.masksToBounds = YES;
    _profileImage.layer.borderWidth = 0;
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
    
    NSString *strurl=[arrdriverinfo valueForKey:@"image"];
    
    if (![strurl isEqualToString:@""])
    {
        [_profileImage sd_setImageWithURL:[NSURL URLWithString:strurl]
                      placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
    }
    
    _ArrivedatPickupLocationbutt.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _CancelRidebutt.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _detailview.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    
    _NavigateButton.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _pickuplab.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"pic"];
    _deslab.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"des"];
    strtripid=[[NSUserDefaults standardUserDefaults]objectForKey:@"tripid"];
    
    
    _estimateView.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    _distanceView.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
}

- (IBAction)backButtonClicked:(id)sender
{
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {

    self.view.userInteractionEnabled=NO;
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getTrips]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"driver"]];
    [profile appendString:[NSString stringWithFormat:@"&trip_type=%@",@"upcoming"]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONResp:data];
                               }
                           }];
    }
}



-(void)barButtonBackPressed:(id)sender
{
    //    SidebarViewController *side=[self.storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"];
    //    [self.navigationController pushViewController:side animated:YES];
    
      [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getTrips]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"driver"]];
    [profile appendString:[NSString stringWithFormat:@"&trip_type=%@",@"upcoming"]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONResp:data];
                               }
                           }];
    
}



-(void)parseJSONResp:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
  //  NSLog(@"*****Near Driver details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    // NSLog(@"%@",DataArray);
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        //
        //        [alert show];
        
        //  NSMutableArray *arrdetails=[[NSMutableArray alloc]init];
        
        arrdetails=nil;
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrdetails];
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"detailsofall"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSMutableArray *arrpages=[[NSMutableArray alloc]init];
        arrpages=[responseJSON valueForKey:@"data"];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrpages forKey:@"detailsofall2"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        UpcomingRidesViewController *upr=[self.storyboard instantiateViewControllerWithIdentifier:@"UpcomingRidesViewController"];
        [self.navigationController pushViewController:upr animated:YES];
        
    }
    
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        // NSMutableArray *arrdetails=[[NSMutableArray alloc]init];
        
        arrdetails=[[[responseJSON valueForKey:@"data"] valueForKey:@"tripDetail"]valueForKey:@"trip"];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrdetails];
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"detailsofall"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSMutableArray *arrpages=[[NSMutableArray alloc]init];
        arrpages=[responseJSON valueForKey:@"data"];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrpages forKey:@"detailsofall2"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        UpcomingRidesViewController *upr=[self.storyboard instantiateViewControllerWithIdentifier:@"UpcomingRidesViewController"];
        [self.navigationController pushViewController:upr animated:YES];
        
    }
    
}





- (IBAction)callbuttonClicked:(id)sender
{
    // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:8143547797"]];
    NSString *phone_number = [[[arrdriverinfo valueForKey:@"mobile_no"] componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phone_number]]];
}


- (IBAction)ArrivedatpickuplocationClicked:(id)sender
{
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {
        
     

    self.view.userInteractionEnabled=NO;
   [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,driverarrived]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"trip_id=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"tripid"]]];
    
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self Arriveatpickuploc:data];
                                   
                               }
                           }];
    }

}


-(void)Arriveatpickuploc:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
  // NSLog(@"***** Arrived at pickUp Location Response ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
        self.view.userInteractionEnabled=YES;
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        StartRideViewController *dvc=[self.storyboard instantiateViewControllerWithIdentifier:@"StartRideViewController"];
        [self.navigationController pushViewController:dvc animated:YES];
    }
}



- (IBAction)CancelRideClicked:(id)sender
{
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {

    BookcancelViewController *bcv=[self.storyboard instantiateViewControllerWithIdentifier:@"BookcancelViewController"];
    [self.navigationController pushViewController:bcv animated:YES];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated
{
    self.title = @"";
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    [self.revealViewController.view removeGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;

    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    [self.revealViewController.view removeGestureRecognizer:self.revealViewController.panGestureRecognizer];
    self.title = @"Rider Details";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,logincheck]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&device_id=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"devicetoken"]]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONRdevicecheck:data];
                               }
                           }];
    
    
    
}


-(void)parseJSONRdevicecheck:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
 //   NSLog(@"***** login check details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        //
        //        [alert show];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Login"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        SplachscreenViewController *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"SplachscreenViewController"];
        UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
        [navController setViewControllers: @[edit] animated: NO ];
        [self.revealViewController setFrontViewController:navController animated:YES];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        
        
    }
}

- (IBAction)NavigateButtonClicked:(id)sender
{

    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {
        
        NSString *googleMapUrlString = [NSString stringWithFormat:@"comgooglemaps://?.saddr=%@&daddr=%@&directionsmode=driving",_pickuplab.text, _deslab.text];
        
        NSString *trimmedString = [googleMapUrlString stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]])
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trimmedString]];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Please install Google Maps - Navigation & Transport app from iTunes store before Navigation" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Install", nil];
            [alert show];
        }


//      [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getBookingInfo]]];
//    
//    request.HTTPMethod = @"POST";
//    
//    NSMutableString* profile = [NSMutableString string];
//    
//    
//    
//    [profile appendString:[NSString stringWithFormat:@"trip_id=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"tripid"]]];
//    
//    [profile appendString:[NSString stringWithFormat:@"&user_type=%@", @"driver"]];
//    
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
//                                   [self parseJSONRespon1:data];
//                                   
//                               }
//                           }];
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == [alertView firstOtherButtonIndex])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://itunes.apple.com/in/app/google-maps-navigation-transport/id585027354?mt=8"]];
    }
}


-(void)parseJSONRespon1:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
  //  NSLog(@"***** Driver location ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
   [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        Driverlocationdetails=[[responseJSON valueForKey:@"data"] valueForKey:@"trip"];
        
        [[NSUserDefaults standardUserDefaults]setObject:Driverlocationdetails forKey:@"driverlocdetails"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        GPSViewController *gps=[self.storyboard instantiateViewControllerWithIdentifier:@"GPSViewController"];
        [self.navigationController pushViewController:gps animated:YES];
    }
}



- (IBAction)ChatButtonClicked:(id)sender
{
    ChatVController *chat=[self.storyboard instantiateViewControllerWithIdentifier:@"ChatVController"];
    [self.navigationController pushViewController:chat animated:YES];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
