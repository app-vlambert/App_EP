//
//  Luminaire.m
//  App_EP
//
//  Created by Lambert Vincent on 09.10.14.
//  Copyright (c) 2014 vincent-lambert. All rights reserved.
//

#import "Luminaire_view.h"
#import "Info_windows.h"

@interface Luminaire_view ()
@end

@implementation Luminaire_view
@synthesize txtType_Cand;
@synthesize txtHauteur;
@synthesize txtLuminaire;
@synthesize txtModel;
@synthesize txtFabricant;
@synthesize txtAlim;
@synthesize txtCompteur;
@synthesize txtRelais;
- (void)viewDidLoad {
    [super viewDidLoad];
    Info_windows *parent = (Info_windows*) self.tabBarController;
    txtType_Cand.text = parent.Type_cand;
    txtHauteur.text = [NSString stringWithFormat:@"%ld",(long)parent.Hauteur];
    txtLuminaire.text = parent.Luminaire;
    txtModel.text = parent.Model;
    txtFabricant.text = parent.Fabricant;
    txtAlim.text = parent.Alimentation;
    txtCompteur.text = parent.Compteur;
    txtRelais.text = parent.Relais;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void) refresh
{
    Info_windows *parent = (Info_windows*) self.tabBarController;
    txtType_Cand.text = parent.Type_cand;
    txtHauteur.text = [NSString stringWithFormat:@"%ld",(long)parent.Hauteur];
    txtLuminaire.text = parent.Luminaire;
    txtModel.text = parent.Model;
    txtFabricant.text = parent.Fabricant;
    txtAlim.text = parent.Alimentation;
    txtCompteur.text = parent.Compteur;
    txtRelais.text = parent.Relais;    [self.view setNeedsDisplay];
}
@end
