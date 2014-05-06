//
//  detailsController.h
//  Take a Beer
//
//  Created by clement on 05/12/12.
//  Copyright (c) 2012 clement Delalandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView.h"
#import "oBeer.h"

@interface detailsController : UIViewController <RateViewDelegate>

@property (weak, nonatomic) IBOutlet RateView *rateView;


- (IBAction)postSocialNetwork:(id)sender;
- (IBAction)SetFavorite:(id)sender;
- (IBAction)infosAction:(id)sender;


@property(retain, nonatomic)  NSMutableArray *tabImagesName;


@property(retain, nonatomic) oBeer *beer;

@property(retain,nonatomic) IBOutlet UILabel *name;
@property(retain,nonatomic) IBOutlet UILabel *brewery;

@property(retain,nonatomic) IBOutlet UIImageView *image;
@property(retain,nonatomic) IBOutlet UIImageView *flagImage;
@property(retain,nonatomic) IBOutlet UIImageView *imgShadow;

@property(weak,nonatomic) IBOutlet UIBarButtonItem *btFavorite;
@property(weak,nonatomic) IBOutlet UISegmentedControl *segmentedInfos;



@end
