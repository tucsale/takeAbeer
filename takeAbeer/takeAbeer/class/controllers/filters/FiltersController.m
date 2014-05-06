//
//  FiltersController.m
//  Take a Beer
//
//  Created by clement on 02/06/13.
//  Copyright (c) 2013 clement Delalandre. All rights reserved.
//

#import "FiltersController.h"
#import "CDELAppDelegate.h"
#import "FiltersCell.h"
#import "sqlFilters.h"
#import "menuController.h"
#import "oFilter.h"

@interface FiltersController ()
@end

@implementation FiltersController{
    NSMutableArray *tabSelectedFilters;
    NSArray *searchResults;
    UILabel *titleFilterLabel;
    NSArray *tabFilters;
  //  NSMutableArray *tabFiltersDisplayed;
}



-(void) refreshData{
    
    CDELAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    sqlFilters *oSqlFilters = [[sqlFilters alloc] init];
    
    tabSelectedFilters = [appDelegate.appFilters objectForKey:_selectedFilter] ;
    if(tabSelectedFilters == nil){
        tabSelectedFilters = [[NSMutableArray alloc] init];
    }
    [self refreshTitle];
   tabFilters = [oSqlFilters readFilters:_selectedFilter];
   // tabFiltersDisplayed = [tabFilters mutableCopy];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refreshData];
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = YES;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:99.0/255.0 green:36.0/255.0 blue:8.0/255.0 alpha:1.0];
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:99.0/255.0 green:36.0/255.0 blue:8.0/255.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
      if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        return [tabFilters count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"FiltersCell";
    
    FiltersCell *cell = (FiltersCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[FiltersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    oFilter *filter = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        filter = [searchResults objectAtIndex:indexPath.row];
    } else {
        filter = [tabFilters objectAtIndex:indexPath.row];
       
    }
  
    cell.label.text = filter.label;
    cell.counter.text = filter.counter;
    NSString *flagImageName;

    if([_selectedFilter isEqualToString:@"country"]){
        flagImageName = [[NSString alloc] initWithFormat:@"%@.png", filter.code];
    }else if ([_selectedFilter isEqualToString:@"brewery"]){
        flagImageName = @"factory";
    }else if ([_selectedFilter isEqualToString:@"color"]){
        flagImageName = @"paint";
    }else{
        flagImageName = @"erlenmeyer";
    }
    cell.icon.image = [UIImage imageNamed: flagImageName];
    if ([tabSelectedFilters containsObject:filter.code]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else  {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    oFilter *filter = nil;
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        filter = [searchResults objectAtIndex:indexPath.row];
    } else {
        filter = [tabFilters objectAtIndex:indexPath.row];
        
    }
    if ([selectedCell accessoryType] == UITableViewCellAccessoryNone) {
        [selectedCell setAccessoryType:UITableViewCellAccessoryCheckmark];
        [tabSelectedFilters addObject:filter.code];
    }
    else {
        [selectedCell setAccessoryType:UITableViewCellAccessoryNone];
        [tabSelectedFilters removeObject:filter.code];
    }
    [self refreshTitle];
}

-(void) viewWillDisappear:(BOOL)animated {
    //if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        CDELAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        [appDelegate.appFilters setObject:tabSelectedFilters forKey:_selectedFilter];
    //}
    [super viewWillDisappear:animated];
}


#pragma mark - Searching


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
     tabFilters = [tabFilters mutableCopy];
    [self refreshTitle];
     [self.tableView reloadData];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"label contains[c] %@", searchString];
    searchResults = [tabFilters filteredArrayUsingPredicate:resultPredicate];

    
    return YES;
}


#pragma mark - IBAction
- (IBAction)resetFilters:(id)sender {
    [tabSelectedFilters removeAllObjects];
    [self refreshTitle];
    [self.tableView reloadData];
}


-(void)refreshTitle{
    _titleFilterButton.title  = [[NSString alloc] initWithFormat:@"nb de filtres: %lu", (unsigned long)[tabSelectedFilters count]];

}
@end
