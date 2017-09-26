//
//  RegistrationViewController.h
//  GetUsHere For Driver
//
//  Created by bharat on 04/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableData *mdata;
    BOOL checked;
    IBOutlet UIButton *checkboxbutton1;
    IBOutlet UIScrollView *scrollView;
    NSMutableArray *arrcars;
    
     NSString *strCountryCodeMobile;
}
@property BOOL isInternetConnectionAvailable;

@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtaddress;
@property (weak, nonatomic) IBOutlet UITextField *txtSelectLanguage;
@property (weak, nonatomic) IBOutlet UIButton *languagebutt;


@property (weak, nonatomic) IBOutlet UITextField *txtgender;
@property (weak, nonatomic) IBOutlet UIButton *genderbutt;
@property (weak, nonatomic) IBOutlet UIButton *nextbutt;

@property (weak, nonatomic) IBOutlet UITextField *txtCountryCode;

@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UIView *genderView;
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UIView *ccView;
@property (weak, nonatomic) IBOutlet UIView *numberView;
@property (weak, nonatomic) IBOutlet UIView *emailView;
@property (weak, nonatomic) IBOutlet UIView *emergencyView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewlend;

@property (weak, nonatomic) IBOutlet UILabel *registerheaderlab;
@property (weak, nonatomic) IBOutlet UILabel *pluslab;
@property (weak, nonatomic) IBOutlet UILabel *agreelab;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@end
