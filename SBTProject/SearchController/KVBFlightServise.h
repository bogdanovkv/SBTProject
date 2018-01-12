//
//  KVBFlyightsRequests.h
//  SBTProject
//
//  Created by Константин Богданов on 20.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString *const KVBTravelpayouts;
extern NSString *const KVBPopularDirections;
extern NSString *const KVBCheapTiktetFromCityToCity;

@class Cities;

/**
 Сервис для получения списка билетов по заданым направлениям.
 */
@interface KVBFlightServise : NSObject

/**
Получает дешевые билеты
 @param departure город вылета
 @param departuretDate дата вылета
 @param destination город прибытия
 @param arrivalDate дата вылета обратно
 @param completionHandler блок который выполняется по завершению, если данные получены ошибка = nil
 */
- (void)recieveCheapTicketsFromCity:(Cities*)departure departureDate:(NSDate*)departuretDate toCity:(Cities*)destination arrivalDate: (NSDate*)arrivalDate withCompletitionHandler:(void (^)(NSData *data, NSError *error))completionHandler;

/**
 Получает популярные билеты
 @param city город вылета
 @param page страница, сервер при 0 вернет все что есть
 @param completionHandler блок который выполняется по завершению, если данные получены ошибка = nil
 */
- (void) recievePopularDirectionFRomCity:(Cities *)city onPage:(NSInteger)page withCompletitionHandler:(void (^)(NSData *data, NSError *error))completionHandler;

@end
