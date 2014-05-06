//
//  sqlBeers.h
//  Take a Beer
//
//  Created by clement on 29/11/12.
//  Copyright (c) 2012 clement Delalandre. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "sql.h"
#import "oBeer.h"


@interface sqlBeers : sql
@property(retain, nonatomic) NSMutableArray *tabBeersFromDB;
@property(retain, nonatomic)  NSArray *tabBeersToDisplay;
@property(retain, nonatomic)  NSMutableDictionary *tabBeersToDisplayWithSection;
@property(retain, nonatomic)  NSMutableArray *tabSectionToDisplay;
@property(retain, nonatomic)  NSMutableArray *tabIndexToDisplay;

-(BOOL) updateFavorite:(NSString *)numBeer withFavorite:(NSString *)favoriteBeer;

-(BOOL) updateRate:(NSString *)numBeer withRate:(NSString *)rateBeer;

-(BOOL) updateFromJSON;

-(void) initFromDb;
-(void) refreshSection: (NSString *) orderBy;
-(void) applyFilterAndOrder: (NSMutableDictionary *) filters orderBy: (NSString *) orderBy;
@end

