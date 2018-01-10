//
//  KVBFlyightModel.m
//  SBTProject
//
//  Created by Константин Богданов on 21.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBFlyightModel.h"
#import "Flyight+CoreDataClass.h"
#import "Cities+CoreDataClass.h"


@implementation KVBFlyightModel


+ (NSArray<KVBFlyightModel*>*)arrayFromDictionaries:(NSDictionary*)flightsDictionary
{
    if (!flightsDictionary)
    {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    
    NSArray *allKeys = flightsDictionary.allKeys;
    
    for(NSString *key in allKeys)
    {
        KVBFlyightModel *flight = [[KVBFlyightModel alloc]initWithDictionary:flightsDictionary[key]];
        [array addObject:flight];
    }
    return array;
}

+ (NSArray<KVBFlyightModel*>*)arrayFromDictionariesWithjClassType:(NSDictionary*)flightsDictionary
{
    if (!flightsDictionary)
    {
        return nil;
    }
    
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
    if (!flightDictionary)
    {
        return nil;
    }
    
    self = [super init];
    if (self) {
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

- (instancetype)initWithFlight:(Flyight*)flight
{
    self = [super init];
    if(self)
    {
        _airlineCode = flight.airline;
        _departureDate = flight.departureDate;
        _departureCode = flight.departure.codeIATA;
        _arrivalCode = flight.arrival.codeIATA;
        _cost = flight.cost;
        _classNumber = flight.classNumber;
        _arrivalDate = flight.arrivalDate;
        _flightNumber = flight.flightNumber;
    }
    return self;
}
- (NSString*)validValueFromString:(NSString*)inputString
{
    NSString *validString = @"No info";
    if(inputString.length)
    {
        validString = inputString;
    }
    return validString;
}
          
- (NSDate*)dateFromString:(NSString*)dateString
{
    if (!dateString.length)
    {
        return nil;
    }
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
    
    return [dateFormatter dateFromString:dateString];
}

@end
