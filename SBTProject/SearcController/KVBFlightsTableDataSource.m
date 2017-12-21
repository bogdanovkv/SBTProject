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
#import "KVBFlyightModel.h"
@interface KVBFlightsTableDataSource()
@end

@implementation KVBFlightsTableDataSource


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    KVBFlyightModel *model = self.popularDirections[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Test flight %@ %@", model.airlineName, model.arrivalDate];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.popularDirections.count;
}



@end
