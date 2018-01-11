//
//  KVBPreparatoryCoreData.h
//  SBTProject
//
//  Created by Константин Богданов on 15.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSManagedObjectContext;
@protocol KVBFirstStartLoadingDelegate;

static NSString * const KVBTravelpayouts = @"fe17c550289588390f32bb8a4caf562f";
static NSString * const KVBLocationsRequestWhereAreMe = @"http://www.travelpayouts.com/whereami";
static NSString * const KVBRequestAllCountries = @"http://api.travelpayouts.com/data/countries.json";
static NSString * const KVBRequestAllCities = @"http://api.travelpayouts.com/data/cities.json";
static NSString * const KVBRequestAllAirports = @"http://api.travelpayouts.com/data/airports.json";


@interface KVBFirstStartCoreDataLoader : NSObject <NSURLSessionDelegate>


@property(nonatomic, copy) NSDictionary *currentLocation;
@property(nonatomic, copy) NSDictionary *countriesDictionary;
@property(nonatomic, copy) NSDictionary *citiesDictionary;
@property(nonatomic, copy) NSDictionary *airportDictionary;
@property(nonatomic, weak) id<KVBFirstStartLoadingDelegate> delegate;

- (instancetype)initWithContext:(NSManagedObjectContext*)context;



@end


@protocol KVBFirstStartLoadingDelegate


- (void)loadingComplete;


@end
