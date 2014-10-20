//
//  Map.h
//  App_EP
//
//  Created by Lambert Vincent on 19/09/14.
//  Copyright (c) 2014 vincent-lambert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>


@interface Map : UIViewController<GMSMapViewDelegate>
{
   // GMSMapView *mapView_;
    
    
}

- (IBAction)Load_Point:(id)sender;

@property (nonatomic, strong) IBOutlet UIButton *Load_PL_bout;
@property (nonatomic, strong) NSString *PL;
@property (nonatomic, strong) NSString *Commune;

@end
