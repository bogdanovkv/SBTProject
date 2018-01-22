//
//  KVBRequest.m
//  SBTProject
//
//  Created by Константин Богданов on 14.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBLocationServiсe.h"


NSString * const KVBTravelpayouts = @"fe17c550289588390f32bb8a4caf562f";
NSString * const KVBLocationsRequestWhereAreMe = @"http://www.travelpayouts.com/whereami";
NSString * const KVBRequestAllCountries = @"http://api.travelpayouts.com/data/countries.json";
NSString * const KVBRequestAllCities = @"http://api.travelpayouts.com/data/cities.json";
NSString * const KVBRequestAllAirports = @"http://api.travelpayouts.com/data/airports.json";

@protocol KVBFirstStartLoadingDelegate;


@interface KVBLocationServiсe()


@property(nonatomic, strong) NSOperationQueue *downloadTaskQueue;


@end


@implementation KVBLocationServiсe


- (instancetype)initWithContex:(NSManagedObjectContext*)context
{
    self = [super init];
    if (self)
    {
        _downloadTaskQueue  = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)whereAreMeWithComletition:(void (^)(NSString *countryName, NSString *cityName,NSString *stringError))completionHandler
{
    if(!completionHandler)
    {
        return;
    }
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:KVBLocationsRequestWhereAreMe];
    
    NSURLQueryItem *locale = [NSURLQueryItem queryItemWithName:@"locale" value:@"ru"];
    NSURLQueryItem *callback = [NSURLQueryItem queryItemWithName:@"callback" value:@""];
    NSURLQueryItem *token = [NSURLQueryItem queryItemWithName:@"token" value:KVBTravelpayouts];
    
    urlComponents.queryItems = @[locale, callback, token];
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig  delegate:nil delegateQueue:self.downloadTaskQueue];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:urlComponents.URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!data)
        {
            completionHandler(@"", @"", @"Can't recieve data from server.");
            return;
        }
        
        NSDictionary *recievedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSString *countryName = recievedData[@"country_name"];
        NSString *cityName = recievedData[@"name"];
        
        if(countryName.length == 0 && cityName.length == 0)
        {
            completionHandler(@"", @"", @"Something goes wrong. Sorry");
            return;
        }
            
        completionHandler(countryName, cityName, @"");
    }];
    
    [dataTask resume];
}



- (void)recieveAllContries:(void (^)(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler
{
    [self recieveByURL:[NSURL URLWithString:KVBRequestAllCountries] withCompletitionHandler:completionHandler];
}

- (void)recieveAllCities:(void (^)(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler

{
    [self recieveByURL:[NSURL URLWithString:KVBRequestAllCities] withCompletitionHandler:completionHandler];

}

- (void)recieveByURL:(NSURL*)url withCompletitionHandler:(void (^)(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler
{
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig  delegate:nil delegateQueue:self.downloadTaskQueue];
    NSURLSessionDownloadTask *dataTask = [session downloadTaskWithRequest:[NSURLRequest requestWithURL:url] completionHandler:completionHandler];

    [dataTask resume];
}

@end
