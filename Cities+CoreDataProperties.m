//
//  Cities+CoreDataProperties.m
//  
//
//  Created by Константин Богданов on 15.12.2017.
//
//

#import "Cities+CoreDataProperties.h"

@implementation Cities (CoreDataProperties)

+ (NSFetchRequest<Cities *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Cities"];
}

@dynamic codeIATA;
@dynamic countryCode;
@dynamic name;
@dynamic parrentCountry;

@end
