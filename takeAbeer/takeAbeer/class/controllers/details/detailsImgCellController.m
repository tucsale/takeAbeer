//
//  detailsImgCellController.m
//  takeAbeer
//
//  Created by Clement Lasnier Delalandre on 06/05/2014.
//  Copyright (c) 2014 Clement Lasnier Delalandre. All rights reserved.
//

#import "detailsImgCellController.h"

@implementation detailsImgCellController

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
            _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
            //_imageView.contentMode = UIViewContentModeScaleAspectFit;
            [self addSubview:_imageView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
