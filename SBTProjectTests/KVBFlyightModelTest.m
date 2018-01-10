//
//  KVBFlyightModelTest.m
//  
//
//  Created by Константин Богданов on 10.01.2018.
//
#include <objc/objc.h>
#include <objc/runtime.h>
#import <XCTest/XCTest.h>
#import <OCMock.h>
#import <Expecta.h>
#import "KVBFlyightModel.h"

@interface KVBFlyightModel(XCTests)


+ (NSArray<KVBFlyightModel*>*)arrayFromDictionaries:(NSDictionary*)flightsDictionary;

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

- (void)testArrayFromDictionariesToBeNil
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
    
    expect(testArray.firstObject).notTo.beNil();
    expect(testArray.lastObject).notTo.beNil();    
}






@end
