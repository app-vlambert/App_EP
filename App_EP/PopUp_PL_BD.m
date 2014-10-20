//
//  PopUp_PL_BD.m
//  App_EP
//
//  Created by Lambert Vincent on 10.10.14.
//  Copyright (c) 2014 vincent-lambert. All rights reserved.
//

#import "PopUp_PL_BD.h"
#import "Info_windows.h"

@interface PopUp_PL_BD ()

@end

@implementation PopUp_PL_BD

@synthesize PL_BD;
@synthesize Cancel;
@synthesize OK;
@synthesize Result;
@synthesize parent;
@synthesize selected;



- (void)viewDidLoad {
    [super viewDidLoad];
    [PL_BD setKeyboardType:UIKeyboardTypeDecimalPad];
    PL_BD.returnKeyType = UIReturnKeyDone;
    PL_BD.delegate = self;
    // Do any additional setup after loading the view.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [PL_BD resignFirstResponder];
}

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
    if(![PL_BD.text  isEqual:@""])
    {
        selected = PL_BD.text;
        SQLmanager *db = [[SQLmanager alloc]initDatabase];
        Result = [db query:[NSString stringWithFormat:@"Select PLU_NUMERO_LAM FROM PL WHERE PLU_NUMERO_LAM = %@",selected]];
        if(Result.count > 0)
        {
           
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
            Info_windows *Info_windows_view = (Info_windows*)[storyboard instantiateViewControllerWithIdentifier:@"Info_windows"];
            Info_windows_view.PL = selected;
            Info_windows_view.appelant = 1;
            [[parent navigationController] pushViewController:Info_windows_view animated:NO];
            [self.view removeFromSuperview];
            parent.popup.hidden = YES;
            
        }
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
