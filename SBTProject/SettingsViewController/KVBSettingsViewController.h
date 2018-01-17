//
//  KVBSettingsViewController.h
//  SBTProject
//
//  Created by Константин Богданов on 14.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KVBCoreDataService;

/**
 Констроллер с таблице в которой выводятся настройки
 */
@interface KVBSettingsViewController : UIViewController

/**
 Инициализизирует контроллер с заданым сервисом CoreData
 @param coreDataServise сервис для работы с CoreData.
 @return объект KVBSettingsViewController.
 */
- (instancetype _Nonnull)initWithCoreDataServise:( KVBCoreDataService * _Nonnull)coreDataServise;


@end
