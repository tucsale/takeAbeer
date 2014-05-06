//
//  WebController.m
//  Take a Beer
//
//  Created by clement on 01/06/13.
//  Copyright (c) 2013 clement Delalandre. All rights reserved.
//

#import "WebController.h"

@interface WebController ()

@end

@implementation WebController
@synthesize webView;
@synthesize webUrl;
@synthesize labelLoading;

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
   // NSString *fullURL = @"http://fr.m.wikipedia.org/wiki/Fermentation_de_la_bi%C3%A8re";
    NSURL *url = [NSURL URLWithString:webUrl];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebView Delegate -
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [labelLoading setHidden:true];
}

#pragma mark - IBAction


- (IBAction)closeModal:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
