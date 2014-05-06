//
//  FiltersController.h
//  Take a Beer
//
//  Created by clement on 02/06/13.
//  Copyright (c) 2013 clement Delalandre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FiltersController : UITableViewController


//@property NSMutableArray *tabFiltersDisplayed;
@property NSString *selectedFilter;
@property (strong, nonatomic) IBOutlet UITableView *tableViewFilters;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *titleFilterButton;


- (IBAction)resetFilters:(id)sender;
//- (IBAction)closeModal:(id)sender;


@end
