//
//  KVBRequest.m
//  SBTProject
//
//  Created by Константин Богданов on 14.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBRequest.h"
#import "KVBPreparatoryCoreData.h"

@interface KVBRequest()

@property(nonatomic, strong) KVBPreparatoryCoreData *coreDataConstructor;
@property(nonatomic, strong) NSOperationQueue *downloadTaskQueue;
@end


@implementation KVBRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        _coreDataConstructor = [KVBPreparatoryCoreData new];
        _downloadTaskQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)whereAreMe
{
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:KVBLocationsRequestWhereAreMe];
   
    NSURLQueryItem *locale = [NSURLQueryItem queryItemWithName:@"locale" value:@"ru"];
    NSURLQueryItem *callback = [NSURLQueryItem queryItemWithName:@"callback" value:@""];
    NSURLQueryItem *token = [NSURLQueryItem queryItemWithName:@"token" value:KVBTravelpayouts];

    urlComponents.queryItems = @[locale, callback, token];
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig  delegate:self.delegate delegateQueue:nil];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:urlComponents.URL];
    
    [dataTask resume];
    
}

- (void)recieveAllContriesWithCities
{
    [self recieveByURL:KVBRequestAllCountries];
    [self recieveByURL:KVBRequestAllCities];
    [self recieveByURL:KVBRequestAllAirports];

}

- (void)recieveByURL: (NSString*) string
{
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:string];
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig  delegate:self.coreDataConstructor delegateQueue:self.downloadTaskQueue];
    NSURLSessionDownloadTask *dataTask = [session downloadTaskWithRequest:[NSURLRequest requestWithURL:urlComponents.URL]];
    
    [dataTask resume];
    
}


@end
