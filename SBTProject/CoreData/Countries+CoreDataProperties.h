//
//  Countries+CoreDataProperties.h
//  SBTProject
//
//  Created by Константин Богданов on 16.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//
//

#import "Countries+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Countries (CoreDataProperties)

+ (NSFetchRequest<Countries *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *codeIATA;
@property (nullable, nonatomic, copy) NSString *currency;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *nameRu;
@property (nullable, nonatomic, retain) Cities *allcities;
@property (nullable, nonatomic, retain) Airpots *airport;

@end

NS_ASSUME_NONNULL_END
