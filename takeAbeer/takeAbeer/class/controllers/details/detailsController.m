//
//  detailsController.m
//  Take a Beer
//
//  Created by clement on 05/12/12.
//  Copyright (c) 2012 clement Delalandre. All rights reserved.
//

#import "detailsController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "detailsContainerController.h"
#import <Social/Social.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "CDELAppDelegate.h"



@interface detailsController ()
@property (nonatomic, weak) detailsContainerController *detailsContainerController;

@end

@implementation detailsController

//@synthesize scrollImage;

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
  
    _name.text = _beer.name;
    _brewery.text = _beer.brewery;
    
    
    NSString *ThumbImageName = [[NSString alloc] initWithFormat:@"%@_1.jpg",_beer.num];
    _image.image  = [UIImage imageNamed: ThumbImageName];
    if(_image.image  == nil){
        _image.image  = [UIImage imageNamed: @"Icon"];
    }
     _flagImage.image = [UIImage imageNamed: _beer.country];
    

    NSString *favoriteName = [[NSString alloc] initWithFormat:@"heart_%@", _beer.favorite];
    _btFavorite.image =  [UIImage imageNamed: favoriteName];
    
       self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:99.0/255.0 green:36.0/255.0 blue:8.0/255.0 alpha:1.0];
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:99.0/255.0 green:36.0/255.0 blue:8.0/255.0 alpha:1.0];
    
    self.rateView.notSelectedImage = [UIImage imageNamed:@"rate_empty"];
    self.rateView.fullSelectedImage = [UIImage imageNamed:@"rate_full"];
    self.rateView.rating = [_beer.rate intValue];
    self.rateView.editable = YES;
    self.rateView.maxRating = 5;
    self.rateView.delegate = self;

}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    _imgShadow.layer.shadowOffset = CGSizeMake(1,1);
    _imgShadow.layer.shadowOpacity = 0.7f;
    _imgShadow.layer.shadowRadius = 2.0;
   // self.navigationController.toolbarHidden = YES;

}

/*
 -(void)orientationChanged:(NSNotification *)object{
 [self viewDidAppear:true];
 }
 */
#pragma mark - prepareForSegue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"embedContainer"]) {
        
        _detailsContainerController = segue.destinationViewController;
        [_detailsContainerController setBeer:_beer];
    }
}

#pragma mark - Action

-(IBAction)SetFavorite:(id)sender{
    [_beer updateFavorite];
    
    NSString *favoriteName = [[NSString alloc] initWithFormat:@"heart_%@", _beer.favorite];
    #ifdef DEBUG
    NSLog(@"favoriteName %@",favoriteName);
    #endif
   // _btFavorite.image =  [UIImage imageNamed: favoriteName];
    [_btFavorite setImage:[UIImage imageNamed: favoriteName]];
}


#pragma mark - Segmented Control
- (IBAction)infosAction:(id)sender{
    
    NSInteger index =  [_segmentedInfos selectedSegmentIndex];
    
    if(index == 0){
        [_detailsContainerController swapViewControllers:@"embedInfo"];
    }else if(index == 1){
        [_detailsContainerController swapViewControllers:@"embedBrewery"];
    }else if(index == 2){
        [_detailsContainerController swapViewControllers:@"embedDescription"];
    }else if(index == 3){
        [_detailsContainerController swapViewControllers:@"embedImg"];
    }else if(index == 4){
        [_detailsContainerController swapViewControllers:@"embedTool"];
    }



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

- (void)postSocialNetwork {
    NSArray *activityItems;
    UIImage *postImage;
    
    NSString *ThumbImageName = [[NSString alloc] initWithFormat:@"%@-1.jpg",_beer.num];
    postImage  = [UIImage imageNamed: ThumbImageName];
    if(postImage  == nil){
        postImage  = [UIImage imageNamed: @"Icon"];
    }
    NSString *postMessage = [[NSString alloc] initWithFormat:@"J'aime la bière %@. #tabeabeer http://www.takeabeer.com",_beer.name];
    
    activityItems = @[postMessage, postImage];
    
    
    UIActivityViewController *activityController =
    [[UIActivityViewController alloc]
     initWithActivityItems:activityItems
     applicationActivities:nil];
    
    [self presentViewController:activityController
                       animated:YES completion:nil];
}


- (void)rateView:(RateView *)rateView ratingDidChange:(int)rating {
   //[NSString stringWithFormat:@"Rating: %i", rating];
    NSString *chnString = [[NSString alloc] initWithFormat:@"%i",rating];
    [_beer updateRate:chnString];
}

@end
