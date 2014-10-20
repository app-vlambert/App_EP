//
//  SQLmanager.m
//  App_EP
//
//  Created by Lambert Vincent on 02.10.14.
//  Copyright (c) 2014 vincent-lambert. All rights reserved.
//

#import "SQLmanager.h"

@implementation SQLmanager
@synthesize result_query;

-(id) initDatabase
{
    //Définition nom BD
    databaseName = @"database.db";
    
    //Définition du path de la BD
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    
    return self;
    
    
    
}


-(void) checkAndCreateDatabase
{
    //Variable de vérification de présence de la BD
    
    BOOL success;
    
    NSFileManager *filemanager = [NSFileManager defaultManager];
    
    //Vérification
    
    success = [filemanager fileExistsAtPath:databasePath];
    
    if(success)
    {
        return;
    } else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"La base de données n'est pas présente" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
}

-(NSArray*)query:(NSString *)sql
{
    sqlite3 *database;
    int type;
    int pos;
    int j;
    
    result_query = [[NSMutableArray alloc] init];
    
    
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        const char* sql_char = [sql UTF8String];
        //création d'un statement permettant de connaitre le status de l'éxécution
        sqlite3_stmt *compiledStatement;
        int test = sqlite3_prepare_v2(database, sql_char, -1, &compiledStatement, NULL);
        if(sqlite3_prepare_v2(database, sql_char, -1, &compiledStatement, NULL) ==SQLITE_OK)
        {
            //fonction de bouclage tant qu'il y a des lignes dans le result
            while(sqlite3_step(compiledStatement) == SQLITE_ROW)
            {
                pos = sqlite3_column_count(compiledStatement);
                NSMutableArray *columns = [[NSMutableArray alloc] initWithCapacity:pos];
                for(j = 0; j < pos; j++)
                {
                    type = sqlite3_column_type(compiledStatement, j);
                    switch (type)
                    {
                        case SQLITE_INTEGER :
                                                [columns addObject:[NSNumber numberWithInt:sqlite3_column_int(compiledStatement, j)]];
                                                break;
                        case SQLITE_FLOAT   :   [columns addObject:[NSNumber numberWithFloat:sqlite3_column_double  (compiledStatement, j)]];
                                                break;
                        case SQLITE_TEXT    :   [columns addObject:[NSString stringWithUTF8String:(char*)sqlite3_column_text(compiledStatement, j)]];
                                                break;

                        case SQLITE_NULL    :   [columns addObject:@""];
                                                break;
                        default             :   [columns addObject:@""];
                    
                    }
                    
                    
                    
                }
                [result_query addObject:[columns mutableCopy]];                
            }
            sqlite3_finalize(compiledStatement);
        }
        sqlite3_close(database);
        
        
    }
    
    return result_query;
}
@end