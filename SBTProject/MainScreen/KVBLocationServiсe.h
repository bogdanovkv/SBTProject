//
//  KVBRequest.h
//  SBTProject
//
//  Created by Константин Богданов on 14.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString * const KVBTravelpayouts;
extern NSString * const KVBLocationsRequestWhereAreMe;
extern NSString * const KVBRequestAllCountries;
extern NSString * const KVBRequestAllCities;
extern NSString * const KVBRequestAllAirports;


@class NSManagedObjectContext;

/**
 Сервис для определения мостоположения и подгрузки данных о странах и городах с сервера.
 */
@interface KVBLocationServiсe : NSObject

/**
 Инициализирует сервис в заданом контексте с заданым дегатом.
 @param context контекст для CoreData
 @return экземпляр KVBLocationServise
 */
- (instancetype)initWithContex:(NSManagedObjectContext*)context;
/**
 Получает с сервера данные о местоположении пользователя
 @param completionHandler блок который будет выполнен по завершении загрузки.
 Параметры блока:
 countryName - название страны, в которой находтся пользователь
 cityName - название города пользователся
 stringError - строка ошибки, если ошибки нет, то будет передана пустая строка @""
 */
- (void)whereAreMeWithComletition:(void (^)(NSString * countryName, NSString *  cityName, NSString *  stringError))completionHandler;
/**
 Получает данные список стран
 */
- (void)recieveAllContries:(void (^)(NSURL * location, NSURLResponse * response, NSError *  error))completionHandler;
/**
 Получает данные список городов
 */
- (void)recieveAllCities:(void (^)(NSURL * location, NSURLResponse * response, NSError *  error))completionHandler;

@end
