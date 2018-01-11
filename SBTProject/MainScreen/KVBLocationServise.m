//
//  KVBRequest.m
//  SBTProject
//
//  Created by Константин Богданов on 14.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBLocationServise.h"
#import "KVBFirstStartCoreDataLoader.h"


@protocol KVBFirstStartLoadingDelegate;


@interface KVBLocationServise()


@property(nonatomic, weak) id<KVBFirstStartLoadingDelegate> delegate;
@property(nonatomic, strong) KVBFirstStartCoreDataLoader *coreDataConstructor;
@property(nonatomic, strong) NSOperationQueue *downloadTaskQueue;


@end


@implementation KVBLocationServise


- (instancetype)initWithDelegate:(id<KVBFirstStartLoadingDelegate>)delegate withContex:(NSManagedObjectContext*)context
{
    self = [super init];
    if (self)
    {
        _delegate = delegate;
        
        _coreDataConstructor = [[KVBFirstStartCoreDataLoader alloc]initWithContext:context];
        _coreDataConstructor.delegate = self.delegate;
        
        _downloadTaskQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)whereAreMeWithComletition:(void (^)(NSString *countryName, NSString *cityName,NSString *stringError))completionHandler
{
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


- (void)recieveAllContriesWithCities
{
    [self recieveByURL:KVBRequestAllCountries];
    [self recieveByURL:KVBRequestAllCities];
    [self recieveByURL:KVBRequestAllAirports];
}

- (void)recieveByURL:(NSString*) string
{
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:string];
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig  delegate:self.coreDataConstructor delegateQueue:self.downloadTaskQueue];
    NSURLSessionDownloadTask *dataTask = [session downloadTaskWithRequest:[NSURLRequest requestWithURL:urlComponents.URL]];
    
    [dataTask resume];
    
}


@end
