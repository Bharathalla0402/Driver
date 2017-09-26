//
//  PingViewController.h
//  GetUsHere For Driver
//
//  Created by bharat on 04/04/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyAnnotation.h"
//@import GoogleMaps;


@interface PingViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    MKCoordinateRegion region;
    
    NSString *str3;
    NSString *strAdd,*strAdd1;

    
    float latitude;
    float longitude;
    
    int count;
  
}
@property (weak, nonatomic) IBOutlet UISwitch *switchcheck;
@property (weak, nonatomic) IBOutlet UILabel *lbltext;
@property(nonatomic, strong) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *viewforback;

@end
