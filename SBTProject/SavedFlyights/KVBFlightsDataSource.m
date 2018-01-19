//
//  KVBFlightsDataSource.m
//  SBTProject
//
//  Created by Константин Богданов on 14.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBFlightsDataSource.h"
#import "KVBSavedFlightCollectionCell.h"
#import "Cities+CoreDataClass.h"
#import "Flyight+CoreDataClass.h"


NSString * const KVBSavedFlightsCellIdentifier = @"KVBSavedFlightsCellIdentifier";


@interface KVBFlightsDataSource()

@end


@implementation KVBFlightsDataSource

- (instancetype)initWithFetchController:(NSFetchedResultsController*)fetchController
{
    self = [super init];
    if (self)
    {
        _fetchController = fetchController;
    }
    return self;
}
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    KVBSavedFlightCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KVBSavedFlightsCellIdentifier forIndexPath:indexPath];
    
    Flyight *flight = [self.fetchController objectAtIndexPath:indexPath];
    
    cell.from = [NSString stringWithFormat:@"%@ - %@", flight.departure.name, flight.arrival.name];
    cell.back = [NSString stringWithFormat:@"%@ - %@", flight.arrival.name, flight.departure.name];
    cell.price = flight.cost;
    cell.departureDate = flight.departureDate;
    cell.backDate = flight.arrivalDate;
    cell.classNumber = flight.classNumber;
    
    return cell;
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> sectionInfo = self.fetchController.sections[section];
    return sectionInfo.numberOfObjects;
}

@end
