//
//  KVBFlyightsRequests.m
//  SBTProject
//
//  Created by Константин Богданов on 20.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBFlyightsRequests.h"
#import "Cities+CoreDataClass.h"

@interface KVBFlyightsRequests()
@property(nonatomic, strong) NSOperationQueue *dataTaskQueue;
@end

@implementation KVBFlyightsRequests

- (void) recieveCheapTicketsFromCity:(Cities*)departure departmentDate: (NSDate*) departmentDate toCity:(Cities*) destination arrivalDate: (NSDate*) arrivalDate withCompletitionHandler:(void (^)(NSData *data, NSError *error))completionHandler
{
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:KVBCheapTiktetFromCityToCity];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"YYYY-MM";
    
    NSURLQueryItem *origin = [NSURLQueryItem queryItemWithName:@"origin" value:departure.codeIATA];
    NSURLQueryItem *token = [NSURLQueryItem queryItemWithName:@"token" value:KVBTravelpayouts];
    
    NSURLQueryItem *destinationCode = [NSURLQueryItem queryItemWithName:@"destination" value:destination.codeIATA];

    NSMutableArray *array = [NSMutableArray arrayWithObjects:origin, token, destinationCode, nil];
    

    NSURLQueryItem *returnDate = [NSURLQueryItem queryItemWithName:@"return_date" value: [dateFormatter stringFromDate:arrivalDate]];

    if (arrivalDate)
    {
        [array addObject:returnDate];
    }
    
    NSURLQueryItem *departDate = [NSURLQueryItem queryItemWithName:@"depart_date" value: [dateFormatter stringFromDate:departmentDate]];

    if (departmentDate)
    {
        [array addObject:departDate];
    }
    
    urlComponents.queryItems = array;
    
    [self recieveByURL:urlComponents withCompletitionHandler:completionHandler];
    
}

- (void) recievePopularDirectionFRomCity:(Cities *)city onPage:(NSInteger)page withCompletitionHandler:(void (^)(NSData *data, NSError *error))completionHandler
{
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:KVBPopularDirections];
    
    NSURLQueryItem *origin = [NSURLQueryItem queryItemWithName:@"origin" value:city.codeIATA];
    NSURLQueryItem *token = [NSURLQueryItem queryItemWithName:@"token" value:KVBTravelpayouts];
    
    urlComponents.queryItems = @[origin, token];
    
    [self recieveByURL:urlComponents withCompletitionHandler:completionHandler];
}

- (void)recieveByURL: (NSURLComponents*) components withCompletitionHandler:(void (^)(NSData *data, NSError *error))completionHandler
{
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig  delegate:self.user delegateQueue:self.dataTaskQueue];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:[NSURLRequest requestWithURL:components.URL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completionHandler(data, error);
    }];
    
    [dataTask resume];
}
@end
