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


/**
 Дата сорс для таблицы с полетами.
 */
@interface KVBFlightsTableDataSource : NSObject <UITableViewDataSource>


@property(nonatomic, strong) KVBCoreDataServise *coreDataServise;           /**< Сервис для работы с кор дата */
@property(nonatomic, copy) NSArray<KVBFlyightModel*> *popularDirections;    /**< Массив с полетами для вывода я в первой секции таблицы */
@property(nonatomic, copy) NSArray<KVBFlyightModel*> *cheapTickets;         /**< Массив с полетами для вывода во второй секции таблицы */
@property(nonatomic, strong) KVBPopularDirectionCell *cell;                 /**< Ячейка с коллекшн вью в первой секции таблшицы */
@property(nonatomic, weak) Cities *departureCity;                           /**< Город вылета */
@property(nonatomic, weak) Cities *arrivalCity;                             /**< Город прибытия */


/**
 Вспомогательный метод на случай, если не пришло билетов с сервера.
 @return возвращает массив с ячейкой таблицы, с луйблом "No tickets" которую можно вывести вместо пустой таблицы.
 */
- (NSArray*)noChepTickets;
/**
 Обнуляет массив popularDirections, и вместо него будет выводиться ячейка с лейблом "No popular directions"
 */
- (void)noPopularDirections;


@end
