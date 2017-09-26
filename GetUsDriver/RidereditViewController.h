//
//  RidereditViewController.h
//  Jaguar Enterprises
//
//  Created by bharat on 27/01/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RiderMainPageViewController.h"


@interface RidereditViewController : UIViewController<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    
    NSMutableArray *arrname;
    NSMutableArray *arrContact;
    
    NSMutableArray *arrperDetails;
    NSMutableArray *arrtripcounts;
    
    UIView *popview,*footerview;
    
    NSMutableArray *arrid;
    
    NSString *base64Encoded;
    
    
    NSMutableArray *personaldetails;
    
    NSString *strimagename;
    
    
    NSString *strdl;
    NSString *strtl;
    NSString *strreg;
    NSString *strdc;
    NSString *strfh1;
    NSString *strll;
}

@property (weak, nonatomic) IBOutlet UIView *first;
@property (weak, nonatomic) IBOutlet UIView *second;
@property (weak, nonatomic) IBOutlet UIView *third;
@property (weak, nonatomic) IBOutlet UIView *fourth;
@property (weak, nonatomic) IBOutlet UIView *fifth;


@property (weak, nonatomic) IBOutlet UILabel *personalinfolab;
@property (weak, nonatomic) IBOutlet UILabel *personalinfolinelab;

@property (weak, nonatomic) IBOutlet UILabel *vehicleinfolab;
@property (weak, nonatomic) IBOutlet UILabel *vehicleinfolinelab;

@property (weak, nonatomic) IBOutlet UILabel *drivinginfolab;
@property (weak, nonatomic) IBOutlet UILabel *drivinginfolinelab;

@property (weak, nonatomic) IBOutlet UILabel *emergencycontactlab;
@property (weak, nonatomic) IBOutlet UILabel *emergencycontactlinelab;








@property (weak, nonatomic) IBOutlet UITableView *contacttable;


@property (weak, nonatomic) IBOutlet UITextField *txtName;

@property (weak, nonatomic) IBOutlet UILabel *lblname;
@property (weak, nonatomic) IBOutlet UILabel *lbltrip;
@property (weak, nonatomic) IBOutlet UILabel *lblcancel;
@property (weak, nonatomic) IBOutlet UILabel *lblcompleted;

@property (weak, nonatomic) IBOutlet UITextField *txtcontact;
@property (weak, nonatomic) IBOutlet UILabel *txtemail;
//@property (weak, nonatomic) IBOutlet UITextField *txtemail;
@property (weak, nonatomic) IBOutlet UILabel *txtLanguagesKnown;
@property (weak, nonatomic) IBOutlet UIButton *languagebutt;


@property (weak, nonatomic) IBOutlet UIImageView *imag;

@property (weak, nonatomic) IBOutlet UIButton *pictureedit;

@property (weak, nonatomic) IBOutlet UIButton *pictureImage;
@property (weak, nonatomic) IBOutlet UIButton *personalCancel;
@property (weak, nonatomic) IBOutlet UIButton *personalUpdate;

@property (weak, nonatomic) IBOutlet UIButton *addanother;

@property (weak, nonatomic) IBOutlet UILabel *labyear;

@property (weak, nonatomic) IBOutlet UITextField *txtCarBrand;
@property (weak, nonatomic) IBOutlet UITextField *txtCarModel;
@property (weak, nonatomic) IBOutlet UITextField *txtMake;
@property (weak, nonatomic) IBOutlet UITextField *txtModel;
@property (weak, nonatomic) IBOutlet UITextField *txtColor;
@property (weak, nonatomic) IBOutlet UITextField *txtlicencePlate;


@end
