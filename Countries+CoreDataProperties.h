//
//  Countries+CoreDataProperties.h
//  
//
//  Created by Константин Богданов on 15.12.2017.
//
//

#import "Countries+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Countries (CoreDataProperties)

+ (NSFetchRequest<Countries *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *codeIATA;
@property (nullable, nonatomic, copy) NSString *currency;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) Cities *allcities;

@end

NS_ASSUME_NONNULL_END
