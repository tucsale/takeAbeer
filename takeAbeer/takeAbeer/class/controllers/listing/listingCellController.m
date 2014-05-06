//
//  listingCellController.m
//  take-a-beer
//
//  Created by clement on 20/10/13.
//  Copyright (c) 2013 clement Delalandre. All rights reserved.
//

#import "listingCellController.h"
#import <QuartzCore/QuartzCore.h>
#import "oBeer.h"

@implementation listingCellController

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
       
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
