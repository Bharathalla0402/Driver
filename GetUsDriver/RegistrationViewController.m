//
//  RegistrationViewController.m
//  GetUsHere For Driver
//
//  Created by bharat on 04/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "RegistrationViewController.h"
#import "RiderData.h"
#import "Alertview.h"
#import "DejalActivityView.h"
#import "MVPopView.h"
#import "GetUsHere.pch"
#import "VehicleinfoViewController.h"
#import "SWRevealViewController.h"
#import "Reachability.h"
#import "CarDriverTableViewCell.h"
#import "DropDownListView.h"

@interface RegistrationViewController ()<kDropDownListViewDelegate>
{
    RiderData *Rdata;
    NSString *strgender;
     DropDownListView * Dropobj;
    
    NSMutableArray *arrlanguagelist,*arrlanguageids;
    
    IBOutlet UIButton *bookbtn;
    
    IBOutlet UITableView *tabl;
   
//    CarDriverTableViewCell *cell;
//    CarDriverTableViewCell *Celll;
    
    UIView *popview;
    UIView *footerview;
    
    NSInteger *selectedBtn;
    
    NSString *strlanguageid;
}
@property (nonatomic, strong)MVPopView *popView;
@end

@implementation RegistrationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
//                                   
//                                   initWithTarget:self
//                                   
//                                   action:@selector(dismissKeyboard)];
//    
//    [self.view addGestureRecognizer:tap];
//    
//    for (UIGestureRecognizer *recognizer in self.view.gestureRecognizers) {
//        [self.view removeGestureRecognizer:recognizer];
//    }
    
    self.title=@"Registration";
    arrlanguagelist=[[NSMutableArray alloc]init];
    arrlanguageids=[[NSMutableArray alloc]init];
    selectedBtn=(int*)-1;
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Full Name" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtName.attributedPlaceholder = str;
    self.txtName.textColor=[UIColor purpleColor];
    
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Set Password" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtPassword.attributedPlaceholder = str1;
     self.txtPassword.textColor=[UIColor purpleColor];
    
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"Address" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtaddress.attributedPlaceholder = str2;
     self.txtaddress.textColor=[UIColor purpleColor];
    
    NSAttributedString *str3 = [[NSAttributedString alloc] initWithString:@"Please Click here to select the Gender" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtgender.attributedPlaceholder = str3;
     self.txtgender.textColor=[UIColor purpleColor];
    
    NSAttributedString *str4 = [[NSAttributedString alloc] initWithString:@"CCode" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtCountryCode.attributedPlaceholder = str4;
     self.txtCountryCode.textColor=[UIColor purpleColor];
    
    NSAttributedString *str5 = [[NSAttributedString alloc] initWithString:@"Phone no" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtPhone.attributedPlaceholder = str5;
     self.txtPhone.textColor=[UIColor purpleColor];
    
    NSAttributedString *str6 = [[NSAttributedString alloc] initWithString:@"Email Id" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtEmail.attributedPlaceholder = str6;
     self.txtEmail.textColor=[UIColor purpleColor];
    
    NSAttributedString *str7= [[NSAttributedString alloc] initWithString:@"Select Language" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtSelectLanguage.attributedPlaceholder = str7;
     self.txtSelectLanguage.textColor=[UIColor purpleColor];
    
    _agreelab.textColor=[UIColor purpleColor];
    _pluslab.textColor=[UIColor purpleColor];
    _registerheaderlab.textColor=[UIColor purpleColor];
    
    
    _nameView.layer.masksToBounds = YES;
    _nameView.layer.cornerRadius = 19.0;
    _nameView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
    
    _passwordView.layer.masksToBounds = YES;
    _passwordView.layer.cornerRadius = 19.0;
    _passwordView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
    
    
    _addressView.layer.masksToBounds = YES;
    _addressView.layer.cornerRadius = 19.0;
    _addressView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
    
    
    _genderView.layer.masksToBounds = YES;
    _genderView.layer.cornerRadius = 19.0;
    _genderView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
    
    
    _ccView.layer.masksToBounds = YES;
    _ccView.layer.cornerRadius = 19.0;
    _ccView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
    
    
    _numberView.layer.masksToBounds = YES;
    _numberView.layer.cornerRadius = 19.0;
    _numberView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
    
    
    _emailView.layer.masksToBounds = YES;
    _emailView.layer.cornerRadius = 19.0;
    _emailView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
    
    _emergencyView.layer.masksToBounds = YES;
    _emergencyView.layer.cornerRadius = 19.0;
    _emergencyView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
    
    _nextbutt.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    CGSize scrollableSize = CGSizeMake(320, 720);
    [_scrollViewlend setContentSize:scrollableSize];
    
    arrcars=[[NSMutableArray alloc]init];

    self.txtName.delegate =self;
    self.txtPassword.delegate = self;
    self.txtaddress.delegate=self;
    self.txtEmail.delegate = self;
    self.txtPhone.delegate = self;
    self.txtCountryCode.delegate=self;
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.tintColor=[UIColor whiteColor];
    numberToolbar.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    
    _txtPhone.inputAccessoryView = numberToolbar;
    _txtCountryCode.inputAccessoryView=numberToolbar;

    
    
//    SWRevealViewController *reveal = self.revealViewController;
//    reveal.panGestureRecognizer.enabled = NO;
    
    mdata = [[NSMutableData alloc]init];
    checked = NO;
    Rdata = [RiderData sharedManager];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back.jpg"]];
    
    [self setupOutlets];
}

//- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position
//{
//    if (position == FrontViewPositionLeftSide) {               // Menu will get revealed
//        self.tapGestureRecognizer.enabled = YES;                 // Enable the tap gesture Recognizer
//        self.interactivePopGestureRecognizer.enabled = NO;        // Prevents the iOS7's pan gesture
//        self.topViewController.view.userInteractionEnabled = NO;       // Disable the topViewController's interaction
//    }
//    else if (position == FrontViewPositionLeft){      // Menu will close
//        self.tapGestureRecognizer.enabled = NO;
//        self.interactivePopGestureRecognizer.enabled = YES;
//        self.topViewController.view.userInteractionEnabled = YES;
//    }
//}

-(void)doneWithNumberPad
{
    [_txtPhone resignFirstResponder];
    [_txtCountryCode resignFirstResponder];
}

- (void)setupOutlets
{
    self.txtName.delegate = self;
    self.txtName.tag = 1;
    
    self.txtPassword.delegate = self;
    self.txtPassword.tag = 2;
    
    self.txtaddress.delegate = self;
    self.txtaddress.tag = 3;
    
    self.txtCountryCode.delegate = self;
    self.txtCountryCode.tag = 4;
    
    self.txtPhone.delegate = self;
    self.txtPhone.tag = 5;
    
    self.txtEmail.delegate = self;
    self.txtEmail.tag = 6;
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

- (void)dismissKeyboard
{
    [self.txtName resignFirstResponder];
    [self.txtPassword resignFirstResponder];
    [self.txtEmail resignFirstResponder];
    [self.txtPhone resignFirstResponder];
    [self.txtaddress resignFirstResponder];
    [self.txtCountryCode resignFirstResponder];
    //[self.view removeGestureRecognizer:];
}

- (IBAction)LanguagebuttClicked:(id)sender
{
    [self.view endEditing:YES];
    
    [Dropobj fadeOut];
    
    
    if ([UIScreen mainScreen].bounds.size.width < 350 )
    {
        [self showPopUpWithTitle:@"Select Language" withOption:arrlanguagelist xy:CGPointMake(self.view.frame.size.width/2-150, 70) size:CGSizeMake(300, 400) isMultiple:YES];
    }
    else
    {
        [self showPopUpWithTitle:@"Select Language" withOption:arrlanguagelist xy:CGPointMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-200) size:CGSizeMake(300, 400) isMultiple:YES];
    }
}



-(void)parseJSONResponselag:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
    NSLog(@"*****language details ******* %@", responseJSON);
    
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
        arrlanguagelist=[[responseJSON valueForKey:@"data"] valueForKey:@"language"];
        arrlanguageids=[[responseJSON valueForKey:@"data"] valueForKey:@"id"];
        
        
//        popview = [[UIView alloc]init];
//        popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//        popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
//        [self.view addSubview:popview];
//        
//        footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, 65, 300, self.view.frame.size.height-80)];
//        footerview.backgroundColor = [UIColor whiteColor];
//        [popview addSubview:footerview];
//        
//        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, footerview.frame.size.width-50, 40)];
//        lab.text=@"Select Language";
//        lab.textColor=[UIColor blackColor];
//        lab.backgroundColor=[UIColor clearColor];
//        lab.textAlignment=NSTextAlignmentLeft+10;
//        lab.font=[UIFont systemFontOfSize:16];
//        [footerview addSubview:lab];
//        
//        UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width-60, 0, 50, 40)];
//        [butt1 setTitle:@"Cancel" forState:UIControlStateNormal];
//        butt1.titleLabel.font = [UIFont systemFontOfSize:15];
//        butt1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//        [butt1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [butt1 addTarget:self action:@selector(Cancelclicked:) forControlEvents:UIControlEventTouchUpInside];
//        [footerview addSubview:butt1];
//        
//        
//        UILabel *labeunder=[[UILabel alloc]initWithFrame:CGRectMake(1, lab.frame.origin.y+lab.frame.size.height+1, footerview.frame.size.width-2, 1)];
//        labeunder.backgroundColor=[UIColor darkGrayColor];
//        [footerview addSubview:labeunder];
//        
//        
//        tabl=[[UITableView alloc] init];
//        tabl.frame = CGRectMake(0,labeunder.frame.origin.y+labeunder.frame.size.height+3, footerview.frame.size.width, footerview.frame.size.height-80);
//        tabl.delegate=self;
//        tabl.dataSource=self;
//        tabl.tag=1;
//        tabl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        [tabl setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//        [footerview addSubview:tabl];
//        
//        UIButton *butt2=[[UIButton alloc]initWithFrame:CGRectMake(0, tabl.frame.size.height+tabl.frame.origin.y, footerview.frame.size.width, 40)];
//        [butt2 setTitle:@"Done" forState:UIControlStateNormal];
//        butt2.titleLabel.font = [UIFont systemFontOfSize:15];
//        butt2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//        [butt2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        butt2.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
//        [butt2 addTarget:self action:@selector(Doneclicked:) forControlEvents:UIControlEventTouchUpInside];
//        [footerview addSubview:butt2];

    }
}



#pragma mark - DropDown Menu Delegates


-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple
{
    popview = [[ UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"Registration" forKey:@"strlanguage"];
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
        
        NSMutableArray *arrids=[[NSMutableArray alloc]init];
        
        for (int i=0; i<ArryData.count; i++)
        {
            NSMutableArray *arr=[[NSMutableArray alloc]init];
            
            
            NSString *str1=[ArryData objectAtIndex:i];
            int j=(int)[str1 integerValue];
            
            [arr addObject:[arrlanguageids objectAtIndex:j]];
            
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
      
        
        _txtSelectLanguage.text=[ArryData componentsJoinedByString:@", "];
        
        
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




-(IBAction)Cancelclicked:(id)sender
{
    [footerview removeFromSuperview];
    popview.hidden = YES;
}

-(IBAction)Doneclicked:(id)sender
{
    [footerview removeFromSuperview];
    popview.hidden = YES;
}


#pragma mark - Table View Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return arrlanguagelist.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    static NSString *CellClassName = @"CarDriverTableViewCell";
//    
//    cell = (CarDriverTableViewCell *)[tableView dequeueReusableCellWithIdentifier: CellClassName];
//    
//    if (cell == nil)
//    {
//        cell = [[CarDriverTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellClassName];
//        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CarDriverTableViewCell"
//                                                     owner:self options:nil];
//        cell = [nib objectAtIndex:0];
//       // cell.backgroundColor=[UIColor blackColor];
//        
//    }
//    
//    UILabel *lblname=(UILabel *)[cell viewWithTag:2];
//    lblname.text=[[arrlanguagelist valueForKey:@"language"] objectAtIndex:indexPath.row];
//    bookbtn=(UIButton *)[cell viewWithTag:1];
//    bookbtn.tag=indexPath.row;
//    [bookbtn setImage:[UIImage imageNamed:@"remember check.png"] forState:UIControlStateNormal];
//    [bookbtn setImage:[UIImage imageNamed:@"remember check2.png"] forState:UIControlStateSelected];
//    [bookbtn addTarget:self action:@selector(btnclicked:) forControlEvents:UIControlEventTouchUpInside];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.tag = indexPath.row;
//    
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
    }
    
    if ([arrlanguagelist containsObject:[arrlanguagelist objectAtIndex:indexPath.row]]) {
        cell.imageView.image = [UIImage imageNamed:@"remember check.png"];
    }
    else {
        cell.imageView.image = [UIImage imageNamed:@"remember check2.png"];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleChecking:)];
    [cell.imageView addGestureRecognizer:tap];
    cell.imageView.userInteractionEnabled = YES; //added based on @John 's comment
    //[tap release];
    
    cell.textLabel.text = [[arrlanguagelist valueForKey:@"language"] objectAtIndex:indexPath.row];
    return cell;
}

- (void) handleChecking:(UITapGestureRecognizer *)tapRecognizer
{
    CGPoint tapLocation = [tapRecognizer locationInView:tabl];
    NSIndexPath *tappedIndexPath = [tabl indexPathForRowAtPoint:tapLocation];
    
    if ([arrlanguagelist containsObject:[arrlanguagelist objectAtIndex:tappedIndexPath.row]]) {
        [arrlanguagelist removeObject:[[arrlanguagelist valueForKey:@"language"]objectAtIndex:tappedIndexPath.row]];
    }
    else {
        [arrlanguagelist addObject:[arrlanguagelist objectAtIndex:tappedIndexPath.row]];
    }
    [tabl reloadRowsAtIndexPaths:[NSArray arrayWithObject:tappedIndexPath] withRowAnimation: UITableViewRowAnimationFade];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tabl deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)btnclicked:(UIButton *)sender
{
//    CGPoint buttonPosition = [sender convertPoint:CGPointZero
//                                           toView:tabl];
//    NSIndexPath *tappedIP = [tabl indexPathForRowAtPoint:buttonPosition];
//    
//    Celll = [tabl cellForRowAtIndexPath: tappedIP];
//    
//    [Celll.bookbtn setBackgroundImage:[UIImage imageNamed:@"remember check2.png"] forState:UIControlStateNormal];
    
}






- (IBAction)RegisterClicked:(id)sender
{
    [self.view endEditing:YES];
    if(_txtName.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please enter username" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else if(_txtPassword.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please enter Password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(_txtgender.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please select the Gender" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }

    
    else if(_txtaddress.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please enter address" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
    else if(_txtPhone.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please enter  Mobile Number" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(_txtEmail.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please Enter Email ID" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (_txtSelectLanguage.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please Select language" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else if (_txtCountryCode.text.length==0)
    {
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please enter country code" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }

    else if (![self NSStringIsValidEmail:_txtEmail.text])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please Enter Valid Email Id" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (checked !=YES)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please Agree user terms and conditions" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        
        [self checkNetworkStatus];
        
        if (_isInternetConnectionAvailable == NO)  {
            
            [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
             
                    withTitle:@"PAKLY"];
            
        }else
        {
            self.view.userInteractionEnabled=NO;
            
            NSString *str;
            NSString *str1;
            NSString *str2;
            NSString *str3;
            NSString *stradd;
         //   NSString *stremer;
            
            str=_txtName.text;
            str1=_txtPhone.text;
            str2=_txtEmail.text;
            str3=_txtPassword.text;
            stradd=_txtaddress.text;
         //   stremer=_txtemergency.text;
            
            
            strCountryCodeMobile = [NSString stringWithFormat:@"+%@",_txtCountryCode.text];
            
            [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"name"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [[NSUserDefaults standardUserDefaults]setObject:str1 forKey:@"phone"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [[NSUserDefaults standardUserDefaults]setObject:strCountryCodeMobile forKey:@"phone1"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [[NSUserDefaults standardUserDefaults]setObject:str2 forKey:@"email"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [[NSUserDefaults standardUserDefaults]setObject:str3 forKey:@"password"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [[NSUserDefaults standardUserDefaults]setObject:strgender forKey:@"gender"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [[NSUserDefaults standardUserDefaults]setObject:stradd forKey:@"address"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [[NSUserDefaults standardUserDefaults]setObject:strlanguageid forKey:@"emercontact"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            [self next];
        }
    }
}

-(void)next
{
    
     NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,cartypes]]];
    
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
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
    
    
    
   NSLog(@"*****login details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
  
    
    
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
        arrcars=[responseJSON valueForKey:@"data"];
        [[NSUserDefaults standardUserDefaults]setObject:arrcars forKey:@"cars"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        VehicleinfoViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"VehicleinfoViewController"];
        [self.navigationController pushViewController:vc animated:YES];
        
     //  [self performSegueWithIdentifier:@"conform" sender:nil];
        
    }
}



-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}


- (IBAction)CheckBoxClicked:(id)sender
{
    if (checked ==NO)
    {
        [checkboxbutton1 setImage:[UIImage imageNamed:@"remember check2.png"] forState:UIControlStateNormal];
        checked =YES;
    }
    else
    {
        [checkboxbutton1 setImage:[UIImage imageNamed:@"remember Check.png"] forState:UIControlStateNormal];
        checked =NO;
    }
}


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
    if (textField==_txtName)
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
   else if (textField==_txtPassword)
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
   else if (textField==_txtaddress)
   {
       const int movementDistance = -190; // tweak as needed
       const float movementDuration = 0.3f; // tweak as needed
       
       int movement = (up ? movementDistance : -movementDistance);
       
       [UIView beginAnimations: @"animateTextField" context: nil];
       [UIView setAnimationBeginsFromCurrentState: YES];
       [UIView setAnimationDuration: movementDuration];
       self.view.frame = CGRectOffset(self.view.frame, 0, movement);
       [UIView commitAnimations];
   }
   else if (textField==_txtCountryCode || textField==_txtPhone)
   {
       const int movementDistance = -210; // tweak as needed
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
    
    const int movementDistance = -110; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nextTag = textField.tag + 1;
    [self jumpToNextTextField:textField withTag:nextTag];
    return NO;
}

-(void)viewDidDisappear:(BOOL)animated{
    
    self.title = @"";
//    SWRevealViewController *reveal = self.revealViewController;
//    reveal.panGestureRecognizer.enabled = YES;
    
    self.view.userInteractionEnabled=YES;
    self.revealViewController.panGestureRecognizer.enabled=YES;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"Registration";
    
//    SWRevealViewController *reveal = self.revreveal.panGestureealViewController;
self.revealViewController.panGestureRecognizer.enabled=NO;
    [self.revealViewController.view removeGestureRecognizer:self.revealViewController.panGestureRecognizer];

    
    _popView = [[MVPopView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20, 80)];
    _popView.backgroundColor =  [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-(self.view.frame.size.width/2),7,self.view.frame.size.width,30)];
    [btn addTarget:self action:@selector(hideBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"Male" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_popView addSubview:btn];
    
    UILabel *la1=[[UILabel alloc]initWithFrame:CGRectMake(0, 41, self.view.frame.size.width-20, 2)];
    [la1 setBackgroundColor:[UIColor whiteColor]];
    [_popView addSubview:la1];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-(self.view.frame.size.width/2),45,self.view.frame.size.width,30)];
    [btn1 addTarget:self action:@selector(hideBtnTapped1) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"Female" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_popView addSubview:btn1];
    
    
    
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getLang]]];
    
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONResponselag:data];
                               }
                           }];
    

    
}

- (void)hideBtnTapped
{
    _txtgender.text=@"Male";
    strgender=@"m";
    [_popView dismiss];
}

- (void)hideBtnTapped1
{
    _txtgender.text=@"Female";
    strgender=@"f";
    [_popView dismiss];
}


- (IBAction)GenderButtClicked:(id)sender
{
    [self.txtgender resignFirstResponder];
    [self.view endEditing:YES];
    [_popView showInView:self.view];
}


#pragma mark -- checkNetworkStatus
-(void)checkNetworkStatus{
    Reachability* internetAvailable = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [internetAvailable currentReachabilityStatus];
    switch (internetStatus)
    {
        case NotReachable:{
            NSLog(@"The internet is down.");
            _isInternetConnectionAvailable = NO;
            break;
        }
        case ReachableViaWiFi:{
            _isInternetConnectionAvailable = YES;
            NSLog(@"The internet is working via WIFI.");
            break;
        }
        case ReachableViaWWAN:{
            _isInternetConnectionAvailable = YES;
            NSLog(@"The internet is working via WWAN.");
            break;
        }
    }
}
#pragma mark -- UIAlertView Method
-(void)showMessage:(NSString*)message withTitle:(NSString *)title{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
    });
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
