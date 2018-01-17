//
//  KVBFlightServiceTests.m
//  SBTProjectTests
//
//  Created by Константин Богданов on 16.01.2018.
//  Copyright © 2018 Константин Богданов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OHHTTPStubsResponse+JSON.h>
#import <OHHTTPStubs.h>
#import <OCMock.h>
#import <Expecta.h>
#import "KVBFlightService.h"


 NSString * const KVBTravelPayoutHost = @"api.travelpayouts.com";
static NSString * const KVBTestUrl = @"http://api.travelpayouts.com/v1/city-directions";

@interface KVBFlightService(KVBXCTest)

- (void)recieveByURL:(NSURLComponents*)components withCompletitionHandler:(void (^)(NSData *data, NSError *error))completionHandler;

@end

@interface KVBFlightServiceTests : XCTestCase


@property(nonatomic, strong) KVBFlightService *flightService;


@end

@implementation KVBFlightServiceTests

- (void)setUp {
    [super setUp];
    

    self.flightService = OCMPartialMock([KVBFlightService new]);
}

- (void)tearDown {
    
    self.flightService = nil;
    [super tearDown];
}

- (void)testRecieveByUrlExecuteBlock
{
    __block BOOL isExecute = NO;
    void (^testCompletitionBlock)(NSData* countryName, NSError *cityName) = ^void(NSData* countryName, NSError *cityName) {
        isExecute = YES;
    };
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:KVBTravelPayoutHost];
        
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSDictionary* obj = @{ @"incorrect": @"foo"};
        return [OHHTTPStubsResponse responseWithJSONObject:obj statusCode:200 headers:nil];
    }];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:KVBTravelPayoutHost];

    [self.flightService recieveByURL:urlComponents withCompletitionHandler:testCompletitionBlock];
    
    expect(isExecute).after(3).beTruthy();
}

- (void)testRecieveByUrlRecieveData
{
    NSDictionary *sendedDataDictionary = @{ @"test": @"data",
                                             @"foo": @"bar"
                                            };
    __block NSDictionary *recievedDataDictionary = nil;
    
    void (^testCompletitionBlock)(NSData* data , NSError *error) = ^void(NSData* data, NSError *error) {
        
        recievedDataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    };
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:KVBTravelPayoutHost];
        
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        
        return [OHHTTPStubsResponse responseWithJSONObject:sendedDataDictionary statusCode:200 headers:nil];
    }];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString: KVBTestUrl];
    
    [self.flightService recieveByURL:urlComponents withCompletitionHandler:testCompletitionBlock];
    
    expect(recievedDataDictionary).after(3).equal(sendedDataDictionary);
}




@end
