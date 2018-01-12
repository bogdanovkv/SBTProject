//
//  KVBDataPicker.h
//  SBTProject
//
//  Created by Константин Богданов on 06.01.2018.
//  Copyright © 2018 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KVBDatePickerDelegate;

/**
 Класс для выбора даты.
 */
@interface KVBDatePicker : UIView


@property(nonatomic, weak) id<KVBDatePickerDelegate> delegate;      /**< Делегат у которого вызывается метод dateChanged: при выборе даты в дата пикере */


@end


@protocol KVBDatePickerDelegate


- (void)dateChanged:(NSDate*)newDate;


@end
