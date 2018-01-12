//
//  KVBSettingTableDataSourse.h
//  SBTProject
//
//  Created by Константин Богданов on 01.01.2018.
//  Copyright © 2018 Константин Богданов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
static NSString *const KVBResetTableViewCell = @"KVBResetTableViewCell";
static NSString *const KVBLanguageSettingCell = @"KVBLanguageSettingCell";
static NSString *const KVBProfileSettings = @"KVBProfileSettings";


/**
 Датасорс для таблицы с настройками
 */
@interface KVBSettingTableDataSourse : NSObject<UITableViewDataSource>

@end
