//
//  socialController.h
//  take-a-beer
//
//  Created by Clement Lasnier Delalandre on 13/11/2013.
//  Copyright (c) 2013 clement Delalandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "oBeer.h"

@interface socialController : UIViewController

@property (strong, nonatomic)  oBeer *beer;

- (IBAction)postSocialNetwork:(id)sender;

@end
