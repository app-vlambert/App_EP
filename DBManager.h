//
//  DBManager.h
//  App_EP
//
//  Created by Lambert Vincent on 22/09/14.
//  Copyright (c) 2014 vincent-lambert. All rights reserved.
//
//go
#import <Foundation/Foundation.h>
#import <sqlite3.h>



@interface DBManager : NSObject
{
    NSString *databasePath;

    
}

+(DBManager*) getsharedInstance;
-(BOOL)createDB;


@end
