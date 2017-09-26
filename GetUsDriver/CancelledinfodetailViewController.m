//
//  CancelledinfodetailViewController.m
//  GetUsDriver
//
//  Created by bharat on 22/06/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "CancelledinfodetailViewController.h"
#import "SidebarViewController.h"
#import "UIImageView+WebCache.h"
#import "SplachscreenViewController.h"
#import "GetUsHere.pch"

@interface CancelledinfodetailViewController ()

@end

@implementation CancelledinfodetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.title=@"Cancelled Ride";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"itemType"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    _txtname.text=_strname;
    _pickuplab.text=_strpickup;
    _deslab.text=_strDestination;
    _bookingtime.text=[NSString stringWithFormat:@"%@ %@",_strdate,_strtime];
    _bookingstatus.text=_strstatus;
    _resaon.text=_strreason;
    
    _pickuptitlelab.textColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _destitlelab.textColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _pickuplinelab.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _deslinelab.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _dateandtimetitlelab.textColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _dateandtimelinelab.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _reasontitlelab.textColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _reasonlinelab.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    
    _driverprofileimage.layer.cornerRadius = _driverprofileimage.frame.size.height /2;
    _driverprofileimage.layer.masksToBounds = YES;
    _driverprofileimage.layer.borderWidth = 0;
    
    NSString *strurl=_strimageurl;
    
    TPFloatRatingView *ratingview=(TPFloatRatingView *)[self.view viewWithTag:2];
    
    _detailview.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    ratingview.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    
    NSString *str1=[NSString stringWithFormat:@"%@",_strratingnumber];
    float value = [str1 floatValue];
    
    ratingview.emptySelectedImage = [UIImage imageNamed:@"StarEmpty"];
    ratingview.fullSelectedImage = [UIImage imageNamed:@"StarFull"];
    ratingview.contentMode = UIViewContentModeScaleAspectFill;
    ratingview.editable = NO;
    ratingview.halfRatings = YES;
    ratingview.floatRatings = YES;
    ratingview.rating=value;
    
    if (![strurl isEqualToString:@""])
    {
        [_driverprofileimage sd_setImageWithURL:[NSURL URLWithString:_strimageurl]
                         placeholderImage:[UIImage imageNamed:@"profilepic.png"]];

    }
    
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"b" style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(barButtonBackPressed:)];
    [backButton setImage:[UIImage imageNamed:@"Untitled-1-2.png"]];
    
    self.navigationItem.leftBarButtonItem = backButton;
}

-(void)barButtonBackPressed:(id)sender
{
    SidebarViewController *side=[self.storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"];
    [self.navigationController pushViewController:side animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"GPS";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,logincheck]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&device_id=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"devicetoken"]]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONRdevicecheck:data];
                               }
                           }];
    
    
    
}


-(void)parseJSONRdevicecheck:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
 //   NSLog(@"***** login check details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        //
        //        [alert show];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Login"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        SplachscreenViewController *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"SplachscreenViewController"];
        UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
        [navController setViewControllers: @[edit] animated: NO ];
        [self.revealViewController setFrontViewController:navController animated:YES];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        
        
    }
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
