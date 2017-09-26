//
//  AcceptingRequestFormViewController.h
//  GetUsDriver
//
//  Created by bharat on 22/06/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AcceptingRequestFormViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *detailView;

@property (weak, nonatomic) IBOutlet UIButton *yesbutt;

@property (weak, nonatomic) IBOutlet UIButton *nobutt;
@property BOOL isInternetConnectionAvailable;

@end
