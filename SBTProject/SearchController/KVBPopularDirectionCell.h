//
//  KVBPopalarDirectionCell.h
//  SBTProject
//
//  Created by Константин Богданов on 21.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KVBCoreDataServise;
@class KVBFlyightModel;
/**
 Класс ячейки таблицы которая содержит внутри себя  UICollectionView
 */
@interface KVBPopularDirectionCell : UITableViewCell


@property(nonatomic, weak) UINavigationController *navController;       /**< Navigation controller в котором отображается ячека */
@property(nonatomic, weak) KVBCoreDataServise *coreDataServise;         /**< Сервис для работы с CoreData */

/**
Инициализирует ячейку с коллекш вью.
 @param popularDirections массив с моделями полетов
 @return возвращает ячейку с коллекшн вью заполненной полетами.
 */
- (instancetype)initWithCollection:(NSArray<KVBFlyightModel*>*)popularDirections;


@end
