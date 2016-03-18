//
//  CategoryAllViewController.m
//  Glutton
//
//  Created by dev on 1/23/16.
//  Copyright © 2016 TylerCo. All rights reserved.
//

#import "CategoryAllViewController.h"
#import "CategoryViewController.h"
#import "SelDishiViewController.h"
#import "FilterTableVC.h"

@interface CategoryAllViewController ()<UISearchBarDelegate>

@property (strong, nonatomic) CategoryViewController *cat_Viewcontroller;
@property (strong, nonatomic) SelDishiViewController *selDishi_Viewcontroller;


@property (strong, nonatomic) NSString *defaultZipCode;

//restaurantVC
@property (strong, nonatomic) UIButton *filterButton;

@property (strong, nonatomic) UIButton *dishiButton;

@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) FilterTableVC *filterController;

// get location Info
@property (nonatomic) CLLocationCoordinate2D currentLocation;

// Is Selected Dishe || Cuisine
@property (nonatomic) bool IsDishe;

@end

@implementation CategoryAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getLocationInfo];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.defaultZipCode = [defaults objectForKey:@"default_zipcode"];
    if (!self.defaultZipCode) {
        self.defaultZipCode = @"local";
        [defaults setObject:self.defaultZipCode forKey:@"default_zipcode"];
    }
    // searchBar & filter setup
    [self setupFilterButton:@"Sort"];
    [self setupSearchBar];
    [self setupFilterView];

    if (!searchOptions){
        [self setupSearchOptions];
    }
    [self.searchBar setPlaceholder:@"city, state or zip code"];
    
    _IsDishe = true; // Dishe
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)OnSelContainer:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    if (selectedSegment == 0) {
        
        [UIView animateWithDuration:(0.5) animations:^{
            self.containerA.alpha = 1;
            self.containerB.alpha = 0;
        
        }];
        _IsDishe = true; // Dishe
        
        
//        //toggle the correct view to be visible
//        [self.containerA setHidden: NO];
//        [self.containerB setHidden: YES];
    }
    else{
        
        [UIView animateWithDuration:(0.5) animations:^{
            self.containerA.alpha = 0;
            self.containerB.alpha = 1;
            _IsDishe = false; // Cuisine
            //ZipCode change || SearchOption Change
            if ([[searchOptions objectForKey:@"IsSearch"] isEqualToString:@"1"]) { // Search option change || Zipcode change
                [_cat_Viewcontroller RunSearch];
                [searchOptions setObject:@"0" forKey:@"IsSearch"];
            }
        }];
        
//        //toggle the correct view to be visible
//        [self.containerA setHidden: YES];
//        [self.containerB setHidden: NO];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"selDishi"]) {
        _selDishi_Viewcontroller = (SelDishiViewController *)[segue destinationViewController];
        //[embed setRestaurant:self.restaurant];
    }else{ // "selCat"
        _cat_Viewcontroller = (CategoryViewController *)[segue destinationViewController];
    }
}

#pragma searchBar

- (void)setupFilterButton:(NSString *)buttonTitle {
    self.filterButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    // [self.filterButton setBackgroundColor:[UIColor redColor]];
    [self.filterButton.layer setBorderWidth:1.5f];
    [self.filterButton.layer setBorderColor:[UIColor brownColor].CGColor];
    [self.filterButton setTitle:buttonTitle forState:UIControlStateNormal];
    [self.filterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.filterButton addTarget:self action:@selector(filterButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setupSearchBar {
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(100.0f, 10.0f, 100.0f, 15.0f)];
    [self.searchBar setPlaceholder:[[NSString alloc] initWithFormat:@"%@", self.defaultZipCode]];
    self.searchBar.delegate = self;
    self.searchBar.showsCancelButton = YES;
    //self.searchBar.keyboardType = UIKeyboardTypeNumberPad;
    self.searchBar.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    UIBarButtonItem *filterBarRight = [[UIBarButtonItem alloc] initWithCustomView:self.filterButton];
    
    [self.navigationItem setTitleView:self.searchBar];
    [self.navigationItem setLeftBarButtonItem:filterBarRight];
    
//    UIBarButtonItem *filterBarLeft = [[UIBarButtonItem alloc] initWithCustomView:self.dishiButton];
//    
//    [self.navigationItem setTitleView:self.searchBar];
//    [self.navigationItem setLeftBarButtonItem:filterBarLeft];
    
    //    [self.navigationController.navigationBar setBackgroundColor:[UIColor redColor]];
    //    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    //[self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setAlpha:1.0f];
    
    
    
    //    self.myNavigationBarItem.titleView = searchBar;
    //    UIBarButtonItem *searchBarItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
    //    self.navigationBarItem.rightBarButtonItem = searchBarItem;
    //    self.myNavigationBarItem.leftBarButtonItem = filterBarItem;
    
    //    [self.navigationController setToolbarHidden:YES];
}

- (void)setupFilterView {
    self.filterController = [[FilterTableVC alloc] initWithNibName:@"FilterTableVC" bundle:nil];
    
}

- (void)filterButtonAction {
    if(!self.filterController)
        NSLog(@"filter is nil");
    [self.navigationController pushViewController: self.filterController animated:YES];
}


- (void)setupSearchOptions {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    searchOptions = [[defaults objectForKey:@"searchOption"] mutableCopy]; // read searchOption
    if (searchOptions == nil) {
        searchOptions = [[NSMutableDictionary alloc] init];
        NSNumber *match = [[NSNumber alloc] initWithLong:0]; //BestMatch
        [searchOptions setObject:match forKey:@"sort"];
        NSNumber *num = [[NSNumber alloc] initWithDouble:3]; //3 mile
        [searchOptions setObject:num forKey:@"distance"];
        NSNumber *swiperesults = [[NSNumber alloc] initWithDouble:20]; //3 mile
        [searchOptions setObject:swiperesults forKey:@"swiperesults"];
        //    NSMutableArray *category = [[NSMutableArray alloc] initWithObjects:@"thai", nil];
        //    [searchOptions setObject:category forKey:@"category"];
    }
    NSString *strLocation = [[NSString alloc]initWithFormat:@"%f,%f",_currentLocation.latitude, _currentLocation.longitude];
    [searchOptions setObject:strLocation forKey: @"ll"];
    if ([self.defaultZipCode isEqualToString:@"local"]) {
        [searchOptions setObject:@"1" forKey:@"IsSearch"];
    }
    
}


//#pragma mark - UISearchBar delegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self.searchBar setPlaceholder:@"city, state or zip code"];
    
    NSLog(@"Calcel Button Clicked");
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    NSLog(@"TextDidEndEditing");
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"TextDidBeginEditing");
    //reset the search bar
    //    searchBar.text = self.defaultZipCode;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    if (![self.defaultZipCode isEqualToString:searchBar.text]) {
        self.defaultZipCode = searchBar.text;
        // zipCode save
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.defaultZipCode forKey:@"default_zipcode"];
       
        if (_IsDishe) { // Dishe
            [searchOptions setObject:@"1" forKey:@"IsSearch"]; // ZipCode Change Search
        }else{ // Cuisine
            [_cat_Viewcontroller RunSearch];
        }
                
    }
}

// get location info
-(void) getLocationInfo{
    self->locationManager = [[CLLocationManager alloc] init];
    self->locationManager.delegate = self;
    self->locationManager.distanceFilter = kCLDistanceFilterNone;
    self->locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self->locationManager startUpdatingLocation];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [self->locationManager requestWhenInUseAuthorization];
    }
    
    self.currentLocation = [self->locationManager location].coordinate;
    
    [self->locationManager stopUpdatingLocation];
    
}


@end
