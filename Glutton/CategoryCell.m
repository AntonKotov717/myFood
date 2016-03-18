//
//  RestaurantCell.m
//  Glutton
//
//  Created by Tyler on 4/20/15.
//  Copyright (c) 2015 TylerCo. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell

- (void)setcategoryNameLabel:(UILabel *)categoryNameLabel {
    _categoryNameLabel = categoryNameLabel;
    [_categoryNameLabel setFont:[UIFont fontWithName:@"Bariol-Bold" size:21]];
    [_categoryNameLabel setTextColor:[UIColor whiteColor]];
//    [_restaurantNameLabel setBackgroundColor:[UIColor colorWithRed:136.0f/255.0f green:136.0f/255.0f blue:136.0f/255.0f alpha:0.5]];
    
    //this is make the image view rounded.
   
    //    self.topImage.layer.masksToBounds = YES;
    //    self.topImage.layer.cornerRadius = 4.0;
    //
    //    self.topImage.layer.borderColor = [UIColor colorWithRed:0.0 green:192.0/255.0 blue:1.0 alpha:1.0].CGColor;
    //    self.topImage.layer.borderWidth = 2.0;
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.cornerRadius = 4.0;
    _imageView.layer.borderColor = [UIColor colorWithRed:0.0 green:192.0/255.0 blue:1.0 alpha:1.0].CGColor;
    _imageView.layer.borderWidth = 2.0;
}

@end
