//
//  detailsBreweryController.h
//  take-a-beer
//
//  Created by Clement Lasnier Delalandre on 02/05/2014.
//  Copyright (c) 2014 clement Delalandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "oBeer.h"

@interface detailsBreweryController : UIViewController

@property(strong, nonatomic) oBeer *beer;
@property(weak,nonatomic) IBOutlet UILabel *name;
@property(weak,nonatomic) IBOutlet UILabel *brewery;
@property(weak,nonatomic) IBOutlet UILabel *country;
@property(weak,nonatomic) IBOutlet UILabel *address;
@property(weak,nonatomic) IBOutlet UILabel *phone;
@property(weak,nonatomic) IBOutlet UILabel *postal;
@property(weak,nonatomic) IBOutlet UILabel *city;
@end
