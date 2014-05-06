//
//  sqlFilters.m
//  Take a Beer
//
//  Created by clement on 02/06/13.
//  Copyright (c) 2013 clement Delalandre. All rights reserved.
//

#import "sqlFilters.h"
#import "sql.h"
#import <sqlite3.h>
#import "oFilter.h"

@implementation sqlFilters


-(NSArray *) readFilters: (NSString *) filterSelected{
    
    NSMutableArray *tabFilters = [[NSMutableArray alloc] init];
    NSArray *tabFiltersSorted = [[NSArray alloc] init];
    int idx = 0;
  //  NSString *counter;
 //   NSString *label;
    NSString *sqlStr;
 
    if([filterSelected isEqualToString:@"brewery"]){
      sqlStr =  @"SELECT `Breweries`.`name` AS `brewery`, COUNT(num) FROM `Beers`,`Breweries` WHERE `Beers`.`breweryId` = `Breweries`.`id` GROUP BY `Breweries`.`name` AND `display` = 1 ORDER BY `Breweries`.`name` ";
    }else{
      sqlStr = [NSString stringWithFormat:@"SELECT %@, COUNT(num) FROM `Beers` WHERE %@ NOT LIKE '' GROUP BY %@ ORDER BY %@", filterSelected,filterSelected, filterSelected, filterSelected];

    }
  	const char *sql = [sqlStr UTF8String];
    
    sqlite3_stmt *compiledStatement;
    if(sqlite3_prepare_v2(database, sql, -1, &compiledStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
            oFilter *filter = [oFilter new];
            filter.label = NSLocalizedString([NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)],nil);
            filter.counter = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
            filter.code = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
            [tabFilters insertObject:filter atIndex:idx++];
        }
        NSSortDescriptor *firstDescriptor =  [[NSSortDescriptor alloc] initWithKey:@"label" ascending:YES];
  
    
    tabFiltersSorted = [tabFilters sortedArrayUsingDescriptors: [NSArray arrayWithObjects: firstDescriptor, nil]];
        
    }else{
        NSLog(@"Error requete -> %s", sqlite3_errmsg(database) );
    }
    sqlite3_finalize(compiledStatement);
    sqlite3_close(database);
    return tabFiltersSorted;
}

@end
