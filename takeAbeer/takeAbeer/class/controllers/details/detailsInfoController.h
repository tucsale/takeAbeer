//
//  detailsInfoController.h
//  take-a-beer
//
//  Created by clement on 17/10/13.
//  Copyright (c) 2013 clement Delalandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "oBeer.h"


@interface detailsInfoController : UIViewController

@property(retain, nonatomic) oBeer *beer;


@property(weak,nonatomic) IBOutlet UILabel *num;
@property(weak,nonatomic) IBOutlet UILabel *name;
@property(weak,nonatomic) IBOutlet UILabel *brewery;
@property(weak,nonatomic) IBOutlet UILabel *color;
@property(weak,nonatomic) IBOutlet UILabel *fermentation;
@property(weak,nonatomic) IBOutlet UILabel *type;
@property(weak,nonatomic) IBOutlet UILabel *country;
@property(weak,nonatomic) IBOutlet UILabel *update;
@property(weak,nonatomic) IBOutlet UILabel *alcoholic;


@end
