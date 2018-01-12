//
//  KVBPreparatoryCoreData.h
//  SBTProject
//
//  Created by Константин Богданов on 15.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSManagedObjectContext;
@protocol KVBFirstStartLoadingDelegate;

extern NSString * const KVBTravelpayouts;
extern NSString * const KVBLocationsRequestWhereAreMe;
extern NSString * const KVBRequestAllCountries;
extern NSString * const KVBRequestAllCities;
extern NSString * const KVBRequestAllAirports;

/**
 Вспомогательный класс для загрузки в кор дату городов, стран и аэропортов с www.travelpayouts.com.
 При успешной загрузке устанавливает в UserDafaults значение @"Exist" для ключа @"isDataExist".
 При неуспешной ничего не устанавливается и метод делегата не вызывается.
 Объект данного класса должен быть делегатом NSURLSession. Внутри реализован метод NSURLSession didFinishDownloadingToURL в котором идет сохранение стран в NSDIctionary.
 Как только все страны, города и аэропорты подгрузяться будет запущено сохранение их в кор дату.
 */
@interface KVBFirstStartCoreDataLoader : NSObject <NSURLSessionDelegate>


@property(nonatomic, weak) id<KVBFirstStartLoadingDelegate> delegate;       /**< Делегат у которого при успешной загрузке вызывается метод loadingComplete. */

/**
 Возвращает экземпляр класса.
 @param context - контекст для CoreData.
 @return экземпляр KVBFirstStartCoreDataLoader.
 */
- (instancetype)initWithContext:(NSManagedObjectContext*)context;


@end


@protocol KVBFirstStartLoadingDelegate


- (void)loadingComplete;


@end

