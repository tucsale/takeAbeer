//
//  MenuCell.m
//  Take a Beer
//
//  Created by clement on 30/05/13.
//  Copyright (c) 2013 clement Delalandre. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell
@synthesize title;
@synthesize counter;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
