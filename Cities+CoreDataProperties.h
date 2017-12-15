//
//  Cities+CoreDataProperties.h
//  
//
//  Created by Константин Богданов on 15.12.2017.
//
//

#import "Cities+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Cities (CoreDataProperties)

+ (NSFetchRequest<Cities *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *codeIATA;
@property (nullable, nonatomic, copy) NSString *countryCode;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) Countries *parrentCountry;

@end

NS_ASSUME_NONNULL_END
