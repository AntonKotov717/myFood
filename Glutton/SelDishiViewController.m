//
//  SelDishiViewController.m
//  Glutton
//
//  Created by dev on 1/22/16.
//  Copyright © 2016 TylerCo. All rights reserved.
//

#import "SelDishiViewController.h"
#import "CategoryViewController.h"
//#import "CategoryCellDish.h"

@interface SelDishiViewController (){
    NSArray *arryDishis;
    NSArray *arryDishisImage;
}

@end

@implementation SelDishiViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"Select Dishes"];
    
    arryDishis = [NSArray arrayWithObjects:
                  @"BURGERS",
                  @"SANDWICHES",
                  @"PIZZA",
                  @"HOTDOGS",
                  @"FRENCH FRIES",
                  @"NOODLES",
                  @"SUSHI",
                  @"SALADS",
                  @"BBQ",
                  @"BURITTO",
                  @"TACOS",
                  @"EGGS",
                  @"BACON",
                  @"DOUNTS",
                  @"WAFFLES",
                  @"PANCAKES",
                  @"COFFEE",
                  @"WRAPS",
                  @"KABOBS",
                  @"SOUP",
                  @"CHICKEN",
                  @"FISH",
                  @"BEEF",
                  @"STEAK",
                  @"PORK",
                  @"LAMB",
                  @"BAGELS",
                  @"RICE",
                  @"LOBSTER",
                  @"CURRY",
                  @"SHRIMP",
                  @"MACARONI AND CHEESE",
                  @"ICE CREAM",
                  @"SMOOTHIES",
                  @"DESSERTS", nil];
    arryDishisImage = [NSArray arrayWithObjects:
                  @"Burgers.jpg",
                  @"Sandwiches.png",
                  @"Pizza.jpg",
                  @"HotDogs.jpg",
                  @"French_Fries.jpg",
                  @"Noodles.jpg",
                  @"Sushi.jpg",
                  @"Salads.jpg",
                  @"BBQ.jpg",
                  @"Buritto.jpg",
                  @"Tacos.jpg",
                  @"Eggs.jpg",
                  @"Bacon.jpg",
                  @"Donuts.jpg",
                  @"Waffles.jpg",
                  @"Pancakes.jpg",
                  @"Coffee.jpg",
                  @"Wraps.jpg",
                  @"Kabobs.jpg",
                  @"Soup.jpg",
                  @"Chicken.jpg",
                  @"Fish.jpg",
                  @"Beef.jpg",
                  @"Steak.jpg",
                  @"Pork.jpg",
                  @"Lamb.jpg",
                  @"Bagels.jpg",
                  @"Rice.jpg",
                  @"Lobster.png",
                  @"Curry.jpg",
                  @"Shrimp.jpg",
                  @"Macaroni_and_cheese.jpg",
                  @"Ice_cream.jpg",
                  @"Smoothies.jpg",
                  @"Desserts.jpg", nil];

    
    self.dishiCollection.delegate = self;
    self.dishiCollection.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return arryDishis.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sample.jpg"]];
    
    cell.maskView.layer.masksToBounds = YES;
    cell.maskView.layer.cornerRadius = 5.0;
    cell.maskView.clipsToBounds = YES;
    
    cell.layer.masksToBounds = YES;
    //    cell.layer.cornerRadius = 5.0;
    //    cell.layer.shadowRadius = 5.0;
    //    cell.layer.shadowOffset = CGSizeMake(4, 4);
    //    cell.layer.shadowColor = [[UIColor blackColor] CGColor];
    //    cell.layer.shadowRadius = 2.0f;
    //    cell.layer.shadowOpacity = 0.60f;
    //    cell.layer.shadowPath = [[UIBezierPath bezierPathWithRect:cell.imageView.layer.bounds] CGPath];
    
    cell.layer.cornerRadius = 5.0;
//    cell.backgroundColor = [UIColor clearColor];
//    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(4,4);
    cell.layer.shadowOpacity = 0.30f;
    cell.layer.shadowRadius = 10.0;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:30.0].CGPath;
 
   
//    UIImageView *audioImageView = (UIImageView *)[cell viewWithTag:100];
//    audioImageView.image = [UIImage imageNamed:[audioImages objectAtIndex:indexPath.row]];
    
    UILabel *label = (UILabel*)[cell viewWithTag:1];
  
    NSString *strLabelName = [arryDishis objectAtIndex:indexPath.row];
    label.text = strLabelName;
    
    // image set
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:2];
    imageView.image = [UIImage imageNamed:[arryDishisImage objectAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    cell.contentView.backgroundColor = [UIColor greenColor];
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
//    
//    UILabel *label = (UILabel*)[cell viewWithTag:1];
////    label.backgroundColor =[UIColor redColor];
//
//    cell.contentView.backgroundColor = [UIColor redColor];
////    cell.contentView.backgroundColor = [UIColor colorWithRed:191.0 green:87.0/255.0 blue:0.0 alpha:1.0].CGColor;
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strSelDishi;
    strSelDishi = [arryDishis objectAtIndex:indexPath.row];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:strSelDishi forKey:@"sel_dishi"];
    
    [defaults setObject:@"0" forKey:@"from_category"]; // from dishe window
    [self.tabBarController setSelectedIndex:1];
    
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //    NSInteger _numberOfCells = NUMBEROFCELLS;
    //    NSInteger viewWidth = COLLECTIONVIEW_WIDTH;
    //    NSInteger totalCellWidth = CELL_WIDTH * _numberOfCells;
    //    NSInteger totalSpacingWidth = CELL_SPACING * (_numberOfCells -1);
    //
    //    NSInteger leftInset = (viewWidth - (totalCellWidth + totalSpacingWidth)) / 2;
    //    NSInteger rightInset = leftInset;
    
    //return UIEdgeInsetsMake(0, leftInset, 0, rightInset);
    return UIEdgeInsetsMake(13, 15, 13, 15);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
