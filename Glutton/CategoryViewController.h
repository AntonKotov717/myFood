//
//  CollectionViewController.h
//  Glutton
//
//  Created by Tyler Corley on 4/4/15.
//  Copyright (c) 2015 TylerCo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"
#import <CoreLocation/CoreLocation.h>
@interface CategoryViewController : UICollectionViewController<CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
    
    
}
-(void) RunSearch;
extern NSMutableDictionary *searchOptions;

@end
