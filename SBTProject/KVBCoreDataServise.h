//
//  KVBCoreDataServise.h
//  SBTProject
//
//  Created by Константин Богданов on 24.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Cities;
@class Countries;
@class Flyight;
@class KVBFlyightModel;

@interface KVBCoreDataServise : NSObject

@property(nonatomic, readonly, strong) NSManagedObjectContext *context;

- (instancetype)initWithContext: (NSManagedObjectContext*) context;
- (NSArray*)recieveCountries;
- (NSArray<Cities*>*)recieveCitiesFromCountry:(Countries*) country;
- (NSArray<Cities*>*)recieveCityByCityCode:(NSString*)codeIATA;
- (NSArray*)findLocationInEntity:(NSString*) entity withName:(NSString*) name;
- (NSArray<Cities*>*)recieveCityByName:(NSString*)cityName inCountry:(Countries*)country;
- (NSArray<Flyight*>*)recieveAllFlyights;
- (void)saveFlight:(KVBFlyightModel*)flyightModel;
- (void)deleteFlight:(Flyight*)flight;

@end
