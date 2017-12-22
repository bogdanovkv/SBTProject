//
//  KVBFlightsTableDelegate.h
//  SBTProject
//
//  Created by Константин Богданов on 14.12.17.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const KVBCustomFlightCellIdentifier = @"KVBCustomFlightCellIdentifier";


@class KVBSearchViewController;
@class KVBPopalarDirectionCell;
@class KVBFlyightModel;
@interface KVBFlightsTableDataSource : NSObject <UITableViewDataSource>

@property(nonatomic, copy) NSArray<KVBFlyightModel*> *popularDirections;
@property(nonatomic, copy) NSArray<KVBFlyightModel*> *cheapTickets;
@property(nonatomic, strong) KVBPopalarDirectionCell *cell;

@end
