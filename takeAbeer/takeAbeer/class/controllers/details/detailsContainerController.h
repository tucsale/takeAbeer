//
//  detailsContainerController.h
//  take-a-beer
//
//  Created by clement on 17/10/13.
//  Copyright (c) 2013 clement Delalandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "oBeer.h"

@interface detailsContainerController : UIViewController

@property (retain,nonatomic) oBeer *beer;
- (void)swapViewControllers:(NSString *)segueIdentifier;


@end
