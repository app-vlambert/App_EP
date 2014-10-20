//
//  ApproxSwissProj.m
//  App_EP
//
//  Created by Lambert Vincent on 22/09/14.
//  Copyright (c) 2014 vincent-lambert. All rights reserved.
//

#import "ApproxSwissProj.h"

@implementation ApproxSwissProj

- (id) init
{
    return self;
}

+ (double) CHtoWGSheight:(double)y :(double)x :(double)h
{
    double y_aux = (y - 600000)/1000000;
    double x_aux = (x - 200000)/1000000;
    
    h = (h + 49.55) - (12.60 * y_aux) - (22.64 * x_aux);
    
    return h;
}

+ (double) CHtoWGSlat:(double)y :(double)x
{
    double y_aux = (y - 600000)/1000000;
    double x_aux = (x - 200000)/1000000;
    
    double lat = (16.9023892 + (3.238272 * x_aux))
                -(0.270978 * pow(y_aux, 2.0))
                -(0.002528 * pow(x_aux,2.0))
                -(0.0447 * pow(y_aux, 2.0)* x_aux)
                -(0.0140 * pow(x_aux, 3.0));
    
    lat = (lat * 100)/36;
    
    return lat;
}

+(double)CHtoWGSlng:(double)y :(double)x
{
    double y_aux = (y - 600000)/1000000;
    double x_aux = (x - 200000)/1000000;
    
    double lng = (2.6779094 + ( 4.728982 * y_aux)
                  +(0.791484 * y_aux * x_aux) + (0.1306 * y_aux * pow(x_aux, 2.0))) - (0.0436 * pow(y_aux, 3.0));
    
    lng = (lng * 100) / 36;
    
    return lng;
    
    
}


+(double)DecToSexAngle:(double)dec
{
    int deg = (int)floor(dec);
    int min = (int)floor((dec - deg) * 60);
    double sec = (((dec - deg) * 60) - min)* 60;
    
    return deg + ((double) min / 100) + (sec / 10000);
}

+(NSArray *)LV03toWGS84:(double)east :(double)north :(double)height
{
    NSArray* d;
    NSValue *lat = [NSNumber numberWithDouble:[self CHtoWGSlat:east :north]];
    NSValue *lng = [NSNumber numberWithDouble:[self CHtoWGSlng:east :north]];
    NSValue *hght = [NSNumber numberWithDouble:[self CHtoWGSheight:east :north :height]];
    
    d = [NSArray arrayWithObjects:lat,lng,hght, nil];
    return d;

}

+(double) SexAngleToSeconds:(double)dms
{
    double deg = 0, min = 0, sec = 0;
    deg = floor(dms);
    min = floor((dms - deg) * 100);
    sec = (((dms-deg)*100)- min) * 100;
    
    return sec + (min * 60) + (deg * 3600);
}

+(double)SexToDecAngle:(double)dms
{
    double deg = 0, min = 0, sec = 0;
    deg = floor(dms);
    min = floor((dms-deg)*100);
    sec = (((dms-deg)*100)-min)*100;
    
    return deg + (min / 60) + (sec / 3600);
}

+(NSArray*)WGS84toLV03:(double)latitude :(double)longitude :(double)elHeight
{
    NSArray *d;
    NSValue *y = [NSNumber numberWithDouble:[self WGStoChy:latitude :longitude]];
    NSValue *x = [NSNumber numberWithDouble:[self WGStoCHx:latitude :longitude]];
    NSValue *h = [NSNumber numberWithDouble:[self WGStoCHh:latitude :longitude :elHeight]];
    d = [NSArray arrayWithObjects:y,x,h,nil];
    
    return d;
}

+(double) WGStoCHh:(double)lat :(double)lng :(double)h
{
    lat = [self DecToSexAngle:lat];
    lng = [self DecToSexAngle:lng];
    
    lat = [self SexAngleToSeconds:lat];
    lng = [self SexAngleToSeconds:lng];
    
    double lat_aux = (lat - 169028.66) / 10000;
    double lng_aux = (lng - 26782.5) / 10000;
    
    h = (h - 49.5) + (2.73 * lng_aux) + (6.94 * lat_aux);
    
    return h;
}

+(double)WGStoCHx:(double)lat :(double)lng
{
    lat = [self DecToSexAngle:lat];
    lng = [self DecToSexAngle:lng];
    
    lat = [self SexAngleToSeconds:lat];
    lng = [self SexAngleToSeconds:lng];
    
    double lat_aux = (lat - 169028.66) / 10000;
    double lng_aux = (lng - 26782.5) / 10000;
    
    double x = ((200147.07 + (308807.95 * lat_aux)
                 + (3745.25 * pow(lng_aux, 2.0)) + (76.63 * pow(lat_aux, 2.0))) - (194.56 * pow(lng_aux, 2.0) * lat_aux)) + (119.79 * pow(lat_aux, 3.0));
    
    return x;
}

+(double)WGStoChy:(double)lat :(double)lng
{
    
    lat = [self DecToSexAngle:lat];
    lng = [self DecToSexAngle:lng];
    
    lat = [self SexAngleToSeconds:lat];
    lng = [self SexAngleToSeconds:lng];
    
    double lat_aux = (lat - 169028.66) / 10000;
    double lng_aux = (lng - 26782.5) / 10000;
    
    double y = (600072.37 + (211455.93 * lng_aux))
                - (10938.51 * lng_aux * lat_aux)
                - (0.36 * lng_aux * pow(lat_aux, 2.0))
                - (44.54 * pow(lng_aux, 3.0));
    
    return y;

}


@end
