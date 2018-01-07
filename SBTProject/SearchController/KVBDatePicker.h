//
//  KVBDataPicker.h
//  SBTProject
//
//  Created by Константин Богданов on 06.01.2018.
//  Copyright © 2018 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KVBDatePickerDelegate;


@interface KVBDatePicker : UIView


@property(nonatomic, weak) id<KVBDatePickerDelegate> delegate;


@end


@protocol KVBDatePickerDelegate


- (void)dateChanged:(NSDate*)newDate;


@end
