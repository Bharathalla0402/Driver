//
//  RidereditViewController.m
//  Jaguar Enterprises
//
//  Created by bharat on 27/01/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "RidereditViewController.h"
#import "SidebarViewController.h"
#import "SWRevealViewController.h"
#import "DejalActivityView.h"
#import "UserInformation.h"
#import "Customcell2.h"
#import "GetUsHere.pch"
#import "DejalActivityView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImageView+WebCache.h"
#import "SettingsViewController.h"
#import "SWRevealViewController.h"
#import "SplachscreenViewController.h"
#import "DropDownListView.h"

@interface RidereditViewController ()<kDropDownListViewDelegate>
{
    DropDownListView * Dropobj;
    
    NSMutableArray *arrlanguageids;
    NSString *strlanguageid;
    NSMutableArray *arrchecks;
    
    NSData *confirmation;
    NSArray *paymentData;
    NSString *email,*fname,*lname,*userid,*tokenid;
    
    IBOutlet UIButton *editbutton;
    IBOutlet UIButton *cancel;
    IBOutlet UIButton *update;
    IBOutlet UIButton *deletebu;
    
    IBOutlet UITextField *lblname1;
    IBOutlet UITextField *txtnumber;
    
    IBOutlet UILabel *label5;
    
    UIImage *currentSelectedImage;
    
  //  UITextField *lblname1;
  //  UITextField *txtnumber;
    
    UITextField *lab;
    UITextField *lab1;
     BOOL isClicked2;
    
    UILabel *labcon;
    
   // UILabel *label5;
    
  //  UIButton *editbutt;
  //  UIButton *cancel;
  //  UIButton *update;
  //  UIButton *deletebu;
    
    BOOL isClicked;
    Customcell2 *cell;
    Customcell2 *cell1;
    NSInteger selectedIndex;
    UIBarButtonItem *backButton2;
    
    
    NSString *byteArray;
    NSMutableDictionary *imagedictionary;
    NSString *jsonString;
    
    
    NSMutableArray *arrlanguages;
    
}
@end

@implementation RidereditViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"My Profile";
    
    selectedIndex = -1;
    isClicked = NO;
     isClicked2=YES;
    
    arrlanguages=[[NSMutableArray alloc]init];
    arrlanguageids=[[NSMutableArray alloc]init];
    arrchecks=[[NSMutableArray alloc]init];
    _txtcontact.delegate=self;
   // _txtemail.delegate=self;
    
    lblname1.delegate=self;
    txtnumber.delegate=self;
    
    
    _contacttable.backgroundColor=[UIColor whiteColor];
    _pictureedit.hidden=YES;
    
   // self.imag.contentMode = UIViewContentModeScaleAspectFit;
    
    self.view.backgroundColor =[UIColor colorWithRed:246.0/255.0f green:244.0/255.0f blue:245.0/255.0f alpha:1.0];
    _first.backgroundColor=[UIColor colorWithRed:120.0/255.0f green:65.0/255.0f blue:99.0/255.0f alpha:1.0];
    
    _second.backgroundColor=[UIColor whiteColor];
    _third.backgroundColor=[UIColor whiteColor];
    _fourth.backgroundColor=[UIColor whiteColor];
    _fifth.backgroundColor=[UIColor whiteColor];
    
    _personalinfolab.textColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _personalinfolinelab.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _vehicleinfolab.textColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _vehicleinfolinelab.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _drivinginfolab.textColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _drivinginfolinelab.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _emergencycontactlab.textColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _emergencycontactlinelab.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
    
   // self.view.backgroundColor=[UIColor lightGrayColor];
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"body_background2.png"]];
    
//    _first.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"body_background2.png"]];
//    _second.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"body_background2.png"]];
//    _third.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"body_background2.png"]];
//    _fourth.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"body_background2.png"]];
    
    
    _addanother.layer.cornerRadius = 10;
    _addanother.clipsToBounds = YES;
    
    _addanother.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"b" style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(barButtonBackPressed:)];
    [backButton setImage:[UIImage imageNamed:@"Untitled-1-2.png"]];
    
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _imag.layer.cornerRadius = _imag.frame.size.height /2;
    _imag.layer.masksToBounds = YES;
   // _imag.layer.borderWidth = 0;
   
    
    _imag.image=[UIImage imageNamed:@"profilepic.png"];
    _imag.hidden=NO;
    
    _personalCancel.hidden=YES;
    _personalUpdate.hidden=YES;
    _pictureImage.hidden=YES;
    
    backButton2 = [[UIBarButtonItem alloc] initWithTitle:@"b" style:UIBarButtonItemStylePlain target:self
                                                  action:@selector(barButtonBackPressed2:)];
    
    [backButton2 setImage:[UIImage imageNamed:@"menu-2.png"]];
    
    self.navigationItem.rightBarButtonItem = backButton2;
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    imagedictionary=[[NSMutableDictionary alloc]init];
    
    
    _personalCancel.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _personalUpdate.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _txtcontact.userInteractionEnabled=NO;
    _txtemail.userInteractionEnabled=NO;
    _txtName.userInteractionEnabled=NO;
    _languagebutt.hidden=YES;
    [_txtName setBorderStyle:UITextBorderStyleNone];
    
    _addanother.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    
   // _txtName.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    
//    NSData *Decode=[[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
//    UserInformation *info = [NSKeyedUnarchiver unarchiveObjectWithData:Decode];
    
    arrtripcounts=[[NSUserDefaults standardUserDefaults]objectForKey:@"tripdetail"];
    
    _lblname.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"named"];
    _txtName.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"named"];
    _lbltrip.text=[NSString stringWithFormat:@"%@",[arrtripcounts valueForKey:@"total_trip"]];
    _lblcancel.text=[NSString stringWithFormat:@"%@",[arrtripcounts valueForKey:@"canceled_trip"]];
    _lblcompleted.text=[NSString stringWithFormat:@"%@",[arrtripcounts valueForKey:@"completed_trip"]];
    _txtcontact.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"phone"];
    _txtemail.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"email"];
   
    
   // arrperDetails=[[NSMutableArray alloc]initWithObjects:info.MobileNumber,info.email, nil];
    
    arrContact=[[NSMutableArray alloc]init];
    arrname=[[NSMutableArray alloc]init];
    personaldetails=[[NSMutableArray alloc]init];
    arrid=[[NSMutableArray alloc]init];
    
    
    NSString *strurl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"imag"]];
    
    if (![strurl isEqualToString:@""])
    {
        [_imag sd_setImageWithURL:[NSURL URLWithString:strurl]
                       placeholderImage:[UIImage imageNamed:@"default profile.png"]];
       //  _imag.contentMode = UIViewContentModeScaleAspectFit;
    }

    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,myprofileinfo]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else
                               {
                                   [self parseJSONR2:data];
                               }
                           }];
}


-(void)barButtonBackPressed:(id)sender
{
    self.view.userInteractionEnabled=NO;
    SidebarViewController *side=[self.storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"];
    [self.navigationController pushViewController:side animated:YES];
}

-(void)barButtonBackPressed2:(id)sender
{
    //  self.navigationItem.rightBarButtonItem.enabled = NO;
    
    if (isClicked2==YES)
    {
        popview = [[UIView alloc]init];
        popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        //  popview.backgroundColor = [UIColor clearColor];
        popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
        
        [self.view addSubview:popview];
        
        footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-120, 60, 120, 100)];
        footerview.backgroundColor=[UIColor whiteColor];
        [popview addSubview:footerview];
        
        UIButton *btn =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, footerview.frame.size.width, footerview.frame.size.height/2-2)];
        [btn addTarget:self action:@selector(hideBtnTapped) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"Edit" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [footerview addSubview:btn];
        
        UILabel *la1=[[UILabel alloc]initWithFrame:CGRectMake(0, 49, footerview.frame.size.width, 2)];
        [la1 setBackgroundColor:[UIColor lightGrayColor]];
        [footerview addSubview:la1];
        
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 51, footerview.frame.size.width, footerview.frame.size.height/2+1)];
        [btn1 addTarget:self action:@selector(hideBtnTapped1) forControlEvents:UIControlEventTouchUpInside];
        [btn1 setTitle:@"Settings" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [footerview addSubview:btn1];
        
        isClicked2=NO;
    }
    else
    {
        [footerview removeFromSuperview];
        popview.hidden = YES;
        isClicked2=YES;
    }
}


- (void)hideBtnTapped
{
    _personalCancel.hidden=NO;
    _personalUpdate.hidden=NO;
    _pictureImage.hidden=NO;
    _txtcontact.userInteractionEnabled=NO;
    _txtemail.userInteractionEnabled=NO;
    _txtName.userInteractionEnabled=NO;
    _languagebutt.hidden=NO;
    
    [footerview removeFromSuperview];
    popview.hidden = YES;
}

- (void)hideBtnTapped1
{
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    self.view.userInteractionEnabled=NO;
    
    SettingsViewController *stvc=[self.storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
    [self.navigationController pushViewController:stvc animated:YES];
}



- (IBAction)pictureEditClicked:(id)sender
{
    _personalCancel.hidden=NO;
    _personalUpdate.hidden=NO;
    _pictureImage.hidden=NO;
    _txtcontact.userInteractionEnabled=YES;
    _txtemail.userInteractionEnabled=YES;
    _txtName.userInteractionEnabled=YES;
    _languagebutt.hidden=NO;
}

- (IBAction)PersonalCancelClicked:(id)sender
{
    _pictureImage.hidden=YES;
    _personalCancel.hidden=YES;
    _personalUpdate.hidden=YES;
    _txtcontact.userInteractionEnabled=NO;
    _txtemail.userInteractionEnabled=NO;
    _txtName.userInteractionEnabled=NO;
    self.navigationItem.rightBarButtonItem.enabled = YES;
    _languagebutt.hidden=YES;
    isClicked2=YES;

}



- (IBAction)PersonalUpdateClicked:(id)sender
{
  //  self.view.userInteractionEnabled=NO;
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    //Set Params
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    
    //Create boundary, it can be anything
    NSString *boundary = @"------VohpleBoundary4QuqLuM1cE5lMwCy";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    //Populate a dictionary with all the regular values you would like to send.
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    
    [parameters setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ] forKey:@"user_id"];
    
    [parameters setValue:_txtName.text forKey:@"name"];
    
    [parameters setValue:_txtemail.text forKey:@"email"];
    
    if (strlanguageid == (id)[NSNull null] || strlanguageid.length == 0 )
    {
       
    }
    else
    {
        [parameters setObject:strlanguageid forKey:@"lang"];
    }

    
    [parameters setValue:_txtemail.text forKey:@"email"];
    
   // [parameters setValue:@"Image.jpg" forKey:@"image_name"];
    
   // [parameters setValue:byteArray forKey:@"image"];
    
    
    // add params (all params are strings)
    for (NSString *param in parameters)
    {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [parameters objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSString *FileParamConstant = @"image";
    
    NSData *imageData = UIImageJPEGRepresentation(currentSelectedImage, 1);
    
    //Assuming data is not nil we add this to the multipart form
    if (imageData)
    {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type:image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    //Close off the request with the boundary
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the request
    [request setHTTPBody:body];
    
    NSString *strRegurl=[NSString stringWithFormat:@"%@%@",BaseUrl,editprofile];
    
    // set URL
    [request setURL:[NSURL URLWithString:strRegurl]];
    

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
    {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else
                               {
                                   [self parseJSONR:data];
                               }
    }];

}

-(void)parseJSONR:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
  //  NSLog(@"***** Edit profile Update details ******* %@", responseJSON);
    
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
        _pictureImage.hidden=YES;
        _personalCancel.hidden=YES;
        _personalUpdate.hidden=YES;
        _txtcontact.userInteractionEnabled=NO;
        _txtemail.userInteractionEnabled=NO;
        _txtName.userInteractionEnabled=NO;
        _languagebutt.hidden=YES;
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,myprofileinfo]]];
        
        request.HTTPMethod = @"POST";
        
        NSMutableString* profile = [NSMutableString string];
        
        [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
        
        request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (error) {
                                       // Handle error
                                       //[self handleError:error];
                                   } else
                                   {
                                       [self parseJSONR2:data];
                                   }
                               }];

        
    }
}
-(void)parseJSONR2:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
    NSLog(@"***** profile details ******* %@", responseJSON);
    
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
        [arrchecks removeAllObjects];
        personaldetails=[responseJSON valueForKey:@"data"];
        arrlanguages=[personaldetails valueForKey:@"lang"];
        arrlanguageids=[arrlanguages valueForKey:@"name"];
        
        NSMutableArray *arrids=[[NSMutableArray alloc]init];
        
        for (int i=0; i<arrlanguages.count; i++)
        {
            NSString *strpresent=[NSString stringWithFormat:@"%@",[[arrlanguages objectAtIndex:i] valueForKey:@"present"]];
            
            if ([strpresent isEqualToString:@"1"])
            {
                NSMutableArray *arr=[[NSMutableArray alloc]init];
                [arr addObject:[[arrlanguages objectAtIndex:i]valueForKey:@"name"]];
                arrids=[[arrids arrayByAddingObjectsFromArray:arr] mutableCopy];
                
                NSMutableArray *arr2=[[NSMutableArray alloc]init];
                NSString *str=[NSString stringWithFormat:@"%d",i];
                [arr2 addObject:str];
                
                arrchecks=[[arrchecks arrayByAddingObjectsFromArray:arr2] mutableCopy];
            }
        }
        NSLog(@"%@",arrids);
        NSString *result = [arrids  componentsJoinedByString:@", "];
        NSLog(@"%@",result);
        NSLog(@"%@",arrchecks);
        
        _txtLanguagesKnown.text=result;
        
        [[NSUserDefaults standardUserDefaults]setObject:result forKey:@"lagre"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        self.view.userInteractionEnabled=YES;
        _txtName.text=[personaldetails valueForKey:@"name"];
        _txtcontact.text=[personaldetails valueForKey:@"mobile_no"];
        _txtemail.text=[personaldetails valueForKey:@"email"];
        
        NSString *str=[personaldetails valueForKey:@"image"];
        [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"imag"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        arrname=[[personaldetails valueForKey:@"contacts"]valueForKey:@"name"];
        arrContact=[[personaldetails valueForKey:@"contacts"]valueForKey:@"contact_no"];
        NSMutableArray *arrcou=[[NSMutableArray alloc]init];
        arrcou=[personaldetails valueForKey:@"contacts"];
        NSString *strcoun=[NSString stringWithFormat:@"%lu",(unsigned long)arrcou.count];
        arrid=[[personaldetails valueForKey:@"contacts"]valueForKey:@"id"];
        
        _labyear.text=[personaldetails valueForKey:@"vehicle_year"];
        _txtMake.text=[personaldetails valueForKey:@"vehicle_make"];
        _txtModel.text=[personaldetails valueForKey:@"vehicle_model"];
        _txtColor.text=[personaldetails valueForKey:@"vehicle_color"];
        _txtlicencePlate.text=[personaldetails valueForKey:@"license_plate"];
        
        strdl=[NSString stringWithFormat:@"%@",[personaldetails valueForKey:@"driver_license"]];
        strtl=[NSString stringWithFormat:@"%@",[personaldetails valueForKey:@"tlc_license"]];
        strreg=[NSString stringWithFormat:@"%@",[personaldetails valueForKey:@"registration"]];
        strdc=[NSString stringWithFormat:@"%@", [personaldetails valueForKey:@"diamond_card"]];
        strfh1=[NSString stringWithFormat:@"%@",[personaldetails valueForKey:@"insurance"]];
        strll=[NSString stringWithFormat:@"%@", [personaldetails valueForKey:@"insurance_liability"]];
        
        isClicked2=YES;
        
        NSString *strurl=[NSString stringWithFormat:@"%@",[personaldetails valueForKey:@"image"]];
        [_imag sd_setImageWithURL:[NSURL URLWithString:strurl]
                 placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
      //   _imag.contentMode = UIViewContentModeScaleAspectFit;
        
        
        if ([strcoun isEqualToString:@"0"])
        {
            _contacttable.hidden=YES;
            labcon=[[UILabel alloc] initWithFrame:CGRectMake(_fifth.frame.size.width/2-50, _fifth.frame.size.height/2-20, 100, 40)];
            labcon.text=@"No Contacts";
            labcon.textColor=[UIColor purpleColor];
            [_fifth addSubview:labcon];
        }
        else
        {
            _contacttable.hidden=NO;
            labcon.hidden=YES;
        }
        
        [_contacttable updateConstraints];
        [_contacttable reloadData];

    }
}


- (IBAction)languagebuttClicked:(id)sender
{
    [self.view endEditing:YES];
    
    [Dropobj fadeOut];
    
    //NSMutableArray *arrlanguage=[arrlanguages valueForKey:@"language"];
    
    if ([UIScreen mainScreen].bounds.size.width < 350 )
    {
        [self showPopUpWithTitle:@"Select Language" withOption:arrlanguageids xy:CGPointMake(self.view.frame.size.width/2-150, 70) size:CGSizeMake(300, 400) isMultiple:YES];
    }
    else
    {
        [self showPopUpWithTitle:@"Select Language" withOption:arrlanguageids xy:CGPointMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-200) size:CGSizeMake(300, 400) isMultiple:YES];
    }
}


#pragma mark - DropDown Menu Delegates


-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple
{
    popview = [[ UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"edit" forKey:@"strlanguage"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrchecks];
    
    [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"languagedata"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple];
    Dropobj.delegate = self;
    [Dropobj showInView:popview animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    // [Dropobj SetBackGroundDropDown_R:0.0 G:108.0 B:194.0 alpha:0.70];
    Dropobj.backgroundColor=[UIColor lightGrayColor];
}


- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex
{
    /*----------------Get Selected Value[Single selection]-----------------*/
    
    
    
}

-(void)DropDownListView2:(DropDownListView *)dropdownListView Datalist:(NSMutableArray *)ArryData
{
    
    if (ArryData.count>0)
    {
        [arrchecks removeAllObjects];
        arrchecks=[[arrchecks arrayByAddingObjectsFromArray:ArryData] mutableCopy];

        NSLog(@"%@",ArryData);
        
        NSMutableArray *arrids=[[NSMutableArray alloc]init];
        
        for (int i=0; i<ArryData.count; i++)
        {
            NSMutableArray *arr=[[NSMutableArray alloc]init];
            
            
            NSString *str1=[ArryData objectAtIndex:i];
            int j=(int)[str1 integerValue];
            
            [arr addObject:[[arrlanguages objectAtIndex:j] valueForKey:@"id"]];
            
            arrids=[[arrids arrayByAddingObjectsFromArray:arr] mutableCopy];
        }
        
        NSLog(@"%@",arrids);
        
        strlanguageid = [arrids  componentsJoinedByString:@","];
        NSLog(@"%@",strlanguageid);
    }
    else
    {
        
    }
    
}

- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData
{
    /*----------------Get Selected Value[Multiple selection]-----------------*/
    
    if (ArryData.count>0)
    {
        _txtLanguagesKnown.text=[ArryData componentsJoinedByString:@", "];
    }
    else
    {
        
    }
    
    [footerview removeFromSuperview];
    popview.hidden = YES;
}



- (void)DropDownListViewDidCancel
{
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    if ([touch.view isKindOfClass:[UIView class]]) {
        [Dropobj fadeOut];
        popview.hidden = YES;
    }
}

-(CGSize)GetHeightDyanamic:(UILabel*)lbl
{
    NSRange range = NSMakeRange(0, [lbl.text length]);
    CGSize constraint;
    constraint= CGSizeMake(288 ,MAXFLOAT);
    CGSize size;
    
    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)) {
        NSDictionary *attributes = [lbl.attributedText attributesAtIndex:0 effectiveRange:&range];
        CGSize boundingBox = [lbl.text boundingRectWithSize:constraint options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        
        size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    }
    else
    {
        CGRect textRect = [lbl.text boundingRectWithSize:size
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:14]}
                                                 context:nil];
        size = textRect.size;
    }
    return size;
}





- (IBAction)PictureClicked:(id)sender
{
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"Select One Option" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take a Photo",@"Choose from Gallery", nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.delegate=self;
    if(buttonIndex==0)
    {
        @try {
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
            {
                UIDevice *device = [UIDevice currentDevice];
                NSString *currDevice = [device model];
                if(![currDevice isEqualToString:@"iPhone Simulator"])
                {
                    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
                    
                    UIImagePickerController *imgPickerCon = [[UIImagePickerController alloc] init];
                    imgPickerCon.sourceType = UIImagePickerControllerSourceTypeCamera;
                    imgPickerCon.delegate = self;
                    imgPickerCon.allowsEditing =  YES;
                    [self presentViewController:imgPickerCon animated:YES completion:nil];
                    
                    imgPickerCon = nil;
                }
                else
                {
                    UIAlertView *alrt=[[UIAlertView alloc] initWithTitle:@"Not Valid" message:@"Camera Not available" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alrt show];
                }
            }
            else
            {
                UIAlertView *alrt=[[UIAlertView alloc] initWithTitle:@"Not Valid" message:@"Camera Not available" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alrt show];
            }
            
            
        }
        @catch (NSException *exception) {
            NSLog(@"Catch:%@",[exception description]);
            NSLog(@"Catch:%@",[exception reason]);
        }
        @finally {
            
        }
        
    }
    else if(buttonIndex==1)
    {
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    else if(buttonIndex==2)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


#pragma mark
#pragma mark -- Reduce Image Size
-(UIImage*)imageWithReduceImage: (UIImage*)imageName scaleToSize: (CGSize)newsize
{
    UIGraphicsBeginImageContextWithOptions(newsize, NO, 12.0);
    [imageName drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    return newImage;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)myimage editingInfo:(NSDictionary *)editingInfo
{
    _imag.image=myimage;
    currentSelectedImage=myimage;
   // currentSelectedImage = [self imageWithReduceImage:myimage
                                                //   scaleToSize:CGSizeMake(20, 20)];
//    NSData *imageData = UIImageJPEGRepresentation(currentSelectedImage, 0.5);
//    NSLog(@"Size of image = %u KB",(imageData.length/1024));
//
//    byteArray = [UIImagePNGRepresentation(currentSelectedImage) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    NSData *data=[byteArray dataUsingEncoding:NSUTF8StringEncoding];
//    base64Encoded = [data base64EncodedStringWithOptions:0];
    
     [self dismissViewControllerAnimated:YES completion:nil];
}




- (IBAction)addanotherContactClicked:(id)sender
{
    
    popview = [[UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    //  popview.backgroundColor = [UIColor clearColor];
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height/2-10, self.view.frame.size.width-20, 130)];
    //footerview.backgroundColor=[UIColor blackColor];
    footerview.backgroundColor = [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    [popview addSubview:footerview];
    
    lab=[[UITextField alloc]initWithFrame:CGRectMake(10, 10, footerview.frame.size.width-20, 30)];
    lab.placeholder=@"Type the Name of the Contact Number";
    lab.backgroundColor=[UIColor whiteColor];
    lab.textColor=[UIColor blackColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont systemFontOfSize:13];
    [footerview addSubview:lab];
    
    lab1=[[UITextField alloc]initWithFrame:CGRectMake(10, 50, footerview.frame.size.width-20, 30)];
    lab1.placeholder=@"Type the Contact Number";
    lab1.backgroundColor=[UIColor whiteColor];
    lab1.textColor=[UIColor blackColor];
    lab1.textAlignment=NSTextAlignmentCenter;
    lab1.font=[UIFont systemFontOfSize:13];
    [footerview addSubview:lab1];
    
    UIButton *cancelbutt=[[UIButton alloc]initWithFrame:CGRectMake(5, 90, footerview.frame.size.width/2-5, 30)];
    cancelbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    [cancelbutt  setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelbutt addTarget:self action:@selector(cancelclicked) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:cancelbutt];
    
    UIButton *add=[[UIButton alloc]initWithFrame:CGRectMake(cancelbutt.frame.size.width+10, 90, footerview.frame.size.width/2-10, 30)];
    add.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    [add  setTitle:@"Add" forState:UIControlStateNormal];
    [add addTarget:self action:@selector(addclicked) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:add];
    
    
    lab.delegate=self;
    lab1.delegate=self;
    
    

}

-(void)cancelclicked
{
    [footerview removeFromSuperview];
     popview.hidden = YES;
}
-(void)addclicked
{

    if (lab.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please Enter the Name of the Contact Number" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (lab1.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please Enter Contact Number" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,addemergencycontact]]];
        
        request.HTTPMethod = @"POST";
        
        NSMutableString* profile = [NSMutableString string];
        
        [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
        [profile appendString:[NSString stringWithFormat:@"&name=%@",lab.text]];
        [profile appendString:[NSString stringWithFormat:@"&contact_no=%@",lab1.text]];
        
        request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (error) {
                                       // Handle error
                                       //[self handleError:error];
                                   } else
                                   {
                                       [self parseJSONR3:data];
                                   }
                               }];
        
    }
}


-(void)parseJSONR3:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
    NSLog(@"***** Emergency contact details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
//        [arrname addObject:lab.text];
//        [arrContact addObject:lab1.text];
        
        [footerview removeFromSuperview];
        popview.hidden = YES;
        _contacttable.hidden=NO;
        labcon.hidden=NO;
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,myprofileinfo]]];
        
        request.HTTPMethod = @"POST";
        
        NSMutableString* profile = [NSMutableString string];
        
        [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
        
        request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (error) {
                                       // Handle error
                                       //[self handleError:error];
                                   } else
                                   {
                                       [self parseJSONR2:data];
                                   }
                               }];

    }
}




-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isClicked && indexPath.row == selectedIndex){
        return 100.0;
    }
    else {
        return 50.0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrContact.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellClassName = @"Customcell2";
    
    cell = (Customcell2 *)[tableView dequeueReusableCellWithIdentifier: CellClassName];
    
    if (cell == nil)
    {
        cell = [[Customcell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellClassName];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Customcell2"
                                                     owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    lblname1=(UITextField *)[cell viewWithTag:1];
    txtnumber=(UITextField *)[cell viewWithTag:2];
    editbutton=(UIButton *)[cell viewWithTag:3];
    cancel=(UIButton *)[cell viewWithTag:4];
    update=(UIButton *)[cell viewWithTag:5];
    deletebu=(UIButton *)[cell viewWithTag:6];
    label5=(UILabel *)[cell viewWithTag:8];
    
    label5.hidden=YES;
   
    [lblname1 setBorderStyle:UITextBorderStyleNone];
    [txtnumber setBorderStyle:UITextBorderStyleNone];
    
    cancel.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    update.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    deletebu.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    lblname1.text=[arrname objectAtIndex:indexPath.row];
    txtnumber.text=[arrContact objectAtIndex:indexPath.row];
    label5.text=[arrid objectAtIndex:indexPath.row];
    
    lblname1.userInteractionEnabled=YES;
    txtnumber.userInteractionEnabled=YES;
    
    
    
    lblname1.delegate=self;
    txtnumber.delegate=self;
    
    lblname1.tag=indexPath.row;
    txtnumber.tag=indexPath.row;
    label5.tag=indexPath.row;
    
    editbutton.tag=indexPath.row;
    cancel.tag=indexPath.row;
    update.tag=indexPath.row;
    deletebu.tag=indexPath.row;
    
    
    [editbutton addTarget:self action:@selector(editclicked:) forControlEvents:UIControlEventTouchUpInside];
    [cancel addTarget:self action:@selector(cancelCli:) forControlEvents:UIControlEventTouchUpInside];
    [update addTarget:self action:@selector(updateClick:) forControlEvents:UIControlEventTouchUpInside];
    [deletebu addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (isClicked && indexPath.row == selectedIndex)
    {
        lblname1.userInteractionEnabled=YES;
        txtnumber.userInteractionEnabled=YES;
        editbutton.hidden=YES;
        cancel.hidden=NO;
        update.hidden=NO;
        deletebu.hidden=NO;
        
    }else
    {
        lblname1.userInteractionEnabled=NO;
        txtnumber.userInteractionEnabled=NO;
        editbutton.hidden=NO;
        cancel.hidden=YES;
        update.hidden=YES;
        deletebu.hidden=YES;
    }
    
    return  cell;
}


-(void)editclicked:(id)sender
{
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero
                                           toView:self.contacttable];
    NSIndexPath *tappedIP = [self.contacttable indexPathForRowAtPoint:buttonPosition];
    
    cell1 = [self.contacttable cellForRowAtIndexPath: tappedIP];
    cell1.editbutton.tag = tappedIP.row;
    cell1.lblname1.tag=tappedIP.row;
    cell1.txtnumber.tag=tappedIP.row;
    
    
    isClicked = !isClicked;
    selectedIndex = tappedIP.row;
    
    
    
    if (isClicked)
    {
        lblname1.userInteractionEnabled=YES;
        txtnumber.userInteractionEnabled=YES;
        editbutton.hidden=YES;
        cancel.hidden=NO;
        update.hidden=NO;
        deletebu.hidden=NO;
    }
    else
    {
        lblname1.userInteractionEnabled=NO;
        txtnumber.userInteractionEnabled=NO;
        editbutton.hidden=NO;
        cancel.hidden=YES;
        update.hidden=YES;
        deletebu.hidden=YES;
    }
    
    
    [self.contacttable reloadData];
}

-(void)cancelCli:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero
                                           toView:self.contacttable];
    NSIndexPath *tappedIP = [self.contacttable indexPathForRowAtPoint:buttonPosition];
    
    cell1 = [self.contacttable cellForRowAtIndexPath: tappedIP];
    cell1.cancel.tag = tappedIP.row;
    
    isClicked = NO;
    selectedIndex = tappedIP.row;
    
    [self.contacttable reloadData];
}

-(void)updateClick:(id)sender
{
   
    CGPoint buttonPosition = [sender convertPoint:CGPointZero
                                           toView:self.contacttable];
    NSIndexPath *tappedIP = [self.contacttable indexPathForRowAtPoint:buttonPosition];
    
    cell1 = [self.contacttable cellForRowAtIndexPath: tappedIP];
    cell1.update.tag = tappedIP.row;
    
    cell1.lblname1.tag=tappedIP.row;
    cell1.txtnumber.tag=tappedIP.row;
    cell1.label5.tag=tappedIP.row;
    
//    [arrname replaceObjectAtIndex:tappedIP.row withObject:lblname1.text];
//    [arrContact replaceObjectAtIndex:tappedIP.row withObject:txtnumber.text];
    
    isClicked = NO;
    selectedIndex = tappedIP.row;
    
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,updateemergencycontact]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&name=%@",lblname1.text]];
    [profile appendString:[NSString stringWithFormat:@"&contact_no=%@",txtnumber.text]];
    [profile appendString:[NSString stringWithFormat:@"&contact_id=%@",label5.text]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else
                               {
                                   [self parseJSONR:data];
                               }
                           }];

    
   // [self.contacttable reloadData];
}

-(void)deleteClick:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero
                                           toView:self.contacttable];
    NSIndexPath *tappedIP = [self.contacttable indexPathForRowAtPoint:buttonPosition];
    
    cell1 = [self.contacttable cellForRowAtIndexPath: tappedIP];
    
//    [arrname removeObjectAtIndex:tappedIP.row];
//    [arrContact removeObjectAtIndex:tappedIP.row];
 //   [_contacttable deleteRowsAtIndexPaths:[NSArray arrayWithObject:tappedIP] withRowAnimation:UITableViewRowAnimationFade];
    cell1.deletebu.tag = tappedIP.row;
    
    cell1.lblname1.tag=tappedIP.row;
    cell1.txtnumber.tag=tappedIP.row;
    cell1.label5.tag=tappedIP.row;
    
    isClicked = NO;
    selectedIndex = tappedIP.row;
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,deleteemergencycontacy]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"contact_id=%@",label5.text]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else
                               {
                                   [self parseJSONR:data];
                               }
                           }];


    
    
    
 //   [self.contacttable reloadData];
}


#pragma mark
#pragma mark -- TextfieldDelegate


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -165; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

#pragma mark
#pragma mark -- Licence show

- (IBAction)DlClicked:(id)sender
{
    popview = [[ UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    //  popview.backgroundColor = [UIColor clearColor];
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(5, self.view.frame.size.height/3, self.view.frame.size.width-10, 261)];
    //footerview.backgroundColor=[UIColor blackColor];
    footerview.backgroundColor = [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    [popview addSubview:footerview];
    
    
    UILabel *labb=[[UILabel alloc]initWithFrame:CGRectMake(10, 7, 150, 40)];
    labb.text=@"Driver licence";
    labb.textColor=[UIColor whiteColor];
    labb.font=[UIFont systemFontOfSize:20];
    [footerview addSubview:labb];
    
    UIButton *butt=[[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width-62,8,60,41)];
   // [butt setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
    [butt setTitle:@"CLOSE" forState:UIControlStateNormal];
    [butt addTarget:self action:@selector(butnclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt];
    
    UIImageView *imaged=[[UIImageView alloc] initWithFrame:CGRectMake(0,butt.frame.origin.y+butt.frame.size.height+10, footerview.frame.size.width, 220)];
    imaged.backgroundColor=[UIColor whiteColor];
    imaged.contentMode=UIImageResizingModeStretch;
    [imaged sd_setImageWithURL:[NSURL URLWithString:strdl]
             placeholderImage:[UIImage imageNamed:@"default profile.png"]];
    
    [footerview addSubview:imaged];
    
    [popview addSubview:footerview];
}

-(void)butnclicked:(id)sender
{
    [footerview removeFromSuperview];
    popview.hidden = YES;
}

- (IBAction)Tlclicked:(id)sender
{
    popview = [[ UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    //  popview.backgroundColor = [UIColor clearColor];
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(5, self.view.frame.size.height/3, self.view.frame.size.width-10, 261)];
    //footerview.backgroundColor=[UIColor blackColor];
    footerview.backgroundColor = [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    [popview addSubview:footerview];
    
    
    UILabel *labb=[[UILabel alloc]initWithFrame:CGRectMake(10, 7, 150, 40)];
    labb.text=@"TLC licence";
    labb.textColor=[UIColor whiteColor];
    labb.font=[UIFont systemFontOfSize:20];
    [footerview addSubview:labb];
    
    UIButton *butt=[[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width-62,8,60,41)];
    // [butt setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
    [butt setTitle:@"CLOSE" forState:UIControlStateNormal];
    [butt addTarget:self action:@selector(butnclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt];
    
    UIImageView *imaged=[[UIImageView alloc] initWithFrame:CGRectMake(0,butt.frame.origin.y+butt.frame.size.height+10, footerview.frame.size.width, 220)];
    imaged.backgroundColor=[UIColor whiteColor];
    imaged.contentMode=UIImageResizingModeStretch;
    [imaged sd_setImageWithURL:[NSURL URLWithString:strtl]
              placeholderImage:[UIImage imageNamed:@"default profile.png"]];
    [footerview addSubview:imaged];
    
    [popview addSubview:footerview];
}
- (IBAction)dcClicked:(id)sender
{
    popview = [[ UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    //  popview.backgroundColor = [UIColor clearColor];
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(5, self.view.frame.size.height/3, self.view.frame.size.width-10, 261)];
    //footerview.backgroundColor=[UIColor blackColor];
    footerview.backgroundColor = [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    [popview addSubview:footerview];
    
    UILabel *labb=[[UILabel alloc]initWithFrame:CGRectMake(10, 7, 150, 40)];
    labb.text=@"Diamond Card";
    labb.textColor=[UIColor whiteColor];
    labb.font=[UIFont systemFontOfSize:20];
    [footerview addSubview:labb];
    
    UIButton *butt=[[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width-62,8,60,41)];
    // [butt setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
    [butt setTitle:@"CLOSE" forState:UIControlStateNormal];
    [butt addTarget:self action:@selector(butnclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt];
    
    UIImageView *imaged=[[UIImageView alloc] initWithFrame:CGRectMake(0,butt.frame.origin.y+butt.frame.size.height+10, footerview.frame.size.width, 220)];
    imaged.backgroundColor=[UIColor whiteColor];
    imaged.contentMode=UIImageResizingModeStretch;
    [imaged sd_setImageWithURL:[NSURL URLWithString:strdc]
              placeholderImage:[UIImage imageNamed:@"default profile.png"]];
    
    [footerview addSubview:imaged];
    
    [popview addSubview:footerview];
}
- (IBAction)rgClicked:(id)sender
{
    popview = [[ UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    //  popview.backgroundColor = [UIColor clearColor];
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(5, self.view.frame.size.height/3, self.view.frame.size.width-10, 261)];
    //footerview.backgroundColor=[UIColor blackColor];
    footerview.backgroundColor = [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    [popview addSubview:footerview];
    
    
    UILabel *labb=[[UILabel alloc]initWithFrame:CGRectMake(10, 7, 150, 40)];
    labb.text=@"Registration";
    labb.textColor=[UIColor whiteColor];
    labb.font=[UIFont systemFontOfSize:20];
    [footerview addSubview:labb];
    
    UIButton *butt=[[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width-62,8,60,41)];
    // [butt setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
    [butt setTitle:@"CLOSE" forState:UIControlStateNormal];
    [butt addTarget:self action:@selector(butnclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt];
    
    UIImageView *imaged=[[UIImageView alloc] initWithFrame:CGRectMake(0,butt.frame.origin.y+butt.frame.size.height+10, footerview.frame.size.width, 220)];
    imaged.backgroundColor=[UIColor whiteColor];
    imaged.contentMode=UIImageResizingModeStretch;
    [imaged sd_setImageWithURL:[NSURL URLWithString:strreg]
              placeholderImage:[UIImage imageNamed:@"default profile.png"]];
    [footerview addSubview:imaged];
    
    [popview addSubview:footerview];
}
- (IBAction)fh1Clicked:(id)sender
{
    popview = [[ UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    //  popview.backgroundColor = [UIColor clearColor];
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(5, self.view.frame.size.height/3, self.view.frame.size.width-10, 261)];
    //footerview.backgroundColor=[UIColor blackColor];
    footerview.backgroundColor = [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    [popview addSubview:footerview];
    
    
    UILabel *labb=[[UILabel alloc]initWithFrame:CGRectMake(10, 7, 150, 40)];
    labb.text=@"FH1 Insurance";
    labb.textColor=[UIColor whiteColor];
    labb.font=[UIFont systemFontOfSize:20];
    [footerview addSubview:labb];
    
    UIButton *butt=[[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width-62,8,60,41)];
    // [butt setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
    [butt setTitle:@"CLOSE" forState:UIControlStateNormal];
    [butt addTarget:self action:@selector(butnclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt];
    
    UIImageView *imaged=[[UIImageView alloc] initWithFrame:CGRectMake(0,butt.frame.origin.y+butt.frame.size.height+10, footerview.frame.size.width, 220)];
    imaged.backgroundColor=[UIColor whiteColor];
    imaged.contentMode=UIImageResizingModeStretch;
    [imaged sd_setImageWithURL:[NSURL URLWithString:strfh1]
              placeholderImage:[UIImage imageNamed:@"default profile.png"]];
    [footerview addSubview:imaged];
    
    [popview addSubview:footerview];
}
- (IBAction)iiClicked:(id)sender
{
    popview = [[ UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    //  popview.backgroundColor = [UIColor clearColor];
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(5, self.view.frame.size.height/3, self.view.frame.size.width-10, 261)];
    //footerview.backgroundColor=[UIColor blackColor];
    footerview.backgroundColor = [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    [popview addSubview:footerview];
    
    
    UILabel *labb=[[UILabel alloc]initWithFrame:CGRectMake(10, 7, 190, 40)];
    labb.text=@"Insurance of liability";
    labb.textColor=[UIColor whiteColor];
    labb.font=[UIFont systemFontOfSize:20];
    [footerview addSubview:labb];
    
    UIButton *butt=[[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width-62,8,60,41)];
    // [butt setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
    [butt setTitle:@"CLOSE" forState:UIControlStateNormal];
    [butt addTarget:self action:@selector(butnclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt];
    
    UIImageView *imaged=[[UIImageView alloc] initWithFrame:CGRectMake(0,butt.frame.origin.y+butt.frame.size.height+10, footerview.frame.size.width, 220)];
    imaged.backgroundColor=[UIColor whiteColor];
    imaged.contentMode=UIImageResizingModeStretch;
    [imaged sd_setImageWithURL:[NSURL URLWithString:strll]
              placeholderImage:[UIImage imageNamed:@"default profile.png"]];
    [footerview addSubview:imaged];
    
    [popview addSubview:footerview];
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

-(void)viewWillAppear:(BOOL)animated
{
    
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



@end
