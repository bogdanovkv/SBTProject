//
//  KVBCoreDataServise.h
//  SBTProject
//
//  Created by Константин Богданов on 24.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Cities;
@class Countries;
@class Flyight;
@class KVBFlyightModel;


/**
 Сервис для работы с CoreData. Поддерживает сущности Cities, Countries, Flyight. Предполагается что даннные для сущностей Cities и Countries уже загружены в CoreData.
 */
@interface KVBCoreDataService : NSObject


@property(nonatomic, readonly, strong) NSManagedObjectContext *context;     /**< Контекст в котором работает класс*/


/**
Инициализирует сервис с заданым контекстом.
 @param context - контекст для работы с кор дата.
 @return экземпляр KVBCoreDataServise
 */
- (instancetype)initWithContext:(NSManagedObjectContext*)context;

/**
 Возвращает массив всех стран хранящихня в CoreData
 @return  массив со странами из CoreData
 */
- (NSArray<Countries*>*)recieveCountries;
/**
 Возвращает города для заданой страны
 @param country страна для которой нужно вернуть города
 @return  массив с городами хранящимися в CoreData для заданой страны
 */
- (NSArray<Cities*>*)recieveCitiesFromCountry:(Countries*) country;
/**
 Возвращает города из CoreData по коду страны. И устанавливает каждому городу связь parrentCountry.
 @param codeIATA - IATA код страны
 @return  массив с городами хранящимися в CoreData для заданой страны
 */
- (NSArray<Cities*>*)recieveCityByCityCode:(NSString*)codeIATA;
/**
 Находит в заданой сущности объект с заданым именем
 @param entity - имя сущности
 @param name - атрибут модели, на русском или английском языке
 @return возвращает массив с объектами имеющими заданое имя
 */
- (NSArray*)findLocationInEntity:(NSString*)entity withName:(NSString*)name;
/**
 Находит в заданой стране город
 @param cityName название города на английском или русском языке
 @param country страна
 @return возвращает массив с городом (объект Cities) имеющим заданое имя. Город должен быть один если нет ошибок в данных.
 */
- (NSArray<Cities*>*)recieveCityByName:(NSString*)cityName inCountry:(Countries*)country;
/**
 Возвращает все полеты сохраненные в кор дате.
 @return - возвращает несортированный массив с объектами (Flyight)
 */
- (NSArray<Flyight*>*)recieveAllFlyights;
/**
 Сохраняет полет из модели KVBFlyightModel в сущность Flyight. Если такой полет уже существуетд, то он не будет добавлен в базу повторно.
 @param flyightModel модель полета
 */
- (void)saveFlight:(KVBFlyightModel*)flyightModel;
/**
  Удаляет полет из CoreData
 */
- (void)deleteFlight:(Flyight*)flight;
/**
  Удаляет все полеты из CoreData
 */
- (void)deleAllFlights;


@end
