//
//  VehicleinfoViewController.h
//  GetUsHere For Driver
//
//  Created by bharat on 04/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VehicleinfoViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *arrcar;
    NSMutableArray *arrcares;
    UITableView *tabl;
    UITableView *CartypeTable;
    NSString *strid;
}
@property (weak, nonatomic) IBOutlet UITextField *txtmake;
@property (weak, nonatomic) IBOutlet UITextField *txtmodel;
@property (weak, nonatomic) IBOutlet UITextField *txtcolor;
@property (weak, nonatomic) IBOutlet UITextField *txtlicence;
@property (weak, nonatomic) IBOutlet UITextField *txtCarType;
@property (weak, nonatomic) IBOutlet UITextField *txtCar;
@property (weak, nonatomic) IBOutlet UITextField *txtwheelchair;
@property (weak, nonatomic) IBOutlet UITextField *txtYear;
@property (weak, nonatomic) IBOutlet UIButton *nextbutt;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewlend;


@property (weak, nonatomic) IBOutlet UIView *cartypeView;
@property (weak, nonatomic) IBOutlet UIView *carsubtypeView;
@property (weak, nonatomic) IBOutlet UIView *wheelchairView;
@property (weak, nonatomic) IBOutlet UIView *makeView;
@property (weak, nonatomic) IBOutlet UIView *modelView;
@property (weak, nonatomic) IBOutlet UIView *yearView;
@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet UIView *licenceView;


@property (weak, nonatomic) IBOutlet UILabel *vehiclelab;


@end
