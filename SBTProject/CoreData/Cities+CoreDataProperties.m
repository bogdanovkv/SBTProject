//
//  Cities+CoreDataProperties.m
//  SBTProject
//
//  Created by Константин Богданов on 16.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//
//

#import "Cities+CoreDataProperties.h"

@implementation Cities (CoreDataProperties)

+ (NSFetchRequest<Cities *> *)fetchRequest
{
	NSFetchRequest *fetchRequest =  [[NSFetchRequest alloc] initWithEntityName:@"Cities"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"arrival.name" ascending:YES]];
    return fetchRequest;
    
}

@dynamic codeIATA;
@dynamic countryCode;
@dynamic name;
@dynamic parrentCountry;
@dynamic airport;
@dynamic nameRu;


@end
