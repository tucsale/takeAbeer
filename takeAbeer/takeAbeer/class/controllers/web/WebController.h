//
//  WebController.h
//  Take a Beer
//
//  Created by clement on 01/06/13.
//  Copyright (c) 2013 clement Delalandre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSString *webUrl;
@property (strong, nonatomic) IBOutlet UILabel *labelLoading;
@end
