//
//  DBManager.m
//  App_EP
//
//  Created by Lambert Vincent on 22/09/14.
//  Copyright (c) 2014 vincent-lambert. All rights reserved.
//

#import "DBManager.h"



static NSString *PL_KEY = @"_id";
static NSString *PL_PLU_NUMERO_LAM = @"PLU_NUMERO_LAM";
static NSString *PL_PLU_CODE_LAM = @"PLU_CODE_LAM";
static NSString *PL_LUM_CODE_LAM = @"LUM_CODE_LAM";
static NSString *PL_ID_CODE_ASS_LAM = @"ID_CODE_ASS_LAM";
static NSString *PL_PLU_NAME_NUMBER_LAM = @"PLU_NAME_NUMBER";
static NSString *PL_ID_PROPRIETAIRE_LAM = @"ID_PROPRIETAIRE_LAM";
static NSString *PL_CANTON = @"CANTON";
static NSString *PL_X = @"X";
static NSString *PL_Y = @"Y";
static NSString *PL_COMMUNE = @"COMMUNE";
static NSString *PL_SECTEUR = @"SECTEUR";
static NSString *PL_LOCALITE = @"LOCALITE";
static NSString *PL_RUE = @"RUE";
static NSString *PL_INFO_CADASTRE = @"INFO_CADASTRE";
static NSString *PL_TYPE_CANDELABRE = @"TYPE_CANDELABRE";
static NSString *PL_HAUTEUR = @"HAUTEUR";
static NSString *PL_LUMINAIRE = @"LUMINAIRE";
static NSString *PL_MODEL_LUMINAIRE = @"MODEL_LUMINAIRE";
static NSString *PL_FABRICANT = @"FABRICANT";
static NSString *PL_ALIMENTATION = @"ALIMENTATION";
static NSString *PL_COMPTEUR = @"COMPTEUR";
static NSString *PL_RELAIS = @"RELAIS";
static NSString *PL_COMMANDE_LAM = @"COMMANDE_LAM";
static NSString *PL_REF_SPONTIS = @"REF_SPONTIS";
static NSString *PL_SELF = @"SELF";
static NSString *PL_N_SPONTIS = @"N_SPONTIS";
static NSString *PL_GENRE_LAMPE = @"GENRE_LAMPE";
static NSString *PL_H_HAUTE = @"H_HAUTE";
static NSString *PL_H_BASSE = @"H_BASSE";
static NSString *PL_LAMPE = @"LAMPE";
static NSString *PL_FULL_POWER = @"FULL_POWER";
static NSString *PL_RED_POWER = @"RED_POWER";
static NSString *PL_DATE_INSTALLATION = @"DATE_INSTALLATION";
static NSString *PL_IGNORE = @"IGNORE";
static NSString *PL_CAL_POWER = @"CAL_POWER";
static NSString *PL_PERCENT = @"PERCENTE";
static NSString *PL_CULOT = @"CULOT";
static NSString *PL_REM = @"REM";

//*********************************************************************************//

static NSString* DEP_KEY = @"_id";
static NSString* DEP_FID = @"FID";
static NSString* DEP_FID_FEATURE_ALIM_DEP = @"FID_FEATURE_ALIM_DEP";
static NSString* DEP_LABEL = @"LABEL";
static NSString* DEP_X = @"X";
static NSString* DEP_Y = @"Y";
static NSString* DEP_NUM_DEPART_DEP =  @"NUM_DEPART_DEP";
static NSString* DEP_DISPLAY_COLOR = @"DISPLAY_COLOR";
static NSString* DEP_COMMANDE = @"COMMANDE";
static NSString* DEP_COULEUR = @"COULEUR";
static NSString* DEP_EMPLACEMENT = @"EMPLACEMENT";
static NSString* DEP_COMPTEUR = @"COMPTEUR";
static NSString* DEP_RELAIS = @"RELAIS";
static NSString* DEP_REMARQUE = @"REMARQUE";


//Fin déclaration des champs

//Chaine d'action BD

static NSString* PL_TABLE_NAME = @"PL";
static NSString* DEP_TABLE_NAME = @"DEP";



@implementation DBManager






static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;


-(id) init
{
    
    return self;
    
}
+(DBManager*) getsharedInstance
{
    if(!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
        
    }
    
    return sharedInstance;
}

-(BOOL) createDB
{
    NSMutableString* DEP_TABLE_CREATE = [[NSMutableString alloc]init];
    [DEP_TABLE_CREATE appendString:@"CREATE TABLE IF NOT EXISTS "];
    [DEP_TABLE_CREATE appendString:DEP_TABLE_NAME];
    [DEP_TABLE_CREATE appendString:@" ("];
    [DEP_TABLE_CREATE appendString:DEP_KEY];
    [DEP_TABLE_CREATE appendString:@" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "];
    [DEP_TABLE_CREATE appendString:DEP_FID];
    [DEP_TABLE_CREATE appendString:@" INTEGER, "];
    [DEP_TABLE_CREATE appendString:DEP_FID_FEATURE_ALIM_DEP];
    [DEP_TABLE_CREATE appendString:@" INTEGER, "];
    [DEP_TABLE_CREATE appendString:DEP_LABEL];
    [DEP_TABLE_CREATE appendString:@" TEXT, "];
    [DEP_TABLE_CREATE appendString:DEP_X];
    [DEP_TABLE_CREATE appendString:@" REAL, "];
  
    return true;
    
}



@end