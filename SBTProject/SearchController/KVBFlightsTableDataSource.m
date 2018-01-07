//
//  KVBFlightsTableDelegate.m
//  SBTProject
//
//  Created by Константин Богданов on 14.12.17.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//



#import "KVBFlightsTableDataSource.h"
#import "KVBSearchViewController.h"
#import "KVBFlyightsRequests.h"
#import "KVBPopularDirectionCell.h"
#import "KVBTableViewFlightCell.h"
#import "KVBFlyightModel.h"
#import "KVBCoreDataServise.h"
#import "Cities+CoreDataClass.h"

NSString * const KVBHeaderIdentifier = @"KVBHeaderIdentifier";


@interface KVBFlightsTableDataSource()


@property(nonatomic, strong) NSArray* sections;


@end


@implementation KVBFlightsTableDataSource


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return self.cell == nil ? [tableView dequeueReusableCellWithIdentifier:@"Cell"]: self.cell;
    }
    else
    {
        KVBTableViewFlightCell *cell = [tableView dequeueReusableCellWithIdentifier:KVBCustomFlightCellIdentifier forIndexPath:indexPath];

        KVBFlyightModel *model = self.cheapTickets[indexPath.row];
        
        if(self.arrivalCity == nil)
        {
            Cities *city = [self.coreDataServise recieveCityByCityCode:model.arrivalCode].firstObject;
            cell.arrival = city.name;
        }
        else
            
        {
            cell.arrival = self.arrivalCity.name;
        }
        
        cell.departure = self.departureCity.name;
        cell.price = [NSString stringWithFormat:@"%li p.", model.cost];
        cell.arrivalDate = model.arrivalDate;
        cell.departureDate = model.departureDate;
        
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 1 : self.cheapTickets.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 2;
}


@end
