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
static NSString *const KVBCheapTiktetFromCityToCity = @"http://api.travelpayouts.com/v1/prices/calendar";

@class Cities;
@interface KVBFlyightsRequests : NSObject
@property(nonatomic, weak) id<NSURLSessionDataDelegate, NSURLSessionDelegate> user;

- (void) recieveCheapTicketsOnPage: (NSInteger) page;
- (void) recievePopularDirectionFRomCity:(Cities*)city onPage: (NSInteger) page;
- (void) recieveCheapTicketsFromCity:(Cities*)departure fromCity:(Cities*) destination onPage: (NSInteger) page;


@end
