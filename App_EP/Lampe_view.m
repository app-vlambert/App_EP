//
//  Lampe_view.m
//  App_EP
//
//  Created by Lambert Vincent on 09.10.14.
//  Copyright (c) 2014 vincent-lambert. All rights reserved.
//

#import "Lampe_view.h"
#import "Info_windows.h"

@interface Lampe_view ()

@end

@implementation Lampe_view
@synthesize txtGenre;
@synthesize txtLampe;
@synthesize txtRef_Spontis;
@synthesize txtN_Spontis;
@synthesize txtCulot;
@synthesize txtSelf;
@synthesize txtCommande;
@synthesize txtHaute;
@synthesize txtBasse;
@synthesize txtFull_power;
@synthesize txtCal_power;
@synthesize txtPercent;
@synthesize txtIgnore;
@synthesize txtDate;
@synthesize txtRem;

- (void)viewDidLoad {
    [super viewDidLoad];
    Info_windows *parent = (Info_windows*) self.tabBarController;
    txtGenre.text = parent.Genre;
    txtLampe.text = parent.Lampe;
    txtRef_Spontis.text = parent.Ref_spontis;
    txtN_Spontis.text = parent.N_spontis;
    txtCulot.text = parent.Culot;
    txtSelf.text = parent.Self;
    txtCommande.text = parent.Commande;
    txtHaute.text = [NSString stringWithFormat:@"%ld",(long)parent.H_Haute];
    txtBasse.text = [NSString stringWithFormat:@"%ld",(long)parent.H_Basse];
    txtFull_power.text = [NSString stringWithFormat:@"%ld",(long)parent.Full_Power];
    txtCal_power.text = [NSString stringWithFormat:@"%ld",(long)parent.Cal_Power];
    txtPercent.text = parent.Percent;
    txtIgnore.text = parent.Ignore;
    txtDate.text = parent.Date;
    txtRem.text = parent.Rem;
    
    

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
    txtGenre.text = parent.Genre;
    txtLampe.text = parent.Lampe;
    txtRef_Spontis.text = parent.Ref_spontis;
    txtN_Spontis.text = parent.N_spontis;
    txtCulot.text = parent.Culot;
    txtSelf.text = parent.Self;
    txtCommande.text = parent.Commande;
    txtHaute.text = [NSString stringWithFormat:@"%ld",(long)parent.H_Haute];
    txtBasse.text = [NSString stringWithFormat:@"%ld",(long)parent.H_Basse];
    txtFull_power.text = [NSString stringWithFormat:@"%ld",(long)parent.Full_Power];
    txtCal_power.text = [NSString stringWithFormat:@"%ld",(long)parent.Cal_Power];
    txtPercent.text = parent.Percent;
    txtIgnore.text = parent.Ignore;
    txtDate.text = parent.Date;
    txtRem.text = parent.Rem;
    [self.view setNeedsDisplay];
    
}

@end
