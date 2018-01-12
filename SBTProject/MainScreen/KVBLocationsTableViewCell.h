//
//  KVBLocationsTableViewCell.h
//  SBTProject
//
//  Created by Константин Богданов on 03.01.2018.
//  Copyright © 2018 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 Класс ячейки с лейблом на всю ширину и высоту ячейки. Для отображения списка городов или стран в таблице.
 */
@interface KVBLocationsTableViewCell : UITableViewCell


@property(nonatomic, copy) NSString *locationName; /**< Строка для задания названия города/страны, которая будет отображаться в ячейке. */


@end
