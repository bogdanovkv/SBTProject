//
//  KVBHeaderView.h
//  SBTProject
//
//  Created by Константин Богданов on 07.01.2018.
//  Copyright © 2018 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 Хедер для таблицы. С лейблом на весь хэдер и выравнием текста по центру.
 */
@interface KVBHeaderView : UITableViewHeaderFooterView


@property(nonatomic, strong) UILabel *sectionNameLabel;     /**< Лэйбл хэдера */


@end
