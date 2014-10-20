//
//  Point_lumineux.m
//  App_EP
//
//  Created by Lambert Vincent on 08.10.14.
//  Copyright (c) 2014 vincent-lambert. All rights reserved.
//

#import "Point_lumineux.h"
#import "Info_windows.h"
@implementation Point_lumineux
@synthesize txtPLU_NUMERO_LAM;
@synthesize txtProp;
@synthesize txtCANTON;
@synthesize txtCOMMUNE;
@synthesize txtLOCALITE;
@synthesize txtSECTEUR;
@synthesize txtRUE;
@synthesize txtCADS;
@synthesize txtX;
@synthesize txtY;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)viewDidLoad
{
    Info_windows *parent = (Info_windows*) self.tabBarController;
    txtPLU_NUMERO_LAM.text = parent.PL_NUMERO_LAM ;
    txtProp.text = parent.Prop;
    txtCANTON.text = parent.CANTON;
    txtCOMMUNE.text = parent.COMMUNE;
    txtLOCALITE.text = parent.LOCALITE;
    txtSECTEUR.text = parent.SECTEUR;
    txtRUE.text = parent.RUE;
    txtCADS.text = parent.CADS;
    txtX.text = [NSString stringWithFormat:@"%f",parent.X];
    txtY.text = [NSString stringWithFormat:@"%f",parent.Y];
    
}

-(void) refresh
{
    Info_windows *parent = (Info_windows*) self.tabBarController;
    txtPLU_NUMERO_LAM.text = parent.PL_NUMERO_LAM ;
    txtProp.text = parent.Prop;
    txtCANTON.text = parent.CANTON;
    txtCOMMUNE.text = parent.COMMUNE;
    txtLOCALITE.text = parent.LOCALITE;
    txtSECTEUR.text = parent.SECTEUR;
    txtRUE.text = parent.RUE;
    txtCADS.text = parent.CADS;
    txtX.text = [NSString stringWithFormat:@"%f",parent.X];
    txtY.text = [NSString stringWithFormat:@"%f",parent.Y];
    [self.view setNeedsDisplay];
    
}

@end
