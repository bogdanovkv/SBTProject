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

@dynamic codeIATA;
@dynamic name;
@dynamic country_codeIATA;
@dynamic city_codeIATA;
@dynamic classNumber;
@dynamic parrrentCity;
@dynamic parrentCountry;
@dynamic nameRu;

+ (NSFetchRequest<Airpots *> *)fetchRequest {
    return [[NSFetchRequest alloc] initWithEntityName:@"Airpots"];
}

@end
