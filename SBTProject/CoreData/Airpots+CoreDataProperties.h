//
//  Airpots+CoreDataProperties.h
//  SBTProject
//
//  Created by Константин Богданов on 16.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//
//

#import "Airpots+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Airpots (CoreDataProperties)

+ (NSFetchRequest<Airpots *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *codeIATA;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *nameRu;
@property (nullable, nonatomic, copy) NSString *country_codeIATA;
@property (nullable, nonatomic, copy) NSString *city_codeIATA;
@property (nonatomic, assign) NSInteger classNumber;
@property (nullable, nonatomic, retain) Cities *parrrentCity;
@property (nullable, nonatomic, retain) Countries *parrentCountry;

@end

NS_ASSUME_NONNULL_END
