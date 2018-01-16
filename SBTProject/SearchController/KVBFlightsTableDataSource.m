//
//  KVBFlightsTableDelegate.m
//  SBTProject
//
//  Created by Константин Богданов on 14.12.17.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//



#import "KVBFlightsTableDataSource.h"
#import "KVBSearchViewController.h"
#import "KVBPopularDirectionCell.h"
#import "KVBTableViewFlightCell.h"
#import "KVBFlyightModel.h"
#import "KVBCoreDataService.h"
#import "Cities+CoreDataClass.h"

NSString * const KVBHeaderIdentifier = @"KVBHeaderIdentifier";

@interface KVBFlightsTableDataSource()


@property(nonatomic, strong) UITableViewCell *errorPopularCell;
@property(nonatomic, strong) UITableViewCell *errorCell;

@end


@implementation KVBFlightsTableDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        _errorCell = [UITableViewCell new];
        _errorCell.textLabel.text = @"No tickets";
        _errorCell.layer.cornerRadius = 15;
        _errorCell.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:246 / 255.0 blue:196 / 255.0 alpha:1.0f];
        
        _errorPopularCell = [UITableViewCell new];
        _errorPopularCell.textLabel.text = @"No popular tickets";
        _errorPopularCell.layer.cornerRadius = 15;
        _errorPopularCell.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:246 / 255.0 blue:196 / 255.0 alpha:1.0f];
    }
    return self;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(!indexPath.section)
    {
        if (!self.popularDirections.count)
        {
            return self.errorPopularCell;
        }
        return self.cell == nil ? [tableView dequeueReusableCellWithIdentifier:@"Cell"]: self.cell;
    }
    
    KVBTableViewFlightCell *cell = [tableView dequeueReusableCellWithIdentifier:KVBCustomFlightCellIdentifier forIndexPath:indexPath];

    KVBFlyightModel *model = self.cheapTickets[indexPath.row];
    
    if ([model isEqual:self.errorCell])
    {
        return self.errorCell;
    }
    
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

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return section == 0 ? 1 : self.cheapTickets.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 2;
}


#pragma mark - Errors from servise

- (NSArray*)noChepTickets
{
    return @[self.errorCell];
}

- (void)noPopularDirections
{
    self.popularDirections = nil;
}



@end
