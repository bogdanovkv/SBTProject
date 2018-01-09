//
//  KVBDataPicker.m
//  SBTProject
//
//  Created by Константин Богданов on 06.01.2018.
//  Copyright © 2018 Константин Богданов. All rights reserved.
//

#import "KVBDatePicker.h"
#import <Masonry.h>

static NSInteger const KVBButtonInsidePickerHeight = 35;


@interface KVBDatePicker()


@property(nonatomic, strong) UIDatePicker *datePicker;
@property(nonatomic, strong) UIButton *okButton;


@end


@implementation KVBDatePicker


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _okButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _okButton.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:199 / 255.0 blue:156 / 255.0 alpha:1.0f];
        [_okButton setTitle:@"OK" forState:UIControlStateNormal];
        [_okButton addTarget:self action:@selector(selectDate) forControlEvents:UIControlEventTouchDown];
        
        _datePicker = [UIDatePicker new];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.backgroundColor = [UIColor colorWithRed:133 / 255.0 green:214 / 255.0 blue:213 / 255.0 alpha:1.0f];
        _datePicker.minimumDate = [NSDate date];
        
        [self addSubview:_datePicker];
        [self addSubview:_okButton];
        
        [self setupContraints];
    }
    return self;
}


#pragma mark - Contraints

- (void)setupContraints
{
    [_okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_datePicker.mas_top);
        make.left.equalTo(_datePicker.mas_left);
        make.right.equalTo(_datePicker.mas_right);
        make.height.mas_equalTo(KVBButtonInsidePickerHeight);
    }];
    
    [_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}


#pragma mark - UIButton Action

- (void)selectDate
{
    [self.delegate dateChanged:self.datePicker.date];
}


@end
