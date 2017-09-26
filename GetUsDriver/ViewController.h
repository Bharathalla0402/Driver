//
//  ViewController.h
//  GetUsDriver
//
//  Created by bharat on 06/04/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>
{
    
    NSMutableData *Mutabledata;
    NSMutableArray *name;
    BOOL checked;
    
    NSString *str;
    NSString *strNmae;
    NSString *riderid;
    NSString *strtotaltrips;
    NSString *strcancelltrips;
    NSString *mobile;
    
    NSMutableArray *arrname;
    
    NSString *strdevicetoken;
    NSString *deviceid;
    
    NSString *email;
    NSMutableArray *arrdetails;
    
    NSString *strimageurl;
    
}
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPwd;

@property BOOL isInternetConnectionAvailable;

@property (weak, nonatomic) IBOutlet UIButton *loginbutt;

@property (weak, nonatomic) IBOutlet UIButton *forgotbutt;

@property (weak, nonatomic) IBOutlet UIView *emailview;
@property (weak, nonatomic) IBOutlet UIView *passwordview;

@end

