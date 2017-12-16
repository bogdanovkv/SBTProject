//
//  Airpots+CoreDataProperties.m
//  SBTProject
//
//  Created by Константин Богданов on 16.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//
//

#import "Airpots+CoreDataProperties.h"

@implementation Airpots (CoreDataProperties)

+ (NSFetchRequest<Airpots *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Airpots"];
}

@dynamic codeIATA;
@dynamic name;
@dynamic country_codeIATA;
@dynamic city_codeIATA;
@dynamic parrrentCity;
@dynamic parrentCountry;
@dynamic nameRu;

@end
