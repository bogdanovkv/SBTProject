//
//  KVBPreparatoryCoreData.m
//  SBTProject
//
//  Created by Константин Богданов on 15.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBFirstStartCoreDataLoader.h"
#import "Cities+CoreDataClass.h"
#import "Countries+CoreDataClass.h"
#import "Airpots+CoreDataClass.h"
#import "AppDelegate.h"

NSString * const KVBTravelpayouts = @"fe17c550289588390f32bb8a4caf562f";
NSString * const KVBLocationsRequestWhereAreMe = @"http://www.travelpayouts.com/whereami";
NSString * const KVBRequestAllCountries = @"http://api.travelpayouts.com/data/countries.json";
NSString * const KVBRequestAllCities = @"http://api.travelpayouts.com/data/cities.json";
NSString * const KVBRequestAllAirports = @"http://api.travelpayouts.com/data/airports.json";

@interface KVBFirstStartCoreDataLoader()


@property(nonatomic, strong) NSManagedObjectContext *context;
@property(nonatomic, copy) NSDictionary *countriesDictionary;
@property(nonatomic, copy) NSDictionary *citiesDictionary;
@property(nonatomic, copy) NSDictionary *airportDictionary;

@end


@implementation KVBFirstStartCoreDataLoader

- (instancetype)initWithContext:(NSManagedObjectContext*)context
{
    self = [super init];
    if (self)
    {
        _context = context;
    }
    return self;
}

#pragma mark -NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location
{
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfURL:location];
    NSDictionary* reciever = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
   
    if(!error)
    {
            if([downloadTask.currentRequest.URL isEqual:[NSURL URLWithString: KVBRequestAllCountries]])
        {
            self.countriesDictionary = reciever;
        }
        if([downloadTask.currentRequest.URL isEqual:[NSURL URLWithString: KVBRequestAllCities]])
        {
            self.citiesDictionary = reciever;
        }
    
        if([downloadTask.currentRequest.URL isEqual:[NSURL URLWithString: KVBRequestAllAirports]])
        {
            self.airportDictionary = reciever;
        }
        
        if(self.countriesDictionary.count != 0 && self.citiesDictionary.count != 0 && self.airportDictionary.count != 0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                        [self setupCoreData];
            
            });
        }
    }

}


-(void)setupCoreData
{
    
    for (NSDictionary *country in self.countriesDictionary)
    {
        Countries *newCountry = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Countries class]) inManagedObjectContext:self.context];
        newCountry.name = country[@"name"];
        newCountry.codeIATA = country[@"code"];
        newCountry.currency = [NSString stringWithFormat:@"%@", country[@"currency"]];
        
        NSDictionary *namesCountries = country[@"name_translations"];
        
        newCountry.nameRu = namesCountries[@"ru"];
    }
    
    for (NSDictionary *city in self.citiesDictionary)
    {
        Cities *newCity = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Cities class]) inManagedObjectContext:self.context];
        newCity.name = city[@"name"];
        newCity.codeIATA = city[@"code"];
        newCity.countryCode =city[@"country_code"];
        
        NSDictionary *namesCities = city[@"name_translations"];
        
        newCity.nameRu = namesCities[@"ru"];
    }
    
    for (NSDictionary *airport in self.airportDictionary)
    {
        Airpots *newAirport = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Airpots class]) inManagedObjectContext:self.context];
        newAirport.name = airport[@"name"];
        newAirport.codeIATA = airport[@"code"];
        newAirport.country_codeIATA = airport[@"country_code"];
        newAirport.city_codeIATA = airport[@"city_code"];
        
        NSDictionary *namesAirport = airport[@"name_translations"];
        
        newAirport.nameRu = namesAirport[@"ru"];
        
    }
    NSError *saveError=nil;
    [self.context save: &saveError];
    
    if(saveError)
    {
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setValue:@"Exist" forKey:@"isDataExist"];
    [self.delegate loadingComplete];
}


@end
