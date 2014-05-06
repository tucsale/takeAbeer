//
//  listingCellController.h
//  take-a-beer
//
//  Created by clement on 20/10/13.
//  Copyright (c) 2013 clement Delalandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "oBeer.h"

@interface listingCellController : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *nameText;
@property (strong, nonatomic) IBOutlet UILabel *breweryText;
@property (strong, nonatomic) IBOutlet UIImageView *imgImage;
@property (strong, nonatomic) IBOutlet UIImageView *imgRating;
@property (strong, nonatomic) IBOutlet UIImageView *imgCellFavorite;
@property (strong, nonatomic) IBOutlet UIImageView *imgFlag;
@property (nonatomic, retain) oBeer *beer;

@end
