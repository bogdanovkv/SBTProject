//
//  KVBFlightsTableDelegate.h
//  SBTProject
//
//  Created by Константин Богданов on 14.12.17.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const KVBCustomFlightCellIdentifier = @"KVBCustomFlightCellIdentifier";
extern NSString * const KVBHeaderIdentifier;

@class KVBPopularDirectionCell;
@class KVBCoreDataServise;
@class KVBFlyightModel;
@class Cities;


@interface KVBFlightsTableDataSource : NSObject <UITableViewDataSource>


@property(nonatomic, strong) KVBCoreDataServise *coreDataServise;
@property(nonatomic, copy) NSArray<KVBFlyightModel*> *popularDirections;
@property(nonatomic, copy) NSArray<KVBFlyightModel*> *cheapTickets;
@property(nonatomic, strong) KVBPopularDirectionCell *cell;
@property(nonatomic, weak) Cities *departureCity;
@property(nonatomic, weak) Cities *arrivalCity;

- (NSArray*)noChepTickets;
- (void)noPopularDirections;


@end
