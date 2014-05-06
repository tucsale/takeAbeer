//
//  CDELAppDelegate.h
//  takeAbeer
//
//  Created by Clement Lasnier Delalandre on 05/05/2014.
//  Copyright (c) 2014 Clement Lasnier Delalandre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDELAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableDictionary *appFilters;
@property(retain, nonatomic) NSString *appOrderBy;
@end
