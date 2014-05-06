//
//  detailsContainerController.m
//  take-a-beer
//
//  Created by clement on 17/10/13.
//  Copyright (c) 2013 clement Delalandre. All rights reserved.
//

#import "detailsContainerController.h"
#import "detailsImgController.h"
#import "detailsDescriptionController.h"
#import "detailsInfoController.h"
#import "detailsToolControler.h"
#import "detailsBreweryController.h"


#define SegueIdentifierDescription @"embedDescription"
#define SegueIdentifierImg @"embedImg"
#define SegueIdentifierTool @"embedTool"
#define SegueIdentifierInfo @"embedInfo"
#define SegueIdentifierBrewery @"embedBrewery"


@interface detailsContainerController ()
@property (strong, nonatomic) NSString *currentSegueIdentifier;
@property (strong, nonatomic) NSString *oldSegueIdentifier;
@property (strong, nonatomic) detailsDescriptionController *detailsDescription;
@property (strong, nonatomic) detailsImgController *detailsImg;
@property (strong, nonatomic) detailsInfoController *detailsInfo;
@property (strong, nonatomic) detailsBreweryController *detailsBrewery;
@property (strong, nonatomic) detailsToolControler *detailsTool;
@property (strong, nonatomic) UIViewController *currentView;
@property (assign, nonatomic) BOOL transitionInProgress;
@property int currentIndex;
@property (strong, nonatomic) NSArray * tabIndexChild;


@end

@implementation detailsContainerController


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
    _transitionInProgress = NO;
    _currentSegueIdentifier = SegueIdentifierInfo;
    _oldSegueIdentifier = SegueIdentifierInfo;
    _tabIndexChild = [NSArray arrayWithObjects: SegueIdentifierInfo,
                      SegueIdentifierBrewery
                      SegueIdentifierDescription,
                      SegueIdentifierImg,
                      SegueIdentifierTool,
                      nil];
    
    
   
    
}
- (void)viewDidAppear:(BOOL)animated{
     [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    // Instead of creating new VCs on each seque we want to hang on to existing
    // instances if we have it. Remove the second condition of the following
    // two if statements to get new VC instances instead.
    if (([segue.identifier isEqualToString:SegueIdentifierInfo])) {
        _detailsInfo = segue.destinationViewController;
        [_detailsInfo setBeer:_beer];
    }
    if (([segue.identifier isEqualToString:SegueIdentifierBrewery])) {
        _detailsBrewery = segue.destinationViewController;
        [_detailsBrewery setBeer:_beer];
    }
    if (([segue.identifier isEqualToString:SegueIdentifierDescription])) {
        _detailsDescription = segue.destinationViewController;
        [_detailsDescription setTmpDescription: _beer.description];
    }
    if (([segue.identifier isEqualToString:SegueIdentifierImg])) {
        _detailsImg = segue.destinationViewController;
        //Prepare Images
        NSString *chnImg ;
        NSMutableArray *tabImagesName = [[NSMutableArray alloc] init];
        for (int i=1; i<=10; i++) {
            NSString *exists = [[NSBundle mainBundle] pathForResource:[[NSString alloc] initWithFormat:@"%@_%d",_beer.num, i] ofType:@"jpg"];
            if(exists == nil){
                continue;
            }
            chnImg = [[NSString alloc] initWithFormat:@"%@_%d.jpg",_beer.num, i];
            [tabImagesName addObject:chnImg];
        }
        
        _detailsImg.tabImagesName = [tabImagesName copy];
    }
    if (([segue.identifier isEqualToString:SegueIdentifierTool])) {
        _detailsTool = segue.destinationViewController;
        _detailsTool.beer = _beer;
    }
    
    if (self.childViewControllers.count > 0) {
        [self swapFromViewController:_currentView toViewController:segue.destinationViewController];
    }
    else {
        // If this is the very first time we're loading this we need to do
        // an initial load and not a swap.
        [self addChildViewController:segue.destinationViewController];
        ((UIViewController *)segue.destinationViewController).view.frame = self.view.frame;
       
        [self.view addSubview:((UIViewController *)segue.destinationViewController).view];
        [segue.destinationViewController didMoveToParentViewController:self];
        _currentView = segue.destinationViewController;
    }
    
}

- (void)swapFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController
{
   // toViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self addChildViewController:toViewController];
    toViewController.view.frame = self.view.frame;
    [fromViewController willMoveToParentViewController:nil];
    
    
    [self transitionFromViewController:fromViewController toViewController:toViewController duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        [fromViewController removeFromParentViewController];
        [toViewController didMoveToParentViewController:self];
        _transitionInProgress = NO;
        _currentView = toViewController;
        
    }];
}

- (void)swapViewControllers:(NSString *)segueIdentifier
{
    if (_transitionInProgress || [_currentSegueIdentifier isEqualToString:segueIdentifier]) {
        return;
    }
    
    _transitionInProgress = YES;
    _currentSegueIdentifier = segueIdentifier;
    [self performSegueWithIdentifier:_currentSegueIdentifier sender:nil];
}
@end
