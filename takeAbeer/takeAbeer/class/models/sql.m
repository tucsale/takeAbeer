//
//  sql.m
//  Take a Beer
//
//  Created by clement on 28/12/12.
//  Copyright (c) 2012 clement Delalandre. All rights reserved.
//

#import "sql.h"
//#import <sqlite3.h>

//static sqlite3 *database = nil;

@implementation sql

-(id)init
{
    if (self = [super init])
    {
        if(database == nil){
            [self createEditableCopyOfDatabaseIfNeeded];
            // The database is stored in the application bundle.
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *path = [documentsDirectory stringByAppendingPathComponent:@"takeabeer.sqlite"];
            
            if(!(sqlite3_open([path UTF8String], &database) == SQLITE_OK))  {
                 sqlite3_close(database);
                NSLog(@"An error has occured: %s", sqlite3_errmsg(database));
                
            }
        }
    }
    return self;
}

// Creates a writable copy of the bundled default database in the application Documents directory.
- (void)createEditableCopyOfDatabaseIfNeeded {
    // First, test for existence.
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"takeabeer.sqlite"];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success) return;
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"takeabeer.sqlite"];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}
@end
