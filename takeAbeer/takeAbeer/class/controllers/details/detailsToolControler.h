//
//  detailsToolControler.h
//  take-a-beer
//
//  Created by clement on 17/10/13.
//  Copyright (c) 2013 clement Delalandre. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "oBeer.h"
@interface detailsToolControler : UIViewController

//@property(weak,nonatomic) IBOutlet UIStepper *stepper;
@property (strong, nonatomic)  oBeer *beer;

- (IBAction)searchTheSameType:(id)sender;
- (IBAction)searchTheSameBrewery:(id)sender;

@end
