//
//  CompletedtripsViewController.h
//  GetUsHere For Driver
//
//  Created by bharat on 04/04/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompletedtripsViewController : UIViewController
{
    
    IBOutlet UITableView *tab;
    IBOutlet UIButton *butt;
    IBOutlet UIButton *butt1;
    
    BOOL isClicked;
    NSInteger selectedIndex;
    NSMutableDictionary *arrpages;
    
    NSString *strpage;
    NSString *strpagepre;
    
    NSMutableArray *arrdetails;
    NSMutableArray *arrinvoicedetails;
}

@property (weak, nonatomic) IBOutlet UIButton *smallPrevious;
@property (weak, nonatomic) IBOutlet UIButton *smallnext;
@property (weak, nonatomic) IBOutlet UIButton *next;
@property (weak, nonatomic) IBOutlet UIButton *previous;

@end
