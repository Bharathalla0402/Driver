//
//  ConformPaymentDriverViewController.h
//  GetUsDriver
//
//  Created by bharat on 18/06/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConformPaymentDriverViewController : UIViewController
{

    NSMutableArray *arrdetails;
    NSMutableArray *arrinvoicedetails;
}
@property BOOL isInternetConnectionAvailable;

@property (weak, nonatomic) IBOutlet UILabel *labInvoiceno;
@property (weak, nonatomic) IBOutlet UILabel *labTotaldistance;
@property (weak, nonatomic) IBOutlet UILabel *labTotalRidetime;
@property (weak, nonatomic) IBOutlet UILabel *labTotalfare;
@property (weak, nonatomic) IBOutlet UILabel *labTotalpaid;

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIButton *conformbutt;
@property (weak, nonatomic) IBOutlet UIButton *declinebutt;

@end
