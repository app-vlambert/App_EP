//
//  ViewController.m
//  App_EP
//
//  Created by Lambert Vincent on 18/09/14.
//  Copyright (c) 2014 vincent-lambert. All rights reserved.
//

#import "ViewController.h"
#import "PopUp_PL_Proche.h"
#import "PopUp_PL_BD.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize popup;
@synthesize popup_view_strong;
@synthesize popup_bd_view_strong;
@synthesize popup_commune_view_strong;

- (void)viewDidLoad
{
    [super viewDidLoad];
    popup.hidden = YES;
    
	// Do any additional setup after loading the view, typically from a nib.
    UIImage *logo = [UIImage imageNamed:@"ampoule-de-dessin-animé-17648518.jpg"];
    UIImageView *logoView = [[UIImageView alloc] initWithImage:logo];
    UIBarButtonItem *logoItem = [[UIBarButtonItem alloc]initWithCustomView:logoView];
    [self.navigationItem setLeftBarButtonItem:logoItem animated:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)PL_proche:(id)sender
{
    PopUp_PL_Proche *popup_view = [[PopUp_PL_Proche alloc]init];
    
     popup_view = [self.storyboard instantiateViewControllerWithIdentifier:@"PopUp_PL"];
    popup_view.parent = self;
    popup_view_strong = popup_view;
   // popup_view.modalPresentationStyle = UIModalPresentationFormSheet;
   // popup_view.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [popup addSubview:popup_view_strong.view];
    popup.hidden = NO;
    
    //[self presentViewController:popup animated:YES completion:NULL];
  //  popup.view.superview.frame = CGRectMake(0.0, 0.0, 200.0, 200.0);
   // popup.view.superview.center = self.view.center;
    
}
-(IBAction)PL_BD:(id)sender
{
    PopUp_PL_BD *popup_view = [[PopUp_PL_BD alloc]init];
    popup_view = [self.storyboard instantiateViewControllerWithIdentifier:@"PopUp_BD"];
    
    popup_view.parent = self;
    popup_bd_view_strong = popup_view;
    [popup addSubview:popup_bd_view_strong.view];
    popup.hidden = NO;
}

-(IBAction)Commune_load:(id)sender
{
    PopUp_Commune *popup_view = [[PopUp_Commune alloc]init];
    popup_view = [self.storyboard instantiateViewControllerWithIdentifier:@"PopUp_Commune"];
    
    popup_view.parent = self;
    popup_commune_view_strong = popup_view;
    [popup addSubview:popup_commune_view_strong.view];
    popup.hidden = NO;
}
-(IBAction)Hide_popup:(id)sender
{
    popup.hidden = YES;
}

@end
