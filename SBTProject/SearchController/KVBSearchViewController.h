//
//  KVBSearchViewController.h
//  SBTProject
//
//  Created by Константин Богданов on 13.12.17.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Cities;

/**
 Контроллер для поиска авиабилетов. Содержит вью для поиска и табличку для вывода результатов.
 */
@interface KVBSearchViewController : UIViewController

/**
 Инициализирует контроллер с заданым местоположением и контекстом.
 @param city -  город вылета
 @param context - контекст для работы с CoreData
 @return экземпляр KVBSearchViewController
 */
- (instancetype)initWithDeparture:(Cities*)city withContext:(NSManagedObjectContext*)context;

@end
