//
//  CompletedtripsViewController.m
//  GetUsHere For Driver
//
//  Created by bharat on 04/04/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "CompletedtripsViewController.h"
#import "UpcomingTableViewCell.h"
#import "SidebarViewController.h"
#import "DetailtripViewController.h"
#import "DejalActivityView.h"
#import "GetUsHere.pch"
#import "UpcomingTableviewcell2.h"
#import "TPFloatRatingView.h"
#import "InvoiceDetailViewController.h"
#import "RatingViewController.h"
#import "SWRevealViewController.h"
#import "SplachscreenViewController.h"

@interface CompletedtripsViewController ()<TPFloatRatingViewDelegate>
{
    UpcomingTableviewcell2 *cell2;
    UpcomingTableViewCell *cell;
}

@end

@implementation CompletedtripsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.title=@"Completed Trips";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    arrdetails=[[NSMutableArray alloc]init];
    arrinvoicedetails=[[NSMutableArray alloc]init];
    
    
    _smallPrevious.hidden=YES;
    _smallnext.hidden=YES;
    _previous.hidden=YES;
    _next.hidden=YES;
    
    _next.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    arrdetails=[[NSMutableArray alloc]init];
    arrpages=[[NSMutableDictionary alloc]init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"detailsofall"];
    arrdetails = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
    
    //    NSUserDefaults *defaults2 = [NSUserDefaults standardUserDefaults];
    //    NSData *data2 = [defaults2 objectForKey:@"detailsofall2"];
    arrpages = [[NSUserDefaults standardUserDefaults]objectForKey:@"detailsofall2"];
    
    
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

}


-(void)nextClick1:(id)sender
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
                                   [self parseJSONResp11:data];
                               }
                           }];
    
}

-(void)parseJSONResp11:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
  //  NSLog(@"*****Next page details ******* %@", responseJSON);
    
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
        selectedIndex = -1;
        
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
                                   [self parseJSONResp11:data];
                               }
                           }];
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 250;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrdetails.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellClassName = @"UpcomingTableViewCell";
    cell = (UpcomingTableViewCell *)[tableView dequeueReusableCellWithIdentifier: CellClassName];
    
    if (cell == nil)
    {
        cell = [[UpcomingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellClassName];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UpcomingTableViewCell"
                                                                 owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.backgroundColor=[UIColor blackColor];
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
    butt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];

 //   lbldate.text=[[arrdetails valueForKey:@"booking_date"]objectAtIndex:indexPath.row];
    lblsource.text=[[arrdetails valueForKey:@"src_addr"]objectAtIndex:indexPath.row];
    lbldestination.text=[[arrdetails valueForKey:@"dest_addr"]objectAtIndex:indexPath.row];
    lbldateandtime.text=[[arrdetails valueForKey:@"booking_date"]objectAtIndex:indexPath.row];
    lblstatus.text=[[arrdetails valueForKey:@"status"]objectAtIndex:indexPath.row];
    lbltime.text=[[arrdetails valueForKey:@"booking_time"]objectAtIndex:indexPath.row];
    
    butt.tag=indexPath.row;
    [butt addTarget:self action:@selector(bclicked233:) forControlEvents:UIControlEventTouchUpInside];
    
   // [tab reloadData];
     return cell;
}


-(void)bclicked233:(UIButton *)sender
{
 
    self.view.userInteractionEnabled=NO;
     [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
    NSString *str=[NSString stringWithFormat:@"%@",[[arrdetails objectAtIndex:sender.tag] valueForKey:@"trip_id"]];
    [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"tripid"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSString *str1=[NSString stringWithFormat:@"%@",[[arrdetails objectAtIndex:sender.tag] valueForKey:@"src_addr"]];
    [[NSUserDefaults standardUserDefaults]setObject:str1 forKey:@"pic"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSString *str2=[NSString stringWithFormat:@"%@",[[arrdetails objectAtIndex:sender.tag] valueForKey:@"dest_addr"]];
    [[NSUserDefaults standardUserDefaults]setObject:str2 forKey:@"des"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
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
                                   [self parseJSONRespon8:data];
                                   
                               }
                           }];
    
}
-(void)parseJSONRespon8:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
 //   NSLog(@"***** Invoice Details Response ******* %@", responseJSON);
    
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

-(void)bclicked5:(UIButton *)sender
{
    RatingViewController *detail=[self.storyboard instantiateViewControllerWithIdentifier:@"RatingViewController"];
    detail.strtripid=[[arrdetails objectAtIndex:sender.tag] valueForKey:@"trip_id"];
    [self.navigationController pushViewController:detail animated:YES];
}


-(void)viewDidDisappear:(BOOL)animated
{
    [DejalBezelActivityView removeView];
    self.title = @"";
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title=@"Completed Trips";
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
