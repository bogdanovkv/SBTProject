//
//  KVBPersistentContainer.m
//  SBTProject
//
//  Created by Константин Богданов on 11.01.2018.
//  Copyright © 2018 Константин Богданов. All rights reserved.
//

#import "KVBPersistentContainer.h"

@implementation KVBPersistentContainer


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer
{
    @synchronized (self)
    {
        if (_persistentContainer == nil)
        {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"SBTProject"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}
@end
