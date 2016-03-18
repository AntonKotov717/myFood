//
//  CategoryAllViewController.h
//  Glutton
//
//  Created by dev on 1/23/16.
//  Copyright © 2016 TylerCo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface CategoryAllViewController : UIViewController<CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
}
@property (weak, nonatomic) IBOutlet UIView *containerA;
@property (weak, nonatomic) IBOutlet UIView *containerB;

- (IBAction)OnSelContainer:(id)sender;
@end
