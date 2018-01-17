//
//  KVBFlyightInfoViewController.h
//  SBTProject
//
//  Created by Константин Богданов on 30.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBFlightInfoViewController.h"

@class Flyight;
/**
 Контроллер для отображения подробной информации о полете. Наследник KVBFlyightInfoViewController. Внутри переопределен метод - (void)buttonAction и тайтл кнопки.(см. хедер KVBFlyightInfoViewController)
 */
@interface KVBFlyightDetailedViewController : KVBFlightInfoViewController

@property(nonatomic, strong) Flyight *flight; /**< Модель полета из кор даты, которая отображается. */

@end
