//
//  KVBFlyightModel.h
//  SBTProject
//
//  Created by Константин Богданов on 21.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVBFlyightModel : NSObject

@property(nonatomic, copy) NSString *airlineName;
@property(nonatomic, copy) NSString *departureCode;
@property(nonatomic, copy) NSString *arrivalCode;
@property(nonatomic, strong) NSDate *departureDate;
@property(nonatomic, strong) NSDate *arrivalDate;
@property(nonatomic, assign) NSInteger cost;
@property(nonatomic, assign) NSInteger flightNumber;
@property(nonatomic, assign) NSInteger classNumber;

+ (NSArray<KVBFlyightModel*>*) arrayFromDictionaries:(NSDictionary*) flightsDictionary;
+ (NSArray<KVBFlyightModel*>*)arrayFromDictionariesWithjClassType:(NSDictionary*) flightsDictionary;

- (instancetype)initWithDictionary:(NSDictionary*) flightDictionary;

@end
