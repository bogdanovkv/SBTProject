//
//  KVBFlightsTableDelegate.h
//  SBTProject
//
//  Created by Константин Богданов on 14.12.17.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KVBSearchViewController;
@class KVBFlyightsRequests;
@class KVBFlyightModel;
@interface KVBFlightsTableDataSource : NSObject <UITableViewDataSource>

@property(nonatomic, strong) NSArray<KVBFlyightModel*> *popularDirections;

@end
