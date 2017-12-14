//
//  KVBRequest.h
//  SBTProject
//
//  Created by Константин Богданов on 14.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVBRequest : NSObject
@property(strong, nonatomic) NSDictionary *currentLoacation;
@property(weak, nonatomic) id<NSURLSessionDelegate> delegate;

- (void)whereAreMe;
- (void) getAll;

@end

