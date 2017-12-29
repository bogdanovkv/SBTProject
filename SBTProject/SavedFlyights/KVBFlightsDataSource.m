//
//  KVBFlightsDataSource.m
//  SBTProject
//
//  Created by Константин Богданов on 14.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBFlightsDataSource.h"
#import "KVBSavedFlightCollectionCell.h"
@implementation KVBFlightsDataSource

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    KVBSavedFlightCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor = UIColor.grayColor;
    cell.from = @"test1";
    cell.to = @"test";
    cell.price = @"1234";
    cell.backDate = nil;
    cell.classNumber = 1;
    return cell;
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

@end
