//
//  sqlFilters.h
//  Take a Beer
//
//  Created by clement on 02/06/13.
//  Copyright (c) 2013 clement Delalandre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sql.h"

@interface sqlFilters : sql

-(NSArray *) readFilters: (NSString *) filterSelected;
@end
