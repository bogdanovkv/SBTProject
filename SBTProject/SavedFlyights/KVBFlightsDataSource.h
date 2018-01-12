//
//  KVBFlightsDataSource.h
//  SBTProject
//
//  Created by Константин Богданов on 14.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

/**
 Датасорс для коллекшн вью.
 */
@interface KVBFlightsDataSource : NSObject <UICollectionViewDataSource>

/**
 Инициализирует дата сорс с заданым фетч контроллером.
 @param fetchController - фетч контроллер
 @return вовращает экземпляр KVBFlightsDataSource
 */
- (instancetype)initWithFetchController:(NSFetchedResultsController*)fetchController;

@property(nonatomic, readonly, strong) NSFetchedResultsController *fetchController;     /**< фетч контроллер */

@end
