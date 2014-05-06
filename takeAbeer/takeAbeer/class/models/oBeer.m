//
//  oBeer.m
//  Take a Beer
//
//  Created by clement on 29/11/12.
//  Copyright (c) 2012 clement Delalandre. All rights reserved.
//


#import "oBeer.h"
#import <sqlite3.h>
#import "sqlBeers.h"

@implementation oBeer




-(void) lineToBeer: (sqlite3_stmt *)compiledStatement{
    char *tempString;
    int i = 0;
    
    tempString = (char *)sqlite3_column_text(compiledStatement, i);
    if (tempString == NULL){
        self.num = @"";
    }else{
        self.num = [NSString stringWithUTF8String: tempString];
    }
    i++;
    tempString = (char *)sqlite3_column_text(compiledStatement, i);
    if (tempString == NULL){
        self.name = @"";
    }else{
        self.name = [NSString stringWithUTF8String: tempString];
    }
    i++;
    tempString = (char *)sqlite3_column_text(compiledStatement, i);
    if (tempString == NULL){
        self.color = @"";
    }else{
        self.color = [NSString stringWithUTF8String: tempString];
    }
    i++;
    
    tempString = (char *)sqlite3_column_text(compiledStatement, i);
    if (tempString == NULL){
        self.type = @"";
    }else{
        self.type = [NSString stringWithUTF8String: tempString];
    }
    i++;
    
    tempString = (char *)sqlite3_column_text(compiledStatement, i);
    if (tempString == NULL){
        self.fermentation = @"";
    }else{
        self.fermentation = [NSString stringWithUTF8String: tempString];
    }
    i++;
    
    tempString = (char *)sqlite3_column_text(compiledStatement, i);
    if (tempString == NULL){
        self.alcoholic = @"";
    }else{
        self.alcoholic = [NSString stringWithUTF8String: tempString];
    }
    i++;
    
    tempString = (char *)sqlite3_column_text(compiledStatement, i);
    if (tempString == NULL){
        
        
        
        self.description = @"";
    }else{
        self.description = [NSString stringWithUTF8String: tempString];
    }
    i++;
    tempString = (char *)sqlite3_column_text(compiledStatement, i);
    if (tempString == NULL){
        self.breweryId = @"";
    }else{
        self.breweryId = [NSString stringWithUTF8String: tempString];
    }
    i++;
    tempString = (char *)sqlite3_column_text(compiledStatement, i);
    if (tempString == NULL){
        self.brewery = @"";
    }else{
        self.brewery = [NSString stringWithUTF8String: tempString];
    }
    i++;
    tempString = (char *)sqlite3_column_text(compiledStatement, i);
    if (tempString == NULL){
        self.country = @"";
    }else{
        self.country = [NSString stringWithUTF8String: tempString];
    }
    i++;
    tempString = (char *)sqlite3_column_text(compiledStatement, i);
    if (tempString == NULL){
        self.address = @"";
    }else{
        self.address = [NSString stringWithUTF8String: tempString];
    }
    i++;
    tempString = (char *)sqlite3_column_text(compiledStatement, i);
    if (tempString == NULL){
        self.city = @"";
    }else{
        self.city = [NSString stringWithUTF8String: tempString];
    }
    i++;
    tempString = (char *)sqlite3_column_text(compiledStatement, i);
    if (tempString == NULL){
        self.postal = @"";
    }else{
        self.postal = [NSString stringWithUTF8String: tempString];
    }
    i++;
    tempString = (char *)sqlite3_column_text(compiledStatement, i);
    if (tempString == NULL){
        self.phone = @"";
    }else{
        self.phone = [NSString stringWithUTF8String: tempString];
    }
    i++;
    tempString = (char *)sqlite3_column_text(compiledStatement, i);
    if (tempString == NULL){
        self.rate = @"0";
    }else{
        self.rate = [NSString stringWithUTF8String: tempString];
    }
    i++;
    tempString = (char *)sqlite3_column_text(compiledStatement, i);
    if (tempString == NULL){
        self.favorite = @"0";
    }else{
        self.favorite = [NSString stringWithUTF8String: tempString];
    }
    i++;
}

-(void) updateFavorite{
    if([self.favorite isEqualToString:@"0"]){
        self.favorite = @"1";
    }else{
        self.favorite = @"0";
    }
    
    sqlBeers *sqlBeer = [[sqlBeers alloc] init];
    [sqlBeer updateFavorite:self.num withFavorite:self.favorite];
}

-(void) updateRate:(NSString *)rateBeer{
    
    self.rate = rateBeer;
    sqlBeers *sqlBeer = [[sqlBeers alloc] init];
    [sqlBeer updateRate:self.num withRate:self.rate];
    
}

@end
