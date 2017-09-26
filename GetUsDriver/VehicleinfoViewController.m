//
//  VehicleinfoViewController.m
//  GetUsHere For Driver
//
//  Created by bharat on 04/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "VehicleinfoViewController.h"
#import "Alertview.h"
#import "DejalActivityView.h"
#import "MVPopView.h"
#import "GetUsHere.pch"
#import "DriverLicenceinfoViewController.h"
#import "SWRevealViewController.h"

@interface VehicleinfoViewController ()
{
    NSString *carID;
    NSMutableArray *DataArray;
    NSString *strwheelchairfacility;
    
}
@property (nonatomic, strong)MVPopView *popView;
@end

@implementation VehicleinfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.txtCar.delegate=self;
    self.txtCarType.delegate=self;
    
     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back.jpg"]];
    
    [tabl setHidden:YES];
    tabl=[[UITableView alloc] init];
    tabl.frame = CGRectMake(10,_txtCar.frame.origin.y+_txtCar.frame.size.height,self.view.frame.size.width-20,200);
    tabl.delegate=self;
    tabl.dataSource=self;
    tabl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.title=@"Vehicle Information";
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Select Car Type" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtCar.attributedPlaceholder = str;
    _txtCar.textColor=[UIColor purpleColor];
    
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Select Car Sub Type" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtCarType.attributedPlaceholder = str1;
    _txtCarType.textColor=[UIColor purpleColor];
    
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"Click here to select the Wheel chair car Facility" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtwheelchair.attributedPlaceholder = str2;
    _txtwheelchair.textColor=[UIColor purpleColor];
    
    NSAttributedString *str3 = [[NSAttributedString alloc] initWithString:@"Make" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtmake.attributedPlaceholder = str3;
    _txtmake.textColor=[UIColor purpleColor];
    
    NSAttributedString *str4 = [[NSAttributedString alloc] initWithString:@"Model" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtmodel.attributedPlaceholder = str4;
    _txtmodel.textColor=[UIColor purpleColor];
    
    NSAttributedString *str5 = [[NSAttributedString alloc] initWithString:@"Year" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtYear.attributedPlaceholder = str5;
    _txtYear.textColor=[UIColor purpleColor];
    
    NSAttributedString *str6 = [[NSAttributedString alloc] initWithString:@"Color" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtcolor.attributedPlaceholder = str6;
    _txtcolor.textColor=[UIColor purpleColor];
    
    NSAttributedString *str7= [[NSAttributedString alloc] initWithString:@"Licence Plate Number" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtlicence.attributedPlaceholder = str7;
    _txtlicence.textColor=[UIColor purpleColor];
    
    _cartypeView.layer.masksToBounds = YES;
    _cartypeView.layer.cornerRadius = 19.0;
    _cartypeView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
    
    _carsubtypeView.layer.masksToBounds = YES;
    _carsubtypeView.layer.cornerRadius = 19.0;
    _carsubtypeView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
    
    
    _wheelchairView.layer.masksToBounds = YES;
    _wheelchairView.layer.cornerRadius = 19.0;
    _wheelchairView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
    
    
    _makeView.layer.masksToBounds = YES;
    _makeView.layer.cornerRadius = 19.0;
    _makeView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
    
    
    _modelView.layer.masksToBounds = YES;
    _modelView.layer.cornerRadius = 19.0;
    _modelView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
    
    
    _yearView.layer.masksToBounds = YES;
    _yearView.layer.cornerRadius = 19.0;
    _yearView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
    
    
    _colorView.layer.masksToBounds = YES;
    _colorView.layer.cornerRadius = 19.0;
    _colorView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
    
    _licenceView.layer.masksToBounds = YES;
    _licenceView.layer.cornerRadius = 19.0;
    _licenceView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
    
    _vehiclelab.textColor=[UIColor purpleColor];
    
    CGSize scrollableSize = CGSizeMake(320, 720);
    [_scrollViewlend setContentSize:scrollableSize];
    
    _nextbutt.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    arrcares=[[NSMutableArray alloc]init];
    arrcar=[[NSMutableArray alloc]init];
    arrcar=[[NSUserDefaults standardUserDefaults]objectForKey:@"cars"];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.tintColor=[UIColor whiteColor];
    numberToolbar.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    
    _txtYear.inputAccessoryView = numberToolbar;
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
       
     [self setupOutlets];
}
-(void)doneWithNumberPad
{
    [_txtYear resignFirstResponder];
}


- (void)setupOutlets
{

    self.txtmake.delegate = self;
    self.txtmake.tag = 1;
    
    self.txtmodel.delegate = self;
    self.txtmodel.tag = 2;
    
    self.txtYear.delegate = self;
    self.txtYear.tag = 3;
    
    self.txtcolor.delegate = self;
    self.txtcolor.tag = 4;
    
    self.txtlicence.delegate = self;
    self.txtlicence.tag = 5;
}

- (void)jumpToNextTextField:(UITextField *)textField withTag:(NSInteger)tag
{
    UIResponder *nextResponder = [self.view viewWithTag:tag];
    
    if ([nextResponder isKindOfClass:[UITextField class]])
    {
        [nextResponder becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];// this will do the trick
}

-(void)getcartypes
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getcarTypes]]];
    
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    
    [profile appendString:[NSString stringWithFormat:@"category_id=%@", carID]];
    
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


//-(void)PostdateToServerwithParameters:(NSMutableString *)parameters andApiExtension:(NSString *)ext
//{
//    
//    NSString *strurl=BaseUrl;
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:strurl,ext]]];
//    request.HTTPMethod = @"POST";
//    request.HTTPBody  = [parameters dataUsingEncoding:NSUTF8StringEncoding];
//    
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//                               if (error) {
//                                   // Handle error
//                                   //[self handleError:error];
//                                   [DejalBezelActivityView removeViewAnimated:YES];
//                               } else {
//                                   [self parseJSONResponse:data];
//                                   [DejalBezelActivityView removeViewAnimated:YES];
//                               }
//                           }];
//}

-(void)parseJSONResponse:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
  //  NSLog(@"*****Cars types ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    [tabl reloadData];
    // NSLog(@"%@",DataArray);
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        [Alertview showalertwithTitle:nil Message:[responseJSON valueForKey:@"message"] cancelButton:nil OkButton:@"Ok"];
        
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        DataArray=[NSMutableArray array];
        [DataArray addObjectsFromArray:[responseJSON valueForKey:@"data"]];
        [tabl reloadData];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];

    if (textField==_txtCar)
    {
        [_txtCarType resignFirstResponder];
        tabl.tag=1;
        _txtCar.inputView=tabl;
        _txtCarType.text=nil;
        [tabl reloadData];
    }
    else if (textField==_txtCarType)
    {
        if (_txtCar.text.length == 0)
        {
            [Alertview showalertwithTitle:@"Alert" Message:@"Please select car" cancelButton:nil OkButton:@"OK"];
            return;
        }
        else
        {
            tabl.tag=2;
            
         //   NSMutableString* profile = [NSMutableString string];
         //   [profile appendString:[NSString stringWithFormat:@"category_id=%@", carID]];
            //  CartypeTable=[[UITableView alloc] init];
            [DejalBezelActivityView activityViewForView:tabl withLabel:@"Please wait..."];
            
         //   [self PostdateToServerwithParameters:profile andApiExtension:@"car_types"];
            
            [self getcartypes];
            
            _txtCarType.inputView=tabl;
        }
    }
}



#pragma - mark -
#pragma - mark Tableview delegate methodes

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==1) {
        return arrcar.count;
        
    }else if (tableView.tag==2)
    {
        return DataArray.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}


-(void) tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if ([view isKindOfClass: [UITableViewHeaderFooterView class]])
    {
        UITableViewHeaderFooterView* castView = (UITableViewHeaderFooterView*) view;
        UIView* content = castView.contentView;
        UIColor* color = [UIColor colorWithWhite:0.85 alpha:1.]; // substitute your color here
        content.backgroundColor = color;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier1 = @"Cell1";
    static NSString *CellIdentifier2 = @"Cell2";
    
    
    UITableViewCell *cell;
    
    if (tableView.tag==1) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:CellIdentifier1];
        }
        
        cell.textLabel.text=[[arrcar objectAtIndex:indexPath.row] valueForKey:@"name"];
        
    }else if (tableView.tag==2)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:CellIdentifier2];
        }
        
        cell.textLabel.text=[[DataArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    }
    
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView.tag==1)
    {
        return @"Select a car";
    }else if(tableView.tag==2)
    {
        return @"Select a carType";
    }
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag==1) {
        [tabl deselectRowAtIndexPath:indexPath animated:YES];
        _txtCar.text=[[arrcar objectAtIndex:indexPath.row] valueForKey:@"name"];
        carID=[[arrcar objectAtIndex:indexPath.row] valueForKey:@"id"];
        [_txtCar resignFirstResponder];
        [tabl reloadData];
        _txtCarType.text=nil;
    }else if (tableView.tag==2)
    {
        [tabl deselectRowAtIndexPath:indexPath animated:YES];
        _txtCarType.text=[[DataArray objectAtIndex:indexPath.row] valueForKey:@"name"];
        strid=[[DataArray objectAtIndex:indexPath.row] valueForKey:@"id"];
        // [CartypeTable setHidden:YES];
        [_txtCarType resignFirstResponder];
        [tabl reloadData];
    }
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nextTag = textField.tag + 1;
    [self jumpToNextTextField:textField withTag:nextTag];
    return NO;
    
}


- (IBAction)NextClicked:(id)sender
{
    
    
    if (_txtCar.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please Select the type of the car" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (_txtCarType.text.length==0)
    {
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please Select the Subtype of the car" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (_txtwheelchair.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please Select the Wheel chair facility of the car" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else if (_txtYear.text.length==0)
    {
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please Enter the year of the car" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (_txtmake.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"please Enter car make" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (_txtmodel.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"please Enter car model" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (_txtcolor.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"please Enter car color" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (_txtlicence.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"please Enter licence plate number" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
else
{
    self.view.userInteractionEnabled=NO;
    
    NSString *str;
    NSString *str1;
    NSString *str2;
    NSString *str3;
    NSString *str4;
    NSString *str5;
    NSString *stryear;
  
    str=_txtCar.text;
    str1=_txtCarType.text;
    str2=_txtmake.text;
    str3=_txtmodel.text;
    str4=_txtcolor.text;
    str5=_txtlicence.text;
    stryear=_txtYear.text;
    
    [[NSUserDefaults standardUserDefaults]setObject:carID forKey:@"car"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:strid forKey:@"cartype"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:_txtCar.text forKey:@"carBrand"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:_txtCarType.text forKey:@"carModel"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:str2 forKey:@"make"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:str3 forKey:@"model"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:str4 forKey:@"color"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:str5 forKey:@"licence"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:strwheelchairfacility forKey:@"wheel"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:stryear forKey:@"year"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    DriverLicenceinfoViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"DriverLicenceinfoViewController"];
    [self.navigationController pushViewController:vc animated:YES];
    
    //[self performSegueWithIdentifier:@"info" sender:self];
    }
}



- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    if (textField==_txtCar)
    {
        const int movementDistance = -50; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        
        int movement = (up ? movementDistance : -movementDistance);
        
        [UIView beginAnimations: @"animateTextField" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }
    else if (textField==_txtCarType)
    {
        const int movementDistance = -50; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        
        int movement = (up ? movementDistance : -movementDistance);
        
        [UIView beginAnimations: @"animateTextField" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }
    else if (textField==_txtwheelchair)
    {
        const int movementDistance = -50; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        
        int movement = (up ? movementDistance : -movementDistance);
        
        [UIView beginAnimations: @"animateTextField" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }

    else if (textField==_txtmake)
    {
        const int movementDistance = -100; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        
        int movement = (up ? movementDistance : -movementDistance);
        
        [UIView beginAnimations: @"animateTextField" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }
    else if (textField==_txtmodel)
    {
        const int movementDistance = -150; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        
        int movement = (up ? movementDistance : -movementDistance);
        
        [UIView beginAnimations: @"animateTextField" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }
    else if (textField==_txtYear)
    {
        const int movementDistance = -200; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        
        int movement = (up ? movementDistance : -movementDistance);
        
        [UIView beginAnimations: @"animateTextField" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }
    else if (textField==_txtcolor)
    {
        const int movementDistance = -110; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        
        int movement = (up ? movementDistance : -movementDistance);
        
        [UIView beginAnimations: @"animateTextField" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }
    else if (textField==_txtlicence)
    {
        const int movementDistance = -130; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        
        int movement = (up ? movementDistance : -movementDistance);
        
        [UIView beginAnimations: @"animateTextField" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }
    
    else
    {
        
        const int movementDistance = -130; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        
        int movement = (up ? movementDistance : -movementDistance);
        
        [UIView beginAnimations: @"animateTextField" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    self.title = @"Vehicle Information";
    
    _popView = [[MVPopView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20, 80)];
    _popView.backgroundColor =  [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-(self.view.frame.size.width/2),7,self.view.frame.size.width,30)];
    [btn addTarget:self action:@selector(hideBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"With Wheel Chair Availability" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_popView addSubview:btn];
    
    UILabel *la1=[[UILabel alloc]initWithFrame:CGRectMake(0, 41, self.view.frame.size.width-20, 2)];
    [la1 setBackgroundColor:[UIColor whiteColor]];
    [_popView addSubview:la1];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-(self.view.frame.size.width/2),45,self.view.frame.size.width,30)];
    [btn1 addTarget:self action:@selector(hideBtnTapped1) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"With out Wheel Chair Availability" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_popView addSubview:btn1];
}

- (void)hideBtnTapped
{
  _txtwheelchair.text=@"With Wheel Chair Availability";
    strwheelchairfacility=@"1";
    [_popView dismiss];
}

- (void)hideBtnTapped1
{
    _txtwheelchair.text=@"With out Wheel Chair Availability";
    strwheelchairfacility=@"0";
    [_popView dismiss];
}



- (IBAction)wheelchairfacilityClicked:(id)sender
{
    [self.txtwheelchair resignFirstResponder];
    [self.view endEditing:YES];
    [_popView showInView:self.view];

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

