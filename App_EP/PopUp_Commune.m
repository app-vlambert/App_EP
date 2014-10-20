//
//  PopUp_Commune.m
//  App_EP
//
//  Created by Lambert Vincent on 13.10.14.
//  Copyright (c) 2014 vincent-lambert. All rights reserved.
//

#import "PopUp_Commune.h"
#import "Map.h"

@interface PopUp_Commune ()

@end

@implementation PopUp_Commune
@synthesize Secteur;
@synthesize Commune;
//@synthesize Cancel;
//@synthesize OK;
@synthesize itemsArray_com;
@synthesize itemsArray_sect;
@synthesize selected_com;
@synthesize selected_sect;
@synthesize parent;

- (void)viewDidLoad {
    [super viewDidLoad];
    Secteur.tag = 1;
    Commune.tag = 2;
    
    SQLmanager *db = [[SQLmanager alloc]initDatabase];
    itemsArray_sect = [db query:@"select distinct  pl.SECTEUR from PL pl" ];
    Secteur.delegate = self;
    Secteur.dataSource = self;
    itemsArray_com = [db query:@"select distinct pl.COMMUNE from PL pl where pl.SECTEUR = 'COURGEVAUX' order by pl.COMMUNE"];
    
    Commune.delegate = self;
    Commune.dataSource = self;
   
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)Load_PL:(id)sender
{
    if(![selected_com isEqual:@""])
    {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    Map *Map_view = (Map*)[storyboard instantiateViewControllerWithIdentifier:@"Map"];
    Map_view.Commune = selected_com;
    
        [self.view removeFromSuperview];    //master.popup.hidden = YES;
        parent.popup.hidden = YES;
    [[parent navigationController] pushViewController:Map_view animated:NO];
    }
    }
-(IBAction)Unload:(id)sender
{
    //ViewController *main = [self parentViewController];
    //ViewController *master =(ViewController*) [self.parentViewController parentViewController];
    // UIViewController *master = [UIViewController ]]
    
    [self.view removeFromSuperview];    //master.popup.hidden = YES;
    parent.popup.hidden = YES;
    
}


#pragma mark -UIPickerView DataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView.tag == 1)
    {
    return [itemsArray_sect count];
    }
    else
    {
        return [itemsArray_com count];
    }
}

#pragma mark - UIPickerView Delegate
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 15.0;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if(pickerView.tag ==1)
    {
        if([itemsArray_sect count] > 0)
        {
            if(row == 0)
            {
                selected_sect = [NSString stringWithFormat:@"%@", [[itemsArray_sect objectAtIndex:row]objectAtIndex:0]];
            }
            if([itemsArray_sect count] > 0)
            {
                return [NSString stringWithFormat:@"%@",[[itemsArray_sect objectAtIndex:row]objectAtIndex:0]];
            }
        }
    }
    if(pickerView.tag ==2)
    {
        if([itemsArray_com count] > 0)
        {
            if(row == 0)
            {
                selected_com = [NSString stringWithFormat:@"%@",[[itemsArray_com objectAtIndex:row]objectAtIndex:0]];
            }
            if([itemsArray_com count] > 0)
            {
                return [NSString stringWithFormat:@"%@",[[itemsArray_com objectAtIndex:row]objectAtIndex:0]];
            }
        }
    }
  return @"";
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView.tag ==1)
    {
        selected_sect = [NSString stringWithFormat:@"%@", [[itemsArray_sect objectAtIndex:row]objectAtIndex:0]];
        SQLmanager *db = [[SQLmanager alloc]initDatabase];
        itemsArray_com = [db query:[NSString stringWithFormat:@"select distinct pl.COMMUNE from PL pl where pl.SECTEUR = '%@'order by pl.COMMUNE",selected_sect]];
        [Commune reloadAllComponents];
    }
    if(pickerView.tag ==2)
    {
        selected_com = [NSString stringWithFormat:@"%@",[[itemsArray_com objectAtIndex:row]objectAtIndex:0]];
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
