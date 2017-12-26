//
//  KVBFlightsTableDelegate.h
//  SBTProject
//
//  Created by Константин Богданов on 14.12.17.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const KVBCustomFlightCellIdentifier = @"KVBCustomFlightCellIdentifier";

@class KVBPopalarDirectionCell;
@class KVBFlyightModel;
@class Cities;

@interface KVBFlightsTableDataSource : NSObject <UITableViewDataSource>

@property(nonatomic, copy) NSArray<KVBFlyightModel*> *popularDirections;
@property(nonatomic, copy) NSArray<KVBFlyightModel*> *cheapTickets;
@property(nonatomic, strong) KVBPopalarDirectionCell *cell;
@property(nonatomic, weak) Cities *departureCity;
@property(nonatomic, weak) Cities *arrivalCity;

@end
