//
//  listingController.m
//  take-a-beer
//
//  Created by clement on 20/10/13.
//  Copyright (c) 2013 clement Delalandre. All rights reserved.
//

#import "listingController.h"
#import "listingCellController.h"
#import "CDELAppDelegate.h"
#import "sqlBeers.h"
#import "detailsController.h"
#import "menuCell.h"
#import "WebController.h"
#import "FiltersController.h"
#import "menuController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
//#import "navigationController.h"


#define SegueDetails @"detailsSegue"
#define filterByType @"filterByType"
#define filterByBrewery @"filterByBrewery"
#define filterByColor @"filterByColor"


#define filterByCountry @"filterByCountry"


@interface listingController ()
@property (strong,nonatomic) NSArray *menuArray; //array for menu
@property(retain, nonatomic) NSMutableDictionary *tabBeers;
//@property(retain, nonatomic) NSArray *tabBeersBrut;
//@property(retain, nonatomic) NSArray *tabSection;
//@property(retain, nonatomic) NSArray *tabIndex;
@property(retain, nonatomic) NSString *searchString;
@property(retain, nonatomic) NSString *displayModel;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;


@end

@implementation listingController{
    NSArray *tabImgRating;
    UISearchBar *searchBarTop;
    UIBarButtonItem *orderButton;
    UIBarButtonItem *searchButton;
    UIBarButtonItem *searchBarItem;
    UISegmentedControl *segmentedOrder;
    UIBarButtonItem *orderBarItem;
    sqlBeers *oSqlBeers;
    NSArray *searchResults;
    NSArray *tabBeersBrut;
    NSArray *tabIndex;
    NSArray *tabSection;
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

#pragma mark - Data refresh
-(void) refreshData{
    
    CDELAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    oSqlBeers = [[sqlBeers alloc] init];
    [oSqlBeers initFromDb];
    
    _searchString = @"";
    [oSqlBeers applyFilterAndOrder:appDelegate.appFilters orderBy:appDelegate.appOrderBy];

    tabSection  = [oSqlBeers tabSectionToDisplay];
   
    _tabBeers  = [oSqlBeers tabBeersToDisplayWithSection];
    tabIndex  = [oSqlBeers tabIndexToDisplay];

    tabBeersBrut = [oSqlBeers tabBeersToDisplay];
    if([[appDelegate.appFilters objectForKey:@"brewery"] count]  == 0){
        [self.navigationController.toolbar.items[0] setTintColor:[UIColor lightGrayColor]];
        
    }else{
        [self.navigationController.toolbar.items[0] setTintColor:[UIColor colorWithRed:99.0/255.0 green:36.0/255.0 blue:8.0/255.0 alpha:1]];
        
    }
    if([[appDelegate.appFilters objectForKey:@"type"] count]  == 0){
        [self.navigationController.toolbar.items[2] setTintColor:[UIColor lightGrayColor]];
        
    }else{
        [self.navigationController.toolbar.items[2] setTintColor:[UIColor colorWithRed:99.0/255.0 green:36.0/255.0 blue:8.0/255.0 alpha:1]];
        
    }
    if([[appDelegate.appFilters objectForKey:@"color"] count]  == 0){
        [self.navigationController.toolbar.items[4] setTintColor:[UIColor lightGrayColor]];
        
    }else{
        [self.navigationController.toolbar.items[4] setTintColor:[UIColor colorWithRed:99.0/255.0 green:36.0/255.0 blue:8.0/255.0 alpha:1]];
        
    }
    if([[appDelegate.appFilters objectForKey:@"country"] count]  == 0){
        [self.navigationController.toolbar.items[6] setTintColor:[UIColor lightGrayColor]];
        
    }else{
        [self.navigationController.toolbar.items[6] setTintColor:[UIColor colorWithRed:99.0/255.0 green:36.0/255.0 blue:8.0/255.0 alpha:1]];
        
    }
    //  [self.navigationController.toolbar.items[1] setTintColor:[UIColor greenColor]];
    
}
- (IBAction)resetFilters:(id)sender {
    CDELAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate.appFilters setObject:@"" forKey:@"name"];
    [appDelegate.appFilters setObject:[[NSMutableArray alloc] initWithObjects: nil] forKey:@"type"];
    [appDelegate.appFilters setObject:[[NSMutableArray alloc] initWithObjects: nil] forKey:@"fermentation"];
    [appDelegate.appFilters setObject:[[NSMutableArray alloc] initWithObjects: nil] forKey:@"alcoholic"];
    [appDelegate.appFilters setObject:[[NSMutableArray alloc] initWithObjects: nil] forKey:@"brewery"];
    [appDelegate.appFilters setObject:[[NSMutableArray alloc] initWithObjects: nil] forKey:@"country"];
    [appDelegate.appFilters setObject:[[NSMutableArray alloc] initWithObjects: nil] forKey:@"favorite"];
    [appDelegate.appFilters setObject:[[NSMutableArray alloc] initWithObjects: nil] forKey:@"rate"];
    [appDelegate.appFilters setObject:[[NSMutableArray alloc] initWithObjects: nil] forKey:@"color"];
    appDelegate.appOrderBy = @"goName";
    [segmentedOrder setSelectedSegmentIndex:0];
    [self refreshData];
    [_tableViewBeer reloadData];
    
}

#pragma mark - View Event
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // [self refreshData];
    
    tabImgRating = [[NSArray alloc] initWithObjects:@"score_0",@"score_1",@"score_2",@"score_3",@"score_4",@"score_5", nil];
    
    
    orderButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrows_vertical"] style:UIBarButtonItemStyleBordered target:self action:@selector(showOrder)];
    searchButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStyleBordered target:self action:@selector(showSearch)];
    
    self.navigationItem.rightBarButtonItems = @[orderButton, searchButton];
    
    //segmentedOrder
    NSArray *itemOrderArray = @[[UIImage imageNamed:@"beer_bottle"],[UIImage imageNamed:@"factory"], [UIImage imageNamed:@"pin_map"],[UIImage imageNamed:@"dice"]];
    segmentedOrder = [[UISegmentedControl alloc]initWithItems:itemOrderArray];
    [segmentedOrder setFrame:CGRectMake(0, 0, 0, 29.0f)];
    segmentedOrder.layer.cornerRadius = 0.0;
    
    [segmentedOrder setTintColor: [UIColor colorWithRed:99.0/255.0 green:36.0/255.0 blue:8.0/255.0 alpha:1]];
    [segmentedOrder setOpaque:YES];
    [segmentedOrder setSelectedSegmentIndex:0];
    [segmentedOrder setBackgroundColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:0.8]];
    segmentedOrder.layer.cornerRadius = 0;
    
    [segmentedOrder addTarget:self action:@selector(orderAction) forControlEvents:UIControlEventValueChanged];
    
    
    orderBarItem = [[UIBarButtonItem alloc] initWithCustomView:segmentedOrder];
    
   // [self.searchDisplayController setActive:FALSE];
    self.navigationController.toolbarHidden = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.toolbarHidden = NO;
   [self refreshData];
    [_tableViewBeer reloadData];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return 1;
    }else{
        return [tabSection count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
    }else{
        
        return [[_tabBeers objectForKey:[tabSection objectAtIndex:section]] count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [tabSection objectAtIndex:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    static NSString *CellIdentifier = @"listingCell";
    // listingCellController *cell = (listingCellController *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    listingCellController *cell = (listingCellController *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[listingCellController alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    oBeer *beer = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        beer = (oBeer *)[searchResults objectAtIndex:indexPath.row];
    }else{
        NSString *key = [tabSection objectAtIndex:indexPath.section];
        beer = (oBeer *)[[_tabBeers objectForKey:key] objectAtIndex:indexPath.row];
    }
    cell.beer = beer;
    cell.nameText.text = beer.name;
    cell.breweryText.text = beer.brewery;
    
    NSString *ThumbImageName = [[NSString alloc] initWithFormat:@"%@_1.jpg",beer.num];
    cell.imgImage.image = [UIImage imageNamed: ThumbImageName];
    if(cell.imgImage.image == nil){
        cell.imgImage.image = [UIImage imageNamed: @"Icon"];
    }
    if([beer.favorite isEqualToString:@"1"]){
        cell.imgCellFavorite.hidden = false;
    }else {
        cell.imgCellFavorite.hidden = true;
    }
    
    //   int randomNumber = arc4random() %(6);
    //  cell.imgRating.image = [UIImage imageNamed:[tabImgRating objectAtIndex:randomNumber]];
    
    NSString *rateImageName = [[NSString alloc] initWithFormat:@"score_%@",beer.rate];
    cell.imgRating.image = [UIImage imageNamed:rateImageName];
    
    if([beer.country isEqual:@""]){
        cell.imgFlag.image = nil;
    }else{
        NSString *imgFlagName = [[NSString alloc] initWithFormat:@"%@",beer.country];
        cell.imgFlag.image = [UIImage imageNamed: imgFlagName];
        
    }
    cell.backgroundView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgCell.png"]];
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgCell.png"]];
    
    return cell;
}

#pragma mark - Table view delegate
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    [headerView setBackgroundColor:[UIColor colorWithRed:130.0/255.0 green:130.0/255.0 blue:130.0/255.0 alpha:0.5]];
    //UIImageView *headerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgsearch"]]; //set your image/
    //headerImage.frame = CGRectMake(0, 0, tableView.bounds.size.width, 30);
    //[headerView addSubview:headerImage];
    
    
    if (tableView != self.searchDisplayController.searchResultsTableView) {
        
        
        
        UILabel *headerLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 205, 30)];
        headerLbl.backgroundColor = [UIColor clearColor];
        headerLbl.text = [tabSection objectAtIndex:section];
        headerLbl.textColor = [UIColor colorWithRed:99.0/255.0 green:36.0/255.0 blue:8.0/255.0 alpha:1.0];
        //headerLbl.textColor = [UIColor whiteColor];
        headerLbl.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:16];
        [headerView addSubview:headerLbl];
        
        UILabel *numOfItem = [[UILabel alloc] initWithFrame:CGRectMake(230, 0, 50, 30)];
        numOfItem.backgroundColor = [UIColor clearColor];
        numOfItem.text = [[NSString alloc] initWithFormat:@"nb: %lu",(unsigned long)[[_tabBeers objectForKey:[tabSection objectAtIndex:section]] count]];
        numOfItem.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:14];
        numOfItem.textColor = [UIColor colorWithRed:99.0/255.0 green:36.0/255.0 blue:8.0/255.0 alpha:1.0];
        //numOfItem.textColor = [UIColor whiteColor];
        [headerView addSubview:numOfItem];
        
    }
    return headerView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
    
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (tableView != self.searchDisplayController.searchResultsTableView) {
        CDELAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        if ([appDelegate.appOrderBy isEqualToString:@"goName"]) {
            return tabSection;
        }
    }
    return nil;
    
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
    if (tableView != self.searchDisplayController.searchResultsTableView) {
        CDELAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        if ([appDelegate.appOrderBy isEqualToString:@"goName"]) {
            return [tabSection indexOfObject:title];
        }
    }
    return 0;
}
#pragma mark - Searching
/*
 - (void)updateSearchString:(NSString*)aSearchString{
 
 CDELAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
 
 _searchString = [[NSString alloc]initWithString:aSearchString];
 [appDelegate.appFilters setObject:aSearchString forKey:@"name"];
 
 [self refreshData];
 [self.tableViewBeer reloadData];
 }
 
 - (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
 {
 [searchBar setShowsCancelButton:YES animated:YES];
 [searchBar setKeyboardType:UIKeyboardTypeAlphabet];
 [searchBar setShowsSearchResultsButton:NO];
 [searchBar setShowsCancelButton:YES];
 // self.tableView.allowsSelection = YES;
 //self.tableView.scrollEnabled = YES;
 //[self hideMenu];
 //[self hideIndex];
 }
 
 -(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
 if([searchText length] > 1){
 [self updateSearchString:searchText];
 }
 }
 
 - (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
 //[searchBar setShowsCancelButton:NO animated:YES];
 // [searchBar resignFirstResponder];
 
 searchBar.text=@"";
 _searchString = @"";
 [self.view endEditing:YES];
 [self updateSearchString:searchBar.text];
 [self hideSearch];
 }
 
 
 - (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
 [self.view endEditing:YES];
 [self hideSearch];
 
 }
 */
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.tableViewBeer reloadData];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[cd] %@", searchString];
    searchResults = [tabBeersBrut filteredArrayUsingPredicate:resultPredicate];    
    return YES;
}



#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:SegueDetails]) {
        
        NSIndexPath *indexPath = [_tableViewBeer indexPathForSelectedRow];
        oBeer *beer = nil;
        if (self.searchDisplayController.active) {
            beer = (oBeer *)[searchResults objectAtIndex:indexPath.row];
        }else{
            NSString *key = [tabSection objectAtIndex:indexPath.section];
            beer = (oBeer *)[[_tabBeers objectForKey:key] objectAtIndex:indexPath.row];
        }
       // NSString *key = [tabSection objectAtIndex:indexPath.section];
        //oBeer *beer = (oBeer *)[[_tabBeers objectForKey:key] objectAtIndex:indexPath.row];
        ((detailsController *)segue.destinationViewController).beer = beer;
        
    }
    if ([segue.identifier isEqualToString:filterByBrewery]) {
        ((FiltersController *)segue.destinationViewController).selectedFilter = @"brewery";
    }
    if ([segue.identifier isEqualToString:filterByCountry]) {
        ((FiltersController *)segue.destinationViewController).selectedFilter = @"country";
    }
    if ([segue.identifier isEqualToString:filterByType]) {
        ((FiltersController *)segue.destinationViewController).selectedFilter = @"type";
    }
    if ([segue.identifier isEqualToString:filterByColor]) {
        ((FiltersController *)segue.destinationViewController).selectedFilter = @"color";
    }
    
}
- (IBAction)showMenu:(id)sender {
    menuController *viewController = (menuController *)self.parentViewController.parentViewController;
    [viewController showMenuDown];
}

#pragma mark - Segmented Control
-(void) orderAction{
    NSInteger index =  [segmentedOrder selectedSegmentIndex];
    CDELAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    if(index == 1){
        appDelegate.appOrderBy = @"goBrewery";
    }else if(index == 2){
        appDelegate.appOrderBy = @"goCountry";
    }else if(index == 3){
        appDelegate.appOrderBy = @"goRandom";
    }else{
        appDelegate.appOrderBy = @"goName";
    }
    
    
    [self refreshData];
    [self.tableViewBeer reloadData];
    //[self hideOrder];
}



#pragma mark - Animation

-(void)showSearch{
    
    [self.searchDisplayController setActive:TRUE animated:TRUE];
   
    //  UIBarButtonItem *searchBarItem = [[UIBarButtonItem alloc] initWithCustomView:searchBarTop];
    /*
     self.navigationItem.rightBarButtonItems = @[searchBarItem];
     //self.navigationItem.leftBarButtonItem = nil;
     // self.navigationItem.titleView = nil;
     [searchBarTop becomeFirstResponder];
     //slide the content view to the right to reveal the menu
     [UIView animateWithDuration:.25
     animations:^{
     [searchBarTop setFrame:CGRectMake(0, 0, 270.0f, searchBarTop.frame.size.height)];
     }completion:^(BOOL finished) {
     
     }
     ];
     */
}
/*
 -(void)hideSearch{
 
 //slide the content view to the right to reveal the menu
 [UIView animateWithDuration:.25
 animations:^{
 [searchBarTop setFrame:CGRectMake(0, 0, 0 , searchBarTop.frame.size.height)];
 }completion:^(BOOL finished) {
 if(finished)
 self.navigationItem.rightBarButtonItems = @[orderButton, searchButton];
 //self.navigationItem.leftBarButtonItem = self.editButtonItem;;
 }
 ];
 
 }
 */


-(void)showOrder{
    self.navigationItem.rightBarButtonItems = @[orderButton,orderBarItem];
    [UIView animateWithDuration:.25
                     animations:^{
                         [segmentedOrder setFrame:CGRectMake(0, 0, 210.0f, segmentedOrder.frame.size.height)];
                     }completion:^(BOOL finished) {
                         [orderButton setAction:@selector(hideOrder)];
                     }
     ];
}
-(void)hideOrder{
    
    //slide the content view to the right to reveal the menu
    [UIView animateWithDuration:.25
                     animations:^{
                         [segmentedOrder setFrame:CGRectMake(0, 0, 0 , segmentedOrder.frame.size.height)];
                     }completion:^(BOOL finished) {
                         self.navigationItem.rightBarButtonItems = @[orderButton, searchButton];
                         //self.navigationItem.leftBarButtonItem = self.editButtonItem;;
                         [orderButton setAction:@selector(showOrder)];
                     }
     ];
}



@end
