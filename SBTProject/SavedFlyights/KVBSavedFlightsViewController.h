//
//  KVBSavedFlightsViewController.h
//  SBTProject
//
//  Created by Константин Богданов on 14.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KVBCoreDataService;

/**
 Контроллер для отображения полетов сохраненных в кор дате.
 */
@interface KVBSavedFlightsViewController : UIViewController


/**
Инициализирует контроллер с заданым кор дата сервисом.
 @param coreDataServise сервис для работы с кор датой.
 @return контроллер с заданым кор дата сервисом.
 */
- (instancetype)initWithCoreDataService:(KVBCoreDataService*)coreDataServise;


@end
