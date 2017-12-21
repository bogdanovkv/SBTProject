//
//  KVBFlyightModel.h
//  SBTProject
//
//  Created by Константин Богданов on 21.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVBFlyightModel : NSObject
@property(nonatomic, strong) NSString *airlineName;
@property(nonatomic, strong) NSString *destinationCode;
@property(nonatomic, strong) NSString *arrivalCode;
@property(nonatomic, strong) NSDate *departureDate;
@property(nonatomic, strong) NSDate *arrivalDate;
@property(nonatomic, assign) NSInteger cost;
@property(nonatomic, assign) NSInteger flightNumber;

+ (NSArray<KVBFlyightModel*>*) arrayFromDictionaries:(NSDictionary*) flightsDictionary;
- (instancetype)initWithDictionary:(NSDictionary*) flightDictionary;

@end
