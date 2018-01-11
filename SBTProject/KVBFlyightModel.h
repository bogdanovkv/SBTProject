//
//  KVBFlyightModel.h
//  SBTProject
//
//  Created by Константин Богданов on 21.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Flyight;

/**
 Модель для работы с полетам, содержит информацию полученную с API www.travelpayouts.com.
 */
@interface KVBFlyightModel : NSObject


@property(nonatomic, copy) NSString *departureCode;     /**< IATA код страны отправления */
@property(nonatomic, copy) NSString *arrivalCode;       /**< IATA код страны прибытия */
@property(nonatomic, copy) NSString *airlineCode;       /**< IATA код авиалинии. */
@property(nonatomic, strong) NSDate *departureDate;     /**< Дата вылета. */
@property(nonatomic, strong) NSDate *arrivalDate;       /**< Дата вылета обратно. */
@property(nonatomic, assign) NSInteger cost;            /**< Цена билетов туда и обратно. */
@property(nonatomic, assign) NSInteger flightNumber;    /**< Номер рейса */
@property(nonatomic, assign) NSInteger classNumber;     /**< Класс полета */

/**
 Инициализирует модель KVBFlyightModel из модели кор даты.
 @param flight - модель из кор даты
 @return экземпляр KVBFlyightModel
 */
- (instancetype)initWithFlight:(Flyight*)flight;

/**
 Инициализирует модель из модели кор даты.
 @param flightDictionary - дикшинари из JSON'а полета с www.travelpayouts.com
 @return экземпляр KVBFlyightModel
 */
- (instancetype)initWithDictionary:(NSDictionary*)flightDictionary;

/**
 Создает массив с моделями с номером класса 0.
 @param flightsDictionary - дикшинари из JSON'а полетов с www.travelpayouts.com. Полеты без номера класса, проперти classNumber будет равно 0.
 @return массив моделей KVBFlyightModel с номером класса 0.
 */
+ (NSArray<KVBFlyightModel*>*)arrayFromDictionaries:(NSDictionary*)flightsDictionary;

/**
 Создает массив с моделями с номером класса.
 @param flightsDictionary - дикшинари из JSON'а полетов с www.travelpayouts.com. Полеты с номером класса 1 2 или 3.
 @return массив моделей KVBFlyightModel
 */
+ (NSArray<KVBFlyightModel*>*)arrayFromDictionariesWithClassType:(NSDictionary*)flightsDictionary;

@end
