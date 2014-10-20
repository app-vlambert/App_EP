//
//  Luminaire.h
//  App_EP
//
//  Created by Lambert Vincent on 09.10.14.
//  Copyright (c) 2014 vincent-lambert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Luminaire_view : UIViewController
@property (nonatomic,strong) IBOutlet UITextField *txtType_Cand;
@property (nonatomic,strong) IBOutlet UITextField *txtHauteur;
@property(nonatomic,strong) IBOutlet UITextField *txtLuminaire;
@property(nonatomic, strong) IBOutlet UITextField *txtModel;
@property(nonatomic, strong) IBOutlet UITextField *txtFabricant;
@property(nonatomic, strong) IBOutlet UITextView *txtAlim;
@property(nonatomic, strong) IBOutlet UITextField *txtCompteur;
@property(nonatomic,strong) IBOutlet UITextField *txtRelais;
-(void) refresh;
@end
