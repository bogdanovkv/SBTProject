//
//  KVBLocationViewController.h
//  
//
//  Created by Константин Богданов on 23.12.2017.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


/**
 Вью контроллер для отображения местоположения пользоватеся и подгрузки данных(городов и стран) с сервиса кор даты.
 При первом запуске приложения запускает загрузку списка стран и городов с сервера.
 */
@interface KVBLocationViewController : UIViewController

- (instancetype)initWithContext:(NSManagedObjectContext*) context;

@end
