//
//  KVBFlyightsRequests.m
//  SBTProject
//
//  Created by Константин Богданов on 20.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBFlightService.h"
#import "Cities+CoreDataClass.h"


NSString *const KVBPopularDirections = @"http://api.travelpayouts.com/v1/city-directions";
NSString *const KVBCheapTiktetFromCityToCity = @"http://api.travelpayouts.com/v1/prices/cheap";

@interface KVBFlightService()
@property(nonatomic, strong) NSOperationQueue *dataTaskQueue;
@property(nonatomic, strong) NSURLSession *session;
@end

@implementation KVBFlightService

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _dataTaskQueue = [NSOperationQueue new];
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:sessionConfig  delegate:nil delegateQueue:self.dataTaskQueue];
    }
    return self;
}

- (void)recieveCheapTicketsFromCity:(Cities*)departure departureDate:(NSDate*)departureDate toCity:(Cities*)destination arrivalDate:(NSDate*)arrivalDate withCompletitionHandler:(void (^)(NSData *data, NSError *error))completionHandler
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
    
    NSURLQueryItem *departDate = [NSURLQueryItem queryItemWithName:@"depart_date" value: [dateFormatter stringFromDate:departureDate]];

    if (departureDate)
    {
        [array addObject:departDate];
    }
    
    urlComponents.queryItems = array;
    
    [self recieveByURL:urlComponents withCompletitionHandler:completionHandler];
    
}

- (void)recievePopularDirectionFRomCity:(Cities *)city onPage:(NSInteger)page withCompletitionHandler:(void (^)(NSData *data, NSError *error))completionHandler
{
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:KVBPopularDirections];
    
    NSURLQueryItem *origin = [NSURLQueryItem queryItemWithName:@"origin" value:city.codeIATA];
    NSURLQueryItem *token = [NSURLQueryItem queryItemWithName:@"token" value:KVBTravelpayouts];
    
    urlComponents.queryItems = @[origin, token];
    
    [self recieveByURL:urlComponents withCompletitionHandler:completionHandler];
}

- (void)recieveByURL:(NSURLComponents*)components withCompletitionHandler:(void (^)(NSData *data, NSError *error))completionHandler
{
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:[NSURLRequest requestWithURL:components.URL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!data)
        {
            NSString *errorText = @"No tickets";
            NSError *noDataError = [NSError errorWithDomain:NSCocoaErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey:errorText}];
            completionHandler(data, noDataError);
            return ;
        }
        completionHandler(data, nil);
    }];
    
    [dataTask resume];
}
@end
