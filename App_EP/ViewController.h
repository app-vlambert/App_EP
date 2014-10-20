//
//  ViewController.h
//  App_EP
//
//  Created by Lambert Vincent on 18/09/14.
//  Copyright (c) 2014 vincent-lambert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopUp_PL_Proche.h"
#import "PopUp_PL_BD.h"
#import "PopUp_Commune.h"
@class PopUp_PL_Proche;
@class PopUp_PL_BD;
@class PopUp_Commune;
@interface ViewController : UIViewController
-(IBAction)PL_proche:(id)sender;
-(IBAction)PL_BD:(id)sender;
-(IBAction)Commune_load:(id)sender;
@property(nonatomic,strong)IBOutlet UIView* popup;
@property(strong,nonatomic)PopUp_PL_Proche *popup_view_strong;
@property(strong,nonatomic)PopUp_PL_BD *popup_bd_view_strong;
@property(strong, nonatomic)PopUp_Commune *popup_commune_view_strong;



-(IBAction)Hide_popup:(id)sender;

@end
