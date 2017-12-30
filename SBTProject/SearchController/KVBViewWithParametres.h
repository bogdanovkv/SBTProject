//
//  KVBViewWithParametres.h
//  SBTProject
//
//  Created by Константин Богданов on 13.12.17.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Cities;
@protocol KVBSearchViewDelegate;


@interface KVBViewWithParametres : UIView

- (instancetype)initWithContext: (NSManagedObjectContext*) context;

@property(nonatomic, strong) UITextField *departureField;
@property(nonatomic, strong) UITextField *departureDate;
@property(nonatomic, strong) UITextField *arrivalField;
@property(nonatomic, strong) UITextField *arrivalDate;
@property(nonatomic, strong) UITextField *backgroundImage;
@property(nonatomic, weak) id<KVBSearchViewDelegate> delegate;

@end


@protocol KVBSearchViewDelegate

- (void)arrivalCityChangedWithCity:(Cities*)city;
- (void)arrivalDateChangedWithDate:(NSDate*)date;
- (void)departureCityChangedWithCity:(Cities*)city;
- (void)departureDateChangedWithDate:(NSDate*)date;

@end
