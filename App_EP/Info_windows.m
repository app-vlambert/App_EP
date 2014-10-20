
//  Info_windows.m
//  App_EP
//
//  Created by Lambert Vincent on 08.10.14.
//  Copyright (c) 2014 vincent-lambert. All rights reserved.
//

#import "Info_windows.h"
#import "Point_lumineux.h"
#import "Luminaire_view.h"
#import "Lampe_view.h"
#import "Map.h"

@interface Info_windows ()

@end
int pos = 0;
@implementation Info_windows
@synthesize PL;
@synthesize PL_NUMERO_LAM;
@synthesize Prop;
@synthesize CANTON;
@synthesize COMMUNE;
@synthesize LOCALITE;
@synthesize SECTEUR;
@synthesize RUE;
@synthesize CADS;
@synthesize X;
@synthesize Y;
@synthesize Type_cand;
@synthesize Hauteur;
@synthesize Luminaire;
@synthesize Model;
@synthesize Fabricant;
@synthesize Alimentation;
@synthesize Compteur;
@synthesize Relais;
@synthesize Genre;
@synthesize Lampe;
@synthesize Ref_spontis;
@synthesize N_spontis;
@synthesize Culot;
@synthesize Self;
@synthesize Commande;
@synthesize H_Haute;
@synthesize H_Basse;
@synthesize Full_Power;
@synthesize Cal_Power;
@synthesize Percent;
@synthesize Ignore;
@synthesize Date;
@synthesize Rem;
@synthesize appelant;

@synthesize Result;
@synthesize pos;

- (void)viewDidLoad {
    //[self.tabBar setFrame:CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - 30, self.tabBar.frame.size.width, self.tabBar.frame.size.height + 30)];
    [super viewDidLoad];
    if (appelant == 1)
    {
        UIImage *temp = [UIImage imageNamed:@"gmap.png"];
        UIButton *google = [[UIButton alloc]initWithFrame:CGRectMake(0.0, 0.0, 30.0, 30.0)];
        [google setImage:temp forState:UIControlStateNormal];
        [google addTarget:self action:@selector(load_map:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:google];
    }
    UIButton *first = [UIButton buttonWithType:UIButtonTypeCustom];
    [first setBackgroundImage:[UIImage imageNamed:@"first.png"] forState:UIControlStateNormal];
    first.frame = CGRectMake(5.0, 2.0, 24.0, 24.0);
    [first addTarget:self action:@selector(go_first:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:first ];
    
    
    UIButton *previous = [UIButton buttonWithType:UIButtonTypeCustom];
    [previous setBackgroundImage:[UIImage imageNamed:@"previous.png"] forState:UIControlStateNormal];
    previous.frame = CGRectMake(40.0, 2.0, 24.0, 24.0);
    [previous addTarget:self action:@selector(go_previous:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:previous];
    
    UIButton *next = [UIButton buttonWithType:UIButtonTypeCustom];
    [next setBackgroundImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
    next.frame = CGRectMake(255.0, 2.0, 24.0, 24.0);
    [next addTarget:self action:@selector(go_next:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:next];
    
    UIButton *last = [UIButton buttonWithType:UIButtonTypeCustom];
    [last setBackgroundImage:[UIImage imageNamed:@"last.png"] forState:UIControlStateNormal];
    last.frame = CGRectMake(290.0, 2.0, 24.0, 24.0);
    [last addTarget:self action:@selector(go_last:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:last];
    
    SQLmanager *db = [[SQLmanager alloc] initDatabase];
    Result = [db query:[NSString stringWithFormat:@"Select pl.PLU_NUMERO_LAM, pl.PLU_CODE_LAM, pl.LUM_CODE_LAM,pl.ID_CODE_ASS_LAM, pl.PLU_NAME_NUMBER_LAM, pl.ID_PROPRIETAIRE_LAM, pl.CANTON, pl.X, pl.Y, pl.COMMUNE, pl.SECTEUR, pl.LOCALITE, pl.RUE, pl.INFO_CADASTRE, pl.TYPE_CANDELABRE, pl.HAUTEUR, pl.LUMINAIRE, pl.MODEL_LUMINAIRE, pl.FABRICANT, dep.LABEL, pl.COMPTEUR, pl.COMMANDE_ALIM, pl.REF_SPONTIS, pl.SELF, pl.N_SPONTIS, pl.GENRE_LAMPE, pl.H_HAUTE, pl.H_BASSE, pl.RELAIS, pl.LAMPE, pl.FULL_POWER, pl.RED_POWER, pl.DATE_INSTALLATION, pl.IGNORE, pl.CAL_POWER, pl.PERCENT, pl.CULOT, pl.REM, pl.COMMANDE_LAM FROM PL pl INNER JOIN dep ON pl.ALIMENTATION = dep.FID_FEATURE_ALIM_DEP WHERE pl.PLU_NUMERO_LAM = %@ order by pl.PLU_CODE_LAM",PL]];
    pos = 0;
    NSString *Percent_calc;
    NSString *Lettre_PL = (NSString *)[[Result objectAtIndex:pos]objectAtIndex:2];
    //Point lumineux
    PL_NUMERO_LAM = [NSString stringWithFormat:@"%@ %@",PL,Lettre_PL];
    Prop = (NSString*)[[Result objectAtIndex:pos]objectAtIndex:5];
    CANTON = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:6];
    COMMUNE = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:9];
    LOCALITE = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:11];
    SECTEUR = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:10];
    RUE = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:12];
    CADS = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:13];
    X = [[[Result objectAtIndex:pos]objectAtIndex:7]doubleValue];
    Y = [[[Result objectAtIndex:pos]objectAtIndex:8]doubleValue];
    //Luminaire
    Type_cand = (NSString*)[[Result objectAtIndex:pos]objectAtIndex:14];
    Hauteur = [[[Result objectAtIndex:pos]objectAtIndex:15]integerValue];
    Luminaire = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:16];
    Model = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:17];
    Fabricant = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:18];
    Alimentation = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:19];
    Compteur = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:20];
    Relais = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:28];
    //Lampe
    Genre = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:25];
    Lampe = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:29];
    Ref_spontis = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:22];
    N_spontis = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:24];
    Culot = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:36];
    Self = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:23];
    Commande = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:38];
    H_Haute = [[[Result objectAtIndex:pos]objectAtIndex:26]integerValue];
    H_Basse = [[[Result objectAtIndex:pos]objectAtIndex:27]integerValue];
    Full_Power = [[[Result objectAtIndex:pos]objectAtIndex:30]integerValue];
    Cal_Power = [[[Result objectAtIndex:pos]objectAtIndex:34]integerValue];
    Percent_calc = (NSString*)[[Result objectAtIndex:pos]objectAtIndex:35];
    Percent = [NSString stringWithFormat:@"%@ %%",Percent_calc];
    //[Percent stringByAppendingString:@"%"];
    Ignore = (NSString*)[[Result objectAtIndex:pos]objectAtIndex:33];
    Date = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:32];
    Rem = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:37];
    self.title = [NSString stringWithFormat:@"%d sur %d",pos +1,Result.count];
    
    
    
    
              
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)go_first:(id)sender
{
    pos = 0;
    NSString *Percent_calc;
    NSString *Lettre_PL = (NSString *)[[Result objectAtIndex:pos]objectAtIndex:2];
    //Point lumineux
    PL_NUMERO_LAM = [NSString stringWithFormat:@"%@ %@",PL,Lettre_PL];
    Prop = (NSString*)[[Result objectAtIndex:pos]objectAtIndex:5];
    CANTON = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:6];
    COMMUNE = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:9];
    LOCALITE = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:11];
    SECTEUR = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:10];
    RUE = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:12];
    CADS = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:13];
    X = [[[Result objectAtIndex:pos]objectAtIndex:7]doubleValue];
    Y = [[[Result objectAtIndex:pos]objectAtIndex:8]doubleValue];
    //Luminaire
    Type_cand = (NSString*)[[Result objectAtIndex:pos]objectAtIndex:14];
    Hauteur = [[[Result objectAtIndex:pos]objectAtIndex:15]integerValue];
    Luminaire = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:16];
    Model = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:17];
    Fabricant = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:18];
    Alimentation = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:19];
    Compteur = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:20];
    Relais = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:28];
    //Lampe
    Genre = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:25];
    Lampe = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:29];
    Ref_spontis = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:22];
    N_spontis = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:24];
    Culot = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:36];
    Self = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:23];
    Commande = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:38];
    H_Haute = [[[Result objectAtIndex:pos]objectAtIndex:26]integerValue];
    H_Basse = [[[Result objectAtIndex:pos]objectAtIndex:27]integerValue];
    Full_Power = [[[Result objectAtIndex:pos]objectAtIndex:30]integerValue];
    Cal_Power = [[[Result objectAtIndex:pos]objectAtIndex:34]integerValue];
    Percent_calc = (NSString*)[[Result objectAtIndex:pos]objectAtIndex:35];
    Percent = [NSString stringWithFormat:@"%@ %%",Percent_calc];
    //[Percent stringByAppendingString:@"%"];
    Ignore = (NSString*)[[Result objectAtIndex:pos]objectAtIndex:33];
    Date = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:32];
    Rem = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:37];
    
    Point_lumineux* pl =self.childViewControllers[0];
    [pl refresh];
    Luminaire_view*lum = self.childViewControllers[1];
    [lum refresh];
    Lampe_view* lam = self.childViewControllers[2];
    [lam refresh];
    
    self.title = [NSString stringWithFormat:@"%d sur %d",pos +1,Result.count];
}

-(IBAction)go_previous:(id)sender
{
    if(pos - 1 >= 0)
    {
        pos = pos -1;
        
        NSString *Percent_calc;
        NSString *Lettre_PL = (NSString *)[[Result objectAtIndex:pos]objectAtIndex:2];
        //Point lumineux
        PL_NUMERO_LAM = [NSString stringWithFormat:@"%@ %@",PL,Lettre_PL];
        Prop = (NSString*)[[Result objectAtIndex:pos]objectAtIndex:5];
        CANTON = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:6];
        COMMUNE = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:9];
        LOCALITE = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:11];
        SECTEUR = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:10];
        RUE = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:12];
        CADS = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:13];
        X = [[[Result objectAtIndex:pos]objectAtIndex:7]doubleValue];
        Y = [[[Result objectAtIndex:pos]objectAtIndex:8]doubleValue];
        //Luminaire
        Type_cand = (NSString*)[[Result objectAtIndex:pos]objectAtIndex:14];
        Hauteur = [[[Result objectAtIndex:pos]objectAtIndex:15]integerValue];
        Luminaire = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:16];
        Model = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:17];
        Fabricant = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:18];
        Alimentation = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:19];
        Compteur = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:20];
        Relais = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:28];
        //Lampe
        Genre = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:25];
        Lampe = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:29];
        Ref_spontis = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:22];
        N_spontis = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:24];
        Culot = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:36];
        Self = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:23];
        Commande = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:38];
        H_Haute = [[[Result objectAtIndex:pos]objectAtIndex:26]integerValue];
        H_Basse = [[[Result objectAtIndex:pos]objectAtIndex:27]integerValue];
        Full_Power = [[[Result objectAtIndex:pos]objectAtIndex:30]integerValue];
        Cal_Power = [[[Result objectAtIndex:pos]objectAtIndex:34]integerValue];
        Percent_calc = (NSString*)[[Result objectAtIndex:pos]objectAtIndex:35];
        Percent = [NSString stringWithFormat:@"%@ %%",Percent_calc];
        //[Percent stringByAppendingString:@"%"];
        Ignore = (NSString*)[[Result objectAtIndex:pos]objectAtIndex:33];
        Date = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:32];
        Rem = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:37];
        
        Point_lumineux* pl =self.childViewControllers[0];
        [pl refresh];
        Luminaire_view*lum = self.childViewControllers[1];
        [lum refresh];
        Lampe_view* lam = self.childViewControllers[2];
        [lam refresh];
        
        self.title = [NSString stringWithFormat:@"%d sur %d",pos +1,Result.count];
    }
}

-(IBAction)go_next:(id)sender
{
    if (pos + 1 <= Result.count - 1)
    {
        pos = pos +1;
        
        NSString *Percent_calc;
        NSString *Lettre_PL = (NSString *)[[Result objectAtIndex:pos]objectAtIndex:2];
        //Point lumineux
        PL_NUMERO_LAM = [NSString stringWithFormat:@"%@ %@",PL,Lettre_PL];
        Prop = (NSString*)[[Result objectAtIndex:pos]objectAtIndex:5];
        CANTON = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:6];
        COMMUNE = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:9];
        LOCALITE = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:11];
        SECTEUR = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:10];
        RUE = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:12];
        CADS = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:13];
        X = [[[Result objectAtIndex:pos]objectAtIndex:7]doubleValue];
        Y = [[[Result objectAtIndex:pos]objectAtIndex:8]doubleValue];
        //Luminaire
        Type_cand = (NSString*)[[Result objectAtIndex:pos]objectAtIndex:14];
        Hauteur = [[[Result objectAtIndex:pos]objectAtIndex:15]integerValue];
        Luminaire = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:16];
        Model = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:17];
        Fabricant = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:18];
        Alimentation = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:19];
        Compteur = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:20];
        Relais = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:28];
        //Lampe
        Genre = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:25];
        Lampe = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:29];
        Ref_spontis = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:22];
        N_spontis = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:24];
        Culot = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:36];
        Self = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:23];
        Commande = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:38];
        H_Haute = [[[Result objectAtIndex:pos]objectAtIndex:26]integerValue];
        H_Basse = [[[Result objectAtIndex:pos]objectAtIndex:27]integerValue];
        Full_Power = [[[Result objectAtIndex:pos]objectAtIndex:30]integerValue];
        Cal_Power = [[[Result objectAtIndex:pos]objectAtIndex:34]integerValue];
        Percent_calc = (NSString*)[[Result objectAtIndex:pos]objectAtIndex:35];
        Percent = [NSString stringWithFormat:@"%@ %%",Percent_calc];
        //[Percent stringByAppendingString:@"%"];
        Ignore = (NSString*)[[Result objectAtIndex:pos]objectAtIndex:33];
        Date = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:32];
        Rem = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:37];
        
        Point_lumineux* pl =self.childViewControllers[0];
        [pl refresh];
        Luminaire_view*lum = self.childViewControllers[1];
        [lum refresh];
        Lampe_view* lam = self.childViewControllers[2];
        [lam refresh];
        
        self.title = [NSString stringWithFormat:@"%d sur %d",pos +1,Result.count];
    }
}

-(IBAction)go_last:(id)sender
{
    pos = Result.count - 1;
    
    NSString *Percent_calc;
    NSString *Lettre_PL = (NSString *)[[Result objectAtIndex:pos]objectAtIndex:2];
    //Point lumineux
    PL_NUMERO_LAM = [NSString stringWithFormat:@"%@ %@",PL,Lettre_PL];
    Prop = (NSString*)[[Result objectAtIndex:pos]objectAtIndex:5];
    CANTON = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:6];
    COMMUNE = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:9];
    LOCALITE = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:11];
    SECTEUR = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:10];
    RUE = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:12];
    CADS = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:13];
    X = [[[Result objectAtIndex:pos]objectAtIndex:7]doubleValue];
    Y = [[[Result objectAtIndex:pos]objectAtIndex:8]doubleValue];
    //Luminaire
    Type_cand = (NSString*)[[Result objectAtIndex:pos]objectAtIndex:14];
    Hauteur = [[[Result objectAtIndex:pos]objectAtIndex:15]integerValue];
    Luminaire = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:16];
    Model = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:17];
    Fabricant = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:18];
    Alimentation = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:19];
    Compteur = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:20];
    Relais = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:28];
    //Lampe
    Genre = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:25];
    Lampe = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:29];
    Ref_spontis = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:22];
    N_spontis = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:24];
    Culot = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:36];
    Self = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:23];
    Commande = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:38];
    H_Haute = [[[Result objectAtIndex:pos]objectAtIndex:26]integerValue];
    H_Basse = [[[Result objectAtIndex:pos]objectAtIndex:27]integerValue];
    Full_Power = [[[Result objectAtIndex:pos]objectAtIndex:30]integerValue];
    Cal_Power = [[[Result objectAtIndex:pos]objectAtIndex:34]integerValue];
    Percent_calc = (NSString*)[[Result objectAtIndex:pos]objectAtIndex:35];
    Percent = [NSString stringWithFormat:@"%@ %%",Percent_calc];
    //[Percent stringByAppendingString:@"%"];
    Ignore = (NSString*)[[Result objectAtIndex:pos]objectAtIndex:33];
    Date = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:32];
    Rem = (NSString*) [[Result objectAtIndex:pos]objectAtIndex:37];
    Point_lumineux* pl =self.childViewControllers[0];
    [pl refresh];
    Luminaire_view*lum = self.childViewControllers[1];
    [lum refresh];
    Lampe_view* lam = self.childViewControllers[2];
    [lam refresh];
    
self.title = [NSString stringWithFormat:@"%d sur %d",pos +1,Result.count];
}
-(void)load_map:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    Map *Map_view = (Map*)[storyboard instantiateViewControllerWithIdentifier:@"Map"];
    Map_view.PL = PL;
    
    [[self navigationController] pushViewController:Map_view animated:NO];
    
 
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
