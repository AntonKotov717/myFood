//
//  SelDishiViewController.h
//  Glutton
//
//  Created by dev on 1/22/16.
//  Copyright © 2016 TylerCo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelDishiViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *dishiCollection;

@end
