//
//  Flyight+CoreDataProperties.h
//  
//
//  Created by Константин Богданов on 30.12.2017.
//
//

#import "Flyight+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Flyight (CoreDataProperties)


+ (NSFetchRequest<Flyight *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *airline;
@property (nullable, nonatomic, copy) NSDate *arrivalDate;
@property (nonatomic) int16_t classNumber;
@property (nonatomic) int32_t cost;
@property (nullable, nonatomic, copy) NSDate *departureDate;
@property (nonatomic) int16_t flightNumber;
@property (nullable, nonatomic, retain) Cities *arrival;
@property (nullable, nonatomic, retain) Cities *departure;


@end

NS_ASSUME_NONNULL_END
