//
//  ConformViewController.h
//  GetUsHere For Driver
//
//  Created by bharat on 04/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConformViewController : UIViewController
{

    NSString *str;
}
@property (weak, nonatomic) IBOutlet UILabel *txtmessage;
@property (weak, nonatomic) IBOutlet UITextView *textmsg;

@property (weak, nonatomic) IBOutlet UIButton *nextbutt;
@property (weak, nonatomic) IBOutlet UILabel *titlelab;

@property (weak, nonatomic) IBOutlet UILabel *filesLabel;
@end
