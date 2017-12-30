//
//  KVBFlightsDataSource.h
//  SBTProject
//
//  Created by Константин Богданов on 14.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface KVBFlightsDataSource : NSObject <UICollectionViewDataSource>

- (instancetype)initWithFetchController:(NSFetchedResultsController*)fetchController;

@property(readonly, nonatomic) NSFetchedResultsController *fetchController;

@end
