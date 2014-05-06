//
//  oBeer.h
//  Take a Beer
//
//  Created by clement on 29/11/12.
//  Copyright (c) 2012 clement Delalandre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface oBeer : NSObject

@property(retain, nonatomic) NSString *num;
@property(retain, nonatomic) NSString *name;
@property(retain, nonatomic) NSString *color;
@property(retain, nonatomic) NSString *type;
@property(retain, nonatomic) NSString *fermentation;
@property(retain, nonatomic) NSString *alcoholic;
@property(retain, nonatomic) NSString *description;
@property(retain, nonatomic) NSString *breweryId;
@property(retain, nonatomic) NSString *brewery;
@property(retain, nonatomic) NSString *country;
@property(retain, nonatomic) NSString *address;
@property(retain, nonatomic) NSString *city;
@property(retain, nonatomic) NSString *postal;
@property(retain, nonatomic) NSString *phone;
@property(retain, nonatomic) NSString *rate;
@property(retain, nonatomic) NSString *favorite;


-(void) lineToBeer: (sqlite3_stmt *)compiledStatement;
-(void) updateFavorite;
-(void) updateRate:(NSString *)rateBeer;

@end
