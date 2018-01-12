//
//  KVBResetAllSettingsCell.h
//  SBTProject
//
//  Created by Константин Богданов on 01.01.2018.
//  Copyright © 2018 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol KVBCustomCellProtocol;

/**
 Ячейка таблицы с кнопкой для удаления всезх полетов из CoreData
 */
@interface KVBResetAllSettingsCell : UITableViewCell


@property(weak, nonatomic) id<KVBCustomCellProtocol> delegate; /**< Делегат который реализует метод deleteFromCoreData. */

- (void)showButton;


@end


@protocol KVBCustomCellProtocol

@required

- (void)deleteFromCoreData;


@end
