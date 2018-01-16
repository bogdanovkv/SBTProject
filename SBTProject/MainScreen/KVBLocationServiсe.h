//
//  KVBRequest.h
//  SBTProject
//
//  Created by Константин Богданов on 14.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <Foundation/Foundation.h>


@class NSManagedObjectContext;
@protocol KVBFirstStartLoadingDelegate;

/**
 Сервис для определения мостоположения и подгрузки данных о странах и городах с сервера.
 */
@interface KVBLocationServiсe : NSObject

/**
 Инициализирует сервис в заданом контексте с заданым дегатом.
 @param delegate делегат для обработки завершения загрузки
 @param context контекст для CoreData
 @return экземпляр KVBLocationServise
 */
- (instancetype _Nonnull)initWithDelegate:(id<KVBFirstStartLoadingDelegate> _Nonnull)delegate withContex:(NSManagedObjectContext* _Nonnull)context;
/**
 Получает с сервера данные о местоположении пользователя
 @param completionHandler блок который будет выполнен по завершении загрузки.
 Параметры блока:
 countryName - название страны, в которой находтся пользователь
 cityName - название города пользователся
 stringError - строка ошибки, если ошибки нет, то будет передана пустая строка @""
 */
- (void)whereAreMeWithComletition:(void (^_Nullable)(NSString * _Nonnull countryName, NSString * _Nonnull cityName, NSString * _Nullable stringError))completionHandler;
/**
 Получает данные список стран и городов и запускает запись их в кор дату.
 */
- (void)recieveAllContriesWithCities;


@end
