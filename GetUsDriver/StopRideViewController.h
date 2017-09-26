//
//  StopRideViewController.h
//  GetUsDriver
//
//  Created by bharat on 13/06/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StopRideViewController : UIViewController<UIAlertViewDelegate>
{
    NSMutableArray *arrdriverinfo;
    NSString *strtripid;
    NSMutableArray *tripinfo;
    NSMutableArray *Driverlocationdetails;
    NSMutableArray *arrinvoicedetails;
    
    NSMutableArray *arrdetails;
}

@property BOOL isInternetConnectionAvailable;
@property (weak, nonatomic) IBOutlet UIView *detailview;
@property (weak, nonatomic) IBOutlet UILabel *txtname;

@property (weak, nonatomic) IBOutlet UIView *topview;


@property (weak, nonatomic) IBOutlet UIButton *NavigateButton;
@property (weak, nonatomic) IBOutlet UILabel *pickuplab;
@property (weak, nonatomic) IBOutlet UILabel *deslab;

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIButton *callbutt;

@property (weak, nonatomic) IBOutlet UIButton *startRideButt;


@property (weak, nonatomic) IBOutlet UILabel *pickuptitlelab;
@property (weak, nonatomic) IBOutlet UILabel *destitlelab;


@end
