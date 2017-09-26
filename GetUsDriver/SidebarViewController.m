//
//  SidebarViewController.m
//  Jaguar Enterprises
//
//  Created by bharat on 01/02/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "SidebarViewController.h"
#import "SWRevealViewController.h"
#import "DejalActivityView.h"
#import "SettingsViewController.h"
#import "AboutUsViewController.h"
#import "UpcomingRidesViewController.h"
#import "CancelledViewController.h"
#import "CompletedtripsViewController.h"
#import "PingViewController.h"
#import "RidereditViewController.h"
#import "GetUsHere.pch"
#import "RiderRequestConformViewController.h"
#import "Reachability.h"
#import "SplachscreenViewController.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@interface SidebarViewController ()

@end

@implementation SidebarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
   //   self.navigationController.title=[UIColor whiteColor];
    
   // self.title = @"Dash board";
    
    self.title=@"Dash board";
    
    _titlelab.textColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.desiredAccuracy = 45;
    locationManager.distanceFilter = 100;
    if(IS_OS_8_OR_LATER)
    {
        [locationManager requestAlwaysAuthorization];
    }
    [locationManager startUpdatingLocation];
    
    latitude=locationManager.location.coordinate.latitude;
    longitude=locationManager.location.coordinate.longitude;
    
    
    count=0;
    
    CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
    
    if (authorizationStatus == kCLAuthorizationStatusAuthorized ||
        authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
        authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        
        [locationManager startUpdatingLocation];
    }

    
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back.jpg"]];
    
    [_sidebarButton setImage:[UIImage imageNamed:@"30_20.png"]];
    
    _viewpingbutt.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    [_viewpingbutt setImage:[UIImage imageNamed:@"view-ping.png"] forState:UIControlStateNormal];
    
    // [_sidebarButton setBackgroundImage:[UIImage imageNamed:@"green.png"] forState:UIControlStateNormal];
    
    //[_sidebarButton setTintColor:[UIColor yellowColor]];
    
    arrcount=[[NSMutableArray alloc]init];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    arrcars=[[NSMutableArray alloc]init];
    arrid=[[NSMutableArray alloc]init];
    arrdetails=[[NSMutableArray alloc]init];
    
   
    
    
    
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/2+6, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-70)/2)];
    view1.backgroundColor= [UIColor colorWithRed:250.0/255.0f green:151.0/255.0f blue:2.0/255.0f alpha:1.0];
    [self.view addSubview:view1];
    
    UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(view1.frame.size.width/2-38, view1.frame.size.height/2-31, 76, 36)];
    
    if (self.view.frame.size.height==480 || self.view.frame.size.height==568)
    {
        image.image=[UIImage imageNamed:@"upcoming-1x.jpg"];
    }
    else if (self.view.frame.size.height==667)
    {
        image.image=[UIImage imageNamed:@"upcoming-1x.jpg"];
    }
    else
    {
        image.image=[UIImage imageNamed:@"upcoming-1x.jpg"];
    }
    [view1 addSubview:image];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(view1.frame.size.width/2-40, view1.frame.size.height/2+5, 80, 40)];
    lab.text=@"Upcoming Rides";
    lab.textColor=[UIColor whiteColor];
    lab.numberOfLines=2;
    lab.textAlignment = NSTextAlignmentCenter;
    [lab setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [view1 addSubview:lab];
    
    UIButton *upcomingrides=[[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/2+6, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-70)/2)];
    upcomingrides.backgroundColor=[UIColor clearColor];
    //  [upcomingrides setImage:[UIImage imageNamed:@"upcoming3.jpg"] forState:UIControlStateNormal];
    [upcomingrides addTarget:self action:@selector(UpcomingRidesClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:upcomingrides];
    
    
    
    
    
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(upcomingrides.frame.size.width+3, self.view.frame.size.height/2+6, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-70)/2)];
    view2.backgroundColor= [UIColor colorWithRed:104.0/255.0f green:53.0/255.0f blue:185.0/255.0f alpha:1.0];
    [self.view addSubview:view2];
    
    UIImageView *image1=[[UIImageView alloc] initWithFrame:CGRectMake(view2.frame.size.width/2-37.5, view2.frame.size.height/2-30, 75, 35)];
    image1.image=[UIImage imageNamed:@"cancelled-v1-2.jpg"];
    [view2 addSubview:image1];
    
    UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(view2.frame.size.width/2-40, view2.frame.size.height/2+5, 80, 40)];
    lab1.text=@"Cancelled Rides";
    lab1.textColor=[UIColor whiteColor];
    lab1.numberOfLines=2;
    lab1.textAlignment = NSTextAlignmentCenter;
    [lab1 setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [view2 addSubview:lab1];
    
    UIButton *Cancelledrides=[[UIButton alloc]initWithFrame:CGRectMake(upcomingrides.frame.size.width+3, self.view.frame.size.height/2+6, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-70)/2)];
    Cancelledrides.backgroundColor=[UIColor clearColor];
    // [Cancelledrides setImage:[UIImage imageNamed:@"cancel3.jpg"] forState:UIControlStateNormal];
    [Cancelledrides addTarget:self action:@selector(CancelledRidesClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Cancelledrides];
    
    
    
    UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(upcomingrides.frame.size.width+Cancelledrides.frame.size.width+6, self.view.frame.size.height/2+6, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-70)/2)];
    view3.backgroundColor= [UIColor colorWithRed:3.0/255.0f green:154.0/255.0f blue:179.0/255.0f alpha:1.0];
    [self.view addSubview:view3];
    
    UIImageView *image2=[[UIImageView alloc] initWithFrame:CGRectMake(view3.frame.size.width/2-37.5, view3.frame.size.height/2-30, 75, 35)];
    image2.backgroundColor=[UIColor colorWithRed:3.0/255.0f green:154.0/255.0f blue:179.0/255.0f alpha:1.0];
    image2.image=[UIImage imageNamed:@"completed-1x-2.jpg"];
    [view3 addSubview:image2];
    
    UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(view3.frame.size.width/2-40, view3.frame.size.height/2+5, 80, 40)];
    lab2.text=@"Completed Rides";
    lab2.textColor=[UIColor whiteColor];
    lab2.numberOfLines=2;
    lab2.textAlignment = NSTextAlignmentCenter;
    [lab2 setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [view3 addSubview:lab2];
    
    UIButton *fareestimate=[[UIButton alloc]initWithFrame:CGRectMake(upcomingrides.frame.size.width+Cancelledrides.frame.size.width+6, self.view.frame.size.height/2+6, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-70)/2)];
    fareestimate.backgroundColor=[UIColor clearColor];
    //  [fareestimate setImage:[UIImage imageNamed:@"fare3.jpg"] forState:UIControlStateNormal];
    [fareestimate addTarget:self action:@selector(CompletedRidesClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fareestimate];
    
    
    
    
    UIView *view4=[[UIView alloc]initWithFrame:CGRectMake(0, upcomingrides.frame.origin.y+upcomingrides.frame.size.height+2, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-70)/2)];
    view4.backgroundColor= [UIColor colorWithRed:12.0/255.0f green:183.0/255.0f blue:165.0/255.0f alpha:1.0];
    [self.view addSubview:view4];
    
    UIImageView *image3=[[UIImageView alloc] initWithFrame:CGRectMake(view4.frame.size.width/2-22.5, view4.frame.size.height/2-32, 45, 45)];
    image3.image=[UIImage imageNamed:@"profile-1x.jpg"];
    [view4 addSubview:image3];
    
    UILabel *lab3=[[UILabel alloc]initWithFrame:CGRectMake(view4.frame.size.width/2-40, view4.frame.size.height/2+5, 80, 40)];
    lab3.text=@"My Profile";
    lab3.textColor=[UIColor whiteColor];
    lab3.numberOfLines=2;
    lab3.textAlignment = NSTextAlignmentCenter;
    [lab3 setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [view4 addSubview:lab3];
    
    UIButton *myprofile=[[UIButton alloc]initWithFrame:CGRectMake(0, upcomingrides.frame.origin.y+upcomingrides.frame.size.height+2, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-70)/2)];
    myprofile.backgroundColor=[UIColor clearColor];
    //  [myprofile setImage:[UIImage imageNamed:@"profile3.jpg"] forState:UIControlStateNormal];
    [myprofile addTarget:self action:@selector(profileClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myprofile];
    
    
    
    
    UIView *view5=[[UIView alloc]initWithFrame:CGRectMake(myprofile.frame.size.width+3, Cancelledrides.frame.origin.y+Cancelledrides.frame.size.height+2, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-70)/2)];
    view5.backgroundColor= [UIColor colorWithRed:158.0/255.0f green:32.0/255.0f blue:177.0/255.0f alpha:1.0];
    [self.view addSubview:view5];
    
    UIImageView *image4=[[UIImageView alloc] initWithFrame:CGRectMake(view5.frame.size.width/2-22.5, view5.frame.size.height/2-32, 45, 45)];
    image4.image=[UIImage imageNamed:@"about-1x.jpg"];
    [view5 addSubview:image4];
    
    UILabel *lab4=[[UILabel alloc]initWithFrame:CGRectMake(view5.frame.size.width/2-40, view5.frame.size.height/2+5, 80, 40)];
    lab4.text=@"About Us";
    lab4.textColor=[UIColor whiteColor];
    lab4.numberOfLines=2;
    lab4.textAlignment = NSTextAlignmentCenter;
    [lab4 setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [view5 addSubview:lab4];
    
    UIButton *aboutus=[[UIButton alloc]initWithFrame:CGRectMake(myprofile.frame.size.width+3, Cancelledrides.frame.origin.y+Cancelledrides.frame.size.height+2, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-70)/2)];
    aboutus.backgroundColor=[UIColor clearColor];
    //   [aboutus setImage:[UIImage imageNamed:@"about2.jpg"] forState:UIControlStateNormal];
    [aboutus addTarget:self action:@selector(AboutusClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aboutus];
    
    
    
    
    UIView *view6=[[UIView alloc]initWithFrame:CGRectMake(myprofile.frame.size.width+aboutus.frame.size.width+6, fareestimate.frame.origin.y+fareestimate.frame.size.height+2, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-70)/2)];
    view6.backgroundColor= [UIColor colorWithRed:222.0/255.0f green:162.0/255.0f blue:13.0/255.0f alpha:1.0];
    [self.view addSubview:view6];
    
    UIImageView *image5=[[UIImageView alloc] initWithFrame:CGRectMake(view6.frame.size.width/2-22.5, view6.frame.size.height/2-32, 45, 45)];
    image5.image=[UIImage imageNamed:@"settings-1x.jpg"];
    [view6 addSubview:image5];
    
    UILabel *lab5=[[UILabel alloc]initWithFrame:CGRectMake(view6.frame.size.width/2-40, view6.frame.size.height/2+5, 80, 40)];
    lab5.text=@"Settings";
    lab5.textColor=[UIColor whiteColor];
    lab5.numberOfLines=2;
    lab5.textAlignment = NSTextAlignmentCenter;
    [lab5 setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [view6 addSubview:lab5];
    
    UIButton *settings=[[UIButton alloc]initWithFrame:CGRectMake(myprofile.frame.size.width+aboutus.frame.size.width+8, fareestimate.frame.origin.y+fareestimate.frame.size.height+2, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-70)/2)];
    settings.backgroundColor=[UIColor clearColor];
    //  [settings setImage:[UIImage imageNamed:@"settings3.jpg"] forState:UIControlStateNormal];
    [settings addTarget:self action:@selector(SettingChanged:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settings];
    

    
    
//    UIButton *upcomingrides=[[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/2+36, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-100)/2)];
//    upcomingrides.backgroundColor=[UIColor colorWithRed:250.0/255.0f green:151.0/255.0f blue:2.0/255.0f alpha:1.0];
//    [upcomingrides setImage:[UIImage imageNamed:@"upcoming3.jpg"] forState:UIControlStateNormal];
//    [upcomingrides addTarget:self action:@selector(UpcomingRidesClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:upcomingrides];
//    
//    UIButton *Cancelledrides=[[UIButton alloc]initWithFrame:CGRectMake(upcomingrides.frame.size.width+3, self.view.frame.size.height/2+36, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-100)/2)];
//    Cancelledrides.backgroundColor=[UIColor colorWithRed:104.0/255.0f green:53.0/255.0f blue:185.0/255.0f alpha:1.0];
//    [Cancelledrides setImage:[UIImage imageNamed:@"cancel3.jpg"] forState:UIControlStateNormal];
//    [Cancelledrides addTarget:self action:@selector(CancelledRidesClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:Cancelledrides];
//    
//    
//    UIButton *fareestimate=[[UIButton alloc]initWithFrame:CGRectMake(upcomingrides.frame.size.width+Cancelledrides.frame.size.width+6, self.view.frame.size.height/2+36, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-100)/2)];
//    fareestimate.backgroundColor=[UIColor colorWithRed:5.0/255.0f green:154.0/255.0f blue:178.0/255.0f alpha:1.0];
//    [fareestimate setImage:[UIImage imageNamed:@"completed33.jpg"] forState:UIControlStateNormal];
//    [fareestimate addTarget:self action:@selector(CompletedRidesClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:fareestimate];
//    
//    
//    UIButton *myprofile=[[UIButton alloc]initWithFrame:CGRectMake(0, upcomingrides.frame.origin.y+upcomingrides.frame.size.height+2, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-100)/2)];
//    myprofile.backgroundColor=[UIColor colorWithRed:12.0/255.0f green:183.0/255.0f blue:165.0/255.0f alpha:1.0];
//    [myprofile setImage:[UIImage imageNamed:@"profile3.jpg"] forState:UIControlStateNormal];
//    [myprofile addTarget:self action:@selector(profileClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:myprofile];
//    
//    
//    UIButton *aboutus=[[UIButton alloc]initWithFrame:CGRectMake(myprofile.frame.size.width+3, Cancelledrides.frame.origin.y+Cancelledrides.frame.size.height+2, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-100)/2)];
//    aboutus.backgroundColor=[UIColor colorWithRed:158.0/255.0f green:32.0/255.0f blue:177.0/255.0f alpha:1.0];
//    [aboutus setImage:[UIImage imageNamed:@"about2.jpg"] forState:UIControlStateNormal];
//    [aboutus addTarget:self action:@selector(AboutusClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:aboutus];
//
//    
//    
//    UIButton *settings=[[UIButton alloc]initWithFrame:CGRectMake(myprofile.frame.size.width+aboutus.frame.size.width+6, fareestimate.frame.origin.y+fareestimate.frame.size.height+2, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-100)/2)];
//    settings.backgroundColor=[UIColor colorWithRed:222.0/255.0f green:162.0/255.0f blue:13.0/255.0f alpha:1.0];
//    [settings setImage:[UIImage imageNamed:@"settings3.jpg"] forState:UIControlStateNormal];
//    [settings addTarget:self action:@selector(SettingChanged:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:settings];
    
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getUserCounts]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONRespo4:data];
                               }
                           }];

    
    
    // Change button color
 //   _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    
    self.revealViewController.delegate = self;
    
    // Set the gesture
   // [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
   
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLGeocoder *ceo = [[CLGeocoder alloc]init];
    CLLocation *location = [locations objectAtIndex:0];
    
    
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude]; //insert your coordinates
    
    [ceo reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error)
     {
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
         //     NSLog(@"placemark %@",placemark);
         //String to hold address
         NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
         NSLog(@"I am currently at %@",locatedAt);
         
         latitude=location.coordinate.latitude;
         longitude=location.coordinate.longitude;
         
         NSLog(@"%f",latitude);
         NSLog(@"%f",longitude);
         
         
     }
     ];
    
    [locationManager stopUpdatingLocation];
    
    if (count==0)
    {
        [self performSelector:@selector(AcceptedResponse:) withObject:self afterDelay:1.0];
    }
    else
    {
        [self performSelector:@selector(AcceptedResponse:) withObject:self afterDelay:20.0];
        
    }
    
    
    
    // [self performSelectorInBackground:@selector(AcceptedResponse:) withObject:nil];
    
}

-(void)AcceptedResponse:(id)sender
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,updatedriverlocation]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"driver_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&latitude=%f",latitude]];
    [profile appendString:[NSString stringWithFormat:@"&longitude=%f",longitude]];
    [profile appendString:[NSString stringWithFormat:@"&device_id=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"devicetoken"]]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONResponloc:data];
                                   
                               }
                           }];
}
-(void)parseJSONResponloc:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
    //  NSLog(@"***** Driver Location ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    // NSLog(@"%@",DataArray);
    
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        count=1;
        locationManager.delegate=self;
        [locationManager startUpdatingLocation];
    }
}




- (IBAction)switchClicked:(id)sender
{
    if(_switchcheck.isOn==YES)
    {
        NSString *str1=@"Available";
        _lbltext.text=str1;
        str3=@"on";
        [[NSUserDefaults standardUserDefaults]setObject:str3 forKey:@"availabilty"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
        [self next01];
    }
    else if(_switchcheck.isOn==NO)
    {
        NSString *str2=@"Not Available";
        _lbltext.text=str2;
        str3=@"off";
        [[NSUserDefaults standardUserDefaults]setObject:str3 forKey:@"availabilty"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
        [self next01];
    }
}


-(void)next01
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,updatedriveravailability]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"driver_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid"]]];
    [profile appendString:[NSString stringWithFormat:@"&availability=%@",str3]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONResponse:data];
                               }
                           }];
}

-(void)parseJSONResponse:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
    //   NSLog(@"*****Driver location ******* %@", responseJSON);
    
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


- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position
{
    if(position == FrontViewPositionLeft) {
        self.view.userInteractionEnabled = YES;
    } else {
        self.view.userInteractionEnabled = NO;
    }
}

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
{
    if(position == FrontViewPositionLeft) {
        self.view.userInteractionEnabled = YES;
    } else {
        self.view.userInteractionEnabled = NO;
    }
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Disable iOS 7 back gesture
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Enable iOS 7 back gesture
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}

-(void)parseJSONRespo4:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
//    NSLog(@"*****Trip details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    arrcount=[responseJSON valueForKey:@"data"];
    
    [[NSUserDefaults standardUserDefaults]setObject:arrcount forKey:@"tripdetail"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    // NSLog(@"%@",DataArray);
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        NSString *strtotal=[NSString stringWithFormat:@"%@",[arrcount valueForKey:@"total_trip"]];
        NSString *strcancelled=[NSString stringWithFormat:@"%@",[arrcount valueForKey:@"canceled_trip"]];
        
        [[NSUserDefaults standardUserDefaults] setObject:strtotal forKey:@"totaltrips"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults] setObject:strcancelled forKey:@"cancellrdtrips"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
}

- (IBAction)SettingChanged:(id)sender
{
    
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        self.view.userInteractionEnabled=NO;
        SettingsViewController *bookTax=[self.storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
        [self.navigationController pushViewController:bookTax animated:YES];
        
    }

}


- (IBAction)profileClicked:(id)sender
{
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {
        
        self.view.userInteractionEnabled=NO;
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        [self nak];
        
    }
}

-(void)nak
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getUserCounts]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONRespo:data];
                               }
                           }];
}

-(void)parseJSONRespo:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
    NSLog(@"*****Profile Details details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    arrcount=[responseJSON valueForKey:@"data"];
    
    [[NSUserDefaults standardUserDefaults]setObject:arrcount forKey:@"tripdetail"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
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
        
        RidereditViewController *edit=[self.storyboard instantiateViewControllerWithIdentifier:@"RidereditViewController"];
        [self.navigationController pushViewController:edit animated:YES];
    }
}



- (IBAction)PingrideClicked:(id)sender
{
    
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {
        
        self.view.userInteractionEnabled=NO;
        PingViewController *ping=[self.storyboard instantiateViewControllerWithIdentifier:@"PingViewController"];
        [self.navigationController pushViewController:ping animated:YES];
        
    }
}


- (IBAction)AboutusClicked:(id)sender
{
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {
        
        self.view.userInteractionEnabled=NO;
        AboutUsViewController *butt=[self.storyboard instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
        [self.navigationController pushViewController:butt animated:YES];
        
    }
    
   
}


- (IBAction)UpcomingRidesClicked:(id)sender
{
    
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {
        
        self.view.userInteractionEnabled=NO;
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
        [self n1];
        
    }
}


- (IBAction)CancelledRidesClicked:(id)sender
{
    
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {
        
        self.view.userInteractionEnabled=NO;
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
        [self nee];
        
    }
}


- (IBAction)CompletedRidesClicked:(id)sender
{
    
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {
        
        self.view.userInteractionEnabled=NO;
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
        [self ne];
        
    }
    
   
}


-(void)n1
{
    
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
    
 //   NSLog(@"*****Near Driver details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
   
    
    // NSLog(@"%@",DataArray);
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        
//        [alert show];
        
        arrdetails=nil;
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrdetails];
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"detailsofall"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSMutableArray *arrpages=[[NSMutableArray alloc]init];
        arrpages=[responseJSON valueForKey:@"data"];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrpages forKey:@"detailsofall2"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        UpcomingRidesViewController *butt=[self.storyboard instantiateViewControllerWithIdentifier:@"UpcomingRidesViewController"];
        [self.navigationController pushViewController:butt animated:YES];
    }
    
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        arrdetails=[[[responseJSON valueForKey:@"data"] valueForKey:@"tripDetail"]valueForKey:@"trip"];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrdetails];
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"detailsofall"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSMutableArray *arrpages=[[NSMutableArray alloc]init];
        arrpages=[responseJSON valueForKey:@"data"];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrpages forKey:@"detailsofall2"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        UpcomingRidesViewController *butt=[self.storyboard instantiateViewControllerWithIdentifier:@"UpcomingRidesViewController"];
        [self.navigationController pushViewController:butt animated:YES];
    }
}

-(void)nee
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getTrips]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"driver"]];
    [profile appendString:[NSString stringWithFormat:@"&trip_type=%@",@"canceled"]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONR:data];
                               }
                           }];
}

-(void)parseJSONR:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
  //  NSLog(@"*****Near Driver details ******* %@", responseJSON);
    
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
        
        arrdetails=[[[responseJSON valueForKey:@"data"]valueForKey:@"tripDetail"] valueForKey:@"trip"];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrdetails forKey:@"detailsofall"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSMutableArray *arrpages=[[NSMutableArray alloc]init];
        arrpages=[responseJSON valueForKey:@"data"];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrpages forKey:@"detailsofall2"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        CancelledViewController *butt=[self.storyboard instantiateViewControllerWithIdentifier:@"CancelledViewController"];
        [self.navigationController pushViewController:butt animated:YES];
    }
}

-(void)ne
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getTrips]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"driver"]];
    [profile appendString:[NSString stringWithFormat:@"&trip_type=%@",@"completed"]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONRe:data];
                               }
                           }];
}

-(void)parseJSONRe:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
//    NSLog(@"*****Near Driver details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    arrdetails=[[responseJSON valueForKey:@"data"]valueForKey:@"trip"];
    
    [[NSUserDefaults standardUserDefaults]setObject:arrdetails forKey:@"detailsofall"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
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
        
        arrdetails=[[[responseJSON valueForKey:@"data"] valueForKey:@"tripDetail"]valueForKey:@"trip"];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrdetails];
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"detailsofall"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSMutableArray *arrpages=[[NSMutableArray alloc]init];
        arrpages=[responseJSON valueForKey:@"data"];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrpages forKey:@"detailsofall2"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        CompletedtripsViewController *butt=[self.storyboard instantiateViewControllerWithIdentifier:@"CompletedtripsViewController"];
        [self.navigationController pushViewController:butt animated:YES];
    }
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidDisappear:(BOOL)animated
{
    
    self.title = @"";
    
    self.view.userInteractionEnabled=YES;
    
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//        self.navigationController.interactivePopGestureRecognizer.delegate = self;
//    }
//    [self.revealViewController.view removeGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [DejalBezelActivityView removeView];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"Dash board";
   self.view.userInteractionEnabled=YES;
    
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    self.revealViewController.delegate = self;
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self.revealViewController.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    
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
    
    
    NSString *stravail=[[NSUserDefaults standardUserDefaults]objectForKey:@"availabilty"];
    _lbltext.textColor=[UIColor blackColor];
    
    if ([stravail isEqualToString:@""])
    {
        
    }
    else if ([stravail isEqualToString:@"off"])
    {
        NSString *str2=@"Not Available";
        _lbltext.text=str2;
        str3=@"off";
        [_switchcheck setOn:NO];
        [[NSUserDefaults standardUserDefaults]setObject:str3 forKey:@"availabilty"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
        [self next01];
    }
    else if ([stravail isEqualToString:@"on"])
    {
        NSString *str1=@"Available";
        _lbltext.text=str1;
        str3=@"on";
        [_switchcheck setOn:YES];
        [[NSUserDefaults standardUserDefaults]setObject:str3 forKey:@"availabilty"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
        [self next01];
    }
    else{
        NSString *str2=@"Available";
        _lbltext.text=str2;
        str3=@"on";
        [_switchcheck setOn:YES];
        [[NSUserDefaults standardUserDefaults]setObject:str3 forKey:@"availabilty"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
        [self next01];
    }
    
    _viewforback.backgroundColor=[UIColor clearColor];
}


-(void)parseJSONRdevicecheck:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
 //   NSLog(@"***** login check details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    [DejalBezelActivityView removeView];
    
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


@end
