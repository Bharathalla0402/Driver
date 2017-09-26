//
//  AppDelegate.m
//  GetUsDriver
//
//  Created by bharat on 06/04/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "AppDelegate.h"
#import "JCNotificationCenter.h"
#import <JCNotificationBannerPresenter/JCNotificationCenter.h>
#import "DriverDetailsViewController.h"
#import "RiderRequestConformViewController.h"
#import "SWRevealViewController.h"
#import "ViewController.h"
#import "RiderMainPageViewController.h"
@import GoogleMaps;
#import "GetUsHere.pch"
#import "UpcomingRidesViewController.h"
#import "DejalActivityView.h"
#import "CancelledViewController.h"
#import "SidebarViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SplachscreenViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSDictionary *userInfo = [launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if (userInfo)
    {
        NSDictionary *userInfo = [launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
        
        if (apsInfo)
        {
            NSDictionary* aps = [userInfo objectForKey:@"aps"];
            NSString* alert2 = [aps objectForKey:@"code"];
            NSString *playSoundOnAlert = [NSString stringWithFormat:@"%@", [[userInfo objectForKey:@"aps"] objectForKey:@"sound"]];
            NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath],playSoundOnAlert]];
            NSError *error;
            AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
            audioPlayer.numberOfLoops = 0;
            [audioPlayer play];
            
            
            if ([alert2 isEqualToString:@"requested"])
            {
                NSDictionary* aps = [userInfo objectForKey:@"aps"];
                NSString *strChangetoJSON=[aps objectForKey:@"data"];
                NSData *data = [strChangetoJSON dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:kNilOptions
                                                                               error:nil];
                
                NSLog(@"Response Decode:%@",jsonResponse);
                
                [[NSUserDefaults standardUserDefaults]setObject:jsonResponse forKey:@"riderdata"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                [[NSUserDefaults standardUserDefaults]setObject:@"requested" forKey:@"itemType"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                // this any item in list you want navigate to
                RiderRequestConformViewController *home = (RiderRequestConformViewController *) [storyboard instantiateViewControllerWithIdentifier:@"RiderRequestConformViewController"];
                
                RiderMainPageViewController *slidemenu = (RiderMainPageViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RiderMainPageViewController"];
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:home];
                UINavigationController *smVC = [[UINavigationController alloc]initWithRootViewController:slidemenu];
                // define rear and frontviewcontroller
                SWRevealViewController *revealController = [[SWRevealViewController alloc]initWithRearViewController:smVC frontViewController:nav];
                self.window.rootViewController=revealController;
                
                
            }
            
            else if ([alert2 isEqualToString:@"completed"])
            {
                NSDictionary* aps = [userInfo objectForKey:@"aps"];
                NSString *strChangetoJSON=[aps objectForKey:@"data"];
                NSData *data = [strChangetoJSON dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:kNilOptions
                                                                               error:nil];
                
                NSLog(@"Response Decode:%@",jsonResponse);
                
                [[NSUserDefaults standardUserDefaults]setObject:jsonResponse forKey:@"riderdata2"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                [[NSUserDefaults standardUserDefaults]setObject:@"completed" forKey:@"itemType"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                
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
            
            else if ([alert2 isEqualToString:@"canceled"])
            {
                NSDictionary* aps = [userInfo objectForKey:@"aps"];
                NSString *strChangetoJSON=[aps objectForKey:@"data"];
                NSData *data = [strChangetoJSON dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:kNilOptions
                                                                               error:nil];
                
                NSLog(@"Response Decode:%@",jsonResponse);
                
                [[NSUserDefaults standardUserDefaults]setObject:jsonResponse forKey:@"riderdata2"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                [[NSUserDefaults standardUserDefaults]setObject:@"canceled" forKey:@"itemType"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
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


        }
    }
    else
    {
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"Login"] isEqualToString:@"YES"])
    {
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        // this any item in list you want navigate to
        SidebarViewController *home = (SidebarViewController *) [storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"];
        
        RiderMainPageViewController *slidemenu = (RiderMainPageViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RiderMainPageViewController"];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:home];
        UINavigationController *smVC = [[UINavigationController alloc]initWithRootViewController:slidemenu];
        // define rear and frontviewcontroller
        SWRevealViewController *revealController = [[SWRevealViewController alloc]initWithRearViewController:smVC frontViewController:nav];
        self.window.rootViewController=revealController;
    }
    }

    
    [application setStatusBarHidden:NO];
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [self startLocationUpdates];
      
    [GMSServices provideAPIKey:@"AIzaSyAAmTzjlk0m_F6WCAHAyYC8DkfbuUrr6Mw"];
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                             categories:nil];
    [application registerUserNotificationSettings:settings];
    [application registerForRemoteNotifications];

    return YES;
}

- (void)startLocationUpdates
{
    if (locationManager == nil)
    {
        locationManager = [[CLLocationManager alloc] init];
    }
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.activityType = CLActivityTypeFitness;
    
    // Movement threshold for new events.
    locationManager.distanceFilter = 10; // meters
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
}


-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
//    devicetokenString = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]stringByReplacingOccurrencesOfString: @">" withString: @""] stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    
    NSString* devTokenValue = [[[[deviceToken description]
                                 stringByReplacingOccurrencesOfString:@"<"withString:@""]
                                stringByReplacingOccurrencesOfString:@">" withString:@""]
                               stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    NSLog(@"Device Token: %@",devTokenValue);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:devTokenValue forKey:@"devicetoken"];
    
    
//    NSLog(@"Did Register for Remote Notifications with Device Token DATA (%@) \n STRING token (%@)", deviceToken,devicetokenString);
//    
//    [[NSUserDefaults standardUserDefaults]setValue:devicetokenString forKey:@"devicetoken"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
    
    //If Same token received again dont take any action else save in NSUserdefaults or system and send to server to register against this device to send push notification on the token specified here.
}

-(void)application:(UIApplication *)application    didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Did Fail to Register for Remote Notifications");
    NSLog(@"%s:%@, %@",__PRETTY_FUNCTION__,error, error.localizedDescription);
}
- (void) application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)notification
{
    
    NSLog(@"remote notification: %@",[notification description]);
    
    if (notification)
    {
        NSLog(@"%@",notification);
        
        if ([notification objectForKey:@"aps"]) {
            if([[notification objectForKey:@"aps"] objectForKey:@"badge"]) {
                [UIApplication sharedApplication].applicationIconBadgeNumber = [[[notification objectForKey:@"aps"] objectForKey: @"badge"] intValue];
            }
        }
    }
 //   NSString* title = @"HoppInRide Notification";
    NSDictionary* aps = [notification objectForKey:@"aps"];
 //   NSString* alert = [aps objectForKey:@"alert"];
    NSString* alert2 = [aps objectForKey:@"code"];
    
    NSString *playSoundOnAlert = [NSString stringWithFormat:@"%@", [[notification objectForKey:@"aps"] objectForKey:@"sound"]];
    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath],playSoundOnAlert]];
    
    NSError *error;
    
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops = 0;
    [audioPlayer play];

    
    if ([alert2 isEqualToString:@"requested"])
    {
        NSDictionary* aps = [notification objectForKey:@"aps"];
        NSString *strChangetoJSON=[aps objectForKey:@"data"];
        NSData *data = [strChangetoJSON dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:nil];
        
        NSLog(@"Response Decode:%@",jsonResponse);
        
        [[NSUserDefaults standardUserDefaults]setObject:jsonResponse forKey:@"riderdata"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:@"requested" forKey:@"itemType"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        // this any item in list you want navigate to
        RiderRequestConformViewController *home = (RiderRequestConformViewController *) [storyboard instantiateViewControllerWithIdentifier:@"RiderRequestConformViewController"];
        
        RiderMainPageViewController *slidemenu = (RiderMainPageViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RiderMainPageViewController"];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:home];
        UINavigationController *smVC = [[UINavigationController alloc]initWithRootViewController:slidemenu];
        // define rear and frontviewcontroller
        SWRevealViewController *revealController = [[SWRevealViewController alloc]initWithRearViewController:smVC frontViewController:nav];
        self.window.rootViewController=revealController;
    
        
    }
    
    else if ([alert2 isEqualToString:@"completed"])
    {
        NSDictionary* aps = [notification objectForKey:@"aps"];
        NSString *strChangetoJSON=[aps objectForKey:@"data"];
        NSData *data = [strChangetoJSON dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:nil];
        
        NSLog(@"Response Decode:%@",jsonResponse);
        
        [[NSUserDefaults standardUserDefaults]setObject:jsonResponse forKey:@"riderdata2"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:@"completed" forKey:@"itemType"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        
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
    
    else if ([alert2 isEqualToString:@"canceled"])
    {
        NSDictionary* aps = [notification objectForKey:@"aps"];
        NSString *strChangetoJSON=[aps objectForKey:@"data"];
        NSData *data = [strChangetoJSON dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:nil];
        
        NSLog(@"Response Decode:%@",jsonResponse);
        
        [[NSUserDefaults standardUserDefaults]setObject:jsonResponse forKey:@"riderdata2"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:@"canceled" forKey:@"itemType"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
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


//    [JCNotificationCenter
//     enqueueNotificationWithTitle:title
//     message:alert
//     tapHandler:^{
//         NSLog(@"Received tap on notification banner!");
//     }];
//
    NSLog(@"Did Receive for Remote Notifications with UserInfo:%@", notification);
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
        
        NSMutableArray *arrdetails=[[NSMutableArray alloc]init];
        
        arrdetails=nil;
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrdetails];
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"detailsofall"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSMutableArray *arrpages=[[NSMutableArray alloc]init];
        arrpages=[responseJSON valueForKey:@"data"];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrpages forKey:@"detailsofall2"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        // this any item in list you want navigate to
        UpcomingRidesViewController *home = (UpcomingRidesViewController *) [storyboard instantiateViewControllerWithIdentifier:@"UpcomingRidesViewController"];
        
        RiderMainPageViewController *slidemenu = (RiderMainPageViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RiderMainPageViewController"];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:home];
        UINavigationController *smVC = [[UINavigationController alloc]initWithRootViewController:slidemenu];
        // define rear and frontviewcontroller
        SWRevealViewController *revealController = [[SWRevealViewController alloc]initWithRearViewController:smVC frontViewController:nav];
        self.window.rootViewController=revealController;
        
    }
    
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
         NSMutableArray *arrdetails=[[NSMutableArray alloc]init];
        
        arrdetails=[[[responseJSON valueForKey:@"data"] valueForKey:@"tripDetail"]valueForKey:@"trip"];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrdetails];
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"detailsofall"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSMutableArray *arrpages=[[NSMutableArray alloc]init];
        arrpages=[responseJSON valueForKey:@"data"];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrpages forKey:@"detailsofall2"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        // this any item in list you want navigate to
        UpcomingRidesViewController *home = (UpcomingRidesViewController *) [storyboard instantiateViewControllerWithIdentifier:@"UpcomingRidesViewController"];
        
        RiderMainPageViewController *slidemenu = (RiderMainPageViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RiderMainPageViewController"];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:home];
        UINavigationController *smVC = [[UINavigationController alloc]initWithRootViewController:slidemenu];
        // define rear and frontviewcontroller
        SWRevealViewController *revealController = [[SWRevealViewController alloc]initWithRearViewController:smVC frontViewController:nav];
        self.window.rootViewController=revealController;
    }

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
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
         NSMutableArray *arrdetails=[[NSMutableArray alloc]init];
        arrdetails=[[[responseJSON valueForKey:@"data"]valueForKey:@"tripDetail"] valueForKey:@"trip"];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrdetails forKey:@"detailsofall"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSMutableArray *arrpages=[[NSMutableArray alloc]init];
        arrpages=[responseJSON valueForKey:@"data"];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrpages forKey:@"detailsofall2"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        // this any item in list you want navigate to
        CancelledViewController *home = (CancelledViewController *) [storyboard instantiateViewControllerWithIdentifier:@"CancelledViewController"];
        
        RiderMainPageViewController *slidemenu = (RiderMainPageViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RiderMainPageViewController"];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:home];
        UINavigationController *smVC = [[UINavigationController alloc]initWithRootViewController:slidemenu];
        // define rear and frontviewcontroller
        SWRevealViewController *revealController = [[SWRevealViewController alloc]initWithRearViewController:smVC frontViewController:nav];
        self.window.rootViewController=revealController;

    }
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
   
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
