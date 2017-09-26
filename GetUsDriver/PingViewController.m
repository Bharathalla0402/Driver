//
//  PingViewController.m
//  GetUsHere For Driver
//
//  Created by bharat on 04/04/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "PingViewController.h"
#import "DejalActivityView.h"
#import "GetUsHere.pch"
#import "SplachscreenViewController.h"
#import "SWRevealViewController.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface PingViewController ()

@end

@implementation PingViewController
@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title=@"Waiting For Request";
    
    
    
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
    mapView.showsUserLocation = YES;
    mapView.delegate=self;
    
    latitude=locationManager.location.coordinate.latitude;
    longitude=locationManager.location.coordinate.longitude;
    
    
    count=0;
    
    CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
    
    if (authorizationStatus == kCLAuthorizationStatusAuthorized ||
        authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
        authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        
        [locationManager startUpdatingLocation];
        mapView.showsUserLocation = YES;
        
    }
    
 //   [self performSelector:@selector(AcceptedResponse:) withObject:self afterDelay:1.0];
   // [self drawMap];
    
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];

    NSString *stravail=[[NSUserDefaults standardUserDefaults]objectForKey:@"availabilty"];
    
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
    
    _viewforback.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
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


-(void)drawMap
{
    [mapView removeAnnotations:mapView.annotations];
    CLLocationCoordinate2D location;
    location.latitude=latitude;
    location.longitude=longitude;
    region.center=location;
    MKCoordinateSpan span1;
    span1.latitudeDelta=0.1;
    span1.longitudeDelta=0.1;
    region.span=span1;
    [mapView setShowsUserLocation:NO];
    [mapView setRegion:region animated:YES];
    mapView.delegate=self;
    MyAnnotation *annotation=[[MyAnnotation alloc]initWithCoordinate:location title:strAdd subtitle:strAdd1];
    [mapView addAnnotation:annotation];
  //  [mapView reloadInputViews];
   // mapView.tag=1;
}

- (UIImage *)image:(UIImage*)originalImage scaledToSize:(CGSize)size
{
    //avoid redundant drawing
    if (CGSizeEqualToSize(originalImage.size, size))
    {
        return originalImage;
    }
    
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    //draw
    [originalImage drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    
    //capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return image
    return image;
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView1 viewForAnnotation:(id<MKAnnotation>)annotation
{
    
        MKAnnotationView *annView=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:nil];
    annView.image=[UIImage imageNamed:@"bigpin.png"];
    annView.image = [self image:annView.image scaledToSize:CGSizeMake(50.0f, 50.0f)];
        annView.canShowCallout=YES;
        return annView;
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
         [mapView removeAnnotations:mapView.annotations];
        [self drawMap];
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


-(void)viewWillDisappear:(BOOL)animated
{
    [locationManager stopUpdatingLocation];
}


-(void)viewWillAppear:(BOOL)animated
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
