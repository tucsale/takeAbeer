//
//  sqlBeers.m
//  Take a Beer
//
//  Created by clement on 29/11/12.
//  Copyright (c) 2012 clement Delalandre. All rights reserved.
//

#import "sqlBeers.h"
#import <sqlite3.h>
#import "oBeer.h"
#import "sql.h"

@implementation sqlBeers{
    
    NSArray *tabTmpSection;
    
}
-(id)init
{
    if (self = [super init]){
        tabTmpSection = [[NSArray alloc] initWithObjects:@"#",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",
                         @"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",
                         @"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
        [self initFromDb];
        
        
    }
    return self;
}



-(BOOL) updateFavorite:(NSString *)numBeer withFavorite:(NSString *)favoriteBeer{
    
	NSString *sqlStr = [NSString stringWithFormat:@"UPDATE `Favorites` SET `favorite`='%@' WHERE beerId='%@'", favoriteBeer, numBeer];
	const char *sql = [sqlStr UTF8String];
    sqlite3_stmt *update_statement;
	if (sqlite3_prepare_v2(database, sql, -1, &update_statement, NULL) != SQLITE_OK) {
#ifdef DEBUG
		NSLog(@"Error requete -> %s", sqlite3_errmsg(database) );
#endif
		return NO;
	}
	
	int success = sqlite3_step(update_statement);
	if (success == SQLITE_ERROR) {
#ifdef DEBUG
        NSLog(@"Error requete -> %s", sqlite3_errmsg(database) );
#endif
		
		return NO;
	}
#ifdef DEBUG
    NSLog(@"SQL -> %@", sqlStr);
#endif
	
	sqlite3_finalize(update_statement);
     [self initFromDb];
    sqlite3_close(database);
   

	return YES;
}

-(BOOL) updateRate:(NSString *)numBeer withRate:(NSString *)rateBeer{
    
	NSString *sqlStr = [NSString stringWithFormat:@"UPDATE `Rates` SET `rate`='%@' WHERE beerId='%@'", rateBeer, numBeer];
	const char *sql = [sqlStr UTF8String];
    sqlite3_stmt *update_statement;
	if (sqlite3_prepare_v2(database, sql, -1, &update_statement, NULL) != SQLITE_OK) {
           #ifdef DEBUG
		NSLog(@"Error requete -> %s", sqlite3_errmsg(database) );
#endif
		return NO;
	}
	
	int success = sqlite3_step(update_statement);
	if (success == SQLITE_ERROR) {
 #ifdef DEBUG
        NSLog(@"Error requete -> %s", sqlite3_errmsg(database) );
#endif
		
		return NO;
	}
 #ifdef DEBUG
   	NSLog(@"SQL -> %@", sqlStr);
#endif
    
	sqlite3_finalize(update_statement);
      [self initFromDb];
    sqlite3_close(database);
    
    //@TODO BS
  
	return YES;
}

-(BOOL) updateFromJSON{
    NSError *error;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.takeabeer.com/api.php"]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    //@todo BS: next Version
    //Convert UTF8
    NSString *responsestring = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    NSLog(@"%@", responsestring);
    
    NSData *JSONdata = [responsestring dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *e = nil;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: JSONdata options: kNilOptions error: &error];
    NSLog(@"Item: %@", jsonArray);
    //NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    //NSArray *jsonArray =
    if (!jsonArray) {
        NSLog(@"Error parsing JSON: %@", e);
        return FALSE;
    }
    NSString *sqlStrTmp;
    NSString *sqlStr = @"";
    for(NSDictionary *item in jsonArray) {
        sqlStrTmp = [NSString stringWithFormat:@"INSERT OR IGNORE INTO `beer` (`id`,`num`, `name`,`type`,`color`,`fermentation`,`alcoholic`,`country`,`description`,`breweryId`,`dateUpdate`,`display`) VALUES ('%@', '%@', '%@', '%@','%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@');",
                     [[item objectForKey:@"id"] stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"],
                     [[item objectForKey:@"num"] stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"],
                     [[item objectForKey:@"name"] stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"],
                     [[item objectForKey:@"type"] stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"],
                     [[item objectForKey:@"color"] stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"],
                     [[item objectForKey:@"fermentation"] stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"],
                     [[item objectForKey:@"alcoholic"] stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"],
                     [[item objectForKey:@"country"] stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"],
                     [[item objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"],
                     [[item objectForKey:@"breweryId"] stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"],
                     [[item objectForKey:@"dateUpdate"] stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"],
                     [[item objectForKey:@"display"] stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"]];
        sqlStr = [sqlStr stringByAppendingString:sqlStrTmp];
        
        sqlStrTmp = [NSString stringWithFormat:@"UPDATE `beer` SET `name` = '%@', `type` = '%@', `color` = '%@', `fermentation` = '%@', `alcoholic` = '%@', `country` = '%@', `description` = '%@', `breweryId` = '%@', `dateUpdate` = '%@' , `display` = '%@'WHERE `id` = '%@';",
                     [[item objectForKey:@"name"] stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"],
                     [[item objectForKey:@"type"] stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"],
                     [[item objectForKey:@"color"] stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"],
                     [[item objectForKey:@"fermentation"] stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"],
                     [[item objectForKey:@"alcoholic"] stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"],
                     [[item objectForKey:@"country"] stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"],
                     [[item objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"],
                     [[item objectForKey:@"breweryId"] stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"],
                     [[item objectForKey:@"dateUpdate"] stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"],
                     [[item objectForKey:@"display"] stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"],
                     [[item objectForKey:@"num"] stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"]];
        sqlStr = [sqlStr stringByAppendingString:sqlStrTmp];
        NSLog(@"Item: %@", item);
    }
    
    if(![sqlStr isEqualToString:@""]){
        // const char *sql = [sqlStr UTF8String];
        const char *sql = [sqlStr cStringUsingEncoding:NSASCIIStringEncoding];
        // NSString *correctString = [NSString stringWithCString:[sqlStr cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding];
        //const char *sql = [correctString UTF8String];
        NSLog(@"SQL -> %s", sql);
        
        sqlite3_stmt *update_statement;
        if (sqlite3_prepare_v2(database, sql, -1, &update_statement, NULL) != SQLITE_OK) {
            NSLog(@"Error requete -> %s", sqlite3_errmsg(database) );
            return NO;
        }
        NSLog(@"SQL -> %s", sql);
        int success = sqlite3_step(update_statement);
        if (success == SQLITE_ERROR) {
            NSLog(@"Error requete -> %s", sqlite3_errmsg(database) );
            return NO;
        }
        NSLog(@"SQL -> %@", sqlStr);
        sqlite3_finalize(update_statement);
        sqlite3_close(database);
    }
    return YES;
    
}


-(void) initFromDb{
    tabTmpSection = [[NSArray alloc] initWithObjects:@"#",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",
                     @"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",
                     @"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
    NSString *sql = @"SELECT `num`,`Beers`.`name`, `color`,`type`,`fermentation`,`alcoholic`,`description`,`breweryId`,`Breweries`.`name` AS `brewery`,`Beers`.`country`,`address`, `city`,`postal`, `phone`,`rate`,`favorite` FROM  `Beers` LEFT  JOIN `Breweries` ON Breweries.id = `Beers`.`breweryId` LEFT  JOIN `Rates` ON `Rates`.`beerId` = `Beers`.`id` LEFT  JOIN `Favorites` ON `Favorites`.`beerId` = `Beers`.`id` AND `Beers`.`name` LIKE 'T%' ORDER BY `num` ";
    
    const char *sqlStatement = [sql UTF8String];
    _tabBeersFromDB = [NSMutableArray new];
 	
    sqlite3_stmt *compiledStatement;
    if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
            oBeer *beer = [oBeer new];
            [beer lineToBeer:compiledStatement];
            
            [_tabBeersFromDB addObject:beer];
            
        }
    }else{
        NSLog(@"Error requete initFromDb -> %s", sqlite3_errmsg(database) );
        sqlite3_close(database);
        
    }
    if (compiledStatement) {
        sqlite3_finalize(compiledStatement);
    }
}

-(void) applyFilterAndOrder: (NSMutableDictionary *) filters orderBy: (NSString *) orderBy{

    _tabSectionToDisplay = [NSMutableArray new];
    _tabIndexToDisplay = [NSMutableArray new];
    _tabBeersToDisplayWithSection = [NSMutableDictionary new];
    NSMutableArray *subpredicates = [NSMutableArray new];
    NSMutableArray *subpredicatesMultiCrit = [NSMutableArray new];
    NSArray *keys = [filters allKeys];
    
    // values in foreach loop
    for (NSString *key in keys) {
        if([[filters objectForKey:key] isKindOfClass:[NSString class]]){
            if(![[filters objectForKey:key] isEqualToString:@""]){
                [subpredicates addObject:[NSPredicate predicateWithFormat:@" %K contains[c] %@ ", key, [filters objectForKey:key]]];
            }
        }else{
            if([filters objectForKey:key] == nil || [[filters objectForKey:key] count] <= 0 )
                continue;
            [subpredicatesMultiCrit removeAllObjects];
            for (NSString *filterActif in [filters objectForKey:key]){
                [subpredicatesMultiCrit addObject:[NSPredicate predicateWithFormat:@"%K like[cd] %@ ", key, filterActif]];
            }
            if(subpredicatesMultiCrit != nil){
                [subpredicates addObject:[NSCompoundPredicate orPredicateWithSubpredicates:subpredicatesMultiCrit]];
            }
        }
    }
    
    
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:subpredicates];
    
    _tabBeersToDisplay = [_tabBeersFromDB filteredArrayUsingPredicate:predicate];
#ifdef DEBUG
    NSLog(@"predicate %@", predicate);
#endif
    
    if([_tabBeersToDisplay count] > 0){
        if ([orderBy isEqualToString:@"goRandom"]) {
            NSMutableArray *arrayForTmp = [_tabBeersToDisplay copy];
            for (int x = 0; x < [arrayForTmp count]; x++) {
                int randInt = (arc4random() % ([arrayForTmp count] - x)) + x;
                [arrayForTmp exchangeObjectAtIndex:x withObjectAtIndex:randInt];
            }
            _tabBeersToDisplay = [arrayForTmp copy];
        }else{
            NSSortDescriptor *firstDescriptor = nil;
            if ([orderBy isEqualToString:@"goCountry"]) {
                firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"country" ascending:YES];
                
            } else if ([orderBy isEqualToString:@"goBrewery"]) {
                firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"brewery" ascending:YES];
                
            } else if ([orderBy isEqualToString:@"goType"]) {
                firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"type" ascending:YES];
            }else{
                firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
            }
            
            _tabBeersToDisplay = [_tabBeersToDisplay sortedArrayUsingDescriptors: [NSArray arrayWithObjects: firstDescriptor, nil]];
            
        }
        [self refreshSection:orderBy];
    }
    
}

-(void) refreshSection: (NSString *) orderBy{
    int i = 0;
    int cpt;
    NSString *oldKey = nil;
    NSString *key;
    NSString *oldIndexKey;
    NSString *indexKey;
    NSMutableArray *tabTmpBeer = [NSMutableArray new];
    NSMutableDictionary *dicIndex;
    
    //  tabTmpSection = [NSArray new];
    for (cpt = 0 ; cpt < [_tabBeersToDisplay count] ; cpt++) {
        
        
        oBeer *beer = [oBeer alloc];
        
        beer = [_tabBeersToDisplay objectAtIndex:cpt];
        NSInteger indexOfTheObject = NSNotFound;
        if ([orderBy isEqualToString:@"goCountry"]) {
            key = NSLocalizedString(beer.country, nil);
        } else if ([orderBy isEqualToString:@"goBrewery"]) {
            key = beer.brewery;
        } else if ([orderBy isEqualToString:@"goType"]) {
            key = beer.type;
        } else if ([orderBy isEqualToString:@"goRandom"]) {
            key = @"Aléatoire";
        }else  {
            indexOfTheObject = [tabTmpSection indexOfObject: [[beer.name uppercaseString] substringToIndex:1]];
            if(indexOfTheObject == NSNotFound){
                // key = @" un chiffre";
                key = @"#";
            }else{
                key = [tabTmpSection objectAtIndex:indexOfTheObject];
            }
        }
        
        if(oldKey == nil){
            oldKey = key;
        }
        if(!([oldKey isEqualToString:key])){
            [_tabBeersToDisplayWithSection setObject:[tabTmpBeer copy] forKey:oldKey];
            [tabTmpBeer removeAllObjects];
            [_tabSectionToDisplay addObject:oldKey];
            oldKey = key;
            i++;
        }
        [tabTmpBeer addObject:beer];
        
        //Index
        if([key length] < 1){
            indexKey = @"#";
        }else{
            indexOfTheObject = [tabTmpSection indexOfObject: [key substringToIndex:1]];
            if(indexOfTheObject == NSNotFound){
                indexKey = @"#";
            }else{
                indexKey = [tabTmpSection objectAtIndex:indexOfTheObject];
            }
        }
        if(oldIndexKey == nil || !([oldIndexKey isEqualToString:indexKey])){
            dicIndex = [[NSMutableDictionary alloc] init];
            [dicIndex setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[_tabSectionToDisplay count]] forKey:@"index"];
            [dicIndex setValue:indexKey forKey:@"label"];
            
            [_tabIndexToDisplay addObject:dicIndex];
            oldIndexKey = indexKey;
            
        }
        
    }
    [_tabBeersToDisplayWithSection setObject:[tabTmpBeer copy] forKey:oldKey];
    [tabTmpBeer removeAllObjects];
    [_tabSectionToDisplay addObject:oldKey];
    
}

@end