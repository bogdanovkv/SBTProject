//
//  KVBSavedFlightCollectionCell.h
//  SBTProject
//
//  Created by Константин Богданов on 29.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 Ячейка коллекшн вью для отображения данных о полете.
 */
@interface KVBSavedFlightCollectionCell : UICollectionViewCell

@property(nonatomic, copy) NSString *from;              /**< Название города вылета. */
@property(nonatomic, copy) NSString *back;              /**< Названия города назначения. */
@property(nonatomic, strong) NSDate *departureDate;     /**< Дата вылета. */
@property(nonatomic, strong) NSDate *backDate;          /**< Дата билетов назад. */
@property(nonatomic, assign) NSInteger classNumber;     /**< Номер класса полета. */
@property(nonatomic, assign) NSInteger price;           /**< Цена. */

/**
 Запускает анимацию летящего самолетика.
 */
- (void)startAnimation;

@end
