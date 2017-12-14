//
//  KVBRequest.m
//  SBTProject
//
//  Created by Константин Богданов on 14.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBRequest.h"

static NSString *const KVBTravelpayouts = @"fe17c550289588390f32bb8a4caf562f";
static NSString *const KVBLocationsRequestUrl = @"http://www.travelpayouts.com/whereami";

@implementation KVBRequest

- (void) whereAreMe
{
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:KVBLocationsRequestUrl];
   
    NSURLQueryItem *locale = [NSURLQueryItem queryItemWithName:@"locale" value:@"ru"];
    NSURLQueryItem *callback = [NSURLQueryItem queryItemWithName:@"callback" value:@""];
    NSURLQueryItem *token = [NSURLQueryItem queryItemWithName:@"token" value:KVBTravelpayouts];

    urlComponents.queryItems = @[locale, callback, token];
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:urlComponents.URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error)
        {
            NSLog(@"Error %@ in request %@", error.userInfo , KVBLocationsRequestUrl);
            self.currentLoacation = nil;
        }
        else
        {
            NSError *error = nil;
            self.currentLoacation = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
        }
        
        dispatch_async(dispatch_get_main_queue(),
                    ^{
                        [self.delegate taskComplete];

        });
        
    }];
    
    [dataTask resume];
    
}
@end
