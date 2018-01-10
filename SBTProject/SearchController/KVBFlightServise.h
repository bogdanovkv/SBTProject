//
//  KVBFlyightsRequests.h
//  SBTProject
//
//  Created by Константин Богданов on 20.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString *const KVBTravelpayouts = @"fe17c550289588390f32bb8a4caf562f";
static NSString *const KVBPopularDirections = @"http://api.travelpayouts.com/v1/city-directions";
static NSString *const KVBCheapTiktetFromCityToCity = @"http://api.travelpayouts.com/v1/prices/cheap";

@class Cities;


@interface KVBFlightServise : NSObject


- (void) recieveCheapTicketsFromCity:(Cities*)departure departmentDate: (NSDate*) departmentDate toCity:(Cities*) destination arrivalDate: (NSDate*) arrivalDate withCompletitionHandler:(void (^)(NSData *data, NSError *error))completionHandler;

- (void) recievePopularDirectionFRomCity:(Cities *)city onPage:(NSInteger)page withCompletitionHandler:(void (^)(NSData *data, NSError *error))completionHandler;

@end
