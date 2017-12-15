//
//  KVBPreparatoryCoreData.m
//  SBTProject
//
//  Created by Константин Богданов on 15.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBPreparatoryCoreData.h"
#import "Cities+CoreDataClass.h"
#import "Countries+CoreDataClass.h"

@implementation KVBPreparatoryCoreData

#pragma mark -NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location
{
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfURL:location];
    NSDictionary* reciever = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    NSMutableDictionary *dict= [NSMutableDictionary dictionary];
    
   
    if([downloadTask.currentRequest.URL isEqual:[NSURL URLWithString: KVBRequestAllCountries]])
    {
        for (NSDictionary *element in reciever)
        {
            
            
            [dict setObject:element forKey:element[@"name"]];
        }
        
        self.countriesArray = dict;
        
    }
    if([downloadTask.currentRequest.URL isEqual:[NSURL URLWithString: KVBRequestAllCities]])
    {
        for (NSDictionary *element in reciever)
        {
            
            [dict setObject:element forKey:element[@"name"]];

        }
        
        self.citiesArray = dict;
    }
    
#pragma mark -AddEntityForAirports
    if([downloadTask.currentRequest.URL isEqual:[NSURL URLWithString: KVBRequestAllAirports]])
    {
//        for (NSDictionary *element in reciever)
//        {
//
//
//        }
//
        self.countriesArray = dict;
    }
        
    
    
    NSLog(@"%@", reciever);


}





@end
