//
//  KVBViewWithParametres.h
//  SBTProject
//
//  Created by Константин Богданов on 13.12.17.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Cities;

@protocol KVBSearchViewDelegate;

/**
 View для задания параметров поиска авиаперелетов.
 */
@interface KVBViewWithParametres : UIView


@property(nonatomic, strong) UITextField *departureField;           /** Лейбл для задания города вылета */
@property(nonatomic, strong) UITextField *arrivalField;             /** Лейбл для задания города прибытия */
@property(nonatomic, strong) NSDate *depatrtureDate;                /** Лейбл для задания даты вылета */
@property(nonatomic, strong) NSDate *arrivalDate;                   /** Лейбл для задания даты вылета обратно */
@property(nonatomic, weak) id<KVBSearchViewDelegate> delegate;      /** Делегат */

/**
 Инициализирует вью с контекстом
 @param context - контекст для получения списка городов и стран
 @return экзмепляр KVBViewWithParametres
 */
- (instancetype)initWithContext:(NSManagedObjectContext*)context;

@end


@protocol KVBSearchViewDelegate


- (void)arrivalCityChangedWithCity:(Cities*)city;
- (void)arrivalDateChangedWithDate:(NSDate*)date;
- (void)departureCityChangedWithCity:(Cities*)city;
- (void)departureDateChangedWithDate:(NSDate*)date;


@end
