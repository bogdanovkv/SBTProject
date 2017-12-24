//
//  Countries+CoreDataProperties.m
//  SBTProject
//
//  Created by Константин Богданов on 16.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
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
@dynamic childCity;
@dynamic airport;
@dynamic nameRu;

@end
