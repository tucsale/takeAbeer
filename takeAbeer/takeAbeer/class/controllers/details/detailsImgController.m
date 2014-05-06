//
//  detailsImgController.m
//  take-a-beer
//
//  Created by clement on 16/10/13.
//  Copyright (c) 2013 clement Delalandre. All rights reserved.
//

#import "detailsImgController.h"
#import "detailsImgCellController.h"

@interface detailsImgController ()

@end

@implementation detailsImgController


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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate
// Number of Sections in Collection View
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSString *)collectionView:(UICollectionView *)collectionView titleForHeaderInSection:(NSInteger)section {
    return @"";
}

//Number of Items in Section
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_tabImagesName count];
}

//Collection View Cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    detailsImgCellController *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myImgCell" forIndexPath:indexPath];

    cell.imageView.image = [UIImage imageNamed:[_tabImagesName objectAtIndex:indexPath.row]];
    
/*    static NSString *CellIdentifier = @"CDELimgCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
   
    
    UIImageView *uiImageTmp = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    [uiImageTmp setContentMode:UIViewContentModeScaleAspectFit];
    
    [uiImageTmp setImage:[UIImage imageNamed:[_tabImagesName objectAtIndex:indexPath.row]]];
    [cell addSubview:uiImageTmp];
    */
    return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568.0){
         return CGSizeMake(200, 200);
        
    }else{
         return CGSizeMake(180, 160);
    }
}

@end
