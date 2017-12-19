//
//  KVBViewWithParametres.m
//  SBTProject
//
//  Created by Константин Богданов on 13.12.17.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBViewWithParametres.h"
#import <Masonry.h>

const CGFloat KVBLeftRightOffsetInView = 20;

@implementation KVBViewWithParametres

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _departureLabel = [UITextField new];
        _departureLabel.placeholder = @"Departure";
        _departureLabel.backgroundColor = UIColor.clearColor;

        _arrivalLabel = [UITextField new];
        _arrivalLabel.placeholder = @"Arrival";
        _arrivalLabel.backgroundColor = UIColor.clearColor;

        _departureDate = [UITextField new];
        _departureDate.placeholder = @"te.st.date";
        _departureDate.backgroundColor = UIColor.clearColor;

        _departureDate = [UITextField new];
        _departureDate.placeholder = @"te.st.date";
        _departureDate.backgroundColor = UIColor.clearColor;

        _arrivalDate = [UITextField new];
        _arrivalDate.placeholder = @"te.st.date";
        _arrivalDate.backgroundColor = UIColor.clearColor;

        [self addSubview:_departureLabel];
        [self addSubview:_arrivalLabel];
        [self addSubview:_departureDate];
        [self addSubview:_arrivalDate];

        
        [_departureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(KVBLeftRightOffsetInView);
            make.left.equalTo(self.mas_left).offset(KVBLeftRightOffsetInView);
            make.right.equalTo(_arrivalLabel.mas_left).offset(-KVBLeftRightOffsetInView);
            make.height.equalTo(@(20));
            make.width.equalTo(_arrivalLabel.mas_width);
            
        }];
        
        [_arrivalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(KVBLeftRightOffsetInView);
            make.right.equalTo(self.mas_right).offset(-KVBLeftRightOffsetInView);
            make.height.equalTo(@(20));
            
        }];

        [_departureDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_departureLabel.mas_bottom).offset(KVBLeftRightOffsetInView);
            make.left.equalTo(self.mas_left).offset(KVBLeftRightOffsetInView);
            make.right.equalTo(_arrivalDate.mas_left).offset(-KVBLeftRightOffsetInView);
            make.height.equalTo(@(20));
            make.width.equalTo(_arrivalDate.mas_width);
            
        }];
        
        [_arrivalDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_arrivalLabel.mas_bottom).offset(KVBLeftRightOffsetInView);
            make.right.equalTo(self.mas_right).offset(-KVBLeftRightOffsetInView);
            make.height.equalTo(_departureLabel.mas_height);
            make.bottom.equalTo(self.mas_bottom).offset(-KVBLeftRightOffsetInView);
            
        }];
    }
    return self;
}

@end
