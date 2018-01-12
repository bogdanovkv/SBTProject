//
//  KVBTableViewFlightCell.h
//  SBTProject
//
//  Created by Константин Богданов on 22.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Ячека таблицы для отображения полетов.
 */
@interface KVBTableViewFlightCell : UITableViewCell

@property(nonatomic, strong) NSString *arrival;             /**< Название города отправления. */
@property(nonatomic, strong) NSString *departure;           /**< Название города прибития. */
@property(nonatomic, strong) UIImageView *customImage;      /**< Картинка отображаемая в таблице. */
@property(nonatomic, strong) NSString *price;               /**< Цена. */
@property(nonatomic, strong) NSDate *departureDate;         /**< Дата вылета. */
@property(nonatomic, strong) NSDate *arrivalDate;           /**< Да вылета обратно. */

@end
