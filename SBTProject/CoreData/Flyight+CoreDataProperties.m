//
//  Flyight+CoreDataProperties.m
//  
//
//  Created by Константин Богданов on 30.12.2017.
//
//

#import "Flyight+CoreDataProperties.h"

@implementation Flyight (CoreDataProperties)

+ (NSFetchRequest<Flyight *> *)fetchRequest {
    NSFetchRequest *fetchRequest =  [[NSFetchRequest alloc] initWithEntityName:@"Flyight"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"arrival.name" ascending:YES]];
    return fetchRequest;
}

@dynamic airline;
@dynamic arrivalDate;
@dynamic classNumber;
@dynamic cost;
@dynamic departureDate;
@dynamic flightNumber;
@dynamic arrival;
@dynamic departure;

@end
