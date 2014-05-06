//
//  detailsDescriptionController.h
//  take-a-beer
//
//  Created by clement on 17/10/13.
//  Copyright (c) 2013 clement Delalandre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface detailsDescriptionController : UIViewController

@property (retain, nonatomic) NSString *tmpDescription;
@property (weak, nonatomic) IBOutlet UITextView *descriptionText;
@end
