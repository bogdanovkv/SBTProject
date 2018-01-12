//
//  KVBCollectionViewFlightCell.h
//  SBTProject
//
//  Created by Константин Богданов on 21.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 Ячейка коллекшн вью для отображения данных о полете
*/
@interface KVBCollectionViewFlightCell : UICollectionViewCell

@property(nonatomic, strong) UILabel *arrivalLabel;         /**< Название страны отправления. */
@property(nonatomic, strong) UILabel *departureLabel;       /**< Название страны назначения. */
@property(nonatomic, strong) UILabel *priceLabel;           /**< Цена.  */

@end
