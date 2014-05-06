//
//  menuController.m
//  take-a-beer
//
//  Created by clement on 20/10/13.
//  Copyright (c) 2013 clement Delalandre. All rights reserved.
//

#import "menuController.h"
#import "MenuCell.h"
#import "CDELAppDelegate.h"
#import "FiltersController.h"
#import "WebController.h"
#import "listingController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>


@interface menuController ()

@property (strong,nonatomic) NSArray *menuArray; //array for menu

@end

@implementation menuController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UISearchBar appearance] setBackgroundImage:[UIImage imageNamed:@"bgsearch.png"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    //Find the path for the menu resource and load it into the menu array
    NSString *menuPlistPath = [[NSBundle mainBundle] pathForResource:@"Menu" ofType:@"plist"];
    _menuArray = [[NSArray alloc] initWithContentsOfFile:menuPlistPath];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshDataListing) name:@"updateParent" object:nil];
    
    
}
-(void) refreshDataListing{
    UINavigationController *navController = (UINavigationController *)self.childViewControllers[0];
    listingController *viewController = (listingController *)navController.childViewControllers[0];
    [viewController refreshData];
    [viewController.tableView reloadData];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [_menuTable reloadData];
    
    _content.layer.shadowColor = [[UIColor blackColor] CGColor];
    _content.layer.shadowOffset = CGSizeMake(0.0f,0.0f);
    _content.layer.shadowOpacity = 0.7f;
    _content.layer.shadowRadius = 4.0f;
    CGRect shadowRect = CGRectInset(_content.bounds, 0, 4);  // inset top/bottom
    _content.layer.shadowPath = [[UIBezierPath bezierPathWithRect:shadowRect] CGPath];
    
    [_menuTable setSeparatorColor:[UIColor clearColor]];
    
    _menuTable.backgroundColor = [UIColor clearColor];
    _menuTable.opaque = NO;
    _menuTable.backgroundView = nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Datasource -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == _menuTable){
        return [_menuArray[section][@"menu"] count];
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView == _menuTable)
        return self.menuArray.count;
    else
        return 1;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"MenuCell";
    MenuCell *cell = (MenuCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSDictionary *menuItem = _menuArray[indexPath.section][@"menu"][indexPath.row];
    cell.title.text = menuItem[@"title"];
    CDELAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    
    if([menuItem[@"type"] isEqual: @"switch"]){
        
        UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
        switchView.tag = indexPath.row;
        cell.accessoryView = switchView;
        [switchView setOn:NO animated:NO];
        [switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        [cell.counter setHidden:true];
        // [switchView setBackgroundColor:[UIColor redColor]];
    }else{
        NSInteger counter;
        if([appDelegate.appFilters objectForKey:menuItem[@"filterBy"]] == nil ){
            counter = 0;
            
        }else{
            counter =  [[appDelegate.appFilters objectForKey:menuItem[@"filterBy"]] count];
        }
        cell.counter.text = [[NSString alloc] initWithFormat:@"%li", (long)counter ];
    }
    cell.backgroundView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgmenutable2.png"]];
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgmenutable2.png"]];
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _menuArray[section][@"title"];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 34;
    
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 43)];
    UIImageView *headerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgsearch.png"]]; //set your image/
    
    UILabel *headerLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 205, 43)];//set as you need
    headerLbl.backgroundColor = [UIColor clearColor];
    headerLbl.text = self.menuArray[section][@"title"];
    headerLbl.textColor = [UIColor colorWithRed:99.0/255.0 green:36.0/255.0 blue:8.0/255.0 alpha:1.0];
    [headerImage addSubview:headerLbl];
    
    headerImage.frame = CGRectMake(0, 0, tableView.bounds.size.width, 43);
    
    [headerView addSubview:headerImage];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 43;
    
}
#pragma mark - UITableView Delegate -

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _menuTable){
        if([_menuArray[indexPath.section][@"menu"][indexPath.row][@"type"] isEqual: @"web"]){
            WebController *webController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebController"];
            [webController setWebUrl:self.menuArray[indexPath.section][@"menu"][indexPath.row][@"url"]];
            
            
            // [self.navigationController pushViewController:webController animated:true];
            UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:webController];
            
            [navController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
            [self presentViewController:navController animated:YES completion:nil];
        }else if([self.menuArray[indexPath.section][@"menu"][indexPath.row][@"type"] isEqual: @"order"]){
            
            CDELAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            appDelegate.appOrderBy = self.menuArray[indexPath.section][@"menu"][indexPath.row][@"orderBy"];
            [self refreshDataListing];
            //appDelegate.appFilters = [[NSMutableDictionary alloc] init];
            
        }else if([self.menuArray[indexPath.section][@"menu"][indexPath.row][@"type"] isEqual: @"filter"]){
            
            FiltersController *filterController = [self.storyboard instantiateViewControllerWithIdentifier:@"FiltersController"];
            [filterController setSelectedFilter:self.menuArray[indexPath.section][@"menu"][indexPath.row][@"filterBy"]];
             [self.navigationController pushViewController:filterController animated:true];
            // [filterController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
            // [self presentViewController:filterController animated:YES completion:nil];
           
           // UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:filterController];
           // [navController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
            //[self presentViewController:navController animated:YES completion:nil];
            
        }
        [self hideMenu];
    }
}
- (void) switchChanged:(id)sender {
    UISwitch* switchControl = sender;
    NSDictionary *menuItem = self.menuArray[1][@"menu"][switchControl.tag];
    CDELAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSString *switchVal = switchControl.on ? @"1" : @"0";
    
    [appDelegate.appFilters setObject:switchVal forKey:menuItem[@"filterBy"]];
    [self refreshDataListing];
    
    
}
#pragma mark - Segue -
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}
#pragma mark - Actions -
- (void)showMenuDown {
    
    if(_content.frame.origin.x == 0){ //only show the menu if it is not already shown
        // [self.filterTable setHidden:true];
        [self.menuTable setHidden:false];
        [self showMenu];
        
    }else{
        [self hideMenu];
    }
}


#pragma mark - animations -
-(void)showMenu{
    
    //slide the content view to the right to reveal the menu
    [UIView animateWithDuration:.25
                     animations:^{
                         [_content setFrame:CGRectMake(_menuTable.frame.size.width, _content.frame.origin.y, _content.frame.size.width, _content.frame.size.height)];
                     }
     ];
    
}

-(void)hideMenu{
    [UIView animateWithDuration:.25
                     animations:^{
                         
                         [_content setFrame:CGRectMake(0, _content.frame.origin.y, _content.frame.size.width, _content.frame.size.height)];
                     }
     ];
}

@end
