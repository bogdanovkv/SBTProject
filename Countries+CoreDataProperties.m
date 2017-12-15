//
//  Countries+CoreDataProperties.m
//  
//
//  Created by Константин Богданов on 15.12.2017.
//
//

#import "Countries+CoreDataProperties.h"

@implementation Countries (CoreDataProperties)

+ (NSFetchRequest<Countries *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Countries"];
}

@dynamic codeIATA;
@dynamic currency;
@dynamic name;
@dynamic allcities;

@end
