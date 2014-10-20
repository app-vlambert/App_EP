//
//  PopUp_PL_Proche.m
//  App_EP
//
//  Created by Lambert Vincent on 09.10.14.
//  Copyright (c) 2014 vincent-lambert. All rights reserved.
//

#import "PopUp_PL_Proche.h"
#import "ViewController.h"
#import "ApproxSwissProj.h"
#import "Info_windows.h"

@interface PopUp_PL_Proche ()

@end

@implementation PopUp_PL_Proche
@synthesize PL_proche;
@synthesize Cancel;
@synthesize OK;
@synthesize itemsArray;
@synthesize parent;
@synthesize selected;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CLLocationManager *My_loc  = [[CLLocationManager alloc]init];
    //PL_proche = [[UIPickerView alloc]init];
    My_loc.delegate = self;
    My_loc.distanceFilter = kCLDistanceFilterNone;
    My_loc.desiredAccuracy = kCLLocationAccuracyBest;
    
    [My_loc startUpdatingLocation];
    SQLmanager *db = [[SQLmanager alloc]initDatabase];
    CLLocation *location = [My_loc location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    NSArray *coord = [ApproxSwissProj WGS84toLV03:coordinate.latitude :coordinate.longitude :0.0];
    
    NSString *X = [coord objectAtIndex:0];
    NSString *Y = [coord objectAtIndex:1];
    
    itemsArray = [db query:[NSString stringWithFormat:@"Select distinct PLU_NUMERO_LAM || ' ' ||PLU_NAME_NUMBER_LAM FROM PL WHERE ((X - %@)*(X-%@))*((Y - %@)*(Y-%@)) < 10000",X,X,Y,Y ]];
    //if(Result.count > 0)
    PL_proche.delegate = self;
    PL_proche.dataSource = self;
    
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
-(IBAction)Unload:(id)sender
{
    //ViewController *main = [self parentViewController];
    //ViewController *master =(ViewController*) [self.parentViewController parentViewController];
   // UIViewController *master = [UIViewController ]]
    
    [self.view removeFromSuperview];    //master.popup.hidden = YES;
    parent.popup.hidden = YES;
    
}

-(IBAction)Load_PL:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    Info_windows *Info_windows_view = (Info_windows*)[storyboard instantiateViewControllerWithIdentifier:@"Info_windows"];
    Info_windows_view.PL = [selected substringToIndex:[selected rangeOfString:@" "].location];
    Info_windows_view.appelant = 1;
    [[parent navigationController] pushViewController:Info_windows_view animated:NO];
    [self.view removeFromSuperview];
    parent.popup.hidden = YES;
    }



#pragma mark -UIPickerView DataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [itemsArray count];
}

#pragma mark - UIPickerView Delegate
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.0;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(row == 0)
    {
    selected = [NSString stringWithFormat:@"%@",[[itemsArray objectAtIndex:row]objectAtIndex:0]];
    }
    if([itemsArray count] > 0)
    {
    return [NSString stringWithFormat:@"%@",[[itemsArray objectAtIndex:row]objectAtIndex:0]];
    }
        return @"";
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if([itemsArray count]>0)
       {
          // NSLog(selected);
    selected = [NSString stringWithFormat:@"%@",[[itemsArray objectAtIndex:row]objectAtIndex:0]];
       }
}

@end
