//
//  StartRideViewController.m
//  GetUsDriver
//
//  Created by bharat on 10/06/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "StartRideViewController.h"
#import "UpcomingCancelViewController.h"
#import "BookcancelViewController.h"
#import "GPSViewController.h"
#import "ChatVController.h"
#import "GetUsHere.pch"
#import "DejalActivityView.h"
#import "StopRideViewController.h"
#import "UpcomingRidesViewController.h"
#import "SidebarViewController.h"
#import "UIImageView+WebCache.h"
#import "SplachscreenViewController.h"
#import "Reachability.h"

@interface StartRideViewController ()
{

    UIAlertView *alert2;
}

@end

@implementation StartRideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title=@"Start Ride";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    arrdriverinfo=[[NSUserDefaults standardUserDefaults]objectForKey:@"driverinfo"];
    _txtname.text=[arrdriverinfo valueForKey:@"name"];
    
    tripinfo=[[NSMutableArray alloc]init];
    Driverlocationdetails=[[NSMutableArray alloc]init];
    
      [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
     arrdetails=[[NSMutableArray alloc]init];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"b" style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(barButtonBackPressed:)];
    [backButton setImage:[UIImage imageNamed:@"Untitled-1-2.png"]];
    
    self.navigationItem.leftBarButtonItem = backButton;
    
   //  _waitingtimalab.text=@"Is there any waiting time ?";
    
//    [[NSUserDefaults standardUserDefaults]setObject:_waitingtimalab.text forKey:@"Waitingtime"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSString *strwaitingtimeid=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"Waitingtimestr"]];
    
    if ([strwaitingtimeid isEqualToString:@"1"] || [strwaitingtimeid isEqualToString:@"2"] || [strwaitingtimeid isEqualToString:@"3"] || [strwaitingtimeid isEqualToString:@"4"] || [strwaitingtimeid isEqualToString:@"5"] || [strwaitingtimeid isEqualToString:@"6"] )
    {
        _waitingtimalab.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"Waitingtime"];
    }
    else
    {
       _waitingtimalab.text=@"Is there any waiting time ?";
    }
    
   _waitingView.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _waitingtimalab.textColor=[UIColor whiteColor];
    
     _topview.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _picuptitlelab.textColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _destitlelab.textColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _profileImage.layer.cornerRadius = _profileImage.frame.size.height /2;
    _profileImage.layer.masksToBounds = YES;
    _profileImage.layer.borderWidth = 0;
    
    NSString *strurl=[arrdriverinfo valueForKey:@"image"];
    
    if (![strurl isEqualToString:@""])
    {
        [_profileImage sd_setImageWithURL:[NSURL URLWithString:strurl]
                         placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
    }
    
    _detailview.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
   
    _NavigateButton.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _startRideButt.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _pickuplab.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"pic"];
    _deslab.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"des"];
    strtripid=[[NSUserDefaults standardUserDefaults]objectForKey:@"tripid"];
    
    
}


-(void)barButtonBackPressed:(id)sender
{
    //    SidebarViewController *side=[self.storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"];
    //    [self.navigationController pushViewController:side animated:YES];
    
    
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



- (IBAction)buttonClicked:(id)sender
{
    
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {

    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:@"Is there any waiting time ?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"5 min",@"10 min",@"15 min",@"20 min",@"25 min",@"30 min", nil];
    [sheet showInView:self.view];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
      _waitingtimalab.text=@"5 min";
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Are you sure you want to apply Waiting Time ?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"YES", nil];
        [alert show];
        
        strwaitid=@"1";
    }
    else if(buttonIndex==1)
    {
      _waitingtimalab.text=@"10 min";
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Are you sure you want to apply Waiting Time ?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"YES", nil];
        [alert show];
        
        strwaitid=@"2";
    }
    else if(buttonIndex==2)
    {
        _waitingtimalab.text=@"15 min";
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Are you sure you want to apply Waiting Time ?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"YES", nil];
        [alert show];
        
         strwaitid=@"3";
    }
    else if(buttonIndex==3)
    {
        _waitingtimalab.text=@"20 min";
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Are you sure you want to apply Waiting Time ?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"YES", nil];
        [alert show];
        
         strwaitid=@"4";
    }
    else if(buttonIndex==4)
    {
        _waitingtimalab.text=@"25 min";
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Are you sure you want to apply Waiting Time ?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"YES", nil];
        [alert show];
        
       strwaitid=@"5";
    }
    else if(buttonIndex==5)
    {
        _waitingtimalab.text=@"30 min";
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Are you sure you want to apply Waiting Time ?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"YES", nil];
        [alert show];
        
        strwaitid=@"6";
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if (alertView==alert2)
    {
        if (buttonIndex == [alertView firstOtherButtonIndex])
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://itunes.apple.com/in/app/google-maps-navigation-transport/id585027354?mt=8"]];
        }
    }
    else
    {
    
    if (buttonIndex == [alertView firstOtherButtonIndex])
    {
        [[NSUserDefaults standardUserDefaults]setObject:_waitingtimalab.text forKey:@"Waitingtime"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:strwaitid forKey:@"Waitingtimestr"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,addwaiting]]];
        
        request.HTTPMethod = @"POST";
        
        NSMutableString* profile = [NSMutableString string];
        
        [profile appendString:[NSString stringWithFormat:@"trip_id=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"tripid"]]];
        [profile appendString:[NSString stringWithFormat:@"&waiting_id=%@",strwaitid]];
        [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"driver"]];
       
        
        request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (error) {
                                       // Handle error
                                       //[self handleError:error];
                                   } else {
                                       [self parseJSONResponStar:data];
                                       
                                   }
                               }];
        
    }
    else
    {
        NSString *strwaitingtimeid=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"Waitingtimestr"]];
        
        if ([strwaitingtimeid isEqualToString:@"1"] || [strwaitingtimeid isEqualToString:@"2"] || [strwaitingtimeid isEqualToString:@"3"] || [strwaitingtimeid isEqualToString:@"4"] || [strwaitingtimeid isEqualToString:@"5"] || [strwaitingtimeid isEqualToString:@"6"] )
        {
            _waitingtimalab.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"Waitingtime"];
        }
        else
        {
            
            _waitingtimalab.text=@"Is there any waiting time ?";
        }
    
    }
    }
}


-(void)parseJSONResponStar:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
  //  NSLog(@"***** Ride Stop Response ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        
    }
    
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

- (IBAction)callbuttonClicked:(id)sender
{
    // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:8143547797"]];
    NSString *phone_number = [[[arrdriverinfo valueForKey:@"mobile_no"] componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phone_number]]];
}

- (IBAction)StartRideClicked:(id)sender
{
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {

    
    popview = [[ UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    //  popview.backgroundColor = [UIColor clearColor];
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height/2-10, self.view.frame.size.width-20, 130)];
    footerview.backgroundColor=[UIColor whiteColor];
   // footerview.backgroundColor = [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    [popview addSubview:footerview];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, footerview.frame.size.width-20, 40)];
    lab.text=@"Are you sure want to start the Ride ?";
    lab.textColor=[UIColor blackColor];
    lab.numberOfLines=2;
    [footerview addSubview:lab];
    
    UIButton *cancelbutt=[[UIButton alloc]initWithFrame:CGRectMake(5, 80, footerview.frame.size.width/2-5, 40)];
    cancelbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    [cancelbutt  setTitle:@"No" forState:UIControlStateNormal];
    [cancelbutt addTarget:self action:@selector(cancelclicked) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:cancelbutt];
    
    UIButton *add=[[UIButton alloc]initWithFrame:CGRectMake(cancelbutt.frame.size.width+10, 80, footerview.frame.size.width/2-10, 40)];
    add.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    [add  setTitle:@"Yes" forState:UIControlStateNormal];
    [add addTarget:self action:@selector(addclicked) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:add];
    }

}

-(void)cancelclicked
{
    [footerview removeFromSuperview];
    popview.hidden = YES;
}


-(void)addclicked
{
 
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,startTrip]]];
    
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
                                   [self parseJSONResponStartRide:data];
                                   
                               }
                           }];
}



-(void)parseJSONResponStartRide:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
  //  NSLog(@"***** Ride Start Response ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        StopRideViewController *stop=[self.storyboard instantiateViewControllerWithIdentifier:@"StopRideViewController"];
        [self.navigationController pushViewController:stop animated:YES];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    self.title = @"";
}

-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"Start Ride";
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
    
  //  NSLog(@"***** login check details ******* %@", responseJSON);
    
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
    
    NSString *googleMapUrlString = [NSString stringWithFormat:@"comgooglemaps://?.saddr=%@&daddr=%@&directionsmode=driving",_pickuplab.text, _deslab.text];
    
    NSString *trimmedString = [googleMapUrlString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trimmedString]];
    }
    else
    {
        alert2=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Please install Google Maps - Navigation & Transport app from iTunes store before Navigation" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Install", nil];
        [alert2 show];
    }

    
//    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getBookingInfo]]];
//    
//    request.HTTPMethod = @"POST";
//    
//    NSMutableString* profile = [NSMutableString string];
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
//                                   [self parseJSONResponnavigate:data];
//                                   
//                               }
//                           }];
    
}




-(void)parseJSONResponnavigate:(NSData*)responseData
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
