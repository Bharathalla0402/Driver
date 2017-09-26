//
//  RiderRequestConformViewController.m
//  GetUsDriver
//
//  Created by bharat on 07/06/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "RiderRequestConformViewController.h"
#import "DejalActivityView.h"
#import "GetUsHere.pch"
#import "SidebarViewController.h"
#import "UpcomingRidesViewController.h"
#import "DriverDetailsViewController.h"
#import "BookcancelViewController.h"
#import "AppDelegate.h"
#import "AcceptingRequestFormViewController.h"
#import "UIImageView+WebCach.h"
#import "SWRevealViewController.h"
#import "SplachscreenViewController.h"
#import "Reachability.h"

@interface RiderRequestConformViewController ()
{
    CFTimeInterval progressStart;
    int progressCount;
    BOOL gotNotifcation;
}

@end

@implementation RiderRequestConformViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _txtnumber.hidden=YES;
    _countinglab.hidden=YES;
    _progressbar.hidden=YES;
    
   [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"itemType"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.title=@"Confirm Request";
    
   // self.view.backgroundColor=[UIColor whiteColor];
 //   _navigationView.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    arrdetails=[[NSMutableArray alloc]init];
    arrdetails=[[NSUserDefaults standardUserDefaults]objectForKey:@"riderdata"];
    
    NSLog(@"%@",arrdetails);
    
    arrdetails2=[[NSMutableArray alloc]init];
    
    _navigationView.hidden=YES;
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
    
    _UserImage.layer.cornerRadius = _UserImage.frame.size.height /2;
    _UserImage.layer.masksToBounds = YES;
    _UserImage.layer.borderWidth = 0;
    
     _topview.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _riderdetailsView.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    _yourCountdownlab.textColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _coundownlinelab.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _rejectview.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    _acceptView.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _locationsView.textColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _locationslinelab.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"b" style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(barButtonBackPressed:)];
    [backButton setImage:[UIImage imageNamed:@"Untitled-1-2.png"]];
    
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back.jpg"]];
    count=0;
    
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
    
//    NSLog(@"*****Near Driver details ******* %@", responseJSON);
    
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








#pragma mark-Get address from latlng

-(NSString*)getAddressFromLatLong : (NSString *)latLng
{
    NSString *esc_addr =  [latLng stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%@&sensor=true", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    NSMutableDictionary *data = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding]options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *dataArray = (NSMutableArray *)[data valueForKey:@"results" ];
    if (dataArray.count == 0)
    {
        NSString *message =@"Please enter a valid Address";
        UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil, nil];
        [toast show];
        int duration = 1; // in seconds
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [toast dismissWithClickedButtonIndex:0 animated:YES];
        });
        
        
    }
    else
    {
        for (id firstTime in dataArray) {
            NSString *jsonStr1 = [firstTime valueForKey:@"formatted_address"];
            _labpickup.text=jsonStr1;
         //   _labpickup.text=@"66 Argonaut Ave, San Francisco, CA 94134, USA";
            // [self getLocationFromAddressString6:_searchDropAddRef.text];
            return jsonStr1;
        }
    }
    return nil;
}

-(NSString*)getAddressFromLatLong1: (NSString *)latLng
{
    NSString *esc_addr =  [latLng stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%@&sensor=true", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    NSMutableDictionary *data = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding]options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *dataArray = (NSMutableArray *)[data valueForKey:@"results" ];
    if (dataArray.count == 0)
    {
        NSString *message =@"Please enter a valid Address";
        UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil, nil];
        [toast show];
        int duration = 1; // in seconds
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [toast dismissWithClickedButtonIndex:0 animated:YES];
        });
        
        
    }
    else
    {
        for (id firstTime in dataArray) {
            NSString *jsonStr1 = [firstTime valueForKey:@"formatted_address"];
            _labdes.text=jsonStr1;
       //     _labdes.text=@"499 McAllister St, San Francisco, CA 94102, USA";
            // [self getLocationFromAddressString6:_searchDropAddRef.text];
            return jsonStr1;
        }
    }
    return nil;
}



-(void)parseJSONRespogetcounts:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
 //   NSLog(@"***** Get User Counts ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        _txtTotalTrip.text=[NSString stringWithFormat:@"%@",[[responseJSON valueForKey:@"data"] valueForKey:@"total_trip"]];
        _txtCancelTrip.text=[NSString stringWithFormat:@"%@",[[responseJSON valueForKey:@"data"]valueForKey:@"canceled_trip"]];
        _txtCompletedTrip.text=[NSString stringWithFormat:@"%@",[[responseJSON valueForKey:@"data"]valueForKey:@"completed_trip"]];
        
    }
}

-(void)progressstatus
{
    if (count==0)
    {
        [self performSelector:@selector(updateProgress) withObject:nil afterDelay:0.9];
    }
    else
    {
        [self performSelector:@selector(stopprogressstatus) withObject:nil afterDelay:0.1];
    }

}
-(void)stopprogressstatus
{
    return;

}

- (void)updateProgress
{
    if ( progressCount < 99 )
    [self performSelector:@selector(progressstatus) withObject:nil afterDelay:2.0];
    _progressbar.progress = progressCount / 99.0;
    NSLog( @"%2d %.3lf", progressCount, CACurrentMediaTime() + progressStart );
    _txtnumber.text=[NSString stringWithFormat:@"%i",progressCount];
    progressCount++;
}

#pragma mark - backbutton clicked

- (IBAction)backbuttonClicked:(id)sender
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
                                   dispatch_async(dispatch_get_main_queue(), ^{
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONRespdetails:data];
                               }
                                       });
                           }];
}

-(void)parseJSONRespdetails:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
//    NSLog(@"*****Upcoming Rides details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    // NSLog(@"%@",DataArray);
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
        self.view.userInteractionEnabled=YES;
    }
    
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        arrdetails2=[[[responseJSON valueForKey:@"data"] valueForKey:@"tripDetail"]valueForKey:@"trip"];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrdetails2];
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"detailsofall"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSMutableArray *arrpages=[[NSMutableArray alloc]init];
        arrpages=[responseJSON valueForKey:@"data"];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrpages forKey:@"detailsofall2"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UpcomingRidesViewController *dvc=[storyboard instantiateViewControllerWithIdentifier:@"UpcomingRidesViewController"];
        [self presentViewController:dvc animated:YES completion:nil];
    }
}



- (IBAction)AcceptClicked:(id)sender
{
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {
    
    self.view.userInteractionEnabled=NO;
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,driverbookingaccept]]];
        
        request.HTTPMethod = @"POST";
        
        NSMutableString* profile = [NSMutableString string];
        
        [profile appendString:[NSString stringWithFormat:@"trip_id=%@", [arrdetails valueForKey:@"trip_id"]]];
        [profile appendString:[NSString stringWithFormat:@"&rider_id=%@",[arrdetails valueForKey:@"user_id"]]];
        [profile appendString:[NSString stringWithFormat:@"&driver_id=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
        
        request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (error) {
                                       // Handle error
                                       //[self handleError:error];
                                   } else {
                                       [self parseJSONRespo1:data];
                                   }
                               }];
    }
}

-(void)parseJSONRespo1:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
  //  NSLog(@"*****Accept Request details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
        self.view.userInteractionEnabled=YES;
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        
        NSString *strtripid=[[[responseJSON valueForKey:@"data"] valueForKey:@"trip"] valueForKey:@"id"];
        
        [[NSUserDefaults standardUserDefaults]setObject:strtripid forKey:@"tripid"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:_labpickup.text forKey:@"pic"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:_labdes.text forKey:@"des"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
            
        NSMutableArray *rider=[[NSMutableArray alloc]init];
        rider=[[responseJSON valueForKey:@"data"] valueForKey:@"rider"];
        
        [[NSUserDefaults standardUserDefaults]setObject:rider forKey:@"driverinfo"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        DriverDetailsViewController *dvc=[self.storyboard instantiateViewControllerWithIdentifier:@"DriverDetailsViewController"];
        [self.navigationController pushViewController:dvc animated:YES];
    }
}


- (IBAction)RejectClicked:(id)sender
{
    
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {

    
    self.view.userInteractionEnabled=NO;
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"pleasewait..."];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,driverbookingreject]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"trip_id=%@", [arrdetails valueForKey:@"trip_id"]]];
    [profile appendString:[NSString stringWithFormat:@"&rider_id=%@",[arrdetails valueForKey:@"user_id"]]];
    [profile appendString:[NSString stringWithFormat:@"&driver_id=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONRespo2:data];
                               }
                           }];
    }
    
}

-(void)parseJSONRespo2:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
  //  NSLog(@"*****Rejected details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
        self.view.userInteractionEnabled=YES;
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        NSString *str=[arrdetails valueForKey:@"trip_id"];
        
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"tripid"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        AcceptingRequestFormViewController *acp=[self.storyboard instantiateViewControllerWithIdentifier:@"AcceptingRequestFormViewController"];
        [self.navigationController pushViewController:acp animated:YES];
        
//        BookcancelViewController *bcv=[self.storyboard instantiateViewControllerWithIdentifier:@"BookcancelViewController"];
//        [self.navigationController pushViewController:bcv animated:YES];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(progressstatus) object:nil];
    self.title = @"";
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    [self.revealViewController.view removeGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;

}


-(void)viewWillAppear:(BOOL)animated
{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
  //  [self.revealViewController.view removeGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
   [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getUserCounts]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [arrdetails valueForKey:@"user_id"]]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONRespogetcounts:data];
                               }
                           }];
    
    NSString *strurlimage=[arrdetails valueForKey:@"image"];
    
    if (![strurlimage isEqualToString:@""])
    {
        [_UserImage sd_setImageWithURL:[NSURL URLWithString:strurlimage]
                       placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
    }

    _txtUserName.text=[arrdetails valueForKey:@"name"];
    
    NSString *str1=[NSString stringWithFormat:@"%@",[arrdetails valueForKey:@"src_lat"]];
    latitude=[str1 floatValue];
    
    NSString *str2=[NSString stringWithFormat:@"%@",[arrdetails valueForKey:@"src_lng"]];
    longitude=[str2 floatValue];
    
    NSString *str3=[NSString stringWithFormat:@"%@",[arrdetails valueForKey:@"dest_lat"]];
    latitude1=[str3 floatValue];
    
    NSString *str4=[NSString stringWithFormat:@"%@",[arrdetails valueForKey:@"dest_lng"]];
    longitude1=[str4 floatValue];
    
    NSString *currentLatLong = [NSString stringWithFormat:@"%f,%f",latitude,longitude];
    [self getAddressFromLatLong:currentLatLong];
    
    NSString *currentLatLong1 = [NSString stringWithFormat:@"%f,%f",latitude1,longitude1];
    [self getAddressFromLatLong1:currentLatLong1];
    
    
    progressStart = CACurrentMediaTime();
    progressCount = 0;
    [self updateProgress];
    
    [self logincheckdetails];

}

-(void)logincheckdetails
{
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
