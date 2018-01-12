//
//  KVBFlyightInfoViewController.h
//  SBTProject
//
//  Created by Константин Богданов on 27.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KVBCoreDataServise;
@class KVBFlyightModel;
@class Cities;


/**
 Контроллер для отображения подробной информации о полете.
 */
@interface KVBFlyightInfoViewController : UIViewController


@property(nonatomic, strong) UIButton *saveButton;                              /**< Кнока для сохранения полета */
@property(nonatomic, readonly, strong) KVBCoreDataServise *coreDataServise;     /**< Сервис для работы с кор дата */


/**
 Инициализирует контроллер
 @param flightModel модель полета
 @param departureCity город вылета
 @param arrivalCity город прибытия
 @return coreDataServise сервис для работы с кор дата
 */
- (instancetype)initWithFlightModel:(KVBFlyightModel*)flightModel departureCity:(Cities*)departureCity arrivalCity:(Cities*)arrivalCity withCoreDataServise:(KVBCoreDataServise*) coreDataServise;
/**
 Метод который вызывается по нажатию saveButton. Вынесен сюда для возможности переиспользования. Если не переопределен, то сохраняет полет и запускает анимацию.
 */
- (void)buttonAction;

@end
