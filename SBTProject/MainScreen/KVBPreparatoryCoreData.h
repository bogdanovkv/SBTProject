//
//  KVBPreparatoryCoreData.h
//  SBTProject
//
//  Created by Константин Богданов on 15.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const KVBTravelpayouts = @"fe17c550289588390f32bb8a4caf562f";
static NSString *const KVBLocationsRequestWhereAreMe = @"http://www.travelpayouts.com/whereami";
static NSString *const KVBRequestAllCountries = @"http://api.travelpayouts.com/data/countries.json";
static NSString *const KVBRequestAllCities = @"http://api.travelpayouts.com/data/cities.json";
static NSString *const KVBRequestAllAirports = @"http://api.travelpayouts.com/data/airports.json";

@interface KVBPreparatoryCoreData : NSObject <NSURLSessionDelegate>

@property(nonatomic, copy) NSDictionary *countriesArray;
@property(nonatomic, copy) NSDictionary *citiesArray;
@property(nonatomic, copy) NSDictionary *airportsArray;


@end
