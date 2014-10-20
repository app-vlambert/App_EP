//
//  Lampe_view.h
//  App_EP
//
//  Created by Lambert Vincent on 09.10.14.
//  Copyright (c) 2014 vincent-lambert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Lampe_view : UIViewController
@property(nonatomic, strong) IBOutlet UITextField* txtGenre;
@property(nonatomic, strong) IBOutlet UITextField* txtLampe;
@property(nonatomic, strong) IBOutlet UITextField* txtRef_Spontis;
@property(nonatomic, strong) IBOutlet UITextField* txtN_Spontis;
@property(nonatomic, strong) IBOutlet UITextField* txtCulot;
@property(nonatomic, strong) IBOutlet UITextField* txtSelf;
@property(nonatomic, strong) IBOutlet UITextField* txtCommande;
@property(nonatomic, strong) IBOutlet UITextField* txtHaute;
@property(nonatomic, strong) IBOutlet UITextField* txtBasse;
@property(nonatomic, strong) IBOutlet UITextField* txtFull_power;
@property(nonatomic, strong) IBOutlet UITextField* txtCal_power;
@property(nonatomic, strong) IBOutlet UITextField* txtPercent;
@property(nonatomic, strong) IBOutlet UITextField* txtIgnore;
@property(nonatomic, strong) IBOutlet UITextField* txtDate;
@property(nonatomic, strong) IBOutlet UITextField* txtRem;
-(void) refresh;
@end
