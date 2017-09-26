//
//  CancelledinfodetailViewController.h
//  GetUsDriver
//
//  Created by bharat on 22/06/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPFloatRatingView.h"

@interface CancelledinfodetailViewController : UIViewController<TPFloatRatingViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *driverprofileimage;
@property (weak, nonatomic) IBOutlet UIView *detailview;
@property (weak, nonatomic) IBOutlet UILabel *txtname;

@property (weak, nonatomic) IBOutlet UILabel *pickuplab;
@property (weak, nonatomic) IBOutlet UILabel *deslab;

@property (weak, nonatomic) IBOutlet UILabel *bookingtime;
@property (weak, nonatomic) IBOutlet UILabel *bookingstatus;

@property (weak, nonatomic) IBOutlet UILabel *resaon;

@property (weak, nonatomic) IBOutlet UILabel *pickuptitlelab;
@property (weak, nonatomic) IBOutlet UILabel *pickuplinelab;
@property (weak, nonatomic) IBOutlet UILabel *destitlelab;
@property (weak, nonatomic) IBOutlet UILabel *deslinelab;
@property (weak, nonatomic) IBOutlet UILabel *dateandtimetitlelab;
@property (weak, nonatomic) IBOutlet UILabel *dateandtimelinelab;
@property (weak, nonatomic) IBOutlet UILabel *reasontitlelab;
@property (weak, nonatomic) IBOutlet UILabel *reasonlinelab;


@property(nonatomic,retain) NSString *strname;
@property(nonatomic,retain) NSString *strimageurl;
@property(nonatomic,retain) NSString *strratingnumber;

@property(nonatomic,retain) NSString *strpickup;
@property(nonatomic,retain) NSString *strDestination;

@property(nonatomic,retain) NSString *strdate;
@property(nonatomic,retain) NSString *strtime;
@property(nonatomic,retain) NSString *strstatus;

@property(nonatomic,retain) NSString *strreason;

@property(nonatomic,retain) NSString *strtripid;

@end
