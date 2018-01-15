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
#import "KVBLocationServise.h"


@interface KVBLocationServiseTests : XCTestCase

@property(nonatomic, strong) KVBLocationServise *locationServise;

@end


@implementation KVBLocationServiseTests


- (void)setUp {
    [super setUp];
    self.locationServise = OCMPartialMock([KVBLocationServise new]);
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


@end
