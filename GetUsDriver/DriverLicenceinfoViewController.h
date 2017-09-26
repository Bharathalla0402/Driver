//
//  DriverLicenceinfoViewController.h
//  GetUsHere For Driver
//
//  Created by bharat on 04/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJSON.h"
#import "JSON.h"


@interface DriverLicenceinfoViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSString *str;
    NSString *str1;
    NSString *str2;
    NSString *str3;
    NSString *str4;
    NSString *str5;
    NSString *str6;
    NSString *str7;
    NSString *str8;
    NSString *str9;
    
    NSString *str10;
    
    
    NSString *str91;
    NSString *str92;
    NSString *str93;
    NSString *str94;
    NSString *str95;
    
    NSString *strfilename;
    NSString *strfilestring;
    
    NSString *fileName;
    NSString *byteArray;
    
    IBOutlet UIButton *button;
    IBOutlet UIImageView *image;
    
    NSMutableArray *mutarray;
    
    
    NSString *UP1;
    NSString *UP2;
    NSString *UP3;
    NSString *UP4;
    NSString *UP5;
    NSString *UP6;
    
     
    UIImage *currentSelectedImage;
    UIImage *currentSelectedImage1;
    UIImage *currentSelectedImage2;
    UIImage *currentSelectedImage3;
    UIImage *currentSelectedImage4;
    UIImage *currentSelectedImage5;
    
    NSMutableDictionary *arrfileimage;
}
@property (weak, nonatomic) IBOutlet UIButton *nextbutt;

@property (weak, nonatomic) IBOutlet UILabel *lab1uplic;
@property (weak, nonatomic) IBOutlet UILabel *lab2uplic;
@property (weak, nonatomic) IBOutlet UILabel *lab3uplic;
@property (weak, nonatomic) IBOutlet UILabel *lab4uplic;
@property (weak, nonatomic) IBOutlet UILabel *lab5uplic;
@property (weak, nonatomic) IBOutlet UILabel *lab6uplic;

@property (weak, nonatomic) IBOutlet UILabel *dllab;
@property (weak, nonatomic) IBOutlet UILabel *tlclab;
@property (weak, nonatomic) IBOutlet UILabel *dclab;
@property (weak, nonatomic) IBOutlet UILabel *reglab;
@property (weak, nonatomic) IBOutlet UILabel *fh1lab;
@property (weak, nonatomic) IBOutlet UILabel *insuoflialab;

@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UILabel *lab4;
@property (weak, nonatomic) IBOutlet UILabel *lab5;
@property (weak, nonatomic) IBOutlet UILabel *lab6;

@end
