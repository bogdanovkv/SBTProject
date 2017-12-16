//
//  Cities+CoreDataProperties.h
//  SBTProject
//
//  Created by Константин Богданов on 16.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//
//

#import "Cities+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Cities (CoreDataProperties)

+ (NSFetchRequest<Cities *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *codeIATA;
@property (nullable, nonatomic, copy) NSString *countryCode;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *nameRu;
@property (nullable, nonatomic, retain) Countries *parrentCountry;
@property (nullable, nonatomic, retain) Airpots *airport;
@end

NS_ASSUME_NONNULL_END
