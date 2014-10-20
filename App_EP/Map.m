//
//  Map.m
//  App_EP
//
//  Created by Lambert Vincent on 19/09/14.
//  Copyright (c) 2014 vincent-lambert. All rights reserved.
//

#import "Map.h"
#import "SQLmanager.h"
#import "Info_windows.h"
//#import "App_EP-Swift.h"
#import "ApproxSwissProj.h"






@interface Map () 





@end

@implementation Map {
    GMSMapView *mapView   ;
    
}

@synthesize Load_PL_bout;
@synthesize PL;
@synthesize Commune;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView {
    int j,i,pos_PL,pos_DEP;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:46.822753 longitude:7.150152 zoom:16];
    mapView= [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    mapView.settings.myLocationButton = YES;
    mapView.mapType = kGMSTypeSatellite;
    mapView.delegate = self;
    


    UIButton *Load_PL = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    Load_PL.frame = CGRectMake(65, 437, 200, 40);
    [Load_PL setTitle:@"Charger PL alentour" forState:UIControlStateNormal];
    [Load_PL setBackgroundColor:[UIColor grayColor]];
    [Load_PL addTarget:self action:@selector(Load_Point:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view = mapView;
    [self.view addSubview: Load_PL];
    
    if(PL.length != 0 ||Commune.length != 0)
    {
        if(PL.length != 0)
        {
        self.navigationController.navigationBar.backItem.title = @"Back";
        SQLmanager *db = [[SQLmanager alloc]initDatabase];
        NSArray *Result_PL = [db query:[NSString stringWithFormat:@"Select pl.PLU_NUMERO_LAM, pl.X, pl.Y, pl.PLU_NAME_NUMBER_LAM From PL pl WHERE pl.PLU_NUMERO_LAM = %@",PL]];
        pos_PL = Result_PL.count;
        
        //traitement des PL
        for (j = 0; j < pos_PL; j++)
        {
            //UIImage *icone;
            double x_user = [[[Result_PL objectAtIndex:j]objectAtIndex:1]doubleValue];
            double y_user = [[[Result_PL objectAtIndex:j]objectAtIndex:2]doubleValue];
            NSArray *tableau_coord = [ApproxSwissProj LV03toWGS84:x_user :y_user :0.0];
            CLLocationCoordinate2D position_marker = CLLocationCoordinate2DMake([[tableau_coord objectAtIndex:0]doubleValue], [[tableau_coord objectAtIndex:1]doubleValue]);
            GMSMarker *marker = [[GMSMarker alloc] init];
            marker.position = position_marker;
            marker.title = [NSString stringWithFormat:@"%@ %@",[[Result_PL objectAtIndex:j]objectAtIndex:0], [[Result_PL objectAtIndex:j]objectAtIndex:3]] ;
            marker.snippet = @"Point Lumineux";
            marker.map = mapView;
            
            GMSCameraUpdate *camera = [GMSCameraUpdate setCamera:[GMSCameraPosition cameraWithLatitude:marker.position.latitude longitude:marker.position.longitude zoom:16]];
            [mapView moveCamera:camera];
        }
        }
    }
        if(Commune.length !=0)
        {
            self.navigationController.navigationBar.backItem.title = @"Back";
            SQLmanager *db = [[SQLmanager alloc]initDatabase];
            
            NSArray *result_PL = [db query:[NSString stringWithFormat:@"Select pl.PLU_NUMERO_LAM, pl.X, pl.Y, pl.PLU_NAME_NUMBER_LAM, dep.couleur From PL pl INNER JOIN DEP dep ON pl.ALIMENTATION = dep.FID_FEATURE_ALIM_DEP WHERE pl.COMMUNE = '%@'",Commune]];
            
            NSArray *result_DEP = [db query:[NSString stringWithFormat:@"Select dep.label, dep.x, dep.y, dep.couleur from DEP dep WHERE dep.FID_FEATURE_ALIM_DEP in (select distinct pl.alimentation from PL pl WHERE pl.COMMUNE = '%@')",Commune]];
            pos_PL = result_PL.count;
            pos_DEP = result_DEP.count;
            //traitement des DEP
            for(i = 0; i <pos_DEP; i++)
            {
                double x_user = [[[result_DEP objectAtIndex:i]objectAtIndex:1]doubleValue];
                double y_user = [[[result_DEP objectAtIndex:i]objectAtIndex:2]doubleValue];
                NSArray *tableau_coord = [ApproxSwissProj LV03toWGS84:x_user :y_user :0.0];
                CLLocationCoordinate2D position_marker = CLLocationCoordinate2DMake([[tableau_coord objectAtIndex:0]doubleValue], [[tableau_coord objectAtIndex:1]doubleValue]);
                NSString *couleur = (NSString *)[[result_DEP objectAtIndex:i]objectAtIndex:3];
                NSString *label = (NSString *)[[result_DEP objectAtIndex:i]objectAtIndex:0];
                GMSMarker *marker = [GMSMarker markerWithPosition:position_marker];
                marker.title = label;
                marker.snippet = @"Alimentation";
                //définition de l'icone du marqueur
                if([couleur isEqualToString:@"Bleu"])
                {
                    if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Station_bleue.bmp"];
                        marker.map = mapView;
                    }else if([label rangeOfString:@"Armoire"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Armoire_bleue.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point de livraison"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Consommateur_bleue.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"PL_bleue.bmp"];
                        marker.map = mapView;
                    }
                    
                    
                }else if([couleur isEqualToString:@"Brun"])
                {
                    if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Station_brun.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Armoire"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Armoire_brun.bmp"];
                        marker.map = mapView;
                    }else if([label rangeOfString:@"Point de livraison"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Consommateur_brun.bmp"];
                        marker.map = mapView;
                    }else if([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"PL_brun.bmp"];
                        marker.map = mapView;
                    }
                    
                }else if ([couleur isEqualToString:@"Cyan"])
                {
                    if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Station_cyan.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Armoire"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Armoire_cyan.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point de livraison"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Consommateur_cyan.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"PL_cyan.bmp"];
                        marker.map = mapView;
                    }
                }else if ([couleur isEqualToString:@"Gris"])
                {
                    if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Station_gris.bmp"];
                        marker.map = mapView;
                    } else if ([label rangeOfString:@"Armoire"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Armoire_gris.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point de livraison"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Consommateur_gris.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"PL_gris.bmp"];
                        marker.map = mapView;
                    }
                }else if ([couleur isEqualToString:@"Jaune"])
                {
                    if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Station_jaune.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Armoire"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Armoire_jaune.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point de livraison" ].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Consommateur_jaune.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"PL_jaune.bmp"];
                        marker.map = mapView;
                    }
                }else if ([couleur isEqualToString:@"Magenta"])
                {
                    if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Station_magenta.bmp"];
                        marker.map = mapView;
                    }else if([label rangeOfString:@"Armoire"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Armoire_magenta.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point de livraison"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Consommateur_magenta.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"PL_magenta.bmp"];
                        marker.map = mapView;
                    }
                    
                }else if ([couleur isEqualToString:@"Noir"])
                {
                    if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Station_noir.bmp"];
                        marker.map = mapView;
                    }else if([label rangeOfString:@"Armoire"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Armoire_noir.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point de livraison"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Consommateur_noir.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"PL_noir.bmp"];
                        marker.map = mapView;
                    }
                    
                }else if ([couleur isEqualToString:@"Orange"])
                {
                    if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Station_orange.bmp"];
                        marker.map = mapView;
                    }else if([label rangeOfString:@"Armoire"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Armoire_orange.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point de livraison"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Consommateur_orange.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"PL_orange.bmp"];
                        marker.map = mapView;
                    }
                }else if ([couleur isEqualToString:@"Rose"])
                {
                    if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Station_rose.bmp"];
                        marker.map = mapView;
                    }else if([label rangeOfString:@"Armoire"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Armoire_rose.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point de livraison"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Consommateur_rose.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"PL_rose.bmp"];
                        marker.map = mapView;
                    }
                }else if ([couleur isEqualToString:@"Rouge"])
                {
                    if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Station_rouge.bmp"];
                        marker.map = mapView;
                    }else if([label rangeOfString:@"Armoire"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Armoire_rouge.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point de livraison"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Consommateur_rouge.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"PL_rouge.bmp"];
                        marker.map = mapView;
                    }
                }else if ([couleur isEqualToString:@"Rouge clair"])
                {
                    if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Station_rougeclair.bmp"];
                        marker.map = mapView;
                    }else if([label rangeOfString:@"Armoire"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Armoire_rougeclair.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point de livraison"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Consommateur_rougeclair.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"PL_rougeclair.bmp"];
                        marker.map = mapView;
                    }
                }else if ([couleur isEqualToString:@"Rouge foncé"])
                {
                    if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Station_rougefoncébmp.bmp"];
                        marker.map = mapView;
                    }else if([label rangeOfString:@"Armoire"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Armoire_rougefoncé.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point de livraison"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Consommateur_rougefoncé.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"PL_rougefoncébmp.bmp"];
                        marker.map = mapView;
                    }
                }else if ([couleur isEqualToString:@"Vert clair"])
                {
                    if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Station_vertclair.bmp"];
                        marker.map = mapView;
                    }else if([label rangeOfString:@"Armoire"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Armoire_vertclair.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point de livraison"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Consommateur_vertclair.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"PL_vertclair.bmp"];
                        marker.map = mapView;
                    }
                }else if ([couleur isEqualToString:@"Vert foncé"])
                {
                    if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Station_vertfoncé.bmp"];
                        marker.map = mapView;
                    }else if([label rangeOfString:@"Armoire"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Armoire_vertfoncé.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point de livraison"].location !=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Consommateur_vertfoncé.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point lumineux"].location !=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"PL_vertfoncé.bmp"];
                        marker.map = mapView;
                    }
                }else if ([couleur isEqualToString:@"Violet"])
                {
                    if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Station_violet.bmp"];
                        marker.map = mapView;
                    }else if([label rangeOfString:@"Armoire"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Armoire_violet.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point de livraison"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"Consommateur_violet.bmp"];
                        marker.map = mapView;
                    }else if ([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
                    {
                        marker.icon = [UIImage imageNamed:@"PL_violet.bmp"];
                        marker.map = mapView;
                    }
                }
            }
            //traitement des PL
            for (j = 0; j < pos_PL; j++)
            {
                //UIImage *icone;
                double x_user = [[[result_PL objectAtIndex:j]objectAtIndex:1]doubleValue];
                double y_user = [[[result_PL objectAtIndex:j]objectAtIndex:2]doubleValue];
                NSArray *tableau_coord = [ApproxSwissProj LV03toWGS84:x_user :y_user :0.0];
                CLLocationCoordinate2D position_marker = CLLocationCoordinate2DMake([[tableau_coord objectAtIndex:0]doubleValue], [[tableau_coord objectAtIndex:1]doubleValue]);
                GMSMarker *marker = [[GMSMarker alloc] init];
                marker.position = position_marker;
                marker.title = [NSString stringWithFormat:@"%@ %@",[[result_PL objectAtIndex:j]objectAtIndex:0], [[result_PL objectAtIndex:j]objectAtIndex:3]] ;
                marker.snippet = @"Point Lumineux";
                NSString *couleur = (NSString *)[[result_PL objectAtIndex:j]objectAtIndex:4];
                //Case impossible en Objective-C -> utilisation de if/else
                if([couleur  isEqualToString:@"Bleu"])
                {
                    marker.icon = [GMSMarker markerImageWithColor:[UIColor blueColor]];
                    marker.map = mapView;
                }else if ([couleur isEqualToString:@"Brun"])
                {
                    marker.icon = [GMSMarker markerImageWithColor:[UIColor colorWithRed:99.0f/255.0f green:37.0f/255.0f blue:35.0f/255.0f alpha:1.0f]];
                    marker.map = mapView;
                }else if ([couleur isEqualToString:@"Cyan"])
                {
                    marker.icon = [GMSMarker markerImageWithColor:[UIColor cyanColor]];
                    marker.map = mapView;
                }else if ([couleur isEqualToString:@"Gris"])
                {
                    marker.icon = [GMSMarker markerImageWithColor:[UIColor colorWithRed:128.0f/255.0f green:128.0f/255.0f blue:128.0f/255.0f alpha:1.0f]];
                    marker.map = mapView;
                }else if ([couleur isEqualToString:@"Jaune"])
                {
                    marker.icon = [GMSMarker markerImageWithColor:[UIColor yellowColor]];
                    marker.map = mapView;
                }else if ([couleur isEqualToString:@"Magenta"])
                {
                    marker.icon = [GMSMarker markerImageWithColor:[UIColor magentaColor]];
                    marker.map = mapView;
                }else if ([couleur isEqualToString:@"Noir"])
                {
                    marker.icon = [GMSMarker markerImageWithColor:[UIColor blackColor]];
                    marker.map = mapView;
                }else if ([couleur isEqualToString:@"Orange"])
                {
                    marker.icon = [GMSMarker markerImageWithColor:[UIColor orangeColor]];
                    marker.map = mapView;
                }else if ([couleur isEqualToString:@"Rose"])
                {
                    marker.icon = [GMSMarker markerImageWithColor:[UIColor colorWithRed:233.0f/255.0f green:127.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
                    marker.map = mapView;
                }else if ([couleur isEqualToString:@"Rouge"])
                {
                    marker.icon = [GMSMarker markerImageWithColor:[UIColor redColor]];
                    marker.map = mapView;
                }else if ([couleur isEqualToString:@"Rouge clair"])
                {
                    marker.icon = [GMSMarker markerImageWithColor:[UIColor colorWithRed:250.0f/255.0f green:114.0f/255.0f blue:114.0f/255.0f alpha:1.0f]];
                    marker.map = mapView;
                }else if ([couleur isEqualToString:@"Rouge foncé"])
                {
                    marker.icon = [GMSMarker markerImageWithColor:[UIColor colorWithRed:193.0f/255.0f green:6.0f/255.0f blue:6.0f/255.0f alpha:1.0f]];
                    marker.map = mapView;
                }else if ([couleur isEqualToString:@"Vert clair"])
                {
                    UIColor *color = [UIColor colorWithRed:4.0f/255.0f green:252.0f/255.0f blue:4.0f/255.0f alpha:1.0f];
                    marker.icon = [GMSMarker markerImageWithColor:color];
                    marker.map = mapView;
                }else if ([couleur isEqualToString:@"Vert foncé"])
                {
                    marker.icon = [GMSMarker markerImageWithColor:[UIColor colorWithRed:5.0f/255.0f green:113.0f/255.0f blue:5.0f/255.0f alpha:1.0f]];
                    marker.map = mapView;
                }else if ([couleur isEqualToString:@"Violet"])
                {
                    marker.icon = [GMSMarker markerImageWithColor:[UIColor purpleColor]];
                    marker.map = mapView;
                }
                
                
                GMSCameraUpdate *camera = [GMSCameraUpdate setCamera:[GMSCameraPosition cameraWithLatitude:marker.position.latitude longitude:marker.position.longitude zoom:16]];
                [mapView moveCamera:camera];
                
                
            }

            
    }else{
        GMSCameraUpdate *camera = [GMSCameraUpdate setCamera:[GMSCameraPosition cameraWithLatitude:46.822753 longitude:7.150152 zoom:16]];
        [mapView moveCamera:camera];
            }
    }


- (void)viewDidLoad

{
    
    [super viewDidLoad];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Load_Point:(id)sender
{
    [mapView clear];
    long  pos_PL = 0;
    long pos_DEP = 0;
    int i,j;
    CLLocation *position = mapView.myLocation;
    NSLog(@"Position actuelle %@", position);
    NSArray *Current_pos = [ApproxSwissProj WGS84toLV03:position.coordinate.latitude:position.coordinate.longitude:position.altitude] ;
    NSString *x_user = Current_pos[0];
    NSString *y_user = Current_pos[1];
    
    //DBManager *test = [DBManager newInstance];
    //SQLiteDB *test = [SQLiteDB init];
    SQLmanager *test = [[SQLmanager alloc] initDatabase] ;
    [test checkAndCreateDatabase];
    NSArray *result_PL = [test query:[NSString stringWithFormat:@"Select pl.PLU_NUMERO_LAM, pl.X, pl.Y, pl.PLU_NAME_NUMBER_LAM, dep.couleur From PL pl INNER JOIN DEP dep ON pl.ALIMENTATION = dep.FID_FEATURE_ALIM_DEP WHERE ((pl.X - %@ ) * (pl.X - %@ )) + ((pl.Y - %@ ) * (pl.Y - %@)) < 100000",x_user,x_user,y_user,y_user]];
    
    NSArray *result_DEP = [test query:[NSString stringWithFormat:@"Select dep.label, dep.x, dep.y, dep.couleur from DEP dep WHERE dep.FID_FEATURE_ALIM_DEP in (select distinct pl.alimentation from PL pl where ((pl.X - %@ ) * (pl.X - %@ )) + ((pl.Y - %@ ) * (pl.Y - %@)) < 100000)" ,x_user,x_user,y_user,y_user ]];
    pos_PL = result_PL.count;
    pos_DEP = result_DEP.count;
    //traitement des DEP
    for(i = 0; i <pos_DEP; i++)
    {
        
        double x_user = [[[result_DEP objectAtIndex:i]objectAtIndex:1]doubleValue];
        double y_user = [[[result_DEP objectAtIndex:i]objectAtIndex:2]doubleValue];
        NSArray *tableau_coord = [ApproxSwissProj LV03toWGS84:x_user :y_user :0.0];
        CLLocationCoordinate2D position_marker = CLLocationCoordinate2DMake([[tableau_coord objectAtIndex:0]doubleValue], [[tableau_coord objectAtIndex:1]doubleValue]);
        NSString *couleur = (NSString *)[[result_DEP objectAtIndex:i]objectAtIndex:3];
        NSString *label = (NSString *)[[result_DEP objectAtIndex:i]objectAtIndex:0];
        GMSMarker *marker = [GMSMarker markerWithPosition:position_marker];
        marker.title = label;
        marker.snippet = @"Alimentation";
        //définition de l'icone du marqueur
        if([couleur isEqualToString:@"Bleu"])
        {
            if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Station_bleue.bmp"];
                marker.map = mapView;
            }else if([label rangeOfString:@"Armoire"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Armoire_bleue.bmp"];
                marker.map = mapView;
            }else if ([label rangeOfString:@"Point de livraison"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Consommateur_bleue.bmp"];
                marker.map = mapView;
            }else if ([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"PL_bleue.bmp"];
                marker.map = mapView;
            }
            
            
        }else if([couleur isEqualToString:@"Brun"])
        {
            if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Station_brun.bmp"];
                marker.map = mapView;
            }else if ([label rangeOfString:@"Armoire"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Armoire_brun.bmp"];
                marker.map = mapView;
            }else if([label rangeOfString:@"Point de livraison"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Consommateur_brun.bmp"];
                marker.map = mapView;
            }else if([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"PL_brun.bmp"];
                marker.map = mapView;
            }
            
        }else if ([couleur isEqualToString:@"Cyan"])
        {
            if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Station_cyan.bmp"];
                marker.map = mapView;
            }else if ([label rangeOfString:@"Armoire"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Armoire_cyan.bmp"];
                marker.map = mapView;
            }else if ([label rangeOfString:@"Point de livraison"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Consommateur_cyan.bmp"];
                marker.map = mapView;
            }else if ([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"PL_cyan.bmp"];
                marker.map = mapView;
            }
        }else if ([couleur isEqualToString:@"Gris"])
        {
            if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
                {
                    marker.icon = [UIImage imageNamed:@"Station_gris.bmp"];
                    marker.map = mapView;
                } else if ([label rangeOfString:@"Armoire"].location!=NSNotFound)
                {
                    marker.icon = [UIImage imageNamed:@"Armoire_gris.bmp"];
                    marker.map = mapView;
                }else if ([label rangeOfString:@"Point de livraison"].location!=NSNotFound)
                {
                    marker.icon = [UIImage imageNamed:@"Consommateur_gris.bmp"];
                    marker.map = mapView;
                }else if ([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
                {
                    marker.icon = [UIImage imageNamed:@"PL_gris.bmp"];
                    marker.map = mapView;
                }
        }else if ([couleur isEqualToString:@"Jaune"])
        {
            if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
                {
                    marker.icon = [UIImage imageNamed:@"Station_jaune.bmp"];
                    marker.map = mapView;
                }else if ([label rangeOfString:@"Armoire"].location!=NSNotFound)
                {
                    marker.icon = [UIImage imageNamed:@"Armoire_jaune.bmp"];
                    marker.map = mapView;
                }else if ([label rangeOfString:@"Point de livraison" ].location!=NSNotFound)
                {
                    marker.icon = [UIImage imageNamed:@"Consommateur_jaune.bmp"];
                    marker.map = mapView;
                }else if ([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
                {
                    marker.icon = [UIImage imageNamed:@"PL_jaune.bmp"];
                    marker.map = mapView;
                }
        }else if ([couleur isEqualToString:@"Magenta"])
        {
            if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Station_magenta.bmp"];
                marker.map = mapView;
            }else if([label rangeOfString:@"Armoire"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Armoire_magenta.bmp"];
                marker.map = mapView;
            }else if ([label rangeOfString:@"Point de livraison"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Consommateur_magenta.bmp"];
                marker.map = mapView;
            }else if ([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"PL_magenta.bmp"];
                marker.map = mapView;
            }
                
        }else if ([couleur isEqualToString:@"Noir"])
        {
            if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Station_noir.bmp"];
                marker.map = mapView;
            }else if([label rangeOfString:@"Armoire"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Armoire_noir.bmp"];
                marker.map = mapView;
            }else if ([label rangeOfString:@"Point de livraison"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Consommateur_noir.bmp"];
                marker.map = mapView;
            }else if ([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"PL_noir.bmp"];
                marker.map = mapView;
            }
        
        }else if ([couleur isEqualToString:@"Orange"])
        {
            if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Station_orange.bmp"];
                marker.map = mapView;
            }else if([label rangeOfString:@"Armoire"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Armoire_orange.bmp"];
                marker.map = mapView;
            }else if ([label rangeOfString:@"Point de livraison"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Consommateur_orange.bmp"];
                marker.map = mapView;
            }else if ([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"PL_orange.bmp"];
                marker.map = mapView;
            }
        }else if ([couleur isEqualToString:@"Rose"])
        {
            if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Station_rose.bmp"];
                marker.map = mapView;
            }else if([label rangeOfString:@"Armoire"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Armoire_rose.bmp"];
                marker.map = mapView;
            }else if ([label rangeOfString:@"Point de livraison"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Consommateur_rose.bmp"];
                marker.map = mapView;
            }else if ([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"PL_rose.bmp"];
                marker.map = mapView;
            }
        }else if ([couleur isEqualToString:@"Rouge"])
        {
            if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Station_rouge.bmp"];
                marker.map = mapView;
            }else if([label rangeOfString:@"Armoire"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Armoire_rouge.bmp"];
                marker.map = mapView;
            }else if ([label rangeOfString:@"Point de livraison"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Consommateur_rouge.bmp"];
                marker.map = mapView;
            }else if ([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"PL_rouge.bmp"];
                marker.map = mapView;
            }
        }else if ([couleur isEqualToString:@"Rouge clair"])
        {
            if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Station_rougeclair.bmp"];
                marker.map = mapView;
            }else if([label rangeOfString:@"Armoire"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Armoire_rougeclair.bmp"];
                marker.map = mapView;
            }else if ([label rangeOfString:@"Point de livraison"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Consommateur_rougeclair.bmp"];
                marker.map = mapView;
            }else if ([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"PL_rougeclair.bmp"];
                marker.map = mapView;
            }
        }else if ([couleur isEqualToString:@"Rouge foncé"])
        {
            if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Station_rougefoncébmp.bmp"];
                marker.map = mapView;
            }else if([label rangeOfString:@"Armoire"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Armoire_rougefoncé.bmp"];
                marker.map = mapView;
            }else if ([label rangeOfString:@"Point de livraison"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Consommateur_rougefoncé.bmp"];
                marker.map = mapView;
            }else if ([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"PL_rougefoncébmp.bmp"];
                marker.map = mapView;
            }
        }else if ([couleur isEqualToString:@"Vert clair"])
        {
            if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Station_vertclair.bmp"];
                marker.map = mapView;
            }else if([label rangeOfString:@"Armoire"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Armoire_vertclair.bmp"];
                marker.map = mapView;
            }else if ([label rangeOfString:@"Point de livraison"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Consommateur_vertclair.bmp"];
                marker.map = mapView;
            }else if ([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"PL_vertclair.bmp"];
                marker.map = mapView;
            }
        }else if ([couleur isEqualToString:@"Vert foncé"])
        {
            if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Station_vertfoncé.bmp"];
                marker.map = mapView;
            }else if([label rangeOfString:@"Armoire"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Armoire_vertfoncé.bmp"];
                marker.map = mapView;
            }else if ([label rangeOfString:@"Point de livraison"].location !=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Consommateur_vertfoncé.bmp"];
                marker.map = mapView;
            }else if ([label rangeOfString:@"Point lumineux"].location !=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"PL_vertfoncé.bmp"];
                marker.map = mapView;
            }
        }else if ([couleur isEqualToString:@"Violet"])
        {
            if([label rangeOfString:@"Station transfo"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Station_violet.bmp"];
                marker.map = mapView;
            }else if([label rangeOfString:@"Armoire"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Armoire_violet.bmp"];
                marker.map = mapView;
            }else if ([label rangeOfString:@"Point de livraison"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"Consommateur_violet.bmp"];
                marker.map = mapView;
            }else if ([label rangeOfString:@"Point lumineux"].location!=NSNotFound)
            {
                marker.icon = [UIImage imageNamed:@"PL_violet.bmp"];
                marker.map = mapView;
            }
        }
    }
    //traitement des PL
    for (j = 0; j < pos_PL; j++)
    {
        //UIImage *icone;
        double x_user = [[[result_PL objectAtIndex:j]objectAtIndex:1]doubleValue];
        double y_user = [[[result_PL objectAtIndex:j]objectAtIndex:2]doubleValue];
        NSArray *tableau_coord = [ApproxSwissProj LV03toWGS84:x_user :y_user :0.0];
        CLLocationCoordinate2D position_marker = CLLocationCoordinate2DMake([[tableau_coord objectAtIndex:0]doubleValue], [[tableau_coord objectAtIndex:1]doubleValue]);
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = position_marker;
        marker.title = [NSString stringWithFormat:@"%@ %@",[[result_PL objectAtIndex:j]objectAtIndex:0], [[result_PL objectAtIndex:j]objectAtIndex:3]] ;
        marker.snippet = @"Point Lumineux";
        NSString *couleur = (NSString *)[[result_PL objectAtIndex:j]objectAtIndex:4];
        //Case impossible en Objective-C -> utilisation de if/else
        if([couleur  isEqualToString:@"Bleu"])
        {
            marker.icon = [GMSMarker markerImageWithColor:[UIColor blueColor]];
            marker.map = mapView;
        }else if ([couleur isEqualToString:@"Brun"])
        {
            marker.icon = [GMSMarker markerImageWithColor:[UIColor colorWithRed:99.0f/255.0f green:37.0f/255.0f blue:35.0f/255.0f alpha:1.0f]];
            marker.map = mapView;
        }else if ([couleur isEqualToString:@"Cyan"])
        {
            marker.icon = [GMSMarker markerImageWithColor:[UIColor cyanColor]];
            marker.map = mapView;
        }else if ([couleur isEqualToString:@"Gris"])
        {
            marker.icon = [GMSMarker markerImageWithColor:[UIColor colorWithRed:128.0f/255.0f green:128.0f/255.0f blue:128.0f/255.0f alpha:1.0f]];
            marker.map = mapView;
        }else if ([couleur isEqualToString:@"Jaune"])
        {
            marker.icon = [GMSMarker markerImageWithColor:[UIColor yellowColor]];
            marker.map = mapView;
        }else if ([couleur isEqualToString:@"Magenta"])
        {
            marker.icon = [GMSMarker markerImageWithColor:[UIColor magentaColor]];
            marker.map = mapView;
        }else if ([couleur isEqualToString:@"Noir"])
        {
            marker.icon = [GMSMarker markerImageWithColor:[UIColor blackColor]];
            marker.map = mapView;
        }else if ([couleur isEqualToString:@"Orange"])
        {
            marker.icon = [GMSMarker markerImageWithColor:[UIColor orangeColor]];
            marker.map = mapView;
        }else if ([couleur isEqualToString:@"Rose"])
        {
            marker.icon = [GMSMarker markerImageWithColor:[UIColor colorWithRed:233.0f/255.0f green:127.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
            marker.map = mapView;
        }else if ([couleur isEqualToString:@"Rouge"])
        {
            marker.icon = [GMSMarker markerImageWithColor:[UIColor redColor]];
            marker.map = mapView;
        }else if ([couleur isEqualToString:@"Rouge clair"])
        {
            marker.icon = [GMSMarker markerImageWithColor:[UIColor colorWithRed:250.0f/255.0f green:114.0f/255.0f blue:114.0f/255.0f alpha:1.0f]];
            marker.map = mapView;
        }else if ([couleur isEqualToString:@"Rouge foncé"])
        {
            marker.icon = [GMSMarker markerImageWithColor:[UIColor colorWithRed:193.0f/255.0f green:6.0f/255.0f blue:6.0f/255.0f alpha:1.0f]];
            marker.map = mapView;
        }else if ([couleur isEqualToString:@"Vert clair"])
        {
            UIColor *color = [UIColor colorWithRed:4.0f/255.0f green:252.0f/255.0f blue:4.0f/255.0f alpha:1.0f];
            marker.icon = [GMSMarker markerImageWithColor:color];
            marker.map = mapView;
        }else if ([couleur isEqualToString:@"Vert foncé"])
        {
            marker.icon = [GMSMarker markerImageWithColor:[UIColor colorWithRed:5.0f/255.0f green:113.0f/255.0f blue:5.0f/255.0f alpha:1.0f]];
            marker.map = mapView;
        }else if ([couleur isEqualToString:@"Violet"])
        {
            marker.icon = [GMSMarker markerImageWithColor:[UIColor purpleColor]];
            marker.map = mapView;
        }

    
    
    }
    

    
    
    
  // -[(void)mapView:(GMSMapView*)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker]
   
    
    

    
    
    
    
    
    

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
    
}
-(void) mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker
{
    if([marker.snippet isEqualToString:@"Point Lumineux"])
    {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    Info_windows *Info_windows_view = (Info_windows*)[storyboard instantiateViewControllerWithIdentifier:@"Info_windows"];
        Info_windows_view.PL = [marker.title substringToIndex:[marker.title rangeOfString:@" "].location];
        Info_windows_view.appelant = 0;
    [[self navigationController] pushViewController:Info_windows_view animated:NO];
    }
    
    
}
@end
