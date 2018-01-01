//
//  KVBSettingTableDataSourse.m
//  SBTProject
//
//  Created by Константин Богданов on 01.01.2018.
//  Copyright © 2018 Константин Богданов. All rights reserved.
//

#import "KVBSettingTableDataSourse.h"


@implementation KVBSettingTableDataSourse

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    if (indexPath.row == 0)
    {
       cell = [tableView dequeueReusableCellWithIdentifier:KVBResetTableViewCell forIndexPath:indexPath];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:KVBLanguageSettingCell forIndexPath:indexPath];

    }

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Settings";
}
@end
