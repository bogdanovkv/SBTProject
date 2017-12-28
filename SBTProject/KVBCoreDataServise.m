//
//  KVBCoreDataServise.m
//  SBTProject
//
//  Created by Константин Богданов on 24.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBCoreDataServise.h"
#import "Cities+CoreDataClass.h"
#import "Countries+CoreDataClass.h"
#import "Airpots+CoreDataClass.h"
#import "Flyight+CoreDataClass.h"
#import "KVBFlyightModel.h"

@interface KVBCoreDataServise()

@property(nonatomic, strong) NSManagedObjectContext *context;

@end

@implementation KVBCoreDataServise

- (instancetype)initWithContext:(NSManagedObjectContext *)context
{
    self = [super init];
    if (self) {
        _context = context;
    }
    return self;
}

- (NSArray*)recieveCountries
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Countries class])];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    
    return [self.context executeFetchRequest:fetchRequest error:nil];
}

- (NSArray*)recieveCitiesFromCountry:(Countries*) country
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Cities class])];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"countryCode == %@", country.codeIATA];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    
    NSArray<Cities*> *arrayWithCities = [self.context executeFetchRequest:fetchRequest error:nil];
    
    for (Cities* city in arrayWithCities)
    {
        [self setupParentCountry:country forCity:city];
    }
    [self.context save:nil];

    return arrayWithCities;
}

- (NSArray*)findLocationInEntity:(NSString*) entity withName:(NSString*) name
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entity];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"name == (%@) OR nameRu == %@",[name capitalizedString] ,[name capitalizedString]];
    
    return [self.context executeFetchRequest:fetchRequest error:nil];
}

- (NSArray*)recieveCityByName:(NSString*)cityName inCountry:(Countries*)country
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Cities class])];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"(nameRu == %@ OR name == %@) AND countryCode==%@", cityName, cityName, country.codeIATA];
    
    NSArray *cityInArray = [self.context executeFetchRequest:fetchRequest error:nil];
    
    [self setupParentCountry:country forCity:cityInArray.firstObject];
    
    return cityInArray;
}

- (NSArray<Cities*>*)recieveCityByCityCode:(NSString*)codeIATA
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Cities class])];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"codeIATA == %@", codeIATA];
    
    NSArray *cityInArray = [self.context executeFetchRequest:fetchRequest error:nil];
    
    return cityInArray;
}


- (void)setupParentCountry:(Countries*)parrenntCountry forCity:(Cities*)city
{
    if (city.parrentCountry == nil)
    {
        city.parrentCountry = parrenntCountry;
    }
}

- (void)saveFlight:(KVBFlyightModel*)flyightModel
{
    Flyight *flight = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Flyight class]) inManagedObjectContext:self.context];
    flight.airline = flyightModel.airlineCode;
    flight.arrivalDate = flyightModel.arrivalDate;
    flight.classNumber = flyightModel.classNumber;
    flight.cost = (int)flyightModel.cost;
    flight.departureDate = flyightModel.departureDate;
    flight.flightNumber = flyightModel.flightNumber;
    
    flight.departure = [self recieveCityByCityCode:flyightModel.departureCode].firstObject;
    flight.arrival = [self recieveCityByCityCode:flyightModel.arrivalCode].firstObject;
//
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Flyight class])];
//    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"airline == %@ AND arrivalDate == %@ AND arrivalDate == %@ AND classNumber == %li AND cost == %li AND departureDate "]
    NSError *error = nil;
    [self.context save:&error];
    
    if(!error)
    {
        NSLog(@"\n%@",error.userInfo);
    }

}

- (NSArray<Flyight*>*)recieveAllFlyights
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Flyight class])];
    
    return [self.context executeFetchRequest:fetchRequest error:nil];
}

@end
