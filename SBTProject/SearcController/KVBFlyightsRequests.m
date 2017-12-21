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

- (void) recieveCheapTicketsOnPage: (NSInteger) page
{
    
}

- (void) recievePopularDirectionFRomCity:(Cities*)city onPage: (NSInteger) page
{
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:KVBPopularDirections];
    
    NSURLQueryItem *origin = [NSURLQueryItem queryItemWithName:@"origin" value:city.codeIATA];
    NSURLQueryItem *token = [NSURLQueryItem queryItemWithName:@"token" value:KVBTravelpayouts];
    
    urlComponents.queryItems = @[origin, token];
    
    [self recieveByURL:urlComponents];
}

- (void) recieveCheapTicketsFromCity:(Cities*)departure fromCity:(Cities*) destination onPage: (NSInteger) page
{
    
}

- (void)recieveByURL: (NSURLComponents*) components
{
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig  delegate:self.user delegateQueue:self.dataTaskQueue];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:[NSURLRequest requestWithURL:components.URL]];
    
    [dataTask resume];
    
}

@end
