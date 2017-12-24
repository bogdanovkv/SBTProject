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

@interface KVBCoreDataServise : NSObject

- (instancetype)initWithContext: (NSManagedObjectContext*) context;
- (NSArray*)recieveCountries;
- (NSArray*)recieveCitiesFromCountry:(Countries*) country;
- (NSArray*)findLocationInEntity:(NSString*) entity withName:(NSString*) name;
- (NSArray*)recieveCityByName:(NSString*)cityName inCountry:(Countries*)country;

@end
