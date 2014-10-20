//
//  SQLmanager.h
//  App_EP
//
//  Created by Lambert Vincent on 02.10.14.
//  Copyright (c) 2014 vincent-lambert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface SQLmanager : NSObject
{
    //Variables propres à BD
    NSString *databaseName;
    NSString *databasePath;
    
    //Variables de stockage des résultats de requêtes
    
    NSMutableArray *result_query;
}

@property (nonatomic, retain) NSMutableArray *result_query;

-(id) initDatabase;
-(void) checkAndCreateDatabase;
-(NSArray*) query :(NSString *) sql;

@end
