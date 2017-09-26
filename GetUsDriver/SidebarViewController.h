//
//  SidebarViewController.h
//  Jaguar Enterprises
//
//  Created by bharat on 01/02/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
#import "SWRevealViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "MyAnnotation.h"


@interface SidebarViewController : UIViewController<MKMapViewDelegate,SWRevealViewControllerDelegate,UIGestureRecognizerDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    MKCoordinateRegion region;
    NSMutableArray *arrcars;
    NSMutableArray *arrid;
    NSMutableArray *arrdetails;
    
    NSMutableArray *arrcount;
    UIView *popview;
    
     NSString *str3;
    
    float latitude;
    float longitude;
    
    int count;

}
@property (weak, nonatomic) IBOutlet UILabel *titlelab;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (weak, nonatomic) IBOutlet UIButton *viewpingbutt;

@property (weak, nonatomic) IBOutlet UISwitch *switchcheck;
@property (weak, nonatomic) IBOutlet UILabel *lbltext;
@property (weak, nonatomic) IBOutlet UIView *viewforback;

@property BOOL isInternetConnectionAvailable;

@end
