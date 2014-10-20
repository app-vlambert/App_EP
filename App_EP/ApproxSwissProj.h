//
//  ApproxSwissProj.h
//  App_EP
//
//  Created by Lambert Vincent on 22/09/14.
//  Copyright (c) 2014 vincent-lambert. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ApproxSwissProj : NSObject {
    double y_aux;
    double x_aux;
    double h;
    double lat;
    double lng;
    double x;
    double y;
    int deg;
    int min;
    double sec;
    NSArray* d;
}
-(id) init;
+(double) CHtoWGSheight: (double) y : (double) x :(double) h ;
+(double) CHtoWGSlat:(double) y : (double) x;
+(double) CHtoWGSlng:(double) y : (double) x;
+(double) DecToSexAngle:(double) dec;
+(NSArray*) LV03toWGS84:(double) east : (double) north : (double) height;
+(double) SexAngleToSeconds:(double) dms;
+(double) SexToDecAngle : (double) dms;
+(NSArray*) WGS84toLV03 : (double) latitude : (double) longitude : (double) elHeight;
+(double) WGStoCHh : (double) lat : (double) lng : (double) h;
+(double) WGStoCHx : (double) lat : (double) lng;
+(double) WGStoChy : (double) lat : (double) lng;
@end
