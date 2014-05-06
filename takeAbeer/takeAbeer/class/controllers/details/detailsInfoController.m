//
//  detailsInfoController.m
//  take-a-beer
//
//  Created by clement on 17/10/13.
//  Copyright (c) 2013 clement Delalandre. All rights reserved.
//

#import "detailsInfoController.h"

@interface detailsInfoController ()


@end

@implementation detailsInfoController

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
    _fermentation.text = _beer.fermentation;
    _type.text = _beer.type;
    _country.text =  NSLocalizedString(_beer.country, nil);
   
   // _update.text = _beer.dateUpdate;
    _color.text = _beer.color;
    _alcoholic.text = _beer.alcoholic;
    

    _name.text = _beer.name;
    _brewery.text = _beer.brewery;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
