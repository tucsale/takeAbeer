//
//  listingController.h
//  take-a-beer
//
//  Created by clement on 20/10/13.
//  Copyright (c) 2013 clement Delalandre. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface listingController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableViewBeer;

-(void) refreshData;
- (IBAction)resetFilters:(id)sender;
@end
