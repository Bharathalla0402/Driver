//
//  InvoiceDetailViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 17/05/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "InvoiceDetailViewController.h"
#import "GetUsHere.pch"
#import "DejalActivityView.h"
#import "UpcomingRidesViewController.h"
#import "SplachscreenViewController.h"
#import "SWRevealViewController.h"


@interface InvoiceDetailViewController ()

@end

@implementation InvoiceDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _BaseFareCrossLine.hidden=YES;
    _MilesFareCrossLine.hidden=YES;
    
    self.title=@"Invoice Details";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor=[UIColor lightGrayColor];
    
    arrinvoiceDetails=[[NSMutableArray alloc]init];
    arrtollscount=[[NSMutableArray alloc]init];
    arrairportcount=[[NSMutableArray alloc]init];
    
    _faredetailsView.textColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _faredetailslinelab.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _bookingdetailslab.textColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _bookingdetailslinelab.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _pickuplocationtitlelab.textColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _deslocationtitlelab.textColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _proceedtopaymentbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    
    _triptodriver.hidden=YES;
    _tripamountView.hidden=YES;
    _dollerlable.hidden=YES;
    _amountlable.hidden=YES;
    _dolleramountbutt.hidden=YES;
    
    _proceedtopaymentbutt.hidden=YES;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"b" style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(barButtonBackPressed:)];
    [backButton setImage:[UIImage imageNamed:@"Untitled-1-2.png"]];
    
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    
   
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"InvoiceDetails"];
    
    arrinvoiceDetails = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
  //  arrinvoiceDetails=[[NSUserDefaults standardUserDefaults]objectForKey:@"InvoiceDetails"];
    
    
    arrtollscount=[arrinvoiceDetails valueForKey:@"tolls"];
    arrairportcount=[arrinvoiceDetails valueForKey:@"airport"];
    
    
    if (arrtollscount != (id)[NSNull null])
    {
    
        strtollsnumber=[NSString stringWithFormat:@"%lu Tolls",(unsigned long)arrtollscount.count];
    
    }
    else
    {
         strtollsnumber=@"0";
    }
    
    
    if (arrairportcount != (id)[NSNull null])
    {
        
        strairportcoun=[NSString stringWithFormat:@"%lu",(unsigned long)arrairportcount.count];
        
    }
    else
    {
         strairportcoun=@"0";
    }
    
      
    strmiles=[NSString stringWithFormat:@"Rate for %@",[arrinvoiceDetails valueForKey:@"distance"]];
    
    NSString *stramount=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"total_tip"]];
   
    if ([stramount isEqualToString:@""])
    {
         _tipamount.text=[NSString stringWithFormat:@"$%@",@"0"];
    }
    else{
        _tipamount.text=[NSString stringWithFormat:@"$%@",stramount];
    }
   
    NSString *strwaitingcharge=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"total_waiting"]];
    
    _waitingChargeLab.text=[NSString stringWithFormat:@"$%@",strwaitingcharge];
    
    NSString *strservicetax=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"service_tax"]];
    NSString *strtip=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"total_tip"]];
    
    
    
      _invoiceno.text=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"invoice_id"]];
      _totaldistance.text=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"distance"]];
      _totalridetime.text=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"duration"]];
    
    NSString *strDiscountcharge=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"discount"]];
    
    _DiscountPricelab.text=[NSString stringWithFormat:@"$%@",strDiscountcharge];
    

    
    NSString *strtotalfarevalue=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"total_fare_value"]];
    int value1=[strwaitingcharge intValue];
    int value2=[strtotalfarevalue intValue];
    int value3=[strservicetax intValue];
    int value4=[strtip intValue];
    int value8=[strDiscountcharge intValue];
    int value5=value1+value2+value3+value4-value8;
    
    
    _totalfare.text=[NSString stringWithFormat:@"$%d",value5];
    
      _basefare.text=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"base_fare"]];
      _ratemileslable.text=[NSString stringWithFormat:@"%@",strmiles];
      _ratemilesamount.text=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"sub_total"]];
      _totaltollscountlable.text=[NSString stringWithFormat:@"%@",strtollsnumber];
      _totaltollsfare.text=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"total_toll_fare"]];
      _servicetax.text=[NSString stringWithFormat:@"$%@",[arrinvoiceDetails valueForKey:@"service_tax"]];
      _pickupaddress.text=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"src_addr"]];
      _desaddress.text=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"dest_addr"]];
    
    
    NSString *strpictime=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"tripStartTime"]];
    NSArray *arr = [strpictime componentsSeparatedByString:@" "];
    _pickuptime.text=[arr objectAtIndex:1];
    
    NSString *strdestime=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"tripEndTime"]];
    NSArray *arr2 = [strdestime componentsSeparatedByString:@" "];
    _destime.text=[arr2 objectAtIndex:1];

    
    
    
   
     _airportcountlable.text=[NSString stringWithFormat:@"%@ Airport",strairportcoun];
    _airportfare.text=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"total_airport_fare"]];
    
    NSString *strtripid=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"trip_id"]];
    [[NSUserDefaults standardUserDefaults]setObject:strtripid forKey:@"tripid"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSLog(@"%@",strtollsnumber);
    NSLog(@"%@",strmiles);
    
    NSString *strbasefareValue=[[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"base_fare"]] substringFromIndex:1];
    NSString *strSubTotalValue=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"sub_total_value"]];
    int a=(int)[strbasefareValue integerValue];
    int b=(int)[strSubTotalValue integerValue];
    
    if (a<b)
    {
        _BaseFareCrossLine.hidden=NO;
    }
    else
    {
        _MilesFareCrossLine.hidden=NO;
    }

    
 //   [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"body_background2.png"]];
    
    _scroollContent.contentSize = CGSizeMake(self.view.frame.size.width,730);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)barButtonBackPressed:(id)sender
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
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
                                   [self parseJSONRespdetails2:data];
                               }
                           }];

}

-(void)parseJSONRespdetails2:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
 //   NSLog(@"*****Upcoming Rides details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    // NSLog(@"%@",DataArray);
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        
//        [alert show];
        
        arrdetails=nil;
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrdetails];
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"detailsofall"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSMutableArray *arrpages=[[NSMutableArray alloc]init];
        arrpages=[responseJSON valueForKey:@"data"];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrpages forKey:@"detailsofall2"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        UpcomingRidesViewController *butt=[self.storyboard instantiateViewControllerWithIdentifier:@"UpcomingRidesViewController"];
        [self.navigationController pushViewController:butt animated:YES];

    }
    
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        arrdetails=[[[responseJSON valueForKey:@"data"] valueForKey:@"tripDetail"]valueForKey:@"trip"];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrdetails];
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"detailsofall"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSMutableArray *arrpages=[[NSMutableArray alloc]init];
        arrpages=[responseJSON valueForKey:@"data"];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrpages forKey:@"detailsofall2"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        UpcomingRidesViewController *butt=[self.storyboard instantiateViewControllerWithIdentifier:@"UpcomingRidesViewController"];
        [self.navigationController pushViewController:butt animated:YES];
    }
}





- (IBAction)tollsinfoClicked:(id)sender
{
    if (arrtollscount.count==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Tolls Information" message:@"There is no Tolls in this Region" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else
    {
        popview = [[ UIView alloc]init];
        popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        //  popview.backgroundColor = [UIColor clearColor];
        popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
        
        [self.view addSubview:popview];
        
        footerview=[[UIView alloc] initWithFrame:CGRectMake(5, self.view.frame.size.height/3, self.view.frame.size.width-10, 201)];
        //footerview.backgroundColor=[UIColor blackColor];
        footerview.backgroundColor = [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
        [popview addSubview:footerview];
        
        
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 40)];
        lab.text=@"Tolls Information";
        lab.textColor=[UIColor whiteColor];
        lab.textAlignment=NSTextAlignmentCenter;
        lab.font=[UIFont systemFontOfSize:16];
        [footerview addSubview:lab];
        
        UIButton *butt=[[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width-40,8,25,21)];
        [butt setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
        //[butt setTitle:@"CLOSE" forState:UIControlStateNormal];
        [butt addTarget:self action:@selector(butnclicked:) forControlEvents:UIControlEventTouchUpInside];
        [footerview addSubview:butt];
        
        UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(3, 0, footerview.frame.size.width, 40)];
        //  [butt setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
        //[butt setTitle:@"CLOSE" forState:UIControlStateNormal];
        [butt1 addTarget:self action:@selector(butnclicked:) forControlEvents:UIControlEventTouchUpInside];
        [footerview addSubview:butt1];
        
        tabl=[[UITableView alloc] init];
        tabl.frame = CGRectMake(0,butt.frame.origin.y+butt.frame.size.height+10, footerview.frame.size.width, 180);
        tabl.delegate=self;
        tabl.dataSource=self;
        tabl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [footerview addSubview:tabl];
        tabl.tag=1;
        
        [popview addSubview:footerview];
    }
}

-(void)butnclicked:(id)sender
{
    [footerview removeFromSuperview];
    popview.hidden = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tabl.tag==1)
    {
        return arrtollscount.count;
    }
    else if (tabl.tag==2)
    {
        return arrairportcount.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tabl.tag==1)
    {
        return 90;
    }
    else if (tabl.tag==2)
    {
        return 90;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (tabl.tag==1)
    {
        static NSString *cellIdetifier = @"Cell";
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetifier];
        
        
        UILabel *namel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, cell.frame.size.width/1.5, 30)];
        namel.text=[[arrtollscount valueForKey:@"user_define_name"]objectAtIndex:indexPath.row];
        namel.lineBreakMode = NSLineBreakByWordWrapping;
        namel.numberOfLines = 1;
       // namel.font=[UIFont systemFontOfSize:15];
        [namel setFont:[UIFont boldSystemFontOfSize:16]];
        [cell addSubview:namel];
        
        UILabel *namelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, namel.frame.origin.y+28, cell.frame.size.width/1.5, cell.frame.size.height)];
        namelabel.text=[[arrtollscount valueForKey:@"name"]objectAtIndex:indexPath.row];
        namelabel.lineBreakMode = NSLineBreakByWordWrapping;
        namelabel.numberOfLines = 3;
        namelabel.font=[UIFont systemFontOfSize:13];
        [cell addSubview:namelabel];
        
        UILabel *pricelabel = [[UILabel alloc] initWithFrame:CGRectMake(namelabel.frame.origin.x+namelabel.frame.size.width + 10 , 20, cell.frame.size.width/4, cell.frame.size.height)];
        pricelabel.text=[NSString stringWithFormat:@"%@",[[arrtollscount valueForKey:@"price"] objectAtIndex:indexPath.row]];
        pricelabel.textAlignment = NSTextAlignmentCenter;
        namelabel.font=[UIFont systemFontOfSize:14];
        [cell addSubview:pricelabel];
        
    }
    
    else if (tabl.tag==2)
    {
        static NSString *cellIdetifier = @"Cell";
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetifier];
        
        UILabel *namel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, cell.frame.size.width/1.5, 30)];
        namel.text=[[arrairportcount valueForKey:@"user_define_name"]objectAtIndex:indexPath.row];
        namel.lineBreakMode = NSLineBreakByWordWrapping;
        namel.numberOfLines = 1;
      //  namel.font=[UIFont systemFontOfSize:15];
        [namel setFont:[UIFont boldSystemFontOfSize:16]];
        [cell addSubview:namel];
        
        UILabel *namelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, namel.frame.origin.y+28, cell.frame.size.width/1.5, cell.frame.size.height)];
        namelabel.text=[[arrairportcount valueForKey:@"name"]objectAtIndex:indexPath.row];
        namelabel.lineBreakMode = NSLineBreakByWordWrapping;
        namelabel.numberOfLines = 3;
        namelabel.font=[UIFont systemFontOfSize:13];
        [cell addSubview:namelabel];
        
        UILabel *pricelabel = [[UILabel alloc] initWithFrame:CGRectMake(namelabel.frame.origin.x+namelabel.frame.size.width + 10 , 20, cell.frame.size.width/4, cell.frame.size.height)];
        pricelabel.text=[NSString stringWithFormat:@"%@",[[arrairportcount valueForKey:@"price"] objectAtIndex:indexPath.row]];
        pricelabel.textAlignment = NSTextAlignmentCenter;
        namelabel.font=[UIFont systemFontOfSize:14];
        [cell addSubview:pricelabel];
    }
    return cell;
}


- (IBAction)airportinfoClicked:(id)sender
{
    if (arrairportcount.count==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Airport Information" message:@"There is no airports in this Region" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else
    {
        popview = [[ UIView alloc]init];
        popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        //  popview.backgroundColor = [UIColor clearColor];
        popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
        
        [self.view addSubview:popview];
        
        footerview=[[UIView alloc] initWithFrame:CGRectMake(5, self.view.frame.size.height/3, self.view.frame.size.width-10, 111)];
        //footerview.backgroundColor=[UIColor blackColor];
        footerview.backgroundColor = [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
        [popview addSubview:footerview];
        
        
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(3, 0, 160, 40)];
        lab.text=@"Airport's Information";
        lab.textColor=[UIColor whiteColor];
        lab.textAlignment=NSTextAlignmentCenter;
        lab.font=[UIFont systemFontOfSize:16];
        [footerview addSubview:lab];
        
        UIButton *butt=[[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width-40,8,25,21)];
        [butt setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
        //[butt setTitle:@"CLOSE" forState:UIControlStateNormal];
        [butt addTarget:self action:@selector(butnclicked:) forControlEvents:UIControlEventTouchUpInside];
        [footerview addSubview:butt];
        
        
        UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(3, 0, footerview.frame.size.width, 40)];
        //  [butt setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
        //[butt setTitle:@"CLOSE" forState:UIControlStateNormal];
        [butt1 addTarget:self action:@selector(butnclicked:) forControlEvents:UIControlEventTouchUpInside];
        [footerview addSubview:butt1];
        
        tabl=[[UITableView alloc] init];
        tabl.frame = CGRectMake(0,butt.frame.origin.y+butt.frame.size.height+10, footerview.frame.size.width, 90);
        tabl.delegate=self;
        tabl.dataSource=self;
        tabl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [footerview addSubview:tabl];
        tabl.tag=2;
        
        [popview addSubview:footerview];
    }
}



-(void)viewDidDisappear:(BOOL)animated
{
    self.title = @"";
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.title=@"Invoice Details";
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
