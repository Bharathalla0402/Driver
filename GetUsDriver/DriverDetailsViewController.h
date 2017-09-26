//
//  DriverDetailsViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 28/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DriverDetailsViewController : UIViewController<UIGestureRecognizerDelegate>
{

    NSMutableArray *arrdriverinfo;
    NSString *strtripid;
    NSMutableArray *tripinfo;
    NSMutableArray *Driverlocationdetails;
    
    NSMutableArray *arrdetails;
}
@property (weak, nonatomic) IBOutlet UILabel *locationtitleView;
@property (weak, nonatomic) IBOutlet UILabel *locationlineview;
@property BOOL isInternetConnectionAvailable;

@property (weak, nonatomic) IBOutlet UIView *detailview;
@property (weak, nonatomic) IBOutlet UIButton *callbutton;
@property (weak, nonatomic) IBOutlet UILabel *txtname;

@property (weak, nonatomic) IBOutlet UIView *topview;

@property (weak, nonatomic) IBOutlet UIButton *NavigateButton;
@property (weak, nonatomic) IBOutlet UILabel *pickuplab;
@property (weak, nonatomic) IBOutlet UILabel *deslab;

@property (weak, nonatomic) IBOutlet UILabel *bookingtime;
@property (weak, nonatomic) IBOutlet UILabel *bookingstatus;


@property (weak, nonatomic) IBOutlet UIButton *ArrivedatPickupLocationbutt;
@property (weak, nonatomic) IBOutlet UIButton *CancelRidebutt;

@property (weak, nonatomic) IBOutlet UIButton *backButtonClicked;


@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@property (weak, nonatomic) IBOutlet UIView *estimateView;
@property (weak, nonatomic) IBOutlet UIView *distanceView;

@property (weak, nonatomic) IBOutlet UILabel *estimatedtime;
@property (weak, nonatomic) IBOutlet UILabel *distancelab;

@end
