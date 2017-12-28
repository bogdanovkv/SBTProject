//
//  KVBFlyightModel.m
//  SBTProject
//
//  Created by Константин Богданов on 21.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBFlyightModel.h"

@implementation KVBFlyightModel

+ (NSArray<KVBFlyightModel*>*)arrayFromDictionaries:(NSDictionary*) flightsDictionary
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSArray *allKeys = [flightsDictionary allKeys];
    
    for(NSString *key in allKeys)
    {
        KVBFlyightModel *flight = [[KVBFlyightModel alloc] initWithDictionary:flightsDictionary[key]];
        [array addObject:flight];
        
    }
    return array;
}

+ (NSArray<KVBFlyightModel*>*)arrayFromDictionariesWithjClassType:(NSDictionary*) flightsDictionary
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSArray *allKeys = [flightsDictionary allKeys];
    
    for(NSString *key in allKeys)
    {
        NSArray *arrayWithClassKeys = [flightsDictionary[key] allKeys];
        for (NSString *keyClass in arrayWithClassKeys)
        {
            KVBFlyightModel *flight = [[KVBFlyightModel alloc] initWithDictionary:flightsDictionary[key][keyClass]];
            flight.classNumber = [keyClass integerValue];
            flight.arrivalCode = [[self alloc] validValueFromString:key];
            [array addObject:flight];
        }
    }
    return array;
}

- (instancetype)initWithDictionary:(NSDictionary*)flightDictionary
{
    self = [super init];
    if (self) {
        _airlineName = [self validValueFromString:flightDictionary[@"airline"]];
        _arrivalCode = [self validValueFromString:flightDictionary[@"destination"]];
        _departureCode = [self validValueFromString:flightDictionary[@"origin"]];
        _departureDate = [self dateFromString:flightDictionary[@"departure_at"] ];
        _arrivalDate = [self dateFromString:flightDictionary[@"return_at"]];
        _airlineCode = [self validValueFromString:flightDictionary[@"airline"]];
        _cost = [flightDictionary[@"price"] integerValue];
        _flightNumber = [flightDictionary[@"flight_number"] integerValue];
    }
    return self;
}

- (NSString*)validValueFromString:(NSString*) inputString
{
    NSString *validString = @"No info";
    if(inputString)
    {
        validString = inputString;
    }
    return validString;
}
          
- (NSDate*)dateFromString:(NSString*)dateString
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
    return [dateFormatter dateFromString:dateString];
}

//FlyightDictionary
//MIL =         {
//    airline = I9;
//    "departure_at" = "2018-01-23T13:15:00Z";
//    destination = MIL;
//    "expires_at" = "2017-12-24T03:37:46Z";
//    "flight_number" = 822;
//    origin = MOW;
//    price = 4773;
//    "return_at" = "2018-01-26T16:30:00Z";
//    transfers = 0;
//};


@end
