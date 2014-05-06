//
//  detailsToolControler.m
//  take-a-beer
//
//  Created by clement on 17/10/13.
//  Copyright (c) 2013 clement Delalandre. All rights reserved.
//

#import "detailsToolControler.h"
#import "detailsController.h"

#import "CDELAppDelegate.h"

@interface detailsToolControler (){
 detailsController *parentController;;

}


@end

@implementation detailsToolControler

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
    //[_stepper setValue:[_beer.rate doubleValue]];
     parentController = (detailsController *)self.parentViewController.parentViewController;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
- (IBAction)valueChanged:(UIStepper *)sender {
    NSString *flagImageName = [[NSString alloc] initWithFormat:@"score_%i.png", (int)[sender value]];
    parentController.imgRating.image = [UIImage imageNamed: flagImageName];
    NSString *chnString = [[NSString alloc] initWithFormat:@"%i",(int)[sender value]];
    [_beer updateRate:chnString];
    
}
*/
- (IBAction)searchTheSameBrewery:(id)sender{
    CDELAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    [appDelegate.appFilters setObject:@"" forKey:@"name"];
    [appDelegate.appFilters setObject:[[NSMutableArray alloc] initWithObjects:_beer.brewery, nil] forKey:@"brewery"];
    [appDelegate.appFilters setObject:[[NSMutableArray alloc] init] forKey:@"type"];
    [appDelegate.appFilters setObject:[[NSMutableArray alloc] init] forKey:@"fermentation"];
    [appDelegate.appFilters setObject:[[NSMutableArray alloc] init] forKey:@"alcoholic"];
    [appDelegate.appFilters setObject:[[NSMutableArray alloc] init] forKey:@"country"];
    [appDelegate.appFilters setObject:[[NSMutableArray alloc] init] forKey:@"color"];

    //[parentController.navigationController popViewControllerAnimated:YES];
    [parentController.navigationController popToRootViewControllerAnimated:YES];
   
    
}

-(IBAction)searchTheSameType:(id)sender{
    CDELAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    [appDelegate.appFilters setObject:@"" forKey:@"name"];
    [appDelegate.appFilters setObject:[[NSMutableArray alloc] init] forKey:@"brewery"];
    [appDelegate.appFilters setObject:[[NSMutableArray alloc] initWithObjects:_beer.type, nil] forKey:@"type"];
    [appDelegate.appFilters setObject:[[NSMutableArray alloc] initWithObjects:_beer.fermentation, nil] forKey:@"fermentation"];
    [appDelegate.appFilters setObject:[[NSMutableArray alloc] initWithObjects:_beer.alcoholic, nil] forKey:@"alcoholic"];
    [appDelegate.appFilters setObject:[[NSMutableArray alloc] init] forKey:@"country"];
    [appDelegate.appFilters setObject:[[NSMutableArray alloc] init] forKey:@"color"];

    
    [parentController.navigationController popToRootViewControllerAnimated:YES];

}
@end
