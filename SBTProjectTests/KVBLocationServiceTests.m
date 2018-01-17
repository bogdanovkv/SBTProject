//
//  KVBLocationServiseTests.m
//  SBTProjectTests
//
//  Created by Константин Богданов on 15.01.2018.
//  Copyright © 2018 Константин Богданов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta.h>
#import <OCMock.h>
#import <OHHTTPStubs.h>
#import <OHHTTPStubsResponse+JSON.h>
#import "KVBLocationServiсe.h"


static NSString * const KVBTravelPayoutHost = @"www.travelpayouts.com";

@interface KVBLocationServiceTests : XCTestCase

@property(nonatomic, strong) KVBLocationServiсe *locationServise;

@end


@implementation KVBLocationServiceTests


- (void)setUp {
    [super setUp];
    self.locationServise = OCMPartialMock([KVBLocationServiсe new]);
}

- (void)tearDown {
    self.locationServise = nil;
    [super tearDown];
}

- (void)testWhereAreMeExecuteBlock
{
    __block BOOL isExecute = NO;
    void (^testCompletitionBlock)(NSString* countryName, NSString *cityName, NSString *error) = ^void(NSString* countryName, NSString *cityName, NSString *error) {
        isExecute = YES;
    };
    
    [self.locationServise whereAreMeWithComletition:testCompletitionBlock];
    
    expect(isExecute).after(3).to.beTruthy();
}

- (void)testWhereAreMeRecieveLocationGetLocation
{
    NSString *testCountry = @"NASHA";
    NSString *testCity = @"Rasha";

    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:KVBTravelPayoutHost];
        
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSDictionary* obj = @{ @"country_name": testCountry,
                                       @"name": testCity};
        return [OHHTTPStubsResponse responseWithJSONObject:obj statusCode:200 headers:nil];
    }];
    
    __block NSString *country = nil;
    __block NSString *city = nil;
    __block NSString *currentError = nil;

    void (^testCompletitionBlock)(NSString* countryName, NSString *cityName, NSString *error) = ^void(NSString* countryName, NSString *cityName, NSString *error) {
        country = countryName;
        city = cityName;
        currentError = error;
    };
    
    [self.locationServise whereAreMeWithComletition:testCompletitionBlock];
    
    expect(country).after(3).equal(testCountry);
    expect(city).after(3).equal(testCity);
    expect(currentError).after(3).equal(@"");

}

- (void)testWhereAreMeRecieveIncorrectLocation
{
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:KVBTravelPayoutHost];
        
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSDictionary* obj = @{ @"incorrect": @"foo",
                               @"data": @"bar"};
        return [OHHTTPStubsResponse responseWithJSONObject:obj statusCode:200 headers:nil];
    }];
    
    __block NSString *country = nil;
    __block NSString *city = nil;
    __block NSString *currentError = nil;
    
    void (^testCompletitionBlock)(NSString* countryName, NSString *cityName, NSString *error) = ^void(NSString* countryName, NSString *cityName, NSString *error) {
        country = countryName;
        city = cityName;
        currentError = error;
    };
    
    [self.locationServise whereAreMeWithComletition:testCompletitionBlock];
    
    expect(country).after(3).equal(@"");
    expect(city).after(3).equal(@"");
    expect(currentError).after(3).notTo.equal(@"");
    expect(currentError).after(3).notTo.beNil();
    

}

- (void)testWhereAreMeRecievetNoData
{
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:KVBTravelPayoutHost];
        
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return nil;
    }];
    
    __block NSString *country = nil;
    __block NSString *city = nil;
    __block NSString *currentError = nil;
    
    void (^testCompletitionBlock)(NSString* countryName, NSString *cityName, NSString *error) = ^void(NSString* countryName, NSString *cityName, NSString *error) {
        country = countryName;
        city = cityName;
        currentError = error;
    };
    
    [self.locationServise whereAreMeWithComletition:testCompletitionBlock];
    
    expect(country).after(3).equal(@"");
    expect(city).after(3).equal(@"");
    expect(currentError).after(3).notTo.equal(@"");
}

- (void)testWhereAreMeWithoutBlock
{
    __block BOOL wasCalled = NO;
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        wasCalled = YES;
        return [request.URL.host isEqualToString:KVBTravelPayoutHost];
        
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return nil;
    }];

    [self.locationServise whereAreMeWithComletition:nil];

    expect(wasCalled).after(3).beFalsy();
}




@end
