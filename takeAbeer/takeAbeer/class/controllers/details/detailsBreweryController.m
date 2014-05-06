//
//  detailsBreweryController.m
//  take-a-beer
//
//  Created by Clement Lasnier Delalandre on 02/05/2014.
//  Copyright (c) 2014 clement Delalandre. All rights reserved.
//

#import "detailsBreweryController.h"

@interface detailsBreweryController ()

@end

@implementation detailsBreweryController

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

    _address.text = _beer.address;
    _city.text = _beer.city;
    _country.text =  NSLocalizedString(_beer.country, nil);
    _phone.text = _beer.phone;
    _postal.text = _beer.postal;
    
    _name.text = _beer.name;
    _brewery.text = _beer.brewery;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
