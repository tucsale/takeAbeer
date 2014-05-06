//
//  CDELAppDelegate.m
//  takeAbeer
//
//  Created by Clement Lasnier Delalandre on 05/05/2014.
//  Copyright (c) 2014 Clement Lasnier Delalandre. All rights reserved.
//

#import "CDELAppDelegate.h"

@implementation CDELAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    _appFilters = [[NSMutableDictionary alloc] init];
    
    [_appFilters setObject:@"" forKey:@"name"];
    [_appFilters setObject:[[NSMutableArray alloc] initWithObjects: nil] forKey:@"type"];
    [_appFilters setObject:[[NSMutableArray alloc] initWithObjects: nil] forKey:@"fermentation"];
    [_appFilters setObject:[[NSMutableArray alloc] initWithObjects: nil] forKey:@"alcoholic"];
    [_appFilters setObject:[[NSMutableArray alloc] initWithObjects: nil] forKey:@"brewery"];
    [_appFilters setObject:[[NSMutableArray alloc] initWithObjects: nil] forKey:@"country"];
    [_appFilters setObject:[[NSMutableArray alloc] initWithObjects: nil] forKey:@"favorite"];
    [_appFilters setObject:[[NSMutableArray alloc] initWithObjects: nil] forKey:@"rate"];
    
    
    _appOrderBy = @"goName";
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbg"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:99.0/255.0 green:36.0/255.0 blue:8.0/255.0 alpha:1.0]];
    
    // [[UICollectionView appearance] setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgnude.png"]]];
    //[[UISearchBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbg"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //  [[UICollectionViewCell appearance] setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgcollectioncell.png"]]];
    
  //  [[UISearchBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbg"] forBarMetrics:UIBarMetricsDefault];
  //  [[UISearchBar appearance] setTintColor:[UIColor colorWithRed:99.0/255.0 green:36.0/255.0 blue:8.0/255.0 alpha:1.0]];
    
    //back button
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:99.0/255.0 green:36.0/255.0 blue:8.0/255.0 alpha:1.0]];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTintColor:[UIColor colorWithRed:99.0/255.0 green:36.0/255.0 blue:8.0/255.0 alpha:1.0]];
    
    [[UITableView appearance] setSeparatorColor:[UIColor colorWithRed:99.0/255.0 green:36.0/255.0 blue:8.0/255.0 alpha:0.0]];
    [[UITableView appearance] setSectionIndexBackgroundColor:[UIColor colorWithRed:99.0/255.0 green:36.0/255.0 blue:8.0/255.0 alpha:0.0]];
    [[UITableView appearance] setSectionIndexColor:[UIColor colorWithRed:99.0/255.0 green:36.0/255.0 blue:8.0/255.0 alpha:1.0]];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
