//
//  menuController.h
//  take-a-beer
//
//  Created by clement on 20/10/13.
//  Copyright (c) 2013 clement Delalandre. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface menuController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *content;
@property (strong, nonatomic) IBOutlet UITableView *menuTable;

- (void)showMenuDown;




@end
