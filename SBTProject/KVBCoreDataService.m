//
//  KVBCoreDataServise.m
//  SBTProject
//
//  Created by Константин Богданов on 24.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBCoreDataService.h"
#import "Cities+CoreDataClass.h"
#import "Countries+CoreDataClass.h"
#import "Airpots+CoreDataClass.h"
#import "Flyight+CoreDataClass.h"
#import "KVBFlyightModel.h"

@interface KVBCoreDataService()

@property(nonatomic, strong) dispatch_queue_t queue;

@end

@implementation KVBCoreDataService

- (instancetype)initWithContext:(NSManagedObjectContext *)context
{
    self = [super init];
    if (self) {
        _context = context;
        _queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
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
    [self save];

    return arrayWithCities;
}

- (NSArray*)findLocationInEntity:(NSString*)entity withName:(NSString*)name
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entity];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"name == %@ OR nameRu == %@",[name capitalizedString] ,[name capitalizedString]];
    
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

- (NSArray<Flyight*>*)recieveAllFlyights
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Flyight class])];
    
    return [self.context executeFetchRequest:fetchRequest error:nil];
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
    
    if ([self existFlightInCoreData:flyightModel])
    {
        return;
    }
    
    Flyight *flight = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Flyight class]) inManagedObjectContext:self.context];
    
    flight.airline = flyightModel.airlineCode;
    flight.arrivalDate = flyightModel.arrivalDate;
    flight.classNumber = flyightModel.classNumber;
    flight.cost = (int)flyightModel.cost;
    flight.departureDate = flyightModel.departureDate;
    flight.flightNumber = flyightModel.flightNumber;
    flight.departure = [self recieveCityByCityCode:flyightModel.departureCode].firstObject;
    flight.arrival = [self recieveCityByCityCode:flyightModel.arrivalCode].firstObject;
    
    [self save];
}

- (BOOL)existFlightInCoreData:(KVBFlyightModel*)flyightModel
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Flyight class])];
    
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"airline == %@ AND classNumber == %li AND cost == %i AND flightNumber == %li",
                              flyightModel.airlineCode,
                              flyightModel.classNumber,
                              (int)flyightModel.cost,
                              flyightModel.flightNumber];
    
    NSArray *sameFlights = [self.context executeFetchRequest:fetchRequest error:nil];
    
    if (sameFlights.count == 0)
    {
        return NO;
    }
    
    for(Flyight *flight in sameFlights)
    {
        if ([flight.departureDate isEqual:flyightModel.departureDate] && [flight.arrivalDate isEqual:flyightModel.arrivalDate])
        {
            return YES;
        }
    }
    return NO;
}

- (void)deleteFlight:(Flyight*)flight
{
    [self.context deleteObject:flight];
    [self save];
}

- (void)deleAllFlights
{
    NSArray *allFlights = [self.context executeFetchRequest:[Flyight fetchRequest] error:nil];
    
    for (id flight in allFlights)
    {
        [self.context deleteObject:flight];
    }
    [self save];
}


#pragma mark FirstStart

- (BOOL)insertCountriesInCoreDataFromDictionary:(NSArray*)countriesDictionary
{
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Countries"] isEqualToString: @"Exist"])
    {
        return YES;
    }

        for (NSDictionary *country in countriesDictionary)
        {
            Countries *newCountry = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Countries class]) inManagedObjectContext:self.context];
            newCountry.name = country[@"name"];
            newCountry.codeIATA = country[@"code"];
            newCountry.currency = [NSString stringWithFormat:@"%@", country[@"currency"]];
        
            NSDictionary *namesCountries = country[@"name_translations"];
        
            newCountry.nameRu = namesCountries[@"ru"];
        }

    [self save];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSUserDefaults standardUserDefaults] setValue:@"Exist" forKey:@"Countries"];
    });
    
   

    return YES;
}

- (BOOL)insertCitiesInCoreDataFromDictionary:(NSArray*)citiesDictionary
{
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Cities"] isEqualToString: @"Exist"])
    {
        return YES;
    }

        for (NSDictionary *city in citiesDictionary)
        {
            Cities *newCity = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Cities class]) inManagedObjectContext:self.context];
            newCity.name = city[@"name"];
            newCity.codeIATA = city[@"code"];
            newCity.countryCode =city[@"country_code"];
        
            NSDictionary *namesCities = city[@"name_translations"];
            
            newCity.nameRu = namesCities[@"ru"];
        }
    
    [self save];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSUserDefaults standardUserDefaults] setValue:@"Exist" forKey:@"Cities"];
    });
    
    return YES;
}

- (void)save
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.context hasChanges] && ![self.context save:nil]){}
    });
    


}


@end
