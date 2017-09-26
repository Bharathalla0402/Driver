//
//  StartRideViewController.h
//  GetUsDriver
//
//  Created by bharat on 10/06/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartRideViewController : UIViewController<UIActionSheetDelegate>
{
    NSMutableArray *arrdriverinfo;
    NSString *strtripid;
    NSMutableArray *tripinfo;
    NSMutableArray *Driverlocationdetails;
     int value;
    
    NSString *strwaitid;
    UIView *popview,*footerview;
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

@property (weak, nonatomic) IBOutlet UIButton *startRideButt;


@property (weak, nonatomic) IBOutlet UIView *waitingView;
@property (weak, nonatomic) IBOutlet UILabel *waitingtimalab;

@property (weak, nonatomic) IBOutlet UILabel *picuptitlelab;
@property (weak, nonatomic) IBOutlet UILabel *destitlelab;


@end
