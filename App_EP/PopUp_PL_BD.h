//
//  PopUp_PL_BD.h
//  App_EP
//
//  Created by Lambert Vincent on 10.10.14.
//  Copyright (c) 2014 vincent-lambert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "Point_lumineux.h"
#import "SQLmanager.h"
@class ViewController;
@interface PopUp_PL_BD : UIViewController<UITextFieldDelegate>

@property(nonatomic, strong) IBOutlet UITextField *PL_BD;
@property(nonatomic, strong) IBOutlet UIButton *Cancel;
@property (nonatomic, strong) IBOutlet UIButton *OK;
@property (nonatomic,strong) NSArray *Result;
@property (nonatomic, strong) IBOutlet ViewController *parent;
@property (nonatomic,strong) IBOutlet NSString* selected;

-(IBAction)Unload:(id)sender;
-(IBAction)Load_PL:(id)sender;

@end
