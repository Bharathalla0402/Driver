//
//  RatingViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 31/05/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPFloatRatingView.h"

@interface RatingViewController : UIViewController<TPFloatRatingViewDelegate,UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *ratingLabel;
@property (strong, nonatomic) IBOutlet TPFloatRatingView *ratingView;
@property (weak, nonatomic) IBOutlet UITextView *txtReview;
@property (weak, nonatomic) IBOutlet UIButton *submitbutt;
@property (weak, nonatomic) IBOutlet UIButton *cancelbutt;

@property (weak, nonatomic) IBOutlet UIView *navigatebar;
@property (weak, nonatomic) IBOutlet UILabel *titlelable;
@property (weak, nonatomic) IBOutlet UIButton *backbtn;

@property(nonatomic,retain) NSString *strtripid;



@end
