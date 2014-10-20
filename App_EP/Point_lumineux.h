//
//  Point_lumineux.h
//  App_EP
//
//  Created by Lambert Vincent on 08.10.14.
//  Copyright (c) 2014 vincent-lambert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Point_lumineux : UIViewController

@property(nonatomic, strong) IBOutlet UITextField *txtPLU_NUMERO_LAM;
@property(nonatomic,strong) IBOutlet UITextField *txtProp;
@property(nonatomic, strong) IBOutlet UITextField *txtCANTON;
@property(nonatomic, strong)IBOutlet UITextField *txtCOMMUNE;
@property(nonatomic, strong)IBOutlet UITextField *txtLOCALITE;
@property(nonatomic, strong) IBOutlet UITextField *txtSECTEUR;
@property(nonatomic, strong) IBOutlet UITextField *txtRUE;
@property(nonatomic, strong) IBOutlet UITextField *txtCADS;
@property(nonatomic,strong) IBOutlet UITextField *txtX;
@property(nonatomic,strong) IBOutlet UITextField *txtY;

-(void) refresh;

@end
