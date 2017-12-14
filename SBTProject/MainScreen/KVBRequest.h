//
//  KVBRequest.h
//  SBTProject
//
//  Created by Константин Богданов on 14.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KVBRequestCompletitionProtocol;

@interface KVBRequest : NSObject
@property(strong, nonatomic) NSDictionary *currentLoacation;
@property(weak, nonatomic) id<KVBRequestCompletitionProtocol> delegate;

- (void)whereAreMe;
- (void) getAll;

@end

@protocol KVBRequestCompletitionProtocol

@required
- (void) taskComplete;

@end
