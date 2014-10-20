//
//  PopUp_Commune.h
//  App_EP
//
//  Created by Lambert Vincent on 13.10.14.
//  Copyright (c) 2014 vincent-lambert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLmanager.h"
#import <CoreLocation/CoreLocation.h>
#import "ViewController.h"
#import "Point_lumineux.h"
@interface PopUp_Commune : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic, strong) IBOutlet UIPickerView *Secteur;
@property(nonatomic, strong) IBOutlet UIPickerView *Commune;
//@property(nonatomic, strong) IBOutlet UIButton *Cancel;
//@property (nonatomic, strong) IBOutlet UIButton *OK;
@property (nonatomic,strong) NSArray *itemsArray_com;
@property (nonatomic,strong) NSArray *itemsArray_sect;
@property (nonatomic, strong) IBOutlet ViewController *parent;
@property (nonatomic,strong) IBOutlet NSString* selected_sect;
@property (nonatomic,strong) IBOutlet NSString* selected_com;
-(IBAction)Unload:(id)sender;
-(IBAction)Load_PL:(id)sender;
@end
