//
//  YelpYapper.m
//  Glutton
//
//  Created by Tyler on 4/2/15.
//  Copyright (c) 2015 TylerCo. All rights reserved.
//

#import "YelpYapper.h"
#import <AFNetworking/AFNetworking.h>
#import "NSURLRequest+OAuth.h"
#import "CategoryViewController.h"
/**
 Default paths and search terms used in this example
 */
static NSString * const kAPIHost           = @"api.yelp.com";
static NSString * const kSearchPath        = @"/v2/search/";
static NSString * const kBusinessPath      = @"/v2/business/";
static NSString * const kRatingPath        = @"http://s3-media4.fl.yelpassets.com/assets/2/www/img/9f83790ff7f6/ico/stars/v1/stars_large_";

@implementation YelpYapper

+ (NSArray *)getBusinesses {
//    NSLog(@"Should be getting called");
    return [self getBusinesses:0.0];
}

+ (NSArray *)getBusinesses:(float)offsetFromCurrentLocation {
//    NSLog(@"In the other business method");
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [[manager HTTPRequestOperationWithRequest:[self searchRequest:CLLocationCoordinate2DMake(0.0, 0.0) withOffset:0] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",[responseObject objectForKey:@"businesses"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }] start];
    return nil;
}

+ (NSArray *)getBusinessDetail:(NSArray *)ids {
    return nil;
}

+ (NSURL *)URLforBusinesses {
    return nil;
}


+ (NSURLRequest *)businessRequest:(NSString *)business {
    NSString *businessPath = [NSString stringWithFormat:@"%@%@", kBusinessPath, business];
    return [NSURLRequest requestWithHost:kAPIHost path:businessPath];
}

+ (NSURL *)URLforRatingAsset:(NSString *)rating {
    NSString *endPoint = [NSString stringWithFormat:@"%@.png", rating.length > 1 ? [rating stringByReplacingOccurrencesOfString:@".5" withString:@"_half"] : rating];
    return [NSURL URLWithString:[kRatingPath stringByAppendingString:endPoint]];
}

+ (NSString *)CategoryString:(NSArray *)categoryArray {
    
    if ([categoryArray count] == 0) {
        return @"No Categories :(";
    } else if ([categoryArray count] == 1) {
        return [[categoryArray firstObject] firstObject];
    } else {
        NSMutableString *returnString = [[NSMutableString alloc] init];
        for (NSArray *category in categoryArray) {
            [returnString appendFormat:@"%@, ", category[0]];
        }
        return [returnString substringToIndex:[returnString length]-2];
    }
}

+ (NSString *)styledPhoneNumber:(NSString *)phoneNumber {
    if (phoneNumber.length > 6) {
        return [NSString stringWithFormat:@"(%@)%@-%@", [phoneNumber substringToIndex:3], [phoneNumber substringWithRange:NSMakeRange(3, 3)], [phoneNumber substringFromIndex:6]];
    }else{
        return phoneNumber;
    }
 }

///////////////////
#pragma searchRequest

+ (NSURLRequest *)searchRequest_for_getCategory:(NSString*)zipCdoe withOffset:(long)offset {
    
    NSString *strItems = @"restaurants";
    // Get SearchOption
    NSNumber *sort = [searchOptions objectForKey:@"sort"];
    NSNumber *distance = [searchOptions objectForKey:@"distance"];
    distance = @(distance.doubleValue * 1609);
    distance = @(distance.integerValue);
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:zipCdoe forKey:@"location"];
    [params setObject:strItems forKey:@"term"];
    [params setObject:sort forKey:@"sort"];
    [params setObject:distance forKey:@"radius_filter"];
    if (offset > 0) {
        [params setObject:[NSNumber numberWithLong:offset] forKey:@"offset"];
    }
    return [NSURLRequest requestWithHost:kAPIHost path:kSearchPath params:[NSDictionary dictionaryWithDictionary:params]];
}

+ (NSURLRequest *)searchRequest_for_getCategory_location:(CLLocationCoordinate2D)coord withOffset:(long)offset {
    
    NSString *strItems = @"restaurants";
    
    NSNumber *sort = [searchOptions objectForKey:@"sort"];
    NSNumber *distance = [searchOptions objectForKey:@"distance"];
    distance = @(distance.doubleValue * 1609);
    distance = @(distance.integerValue);
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSString stringWithFormat:@"%f,%f", coord.latitude, coord.longitude] forKey:@"ll"];
    [params setObject:strItems forKey:@"term"];
    [params setObject:sort forKey:@"sort"];
    [params setObject:distance forKey:@"radius_filter"];
    
    if (offset > 0) {
        [params setObject:[NSNumber numberWithLong:offset] forKey:@"offset"];
    }
    return [NSURLRequest requestWithHost:kAPIHost path:kSearchPath params:[NSDictionary dictionaryWithDictionary:params]];
}

+ (NSURLRequest *)searchRequest:(CLLocationCoordinate2D)coord withOffset:(long)offset {
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *curZipcode = [defaults objectForKey:@"currentzipcode"];
    NSString *curCategoryKey = [defaults objectForKey:@"currentcategoryKey"];
    
    NSNumber *sort = [searchOptions objectForKey:@"sort"];
    NSNumber *distance = [searchOptions objectForKey:@"distance"];
    distance = @(distance.doubleValue * 1609);
    distance = @(distance.integerValue);
    
    NSString *strLocation = [searchOptions objectForKey: @"ll"];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSString *strDishe = [defaults objectForKey:@"sel_dishi"];
    //strDishe = [strDishe stringByAppendingString:@" restaurants"];
    
    NSString *strFromCategory = [defaults objectForKey:@"from_category"];
    if ([strFromCategory isEqualToString:@"1"]) { // from category window
        [params setObject:@"restaurants" forKey:@"term"]; // term
        [params setObject:curCategoryKey forKey:@"category_filter"];
    }else{ // from dishe window
        [params setObject:strDishe forKey:@"term"]; // term
    }
        
       //location
    if ([curZipcode isEqualToString:@"local"]) {
        [params setObject:strLocation forKey:@"ll"];
    }else{ //zipCode search
        [params setObject:curZipcode forKey:@"location"];
    }
    [params setObject:sort forKey:@"sort"];
    [params setObject:distance forKey:@"radius_filter"];
//    NSNumber *deal = [[NSNumber alloc] initWithBool:YES];
//    [params setObject:deal forKey:@"deals_filter"];
    if (offset > 0) {
        [params setObject:[NSNumber numberWithLong:offset] forKey:@"offset"];
    }
    return [NSURLRequest requestWithHost:kAPIHost path:kSearchPath params:[NSDictionary dictionaryWithDictionary:params]];
}

@end
