//
//  AppDelegate.h
//  GetUsDriver
//
//  Created by bharat on 06/04/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>
{
    NSString *devicetokenString;
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) UIWindow *window;


@end

