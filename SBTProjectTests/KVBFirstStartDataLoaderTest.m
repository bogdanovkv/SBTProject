//
//  KVBFirstStartDataLoaderTest.m
//  SBTProjectTests
//
//  Created by Константин Богданов on 13.01.2018.
//  Copyright © 2018 Константин Богданов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta.h>
#import <OCMock.h>
#import "KVBFirstStartCoreDataLoader.h"
#import <CoreData/CoreData.h>
#import "KVBPersistentContainer.h"
#import "Cities+CoreDataClass.h"
#import "Countries+CoreDataClass.h"
#import "Airpots+CoreDataClass.h"
#import <objc/runtime.h>

@interface Countries(XCTests)


@end

@implementation Countries(XCTests)

- (void)setName:(NSString *)name{
    objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@interface KVBFirstStartCoreDataLoader(KVBXCTests)


@property(nonatomic, strong) NSManagedObjectContext *context;

- (BOOL)setupCoreDataWithCountries:(NSArray*)countriesDictionary withCities:(NSArray*)citiesDictionary withAirports:(NSArray*)airportDictionary;


@end


@interface KVBFirstStartDataLoaderTest : XCTestCase


@property(nonatomic, strong) KVBFirstStartCoreDataLoader *coreDataLoader;

@end


@implementation KVBFirstStartDataLoaderTest

- (void)setUp {
    [super setUp];
    KVBPersistentContainer *persistentContainer = [KVBPersistentContainer new];
    NSManagedObjectContext *context = OCMPartialMock(persistentContainer.persistentContainer.viewContext);

    self.coreDataLoader = OCMPartialMock([[KVBFirstStartCoreDataLoader alloc]initWithContext:context]);
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    self.coreDataLoader = nil;
    [super tearDown];
}

- (void)testSetupCoreDataWithCountriesReturnNo
{
    BOOL result = [self.coreDataLoader setupCoreDataWithCountries:nil withCities:nil withAirports:nil];
    
    expect(result).beFalsy();
}

- (void)testSetupCoreDataWithCountriesReturnNoWithCountries
{
    NSArray *country =  @[@{
        @"code": @"NC",
        @"name": @"New Caledonia",
        @"currency": @"XPF",
        @"name_translations": @{
            @"de": @"Neukaledonien",
            @"en": @"New Caledonia",
            @"zh-CN": @"新喀里多尼亚",
            @"tr": @"Yeni Kaledonya",
            @"ru": @"Новая Каледония",
            @"fr": @"Nouvelle-Calédonie",
            @"es": @"Nueva Caledonia",
            @"it": @"Nuova Caledonia",
            @"th": @"ประเทศนิวแคลิโดเนีย"
        }
    }];
    
    BOOL result = [self.coreDataLoader setupCoreDataWithCountries:country withCities:nil withAirports:nil];
    
    expect(result).beFalsy();
}

- (void)testSetupCoreDataWithCountriesReturnNoWithCities
{
    NSArray *city = @[ @{
                               @"code": @"SCE",
                               @"name": @"State College",
                               @"coordinates": @{
                                   @"lon": @(-77.84823),
                                   @"lat": @40.85372
                               },
                               @"time_zone": @"America/New_York",
                               @"name_translations": @{
                                   @"de": @"State College",
                                   @"en": @"State College",
                                   @"zh-CN": @"大学城",
                                   @"tr": @"State College",
                                   @"ru": @"Стейт Колледж",
                                   @"it": @"State College",
                                   @"es": @"State College",
                                   @"fr": @"State College",
                                   @"th": @"สเตทคอลเลจ"
                               },
                               @"country_code": @"US"
                               }];
    
    BOOL result = [self.coreDataLoader setupCoreDataWithCountries:nil withCities:city withAirports:nil];
    
    expect(result).beFalsy();
}

- (void)testSetupCoreDataWithCountriesReturnNoWithAirports
{
    NSArray *airport = @[ @{
                            @"code": @"MQP",
                            @"name": @"Kruger Mpumalanga International Airport",
                            @"coordinates": @{
                                @"lon": @31.098131,
                                @"lat":@(-25.384947)
                            },
                           @"time_zone": @"Africa/Johannesburg",
                            @"name_translations": @{
                                @"de": @"Nelspruit",
                                @"en": @"Kruger Mpumalanga International Airport",
                                @"tr": @"International Airport",
                                @"it": @"Kruger Mpumalanga",
                                @"fr": @"Kruger Mpumalanga",
                                @"es": @"Kruger Mpumalanga",
                                @"th": @"สนามบินเนลสปรุต"
                            },
                            @"country_code": @"ZA",
                            @"city_code": @"NLP"
                            }];
    
    BOOL result = [self.coreDataLoader setupCoreDataWithCountries:nil withCities:nil withAirports:airport];
    
    expect(result).beFalsy();
}




@end
