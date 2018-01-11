//
//  KVBRequest.h
//  SBTProject
//
//  Created by Константин Богданов on 14.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <Foundation/Foundation.h>


@class NSManagedObjectContext;
@protocol KVBFirstStartLoadingDelegate;


@interface KVBLocationServise : NSObject


@property(nonatomic, copy) NSDictionary *currentLoacation;

- (instancetype)initWithDelegate:(id<KVBFirstStartLoadingDelegate>)delegate withContex:(NSManagedObjectContext*)context;
- (void)whereAreMeWithComletition:(void (^)(NSString *countryName, NSString *cityName, NSString *stringError))completionHandler;
- (void)recieveAllContriesWithCities;


@end
