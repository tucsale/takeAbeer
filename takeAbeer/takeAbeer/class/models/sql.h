//
//  sql.h
//  Take a Beer
//
//  Created by clement on 28/12/12.
//  Copyright (c) 2012 clement Delalandre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
//#import "oBeer.h"

@interface sql : NSObject{
   sqlite3 *database;
}

-(void)createEditableCopyOfDatabaseIfNeeded;


@end
