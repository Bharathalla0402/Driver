//
//  UpcomingRidesViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 18/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "UpcomingRidesViewController.h"
#import "UpcomingTableViewCell.h"
#import "UpcomingTableviewcell2.h"
#import "DejalActivityView.h"
#import "UpcomingdetailsViewController.h"
#import "SidebarViewController.h"
#import "DetailtripViewController.h"
#import "GetUsHere.pch"
#import "DriverDetailsViewController.h"
#import "InvoiceDetailViewController.h"
#import "TPFloatRatingView.h"
#import "RatingViewController.h"
#import "ConformPaymentDriverViewController.h"
#import "RiderRequestConformViewController.h"
#import "StartRideViewController.h"
#import "StopRideViewController.h"
#import "CancelledinfodetailViewController.h"
#import "SWRevealViewController.h"
#import "SplachscreenViewController.h"



@interface UpcomingRidesViewController ()<TPFloatRatingViewDelegate>
{
    UpcomingTableviewcell2 *cell2;
    UpcomingTableViewCell *cell;
    
    UpcomingTableViewCell *cell1;
    UpcomingTableviewcell2 *cell3;
    
    UpcomingTableViewCell *cell5;
}

@end

@implementation UpcomingRidesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"My Rides";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"b" style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(barButtonBackPressed:)];
    [backButton setImage:[UIImage imageNamed:@"Untitled-1-2.png"]];
    
   // selectedIndex = -1;
    isClicked = NO;
    
    self.view.userInteractionEnabled=YES;
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"itemType"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _smallPrevious.hidden=YES;
    _smallnext.hidden=YES;
    _previous.hidden=YES;
    _next.hidden=YES;
    
    _next.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    arrupcomingdetails=[[NSMutableArray alloc]init];
    arrpages=[[NSMutableDictionary alloc]init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"detailsofall"];
    arrupcomingdetails = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    //    NSUserDefaults *defaults2 = [NSUserDefaults standardUserDefaults];
    //    NSData *data2 = [defaults2 objectForKey:@"detailsofall2"];
    arrpages = [[NSUserDefaults standardUserDefaults]objectForKey:@"detailsofall2"];
    
    if (arrupcomingdetails==nil)
    {
        tab.hidden=YES;
    }
    
    if ([[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"prevPage"]]isEqualToString:@"0"] && ![[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"nextPage"]]isEqualToString:@"0"])
    {
         tab.hidden=NO;
        _next.hidden=NO;
        _smallPrevious.hidden=YES;
        _smallnext.hidden=YES;
        _previous.hidden=YES;
        strpage=[arrpages valueForKey:@"nextPage"];
        _next.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
        [_next addTarget:self action:@selector(nextClick4:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    // arrdetails=[[NSUserDefaults standardUserDefaults]objectForKey:@"detailsofall"];
    arrdetails=[[NSMutableArray alloc]init];
    arrcompleteddetails=[[NSMutableArray alloc]init];
    arrinvoicedetails=[[NSMutableArray alloc]init];
    butt.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _segmentchang.selectedSegmentIndex=0;
    
    arrdriverinfo=[[NSMutableArray alloc]init];
    arrtripinfo=[[NSMutableArray alloc]init];
    
 
        SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
  
    
    if (_segmentchang.selectedSegmentIndex==0)
    {
    
        UIColor *selectedColor = [UIColor colorWithRed: 90.0f/255.0 green:143.0f/255.0 blue:63.0f/255.0 alpha:1.0];
        UIColor *deselectedColor = [UIColor colorWithRed: 90.0f/255.0 green:143.0f/255.0 blue:63.0f/255.0 alpha:1.0];
        
        for (id subview in [_segmentchang subviews]) {
            if ([subview isSelected])
                [subview setTintColor:selectedColor];
            else
                [subview setTintColor:deselectedColor]; 
        }
        
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIFont fontWithName:@"System Bold" size:13], NSFontAttributeName,
                                    [UIColor colorWithRed: 90.0f/255.0 green:143.0f/255.0 blue:63.0f/255.0 alpha:1.0], NSForegroundColorAttributeName, nil];
        
        [_segmentchang setTitleTextAttributes:attributes forState:UIControlStateNormal];

        [tab reloadData];
        tab.tag=2;
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
        [self nex14];
        [tab reloadData];
    }
    [tab reloadData];
    
}



-(void)barButtonBackPressed:(id)sender
{
    self.view.userInteractionEnabled=NO;
    SidebarViewController *side=[self.storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"];
    [self.navigationController pushViewController:side animated:YES];
}

- (IBAction)segmentvaluechanged:(id)sender
{
    UIColor *selectedColor = [UIColor colorWithRed: 90.0f/255.0 green:143.0f/255.0 blue:63.0f/255.0 alpha:1.0];
    UIColor *deselectedColor = [UIColor colorWithRed: 90.0f/255.0 green:143.0f/255.0 blue:63.0f/255.0 alpha:1.0];
    
    for (id subview in [_segmentchang subviews]) {
        if ([subview isSelected])
            [subview setTintColor:selectedColor];
        else
            [subview setTintColor:deselectedColor];
        
    }
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont fontWithName:@"System Bold" size:13], NSFontAttributeName,
                                [UIColor colorWithRed: 90.0f/255.0 green:143.0f/255.0 blue:63.0f/255.0 alpha:1.0], NSForegroundColorAttributeName, nil];
    
    [_segmentchang setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    if (_segmentchang.selectedSegmentIndex==0)
    {
         tab.hidden=NO;
      //  selectedIndex = -1;
        [tab reloadData];
        tab.tag=2;
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
        [self nex14];
        [tab reloadData];
        
    }
    if (_segmentchang.selectedSegmentIndex==1)
    {
         tab.hidden=NO;
        //selectedIndex = -1;
        [tab reloadData];
        tab.tag=3;
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
        [self ne15];
        [tab reloadData];
    }
    if (_segmentchang.selectedSegmentIndex==2)
    {
         tab.hidden=NO;
       // selectedIndex = -1;
        [tab reloadData];
        tab.tag=1;
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
        [self next12];
        [tab reloadData];
    }
}


#pragma mark - All Details

-(void)next12
{
     NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getTrips]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"driver"]];
    [profile appendString:[NSString stringWithFormat:@"&trip_type=%@",@"all"]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONResponse:data];
                               }
                           }];
    
    
}

-(void)parseJSONResponse:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
 //   NSLog(@"*****All rides details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    // NSLog(@"%@",DataArray);
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
        tab.hidden=YES;
        
        _smallPrevious.hidden=YES;
        _smallnext.hidden=YES;
        _previous.hidden=YES;
        _next.hidden=YES;
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
      //  selectedIndex = -1;
        arrdetails=[[[responseJSON valueForKey:@"data"] valueForKey:@"tripDetail"]valueForKey:@"trip"];
          arrpages=[responseJSON valueForKey:@"data"];
        
        if ([[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"prevPage"]]isEqualToString:@"0"] && ![[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"nextPage"]]isEqualToString:@"0"])
        {
            _next.hidden=NO;
            _smallPrevious.hidden=YES;
            _smallnext.hidden=YES;
            _previous.hidden=YES;
            strpage=[arrpages valueForKey:@"nextPage"];
            _next.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
            [_next addTarget:self action:@selector(nextClick1:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        else if ([[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"prevPage"]]isEqualToString:@"0"] && [[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"nextPage"]]isEqualToString:@"0"])
        {
            _next.hidden=YES;
            _smallnext.hidden=YES;
            _smallPrevious.hidden=YES;
            _previous.hidden=YES;
        }

        [tab reloadData];
    }
}

-(void)nextClick1:(id)sender
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getTrips]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"driver"]];
    [profile appendString:[NSString stringWithFormat:@"&trip_type=%@",@"all"]];
    [profile appendString:[NSString stringWithFormat:@"&page=%@",strpage]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONResp11:data];
                               }
                           }];
    
}

-(void)parseJSONResp11:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
 //   NSLog(@"*****Next page details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    // NSLog(@"%@",DataArray);
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
       // selectedIndex = -1;
        
        arrdetails=[[[responseJSON valueForKey:@"data"] valueForKey:@"tripDetail"]valueForKey:@"trip"];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrdetails];
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"detailsofall"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        arrpages=[responseJSON valueForKey:@"data"];
        
        NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:arrdetails];
        [[NSUserDefaults standardUserDefaults]setObject:data2 forKey:@"detailsofall2"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        if (![[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"prevPage"]]isEqualToString:@"0"] && ![[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"nextPage"]]isEqualToString:@"0"])
        {
            _next.hidden=YES;
            _smallnext.hidden=NO;
            _smallPrevious.hidden=NO;
            _previous.hidden=YES;
            
            strpage=[arrpages valueForKey:@"nextPage"];
            strpagepre=[arrpages valueForKey:@"prevPage"];
            
            _smallnext.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
            _smallPrevious.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
            
            [_smallnext addTarget:self action:@selector(nextClick1:) forControlEvents:UIControlEventTouchUpInside];
            [_smallPrevious addTarget:self action:@selector(nextClick2:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (![[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"prevPage"]]isEqualToString:@"0"] && [[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"nextPage"]]isEqualToString:@"0"])
        {
            _next.hidden=YES;
            _smallnext.hidden=YES;
            _smallPrevious.hidden=YES;
            _previous.hidden=NO;
            strpagepre=[arrpages valueForKey:@"prevPage"];
            _previous.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
            [_previous addTarget:self action:@selector(nextClick2:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"prevPage"]]isEqualToString:@"0"] && ![[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"nextPage"]]isEqualToString:@"0"])
        {
            _next.hidden=NO;
            _smallnext.hidden=YES;
            _smallPrevious.hidden=YES;
            _previous.hidden=YES;
            
            strpage=[arrpages valueForKey:@"nextPage"];
            _next.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
            [_next addTarget:self action:@selector(nextClick1:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"prevPage"]]isEqualToString:@"0"] && [[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"nextPage"]]isEqualToString:@"0"])
        {
            _next.hidden=YES;
            _smallnext.hidden=YES;
            _smallPrevious.hidden=YES;
            _previous.hidden=YES;
        }
        [tab reloadData];
    }
}


-(void)nextClick2:(id)sender
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getTrips]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"driver"]];
    [profile appendString:[NSString stringWithFormat:@"&trip_type=%@",@"all"]];
    [profile appendString:[NSString stringWithFormat:@"&page=%@",strpagepre]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONResp11:data];
                               }
                           }];
    
}





#pragma mark - Upcoming Details

-(void)nex14
{
    
   NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getTrips]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"driver"]];
    [profile appendString:[NSString stringWithFormat:@"&trip_type=%@",@"upcoming"]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONRespons:data];
                               }
                           }];
    
    
}

-(void)parseJSONRespons:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];

 //   NSLog(@"*****Upcoming details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    // NSLog(@"%@",DataArray);
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
        tab.hidden=YES;
        _smallPrevious.hidden=YES;
        _smallnext.hidden=YES;
        _previous.hidden=YES;
        _next.hidden=YES;
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
     //   selectedIndex = -1;
        arrupcomingdetails=[[[responseJSON valueForKey:@"data"] valueForKey:@"tripDetail"]valueForKey:@"trip"];
        arrpages=[responseJSON valueForKey:@"data"];
        
        if ([[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"prevPage"]]isEqualToString:@"0"] && ![[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"nextPage"]]isEqualToString:@"0"])
        {
            _next.hidden=NO;
            _smallPrevious.hidden=YES;
            _smallnext.hidden=YES;
            _previous.hidden=YES;
            
            strpage=[arrpages valueForKey:@"nextPage"];
            _next.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
            [_next addTarget:self action:@selector(nextClick4:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"prevPage"]]isEqualToString:@"0"] && [[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"nextPage"]]isEqualToString:@"0"])
        {
            _next.hidden=YES;
            _smallnext.hidden=YES;
            _smallPrevious.hidden=YES;
            _previous.hidden=YES;
        }
        
        [tab reloadData];
    }
}



-(void)nextClick4:(id)sender
{
     [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getTrips]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"driver"]];
    [profile appendString:[NSString stringWithFormat:@"&trip_type=%@",@"upcoming"]];
    [profile appendString:[NSString stringWithFormat:@"&page=%@",strpage]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONResp12:data];
                               }
                           }];
    
}

-(void)parseJSONResp12:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
 //  NSLog(@"*****Next page Upcoming details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    // NSLog(@"%@",DataArray);
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
        //        FinalpayconformViewController *fpc=[self.storyboard instantiateViewControllerWithIdentifier:@"FinalpayconformViewController"];
        //        [self.navigationController pushViewController:fpc animated:YES];
    }
    
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
    //    selectedIndex = -1;
        arrupcomingdetails=[[[responseJSON valueForKey:@"data"] valueForKey:@"tripDetail"]valueForKey:@"trip"];
        
        arrpages=[responseJSON valueForKey:@"data"];
        
        NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:arrdetails];
        [[NSUserDefaults standardUserDefaults]setObject:data2 forKey:@"detailsofall2"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        if (![[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"prevPage"]]isEqualToString:@"0"] && ![[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"nextPage"]]isEqualToString:@"0"])
        {
            _next.hidden=YES;
            _smallnext.hidden=NO;
            _smallPrevious.hidden=NO;
            _previous.hidden=YES;
            
            strpage=[arrpages valueForKey:@"nextPage"];
            strpagepre=[arrpages valueForKey:@"prevPage"];
            
            _smallnext.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
            _smallPrevious.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
            
            [_smallnext addTarget:self action:@selector(nextClick4:) forControlEvents:UIControlEventTouchUpInside];
            [_smallPrevious addTarget:self action:@selector(nextClick5:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (![[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"prevPage"]]isEqualToString:@"0"] && [[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"nextPage"]]isEqualToString:@"0"])
        {
            _next.hidden=YES;
            _smallnext.hidden=YES;
            _smallPrevious.hidden=YES;
            _previous.hidden=NO;
            strpagepre=[arrpages valueForKey:@"prevPage"];
            _previous.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
            [_previous addTarget:self action:@selector(nextClick5:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"prevPage"]]isEqualToString:@"0"] && ![[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"nextPage"]]isEqualToString:@"0"])
        {
            _next.hidden=NO;
            _smallnext.hidden=YES;
            _smallPrevious.hidden=YES;
            _previous.hidden=YES;
            
            strpage=[arrpages valueForKey:@"nextPage"];
            _next.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
            [_next addTarget:self action:@selector(nextClick4:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"prevPage"]]isEqualToString:@"0"] && [[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"nextPage"]]isEqualToString:@"0"])
        {
            _next.hidden=YES;
            _smallnext.hidden=YES;
            _smallPrevious.hidden=YES;
            _previous.hidden=YES;
        }
        [tab reloadData];
    }
}


-(void)nextClick5:(id)sender
{
     [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getTrips]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"driver"]];
    [profile appendString:[NSString stringWithFormat:@"&trip_type=%@",@"upcoming"]];
    [profile appendString:[NSString stringWithFormat:@"&page=%@",strpagepre]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONResp12:data];
                               }
                           }];
    
}




#pragma mark - Completed Details


-(void)ne15
{
    
     NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getTrips]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"driver"]];
    [profile appendString:[NSString stringWithFormat:@"&trip_type=%@",@"completed"]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONRespon:data];
                               }
                           }];
    
    
}

-(void)parseJSONRespon:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
  //  NSLog(@"*****Completed details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
        tab.hidden=YES;
        _smallPrevious.hidden=YES;
        _smallnext.hidden=YES;
        _previous.hidden=YES;
        _next.hidden=YES;
        
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
    //    selectedIndex = -1;
        arrcompleteddetails=[[[responseJSON valueForKey:@"data"] valueForKey:@"tripDetail"]valueForKey:@"trip"];
        arrpages=[responseJSON valueForKey:@"data"];
        
        if ([[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"prevPage"]]isEqualToString:@"0"] && ![[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"nextPage"]]isEqualToString:@"0"])
        {
            _next.hidden=NO;
            _smallPrevious.hidden=YES;
            _smallnext.hidden=YES;
            _previous.hidden=YES;
            strpage=[arrpages valueForKey:@"nextPage"];
            _next.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
            [_next addTarget:self action:@selector(nextClick6:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"prevPage"]]isEqualToString:@"0"] && [[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"nextPage"]]isEqualToString:@"0"])
        {
            _next.hidden=YES;
            _smallnext.hidden=YES;
            _smallPrevious.hidden=YES;
            _previous.hidden=YES;
        }
        [tab reloadData];
    }
}


-(void)nextClick6:(id)sender
{
     [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getTrips]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"driver"]];
    [profile appendString:[NSString stringWithFormat:@"&trip_type=%@",@"completed"]];
    [profile appendString:[NSString stringWithFormat:@"&page=%@",strpage]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONResp13:data];
                               }
                           }];
    
}

-(void)parseJSONResp13:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
//    NSLog(@"*****Next page Completed details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    // NSLog(@"%@",DataArray);
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
        //        FinalpayconformViewController *fpc=[self.storyboard instantiateViewControllerWithIdentifier:@"FinalpayconformViewController"];
        //        [self.navigationController pushViewController:fpc animated:YES];
    }
    
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
    //    selectedIndex = -1;
        
        arrcompleteddetails=[[[responseJSON valueForKey:@"data"] valueForKey:@"tripDetail"]valueForKey:@"trip"];
        
        arrpages=[responseJSON valueForKey:@"data"];
    
        
        NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:arrdetails];
        [[NSUserDefaults standardUserDefaults]setObject:data2 forKey:@"detailsofall2"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        if (![[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"prevPage"]]isEqualToString:@"0"] && ![[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"nextPage"]]isEqualToString:@"0"])
        {
            _next.hidden=YES;
            _smallnext.hidden=NO;
            _smallPrevious.hidden=NO;
            _previous.hidden=YES;
            
            strpage=[arrpages valueForKey:@"nextPage"];
            strpagepre=[arrpages valueForKey:@"prevPage"];
            
            _smallnext.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
            _smallPrevious.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
            
            [_smallnext addTarget:self action:@selector(nextClick6:) forControlEvents:UIControlEventTouchUpInside];
            [_smallPrevious addTarget:self action:@selector(nextClick7:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (![[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"prevPage"]]isEqualToString:@"0"] && [[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"nextPage"]]isEqualToString:@"0"])
        {
            _next.hidden=YES;
            _smallnext.hidden=YES;
            _smallPrevious.hidden=YES;
            _previous.hidden=NO;
            strpagepre=[arrpages valueForKey:@"prevPage"];
            _previous.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
            [_previous addTarget:self action:@selector(nextClick7:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"prevPage"]]isEqualToString:@"0"] && ![[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"nextPage"]]isEqualToString:@"0"])
        {
            _next.hidden=NO;
            _smallnext.hidden=YES;
            _smallPrevious.hidden=YES;
            _previous.hidden=YES;
            
            strpage=[arrpages valueForKey:@"nextPage"];
            _next.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
            [_next addTarget:self action:@selector(nextClick6:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"prevPage"]]isEqualToString:@"0"] && [[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"nextPage"]]isEqualToString:@"0"])
        {
            _next.hidden=YES;
            _smallnext.hidden=YES;
            _smallPrevious.hidden=YES;
            _previous.hidden=YES;
        }
       [tab reloadData];
        
    }
}


-(void)nextClick7:(id)sender
{
     [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getTrips]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"driver"]];
     [profile appendString:[NSString stringWithFormat:@"&trip_type=%@",@"completed"]];
    [profile appendString:[NSString stringWithFormat:@"&page=%@",strpagepre]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONResp13:data];
                               }
                           }];
    
}




#pragma mark - Tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 250;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==1)
    {
        return arrdetails.count;
    }
    else if (tableView.tag==2)
    {
        return arrupcomingdetails.count;
    }
    else if (tableView.tag==3)
    {
        return arrcompleteddetails.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // butt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    
    if (tableView.tag==1)
    {
        static NSString *CellClassName = @"UpcomingTableViewCell";
        cell = (UpcomingTableViewCell *)[tableView dequeueReusableCellWithIdentifier: CellClassName];
        
        if (cell == nil)
        {
            cell = [[UpcomingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellClassName];
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UpcomingTableViewCell"
                                                                 owner:self options:nil];
            cell = [nib objectAtIndex:0];
           // cell.backgroundColor=[UIColor blackColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(8, 8, self.view.frame.size.width/2-11, 106)];
        view1.backgroundColor=[UIColor clearColor];
        [cell addSubview:view1];
        
        UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+3, 8, self.view.frame.size.width/2-11, 106)];
        view2.backgroundColor=[UIColor clearColor];
        [cell addSubview:view2];
        
        UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(8, 121, self.view.frame.size.width-16, 65)];
        view3.backgroundColor=[UIColor clearColor];
        [cell addSubview:view3];
        
        UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(16, 33, view1.frame.size.width-16, 1)];
        lab.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
        [cell addSubview:lab];
        
        UILabel *lab1=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+11, 33, view1.frame.size.width-20, 1)];
        lab1.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
        [cell addSubview:lab1];
        
        UILabel *lab2=[[UILabel alloc] initWithFrame:CGRectMake(16, 149, view3.frame.size.width-16, 1)];
        lab2.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
        [cell addSubview:lab2];

        
     //   UILabel *lbldate=(UILabel *)[cell viewWithTag:1];
        UILabel *lblsource=(UILabel *)[cell viewWithTag:2];
        UILabel *lbldestination=(UILabel *)[cell viewWithTag:3];
        UILabel *lbldateandtime=(UILabel *)[cell viewWithTag:4];
        UILabel *lblstatus=(UILabel *)[cell viewWithTag:5];
        UILabel *lbltime=(UILabel *)[cell viewWithTag:8];
        butt=(UIButton *)[cell viewWithTag:6];
                
    //    lbldate.text=[[arrdetails valueForKey:@"booking_date"]objectAtIndex:indexPath.row];
        lblsource.text=[[arrdetails valueForKey:@"src_addr"]objectAtIndex:indexPath.row];
        lbldestination.text=[[arrdetails valueForKey:@"dest_addr"]objectAtIndex:indexPath.row];
        lbldateandtime.text=[[arrdetails valueForKey:@"booking_date"]objectAtIndex:indexPath.row];
        lblstatus.text=[[arrdetails valueForKey:@"status"]objectAtIndex:indexPath.row];
        lbltime.text=[[arrdetails valueForKey:@"booking_time"]objectAtIndex:indexPath.row];
                
        butt.tag=indexPath.row;
        butt.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];

                
        [butt addTarget:self action:@selector(allDataridesClicked:) forControlEvents:UIControlEventTouchUpInside];
                
        return cell;
           
    }
    
    
    else if (tableView.tag==2)
    {
        static NSString *CellClassName = @"UpcomingTableViewCell";
        cell = (UpcomingTableViewCell *)[tableView dequeueReusableCellWithIdentifier: CellClassName];
        
        if (cell == nil)
        {
            cell = [[UpcomingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellClassName];
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UpcomingTableViewCell"
                                                             owner:self options:nil];
            cell = [nib objectAtIndex:0];
           // cell.backgroundColor=[UIColor blackColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(8, 8, self.view.frame.size.width/2-11, 106)];
        view1.backgroundColor=[UIColor clearColor];
        [cell addSubview:view1];
        
        UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+3, 8, self.view.frame.size.width/2-11, 106)];
        view2.backgroundColor=[UIColor clearColor];
        [cell addSubview:view2];
        
        UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(8, 121, self.view.frame.size.width-16, 65)];
        view3.backgroundColor=[UIColor clearColor];
        [cell addSubview:view3];
        
        UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(16, 33, view1.frame.size.width-16, 1)];
        lab.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
        [cell addSubview:lab];
        
        UILabel *lab1=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+11, 33, view1.frame.size.width-20, 1)];
        lab1.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
        [cell addSubview:lab1];
        
        UILabel *lab2=[[UILabel alloc] initWithFrame:CGRectMake(16, 149, view3.frame.size.width-16, 1)];
        lab2.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
        [cell addSubview:lab2];

        
     //   UILabel *lbldate=(UILabel *)[cell viewWithTag:1];
        UILabel *lblsource=(UILabel *)[cell viewWithTag:2];
        UILabel *lbldestination=(UILabel *)[cell viewWithTag:3];
        UILabel *lbldateandtime=(UILabel *)[cell viewWithTag:4];
        UILabel *lblstatus=(UILabel *)[cell viewWithTag:5];
        UILabel *lbltime=(UILabel *)[cell viewWithTag:8];
        
        butt=(UIButton *)[cell viewWithTag:6];
            
     //   lbldate.text=[[arrupcomingdetails valueForKey:@"booking_date"]objectAtIndex:indexPath.row];
        lblsource.text=[[arrupcomingdetails valueForKey:@"src_addr"]objectAtIndex:indexPath.row];
        lbldestination.text=[[arrupcomingdetails valueForKey:@"dest_addr"]objectAtIndex:indexPath.row];
        lbldateandtime.text=[[arrupcomingdetails valueForKey:@"booking_date"]objectAtIndex:indexPath.row];
        lblstatus.text=[[arrupcomingdetails valueForKey:@"status"]objectAtIndex:indexPath.row];
        lbltime.text=[[arrupcomingdetails valueForKey:@"booking_time"]objectAtIndex:indexPath.row];
            
        butt.tag=indexPath.row;
        butt.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];

        [butt addTarget:self action:@selector(upcominglistClicked:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    
    else if (tableView.tag==3)
    {
        static NSString *CellClassName = @"UpcomingTableViewCell";
        cell5 = (UpcomingTableViewCell *)[tableView dequeueReusableCellWithIdentifier: CellClassName];
            
        if (cell5 == nil)
        {
            cell5 = [[UpcomingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellClassName];
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UpcomingTableViewCell"
                                                             owner:self options:nil];
            cell5 = [nib objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
          //  cell5.backgroundColor=[UIColor blackColor];
        }
        
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(8, 8, self.view.frame.size.width/2-11, 106)];
        view1.backgroundColor=[UIColor clearColor];
        [cell5 addSubview:view1];
        
        UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+3, 8, self.view.frame.size.width/2-11, 106)];
        view2.backgroundColor=[UIColor clearColor];
        [cell5 addSubview:view2];
        
        UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(8, 121, self.view.frame.size.width-16, 65)];
        view3.backgroundColor=[UIColor clearColor];
        [cell5 addSubview:view3];
        
        UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(16, 33, view1.frame.size.width-16, 1)];
        lab.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
        [cell5 addSubview:lab];
        
        UILabel *lab1=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+11, 33, view1.frame.size.width-20, 1)];
        lab1.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
        [cell5 addSubview:lab1];
        
        UILabel *lab2=[[UILabel alloc] initWithFrame:CGRectMake(16, 149, view3.frame.size.width-16, 1)];
        lab2.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
        [cell5 addSubview:lab2];

        
      //  UILabel *lbldate=(UILabel *)[cell5 viewWithTag:1];
        UILabel *lblsource=(UILabel *)[cell5 viewWithTag:2];
        UILabel *lbldestination=(UILabel *)[cell5 viewWithTag:3];
        UILabel *lbldateandtime=(UILabel *)[cell5 viewWithTag:4];
        UILabel *lblstatus=(UILabel *)[cell5 viewWithTag:5];
        UILabel *lbltime=(UILabel *)[cell5 viewWithTag:8];
        
        butt=(UIButton *)[cell5 viewWithTag:6];
            
     //   lbldate.text=[[arrcompleteddetails valueForKey:@"booking_date"]objectAtIndex:indexPath.row];
        lblsource.text=[[arrcompleteddetails valueForKey:@"src_addr"]objectAtIndex:indexPath.row];
        lbldestination.text=[[arrcompleteddetails valueForKey:@"dest_addr"]objectAtIndex:indexPath.row];
        lbldateandtime.text=[[arrcompleteddetails valueForKey:@"booking_date"]objectAtIndex:indexPath.row];
        lblstatus.text=[[arrcompleteddetails valueForKey:@"status"]objectAtIndex:indexPath.row];
        lbltime.text=[[arrcompleteddetails valueForKey:@"booking_time"]objectAtIndex:indexPath.row];
        
        butt.tag=indexPath.row;
        butt.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];

        [butt addTarget:self action:@selector(completedCompletedClicked:) forControlEvents:UIControlEventTouchUpInside];
        return cell5;
    }
    
    [tab reloadData];
    return 0;
}


#pragma mark- buttons Clicked




#pragma mark - Upcoming Buttons Clicked

-(void)upcominglistClicked:(UIButton *)sender
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
    
     self.view.userInteractionEnabled=NO;
    
    NSString *str=[NSString stringWithFormat:@"%@",[[arrupcomingdetails objectAtIndex:sender.tag] valueForKey:@"trip_id"]];
    [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"tripid"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSString *str1=[NSString stringWithFormat:@"%@",[[arrupcomingdetails objectAtIndex:sender.tag] valueForKey:@"src_addr"]];
    [[NSUserDefaults standardUserDefaults]setObject:str1 forKey:@"pic"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSString *str2=[NSString stringWithFormat:@"%@",[[arrupcomingdetails objectAtIndex:sender.tag] valueForKey:@"dest_addr"]];
    [[NSUserDefaults standardUserDefaults]setObject:str2 forKey:@"des"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    if ([[[arrupcomingdetails objectAtIndex:sender.tag] valueForKey:@"status"] isEqualToString:@"pending"])
    {
       
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,gettrip]]];
        
        request.HTTPMethod = @"POST";
        
        NSMutableString* profile = [NSMutableString string];
        
        [profile appendString:[NSString stringWithFormat:@"trip_id=%@",[[arrupcomingdetails objectAtIndex:sender.tag] valueForKey:@"trip_id"]]];
        [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"driver"]];
        
        request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (error) {
                                       // Handle error
                                       //[self handleError:error];
                                   } else {
                                       [self parsejsonupcomingpending:data];
                                       
                                   }
                               }];
       

    }
    
    else if ([[[arrupcomingdetails objectAtIndex:sender.tag] valueForKey:@"status"] isEqualToString:@"confirmed"])
    {
         self.view.userInteractionEnabled=NO;
        
        DriverDetailsViewController *det=[self.storyboard instantiateViewControllerWithIdentifier:@"DriverDetailsViewController"];
        [self.navigationController pushViewController:det animated:YES];
    }
    
    else if ([[[arrupcomingdetails objectAtIndex:sender.tag] valueForKey:@"status"] isEqualToString:@"arrived"])
    {
        StartRideViewController *sr=[self.storyboard instantiateViewControllerWithIdentifier:@"StartRideViewController"];
        [self.navigationController pushViewController:sr animated:YES];
    }
    
    else if ([[[arrupcomingdetails objectAtIndex:sender.tag] valueForKey:@"status"] isEqualToString:@"started"])
    {
        StopRideViewController *stop=[self.storyboard instantiateViewControllerWithIdentifier:@"StopRideViewController"];
        [self.navigationController pushViewController:stop animated:YES];
    }
    
    
    else if ([[[arrupcomingdetails objectAtIndex:sender.tag] valueForKey:@"status"] isEqualToString:@"stopped"])
    {
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,invoicedetail]]];
        
        request.HTTPMethod = @"POST";
        
        NSMutableString* profile = [NSMutableString string];
        
        [profile appendString:[NSString stringWithFormat:@"trip_id=%@",[[arrupcomingdetails objectAtIndex:sender.tag] valueForKey:@"trip_id"]]];
        
        
        request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (error) {
                                       // Handle error
                                       //[self handleError:error];
                                   } else {
                                       
                                       [self completedCompletddata:data];
                                       
                                   }
                               }];
        
    }
    else if ([[[arrupcomingdetails objectAtIndex:sender.tag] valueForKey:@"status"] isEqualToString:@"Rider_Paid"])
    {
        
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,invoicedetail]]];
        
        request.HTTPMethod = @"POST";
        
        NSMutableString* profile = [NSMutableString string];
        
        [profile appendString:[NSString stringWithFormat:@"trip_id=%@",[[arrupcomingdetails objectAtIndex:sender.tag] valueForKey:@"trip_id"]]];
        
        
        request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (error) {
                                       // Handle error
                                       //[self handleError:error];
                                   } else {
                                       
                                       [self completedCompletddata2:data];
                                       
                                   }
                               }];

        
    }
    else
    {
        
        DetailtripViewController *detail=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailtripViewController"];
        
        detail.strpickup=[[arrupcomingdetails objectAtIndex:sender.tag] valueForKey:@"src_addr"];
        detail.strDestination=[[arrupcomingdetails objectAtIndex:sender.tag] valueForKey:@"dest_addr"];
        detail.strdate=[[arrupcomingdetails objectAtIndex:sender.tag] valueForKey:@"booking_date"];
        detail.strtime=[[arrupcomingdetails objectAtIndex:sender.tag] valueForKey:@"booking_time"];
        detail.strstatus=[[arrupcomingdetails objectAtIndex:sender.tag] valueForKey:@"status"];
        
        [self.navigationController pushViewController:detail animated:YES];
        
    }
}


#pragma mark - Completed Buttons Clicked

-(void)completedCompletedClicked:(UIButton *)sender
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
    
    self.view.userInteractionEnabled=NO;
    
    NSString *str=[NSString stringWithFormat:@"%@",[[arrcompleteddetails objectAtIndex:sender.tag] valueForKey:@"trip_id"]];
    [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"tripid"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSString *str1=[NSString stringWithFormat:@"%@",[[arrcompleteddetails objectAtIndex:sender.tag] valueForKey:@"src_addr"]];
    [[NSUserDefaults standardUserDefaults]setObject:str1 forKey:@"pic"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSString *str2=[NSString stringWithFormat:@"%@",[[arrcompleteddetails objectAtIndex:sender.tag] valueForKey:@"dest_addr"]];
    [[NSUserDefaults standardUserDefaults]setObject:str2 forKey:@"des"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,invoicedetail]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"trip_id=%@",[[arrcompleteddetails objectAtIndex:sender.tag] valueForKey:@"trip_id"]]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   
                                   [self completedCompletddata:data];
                                   
                               }
                           }];
    
}




-(void)completedCompletddata:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
   // NSLog(@"***** Invoice Details Response ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
        self.view.userInteractionEnabled=YES;
        
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        arrinvoicedetails=[responseJSON valueForKey:@"data"];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrinvoicedetails];
        
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"InvoiceDetails"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        InvoiceDetailViewController *det=[self.storyboard instantiateViewControllerWithIdentifier:@"InvoiceDetailViewController"];
        [self.navigationController pushViewController:det animated:YES];
    }
}

-(void)completedCompletddata2:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
  //  NSLog(@"***** Invoice Details Response ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
        self.view.userInteractionEnabled=YES;
        
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        arrinvoicedetails=[responseJSON valueForKey:@"data"];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrinvoicedetails];
        
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"InvoiceDetails"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        ConformPaymentDriverViewController *cvc=[self.storyboard instantiateViewControllerWithIdentifier:@"ConformPaymentDriverViewController"];
        [self.navigationController pushViewController:cvc animated:YES];
    }
}



#pragma mark - All Buttons Clicked



-(void)allDataridesClicked:(UIButton *)sender
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
    
    self.view.userInteractionEnabled=YES;
    
    NSString *str=[NSString stringWithFormat:@"%@",[[arrdetails objectAtIndex:sender.tag] valueForKey:@"trip_id"]];
    [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"tripid"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSString *str1=[NSString stringWithFormat:@"%@",[[arrdetails objectAtIndex:sender.tag] valueForKey:@"src_addr"]];
    [[NSUserDefaults standardUserDefaults]setObject:str1 forKey:@"pic"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSString *str2=[NSString stringWithFormat:@"%@",[[arrdetails objectAtIndex:sender.tag] valueForKey:@"dest_addr"]];
    [[NSUserDefaults standardUserDefaults]setObject:str2 forKey:@"des"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    if ([[[arrdetails objectAtIndex:sender.tag] valueForKey:@"status"] isEqualToString:@"pending"])
    {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,gettrip]]];
        
        request.HTTPMethod = @"POST";
        
        NSMutableString* profile = [NSMutableString string];
        
        [profile appendString:[NSString stringWithFormat:@"trip_id=%@",[[arrdetails objectAtIndex:sender.tag] valueForKey:@"trip_id"]]];
        [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"driver"]];
        
        request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (error) {
                                       // Handle error
                                       //[self handleError:error];
                                   } else {
                                       [self parsejsonupcomingpending:data];
                                       
                                   }
                               }];
        
    }
    
    else if ([[[arrdetails objectAtIndex:sender.tag] valueForKey:@"status"] isEqualToString:@"confirmed"])
    {
        
        DriverDetailsViewController *det=[self.storyboard instantiateViewControllerWithIdentifier:@"DriverDetailsViewController"];
        [self.navigationController pushViewController:det animated:YES];
    }
    
    else if ([[[arrdetails objectAtIndex:sender.tag] valueForKey:@"status"] isEqualToString:@"arrived"])
    {
        StartRideViewController *sr=[self.storyboard instantiateViewControllerWithIdentifier:@"StartRideViewController"];
        [self.navigationController pushViewController:sr animated:YES];
    }
    
    else if ([[[arrdetails objectAtIndex:sender.tag] valueForKey:@"status"] isEqualToString:@"started"])
    {
        StopRideViewController *stop=[self.storyboard instantiateViewControllerWithIdentifier:@"StopRideViewController"];
        [self.navigationController pushViewController:stop animated:YES];
    }
    
    
    else if ([[[arrdetails objectAtIndex:sender.tag] valueForKey:@"status"] isEqualToString:@"stopped"])
    {
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,invoicedetail]]];
        
        request.HTTPMethod = @"POST";
        
        NSMutableString* profile = [NSMutableString string];
        
        [profile appendString:[NSString stringWithFormat:@"trip_id=%@",[[arrdetails objectAtIndex:sender.tag] valueForKey:@"trip_id"]]];
        
        
        request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (error) {
                                       // Handle error
                                       //[self handleError:error];
                                   } else {
                                       
                                       [self completedCompletddata:data];
                                       
                                   }
                               }];
        
    }
    else if ([[[arrdetails objectAtIndex:sender.tag] valueForKey:@"status"] isEqualToString:@"completed"])
    {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,invoicedetail]]];
        
        request.HTTPMethod = @"POST";
        
        NSMutableString* profile = [NSMutableString string];
        
        [profile appendString:[NSString stringWithFormat:@"trip_id=%@",[[arrdetails objectAtIndex:sender.tag] valueForKey:@"trip_id"]]];
        
        request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (error) {
                                       // Handle error
                                       //[self handleError:error];
                                   } else {
                                       
                                       [self completedCompletddata:data];
                                       
                                   }
                               }];

    }
    else if ([[[arrdetails objectAtIndex:sender.tag] valueForKey:@"status"] isEqualToString:@"Rider_Paid"])
    {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,invoicedetail]]];
        
        request.HTTPMethod = @"POST";
        
        NSMutableString* profile = [NSMutableString string];
        
        [profile appendString:[NSString stringWithFormat:@"trip_id=%@",[[arrdetails objectAtIndex:sender.tag] valueForKey:@"trip_id"]]];
        
        
        request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (error) {
                                       // Handle error
                                       //[self handleError:error];
                                   } else {
                                       
                                       [self completedCompletddata2:data];
                                       
                                   }
                               }];
    }
    else if ([[[arrdetails objectAtIndex:sender.tag] valueForKey:@"status"] isEqualToString:@"canceled"])
    {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,gettrip]]];
        
        request.HTTPMethod = @"POST";
        
        NSMutableString* profile = [NSMutableString string];
        
        [profile appendString:[NSString stringWithFormat:@"trip_id=%@",[[arrdetails objectAtIndex:sender.tag] valueForKey:@"trip_id"]]];
        [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"driver"]];
        
        request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (error) {
                                       // Handle error
                                       //[self handleError:error];
                                   } else {
                                       [self parseJSONResponcancelled:data];
                                       
                                   }
                               }];

    }
    else
    {
        DetailtripViewController *detail=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailtripViewController"];
        
        detail.strpickup=[[arrdetails objectAtIndex:sender.tag] valueForKey:@"src_addr"];
        detail.strDestination=[[arrdetails objectAtIndex:sender.tag] valueForKey:@"dest_addr"];
        detail.strdate=[[arrdetails objectAtIndex:sender.tag] valueForKey:@"booking_date"];
        detail.strtime=[[arrdetails objectAtIndex:sender.tag] valueForKey:@"booking_time"];
        detail.strstatus=[[arrdetails objectAtIndex:sender.tag] valueForKey:@"status"];
        
        [self.navigationController pushViewController:detail animated:YES];
        
    }
}


-(void)parseJSONResponcancelled:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
 //   NSLog(@"***** Cancelled Response ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
        self.view.userInteractionEnabled=YES;
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        arrdriverinfo=[[responseJSON valueForKey:@"data"]valueForKey:@"user"];
        arrtripinfo=[[responseJSON valueForKey:@"data"]valueForKey:@"trip"];
        
        CancelledinfodetailViewController *det=[self.storyboard instantiateViewControllerWithIdentifier:@"CancelledinfodetailViewController"];
        
        det.strname=[arrdriverinfo valueForKey:@"name"];
        det.strimageurl=[arrdriverinfo valueForKey:@"image"];
        det.strratingnumber=[arrdriverinfo valueForKey:@"avg_rating"];
        
        det.strpickup=[arrtripinfo valueForKey:@"src_addr"];
        det.strDestination=[arrtripinfo valueForKey:@"dest_addr"];
        det.strdate=[arrtripinfo valueForKey:@"booking_date"];
        det.strtime=[arrtripinfo valueForKey:@"booking_time"];
        det.strstatus=[arrtripinfo valueForKey:@"status"];
        
        det.strreason=[arrtripinfo valueForKey:@"canceled_message"];
        det.strtripid=[arrtripinfo valueForKey:@"trip_id"];
        
        [self.navigationController pushViewController:det animated:YES];
    }
}



-(void)parsejsonupcomingpending:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
 //   NSLog(@"***** Cancelled Response ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
        self.view.userInteractionEnabled=YES;
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        NSMutableDictionary *arrdetailspend=[[NSMutableDictionary alloc]init];
        
        arrdetails=[[responseJSON valueForKey:@"data"]valueForKey:@"user"];
        arrtripinfo=[[responseJSON valueForKey:@"data"]valueForKey:@"trip"];
        
        NSString *strtripid=[arrtripinfo valueForKey:@"trip_id"];
        NSString *strsourcelat=[arrtripinfo valueForKey:@"src_lat"];
        NSString *strsourcelong=[arrtripinfo valueForKey:@"src_lng"];
        NSString *strdeslat=[arrtripinfo valueForKey:@"dest_lat"];
        NSString *strdeslong=[arrtripinfo valueForKey:@"dest_lng"];
        
        NSString *strname=[arrdetails valueForKey:@"name"];
        NSString *strimage=[arrdetails valueForKey:@"image"];
        NSString *strrating=[arrdetails valueForKey:@"avg_rating"];
        NSString *strmobile=[arrdetails valueForKey:@"mobile_no"];
        NSString *struserid=[arrdetails valueForKey:@"user_id"];
        
        [arrdetailspend setObject:strtripid forKey:@"trip_id"];
        [arrdetailspend setObject:strsourcelat forKey:@"src_lat"];
        [arrdetailspend setObject:strsourcelong forKey:@"src_lng"];
        [arrdetailspend setObject:strdeslat forKey:@"dest_lat"];
        [arrdetailspend setObject:strdeslong forKey:@"dest_lng"];
        
        [arrdetailspend setObject:strname forKey:@"name"];
        [arrdetailspend setObject:strimage forKey:@"image"];
        [arrdetailspend setObject:strrating forKey:@"avg_rating_value"];
        [arrdetailspend setObject:strmobile forKey:@"mobile_no"];
        [arrdetailspend setObject:struserid forKey:@"user_id"];
        
    

        NSLog(@"%@",arrdetailspend);
        
        [[NSUserDefaults standardUserDefaults]setObject:arrdetailspend forKey:@"riderdata"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        RiderRequestConformViewController *detail=[self.storyboard instantiateViewControllerWithIdentifier:@"RiderRequestConformViewController"];
        
        [self.navigationController pushViewController:detail animated:YES];
       
    }
}


-(void)viewDidAppear:(BOOL)animated
{
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = YES;
}


#pragma mark - View Appear and Disappear

-(void)viewDidDisappear:(BOOL)animated
{
    [DejalBezelActivityView removeView];
    self.title = @"";
    
    self.view.userInteractionEnabled=YES;
    
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//        self.navigationController.interactivePopGestureRecognizer.delegate = self;
//    }
//    [self.revealViewController.view removeGestureRecognizer:self.revealViewController.panGestureRecognizer];
//    
//    SWRevealViewController *reveal = self.revealViewController;
//    reveal.panGestureRecognizer.enabled = NO;

}

-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"My Rides";
    
    self.view.userInteractionEnabled=YES;
    
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//        self.navigationController.interactivePopGestureRecognizer.delegate = self;
//    }
//    [self.revealViewController.view removeGestureRecognizer:self.revealViewController.panGestureRecognizer];
//    
//    SWRevealViewController *reveal = self.revealViewController;
//    reveal.panGestureRecognizer.enabled = NO;

    
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
    
  //  NSLog(@"***** login check details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    [DejalBezelActivityView removeView];
    
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



- (void)didReceiveMemoryWarning
{
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
