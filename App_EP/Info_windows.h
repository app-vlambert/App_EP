//
//  Info_windows.h
//  App_EP
//
//  Created by Lambert Vincent on 08.10.14.
//  Copyright (c) 2014 vincent-lambert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLmanager.h"

@interface Info_windows : UITabBarController
//Point lumineux
@property (nonatomic) NSString* PL;
@property (nonatomic) NSString* PL_NUMERO_LAM;
@property (nonatomic) NSString* Prop;
@property (nonatomic) NSString* CANTON;
@property (nonatomic) NSString* COMMUNE;
@property (nonatomic) NSString* LOCALITE;
@property (nonatomic) NSString* SECTEUR;
@property (nonatomic) NSString* RUE;
@property (nonatomic) NSString* CADS;
@property (nonatomic) double X;
@property (nonatomic) double Y;
//Luminaire
@property (nonatomic) NSString* Type_cand;
@property (nonatomic) NSInteger Hauteur;
@property (nonatomic) NSString *Luminaire;
@property (nonatomic) NSString *Model;
@property (nonatomic) NSString *Fabricant;
@property (nonatomic) NSString *Alimentation;
@property (nonatomic) NSString *Compteur;
@property (nonatomic) NSString *Relais;
//Lampe
@property (nonatomic) NSString* Genre;
@property (nonatomic) NSString* Lampe;
@property (nonatomic) NSString* Ref_spontis;
@property (nonatomic) NSString* N_spontis;
@property (nonatomic) NSString* Culot;
@property (nonatomic) NSString* Self;
@property (nonatomic) NSString* Commande;
@property (nonatomic) NSInteger H_Haute;
@property (nonatomic) NSInteger H_Basse;
@property (nonatomic) NSInteger Full_Power;
@property (nonatomic) NSInteger Cal_Power;
@property (nonatomic) NSString *Percent;
@property (nonatomic) NSString *Ignore;
@property (nonatomic) NSString *Date;
@property (nonatomic) NSString *Rem;

@property(nonatomic) NSArray *Result;
@property(nonatomic) int pos;
@property(nonatomic)int appelant; //0 ou 1 ...0 cache le bouton google map 1 l'affiche

-(IBAction)go_first:(id)sender;
-(IBAction)go_previous:(id)sender;
-(IBAction)go_next:(id)sender;
-(IBAction)go_last:(id)sender;
-(IBAction)load_map:(id)sender;

@end


