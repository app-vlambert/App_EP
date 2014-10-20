//
//  PopUp_PL_Proche.h
//  App_EP
//
//  Created by Lambert Vincent on 09.10.14.
//  Copyright (c) 2014 vincent-lambert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLmanager.h"
#import <CoreLocation/CoreLocation.h>
#import "ViewController.h"
#import "Point_lumineux.h"

@class ViewController;
@interface PopUp_PL_Proche : UIViewController<CLLocationManagerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic, strong) IBOutlet UIPickerView *PL_proche;
@property(nonatomic, strong) IBOutlet UIButton *Cancel;
@property (nonatomic, strong) IBOutlet UIButton *OK;
@property (nonatomic,strong) NSArray *itemsArray;
@property (nonatomic, strong) IBOutlet ViewController *parent;
@property (nonatomic,strong) IBOutlet NSString* selected;
-(IBAction)Unload:(id)sender;
-(IBAction)Load_PL:(id)sender;
@end
