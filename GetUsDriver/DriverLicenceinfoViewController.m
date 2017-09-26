//
//  DriverLicenceinfoViewController.m
//  GetUsHere For Driver
//
//  Created by bharat on 04/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "DriverLicenceinfoViewController.h"
#import "DejalActivityView.h"
#import "Alertview.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "WebServiceConnection.h"
#import "UIImageView+WebCache.h"
#import "constants.h"
#import "GetUsHere.pch"
#import "SWRevealViewController.h"


@interface DriverLicenceinfoViewController ()
{
   
}
@end

@implementation DriverLicenceinfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back.jpg"]];
   
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    image.hidden=YES;
    
     _nextbutt.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    str=[[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
    str1=[[NSUserDefaults standardUserDefaults]objectForKey:@"phone"];
    str2=[[NSUserDefaults standardUserDefaults]objectForKey:@"email"];
    str3=[[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
    str4=[[NSUserDefaults standardUserDefaults]objectForKey:@"car"];
    str5=[[NSUserDefaults standardUserDefaults]objectForKey:@"cartype"];
    str6=[[NSUserDefaults standardUserDefaults]objectForKey:@"make"];
    str7=[[NSUserDefaults standardUserDefaults]objectForKey:@"model"];
    str8=[[NSUserDefaults standardUserDefaults]objectForKey:@"color"];
    str9=[[NSUserDefaults standardUserDefaults]objectForKey:@"licence"];
    
    str10=[[NSUserDefaults standardUserDefaults]objectForKey:@"phone1"];
    
    str91=[[NSUserDefaults standardUserDefaults]objectForKey:@"gender"];
    str92=[[NSUserDefaults standardUserDefaults]objectForKey:@"address"];
    str93=[[NSUserDefaults standardUserDefaults]objectForKey:@"emercontact"];
    str94=[[NSUserDefaults standardUserDefaults]objectForKey:@"wheel"];
    str95=[[NSUserDefaults standardUserDefaults]objectForKey:@"year"];
    
    mutarray=[[NSMutableArray alloc]init];
    
     _lab1uplic.text=@"Upload Driver License";
     _lab2uplic.text=@"Upload TLC License";
     _lab3uplic.text=@"Upload Diamond Card";
     _lab4uplic.text=@"Upload Registration No";
     _lab5uplic.text=@"Upload FH1 Insurance";
     _lab6uplic.text=@"Upload Insurance of Liability";
    
    UP1=_lab1uplic.text;
    UP2=_lab2uplic.text;
    UP3=_lab3uplic.text;
    UP4=_lab4uplic.text;
    UP5=_lab5uplic.text;
    UP6=_lab6uplic.text;
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
}

- (IBAction)DlicenUploadClicked:(id)sender
{
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"Photo capturing" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take a Photo",@"Select a photo from gallery", nil];
    [sheet showInView:self.view];
    button.tag=1;
}
- (IBAction)TLCLicenseClicked:(id)sender
{
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"Photo capturing" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take a Photo",@"Select a photo from gallery", nil];
    [sheet showInView:self.view];
    button.tag=2;
}
- (IBAction)DiamondClicked:(id)sender
{
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"Photo capturing" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take a Photo",@"Select a photo from gallery", nil];
    [sheet showInView:self.view];
    button.tag=3;

}
- (IBAction)RegistrationClicked:(id)sender
{
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"Photo capturing" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take a Photo",@"Select a photo from gallery", nil];
    [sheet showInView:self.view];
    button.tag=4;
    
}
- (IBAction)fh1Clicked:(id)sender
{
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"Photo capturing" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take a Photo",@"Select a photo from gallery", nil];
    [sheet showInView:self.view];
    button.tag=5;
}
- (IBAction)insuranceofliabilityClicked:(id)sender
{
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"Photo capturing" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take a Photo",@"Select a photo from gallery", nil];
    [sheet showInView:self.view];
    button.tag=6;

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
-(UIImage*)imageWithReduceImage: (UIImage*)imageName scaleToSize: (CGSize)newsize{
    UIGraphicsBeginImageContextWithOptions(newsize, NO, 12.0);
    [imageName drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    return newImage;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)myimage editingInfo:(NSDictionary *)editingInfo
{
    image.image=myimage;
    image.hidden=YES;
    image.image = myimage;
    
    if (button.tag==1)
    {
       _lab1uplic.text=@"Driverlicence.jpg";
        
        currentSelectedImage = [self imageWithReduceImage:myimage
                                              scaleToSize:CGSizeMake(20, 20)];
        
        NSData *imageData = UIImageJPEGRepresentation(currentSelectedImage, 0.5);
        NSLog(@"Size of image = %u KB",(imageData.length/1024));
        
        byteArray = [UIImagePNGRepresentation(currentSelectedImage) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    if (button.tag==2)
    {
         _lab2uplic.text=@"TLClicence.jpg";
        currentSelectedImage1 = [self imageWithReduceImage:myimage
                                              scaleToSize:CGSizeMake(20, 20)];
        
        NSData *imageData = UIImageJPEGRepresentation(currentSelectedImage1, 0.5);
        NSLog(@"Size of image = %u KB",(imageData.length/1024));
        
        byteArray = [UIImagePNGRepresentation(currentSelectedImage1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    if (button.tag==3)
    {
            _lab3uplic.text=@"Diamondcard.jpg";
        currentSelectedImage2 = [self imageWithReduceImage:myimage
                                              scaleToSize:CGSizeMake(20, 20)];
        
        NSData *imageData = UIImageJPEGRepresentation(currentSelectedImage2, 0.5);
        NSLog(@"Size of image = %u KB",(imageData.length/1024));
        
        byteArray = [UIImagePNGRepresentation(currentSelectedImage2) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    if (button.tag==4)
    {
       
        _lab4uplic.text=@"Registration.jpg";
        currentSelectedImage3 = [self imageWithReduceImage:myimage
                                              scaleToSize:CGSizeMake(20, 20)];
        
        NSData *imageData = UIImageJPEGRepresentation(currentSelectedImage3, 0.5);
        NSLog(@"Size of image = %u KB",(imageData.length/1024));
        
        byteArray = [UIImagePNGRepresentation(currentSelectedImage3) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    if (button.tag==5)
    {
        _lab5uplic.text=@"FH1Insurance.jpg";
        currentSelectedImage4 = [self imageWithReduceImage:myimage
                                              scaleToSize:CGSizeMake(20, 20)];
        
        NSData *imageData = UIImageJPEGRepresentation(currentSelectedImage4, 0.5);
        NSLog(@"Size of image = %u KB",(imageData.length/1024));
        
        byteArray = [UIImagePNGRepresentation(currentSelectedImage4) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    if (button.tag==6)
    {
        _lab6uplic.text=@"InsuranceLiability.jpg";
        currentSelectedImage5 = [self imageWithReduceImage:myimage
                                              scaleToSize:CGSizeMake(20, 20)];
        
        NSData *imageData = UIImageJPEGRepresentation(currentSelectedImage5, 0.5);
        NSLog(@"Size of image = %u KB",(imageData.length/1024));
        
        byteArray = [UIImagePNGRepresentation(currentSelectedImage5) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}



- (IBAction)RegisterClicked:(id)sender
{

    if ([_lab1uplic.text isEqualToString:@"Upload Driver License"])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please upload Driver License" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([_lab2uplic.text isEqualToString:@"Upload TLC License"])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please upload TLC License" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([_lab3uplic.text isEqualToString:@"Upload Diamond Card"])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please upload Diamond Card" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([_lab4uplic.text isEqualToString:@"Upload Registration No"])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please upload Registration Card" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([_lab5uplic.text isEqualToString:@"Upload FH1 Insurance"])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please upload FH1 Insurance Card" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([_lab6uplic.text isEqualToString:@"Upload Insurance of Liability"])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please upload Insurance of liability Card" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        self.view.userInteractionEnabled=NO;
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        [self next];
    }
}



-(void)next
{
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
    
    [parameters setValue:str forKey:@"name"];
    
    [parameters setValue:str10 forKey:@"ccode"];
    
    [parameters setValue:str1 forKey:@"mobile_no"];
    
    [parameters setValue:str2 forKey:@"email"];
    
    [parameters setValue:str3 forKey:@"password"];
    
    [parameters setValue:@"driver" forKey:@"user_type"];
    
    [parameters setValue:str4 forKey:@"car_type"];
    
    [parameters setValue:str5 forKey:@"car_sub_type"];
    
    [parameters setValue:str6 forKey:@"vehicle_make"];
    
    [parameters setValue:str7 forKey:@"vehicle_model"];
    
    [parameters setValue:str8 forKey:@"vehicle_color"];
    
    [parameters setValue:str9 forKey:@"license_plate"];
    
    [parameters setValue:str91 forKey:@"user_sex"];
    
    [parameters setValue:str92 forKey:@"address"];
    
    [parameters setValue:str93 forKey:@"lang"];
    
    [parameters setValue:str94 forKey:@"wheel_chair"];
    
    [parameters setValue:str95 forKey:@"vehicle_year"];
    
    [parameters setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"devicetoken"] forKey:@"device_id"];
    
    [parameters setValue:@"ios" forKey:@"os"];
    
    
    // add params (all params are strings)
    for (NSString *param in parameters)
    {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [parameters objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSString *FileParamConstant = @"driver_license";
    NSString *FileParamConstant1 = @"tlc_license";
    NSString *FileParamConstant2 = @"diamond_card";
    NSString *FileParamConstant3 = @"registration";
    NSString *FileParamConstant4 = @"insurance";
    NSString *FileParamConstant5 = @"insurance_liability";
    
    
    NSData *imageData = UIImageJPEGRepresentation(currentSelectedImage, 1);
    NSData *imageData1 = UIImageJPEGRepresentation(currentSelectedImage1, 1);
    NSData *imageData2 = UIImageJPEGRepresentation(currentSelectedImage2, 1);
    NSData *imageData3 = UIImageJPEGRepresentation(currentSelectedImage3, 1);
    NSData *imageData4 = UIImageJPEGRepresentation(currentSelectedImage4, 1);
    NSData *imageData5 = UIImageJPEGRepresentation(currentSelectedImage5, 1);
    
    //Assuming data is not nil we add this to the multipart form
    if (imageData)
    {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type:image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant1] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type:image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData1];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant2] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type:image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData2];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant3] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type:image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData3];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant4] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type:image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData4];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant5] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type:image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData5];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];

    }

    //Close off the request with the boundary
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the request
    [request setHTTPBody:body];
    
    NSString *strRegurl=[NSString stringWithFormat:@"%@%@",BaseUrl,registration];
    
    // set URL
    [request setURL:[NSURL URLWithString:strRegurl]];
    
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    [self parseJSONResponse:data];
                }
            }
        });
    }] resume];
    

}

-(void)parseJSONResponse:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
    NSLog(@"*****Register details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    NSString *strr;
    strr=[responseJSON objectForKey:@"message"];
    
    [[NSUserDefaults standardUserDefaults]setObject:strr forKey:@"message"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    // NSLog(@"%@",DataArray);
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
        self.view.userInteractionEnabled=YES;
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        [self performSegueWithIdentifier:@"final" sender:self];
        
    }
}


-(void)viewDidDisappear:(BOOL)animated{
    
    self.title = @"";
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = YES;
    
    self.view.userInteractionEnabled=YES;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"Files Upload";
    
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
