//
//  KVBFlyightModelTest.m
//  
//
//  Created by Константин Богданов on 10.01.2018.
//


#import <XCTest/XCTest.h>
#import <OCMock.h>
#import <Expecta.h>
#import "KVBFlyightModel.h"


@interface KVBFlyightModel(KVBXCTests)


- (instancetype)initWithDictionary:(NSDictionary*)flightDictionary;
- (NSString*)validValueFromString:(NSString*)inputString;
- (NSDate*)dateFromString:(NSString*)dateString;

@end

@interface KVBFlyightModelTest : XCTestCase

@property(nonatomic, strong) KVBFlyightModel *flightModel;

@end

@implementation KVBFlyightModelTest

- (void)setUp {
    [super setUp];
    self.flightModel = OCMPartialMock([KVBFlyightModel alloc]);
}

- (void)tearDown {
    self.flightModel = nil;
    [super tearDown];
}

- (void)testValidValueFromStringNotToBeNil
{
    NSString *testString = [self.flightModel validValueFromString:nil];
    
    expect(testString).notTo.beNil();
    expect(testString).equal(@"No info");
}

- (void)testValidValueFromStringNotToBeNilWithEmptyString
{
    NSString *testString = [self.flightModel validValueFromString:@""];
    
    expect(testString).notTo.beNil();
    expect(testString).equal(@"No info");
}

- (void)testValidValueFromString
{
    NSString *parametr = @"parametr";
    NSString *testString = [self.flightModel validValueFromString:parametr];
    
    expect(testString).equal(parametr);
}

- (void)testDateFromStringToBeNil
{
    NSDate *date = [self.flightModel dateFromString:nil];
    
    expect(date).to.beNil();
}

- (void)testDateFromStringNotToBeNil
{
    NSString *dateString = @"2015-06-09T21:20:00Z";
    
    NSDate *date = [self.flightModel dateFromString:dateString];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";

    expect(date).notTo.beNil();
    expect(date).equal([dateFormatter dateFromString:dateString]);
}

- (void)testInitWithDictionaryToBeNil
{
    KVBFlyightModel *flightModel = OCMPartialMock([KVBFlyightModel alloc]);
    flightModel = [flightModel initWithDictionary:nil];
    
    expect(flightModel).to.beNil();
}

- (void)testInitWithDictionary
{
    NSDictionary *testDictionary = @{
        @"price": @35443,
        @"airline": @"UN",
        @"flight_number": @571,
        @"departure_at": @"2015-06-09T21:20:00Z",
        @"return_at": @"2015-07-15T12:40:00Z",
        @"expires_at": @"2015-01-08T18:30:40Z"
    };
    
    NSDate *testDate = [NSDate date];
    
    OCMStub([self.flightModel dateFromString:@"2015-06-09T21:20:00Z"]).andReturn(testDate);
    OCMStub([self.flightModel dateFromString:@"2015-07-15T12:40:00Z"]).andReturn(testDate);

    self.flightModel = [self.flightModel initWithDictionary:testDictionary];
    
    expect(self.flightModel).notTo.beNil();
    expect(self.flightModel.cost).equal(@35443);
    expect(self.flightModel.airlineCode).equal(@"UN");
    expect(self.flightModel.flightNumber).equal(@571);
    expect(self.flightModel.departureDate).equal(testDate);
    expect(self.flightModel.arrivalDate).equal(testDate);
    expect(self.flightModel.arrivalCode).equal(@"No info");
    expect(self.flightModel.departureCode).equal(@"No info");
    expect(self.flightModel.departureCode).equal(@"No info");
    expect(self.flightModel.classNumber).equal(@0);
}
- (void)testArrayFromDictionariesNotBeNil
{
    
    NSArray *testArray = [KVBFlyightModel arrayFromDictionaries:nil];
    
    expect(testArray).to.beNil();
}

- (void)testArrayFromDictionariesNotToBeNil
{
    NSDictionary *testDictionary = @{
                                     @0: @{
            @"price": @35443,
            @"airline": @"UN",
            @"flight_number": @571,
            @"departure_at": @"2015-06-09T21:20:00Z",
            @"return_at": @"2015-07-15T12:40:00Z",
            @"expires_at": @"2015-01-08T18:30:40Z"
        },
                                     @1: @{
            @"price": @27506,
            @"airline": @"CX",
            @"flight_number": @204,
            @"departure_at": @"2015-06-05T16:40:00Z",
            @"return_at": @"2015-06-22T12:00:00Z",
            @"expires_at": @"2015-01-08T18:38:45Z"
        }
    };

    NSArray<KVBFlyightModel*> *testArray = [KVBFlyightModel arrayFromDictionaries:testDictionary];
    
    expect(testArray.count).equal(@2);
    expect([testArray.firstObject isKindOfClass:[KVBFlyightModel class]]).beTruthy();
    expect([testArray.lastObject isKindOfClass:[KVBFlyightModel class]]).beTruthy();
}

- (void)testArrayFromDictionariesWithClassNotBeNil
{
    NSArray *testArray = [KVBFlyightModel arrayFromDictionariesWithClassType:nil];
    
    expect(testArray).to.beNil();
}

- (void)testArrayFromDictionariesWithClassType
{
    NSDictionary *testDictionary =    @{
                                       @"HKT": @{
            @"0": @{
                @"price": @35443,
                @"airline": @"UN",
                @"flight_number": @571,
                @"departure_at": @"2015-06-09T21:20:00Z",
                @"return_at": @"2015-07-15T12:40:00Z",
                @"expires_at": @"2015-01-08T18:30:40Z"
            },
            @"1": @{
                @"price": @27506,
                @"airline": @"CX",
                @"flight_number": @204,
                @"departure_at": @"2015-06-05T16:40:00Z",
                @"return_at": @"2015-06-22T12:00:00Z",
                @"expires_at": @"2015-01-08T18:38:45Z"
            },
            @"2": @{
                @"price": @31914,
                @"airline": @"AB",
                @"flight_number": @8113,
                @"departure_at": @"2015-06-12T13:45:00Z",
                @"return_at": @"2015-06-24T20:30:00Z",
                @"expires_at": @"2015-01-08T15:17:42Z"
            }
        }
    };
    
    NSArray<KVBFlyightModel*> *testArray = [KVBFlyightModel arrayFromDictionariesWithClassType:testDictionary];
    
    expect(testArray.count).equal(@3);
    expect([testArray[0] isKindOfClass:[KVBFlyightModel class]]).beTruthy();
    expect([testArray[1] isKindOfClass:[KVBFlyightModel class]]).beTruthy();
    expect([testArray[2] isKindOfClass:[KVBFlyightModel class]]).beTruthy();
}




@end
