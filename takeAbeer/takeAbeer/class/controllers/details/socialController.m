//
//  socialController.m
//  take-a-beer
//
//  Created by Clement Lasnier Delalandre on 13/11/2013.
//  Copyright (c) 2013 clement Delalandre. All rights reserved.
//

#import "socialController.h"

@interface socialController ()

@end

@implementation socialController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)postSocialNetwork:(id)sender {
   
    UIImageView *image = [[UIImageView alloc] init];
    
    NSString *ThumbImageName = [[NSString alloc] initWithFormat:@"%@-1.jpg",_beer.num];
    image.image  = [UIImage imageNamed: ThumbImageName];
    if(image.image  == nil){
        image.image  = [UIImage imageNamed: @"Icon.png"];
    }
    NSString *postMessage = [[NSString alloc] initWithFormat:@"J'aime la bière %@. #tabeabeer http://www.takeabeer.com",_beer.name];
    NSArray *activityItems;
     activityItems = @[postMessage, image.image];
    
    
    UIActivityViewController *activityController =
    [[UIActivityViewController alloc]
     initWithActivityItems:activityItems
     applicationActivities:nil];
    
    [self presentViewController:activityController
                       animated:YES completion:nil];
}

@end
