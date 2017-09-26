//
//  RiderRequestConformViewController.h
//  GetUsDriver
//
//  Created by bharat on 07/06/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RiderRequestConformViewController : UIViewController<UIGestureRecognizerDelegate>
{
    NSMutableArray *arrdetails;
    NSMutableArray *arrdetails2;
    
    float latitude;
    float longitude;
    
    float latitude1;
    float longitude1;
    
    int count;
}

@property BOOL isInternetConnectionAvailable;
@property (weak, nonatomic) IBOutlet UIView *riderdetailsView;

@property (weak, nonatomic) IBOutlet UILabel *yourCountdownlab;
@property (weak, nonatomic) IBOutlet UILabel *coundownlinelab;

@property (weak, nonatomic) IBOutlet UILabel *countinglab;
@property (weak, nonatomic) IBOutlet UIView *acceptView;
@property (weak, nonatomic) IBOutlet UIView *rejectview;

@property (weak, nonatomic) IBOutlet UILabel *locationsView;
@property (weak, nonatomic) IBOutlet UILabel *locationslinelab;

@property (weak, nonatomic) IBOutlet UIView *topview;



@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UIButton *backbutt;


@property (weak, nonatomic) IBOutlet UILabel *txtTotalTrip;
@property (weak, nonatomic) IBOutlet UILabel *txtCancelTrip;
@property (weak, nonatomic) IBOutlet UILabel *txtCompletedTrip;
@property (weak, nonatomic) IBOutlet UILabel *txtUserName;
@property (weak, nonatomic) IBOutlet UIImageView *UserImage;


@property (weak, nonatomic) IBOutlet UILabel *txtnumber;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *progressHeight;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIProgressView *progressbar;


@property (weak, nonatomic) IBOutlet UIButton *acceptbutt;
@property (weak, nonatomic) IBOutlet UIButton *rejectbutt;

@property (weak, nonatomic) IBOutlet UILabel *labpickup;
@property (weak, nonatomic) IBOutlet UILabel *labdes;

@property (weak, nonatomic) IBOutlet UILabel *labestimatetime;


@property (strong, nonatomic) UIWindow *window;

@end
