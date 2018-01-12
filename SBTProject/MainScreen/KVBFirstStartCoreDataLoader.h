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

extern NSString * const KVBTravelpayouts;
extern NSString * const KVBLocationsRequestWhereAreMe;
extern NSString * const KVBRequestAllCountries;
extern NSString * const KVBRequestAllCities;
extern NSString * const KVBRequestAllAirports;


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
