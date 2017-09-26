//
//  ConformViewController.m
//  GetUsHere For Driver
//
//  Created by bharat on 04/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "ConformViewController.h"
#import "ViewController.h"
#import "SplachscreenViewController.h"
#import "SWRevealViewController.h"

@interface ConformViewController ()

@end

@implementation ConformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back.jpg"]];
    str=[[NSUserDefaults standardUserDefaults]objectForKey:@"message"];
    
    _textmsg.text=str;
    
   // _txtmessage.text=str;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
     _nextbutt.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _titlelab.textColor=[UIColor purpleColor];
    _textmsg.textColor=[UIColor purpleColor];
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
    

   
}

- (IBAction)OkClicked:(id)sender
{
    self.view.userInteractionEnabled=NO;
    
    SplachscreenViewController *book=[self.storyboard instantiateViewControllerWithIdentifier:@"SplachscreenViewController"];
    [self.navigationController pushViewController:book animated:YES];

}


-(void)viewDidDisappear:(BOOL)animated
{
    
    self.title = @"";
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = YES;
    
    self.view.userInteractionEnabled=YES;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"Confirmation";
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
