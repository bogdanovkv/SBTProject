//
//  KVBCollectionViewFlightCell.m
//  SBTProject
//
//  Created by Константин Богданов on 21.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//
#import "KVBCollectionViewFlightCell.h"
#import <Masonry.h>

const NSInteger KVBElementOffset = 15;

@implementation KVBCollectionViewFlightCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _arrivalLabel = [UILabel new];
        _arrivalLabel.text = @"TestTest";
        _arrivalLabel.numberOfLines = 0;
        _arrivalLabel.backgroundColor = UIColor.clearColor;
        
        _departureLabel = [UILabel new];
        _departureLabel.text = @"TestTest";
        _departureLabel.numberOfLines = 0;
        _departureLabel.backgroundColor = UIColor.clearColor;
        
        _priceLabel = [UILabel new];
        _priceLabel.text = @"TestTest";
        _priceLabel.numberOfLines = 0;
        _priceLabel.backgroundColor = UIColor.clearColor;
        
        _imageView = [UIImageView new];
        _imageView.image = [UIImage imageNamed:@"iconfl.png"];
        
        self.layer.cornerRadius = 15;
        self.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:246 / 255.0 blue:196 / 255.0 alpha:1.0f];
        
        [self.contentView addSubview:_imageView];
        [self.contentView addSubview:_arrivalLabel];
        [self.contentView addSubview:_departureLabel];
        [self.contentView addSubview:_priceLabel];

        [self setupConstraints];
    }
    return self;
}

- (void)setupConstraints
{
    [_arrivalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(KVBElementOffset);
        make.left.equalTo(self.contentView.mas_left).offset(KVBElementOffset);
        make.right.equalTo(_imageView.mas_left).offset(-KVBElementOffset);
        
    }];
    
    [_departureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_arrivalLabel.mas_bottom).offset(KVBElementOffset);
        make.left.equalTo(self.contentView.mas_left).offset(KVBElementOffset);
        make.right.equalTo(_imageView.mas_left).offset(-KVBElementOffset);
        
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_departureLabel.mas_bottom).offset(KVBElementOffset);
        make.left.equalTo(self.contentView.mas_left).offset(KVBElementOffset);
        make.right.equalTo(self.contentView.mas_right).offset(-KVBElementOffset);
        
    }];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-KVBElementOffset);
        make.top.equalTo(self.contentView.mas_top).offset(KVBElementOffset);
        make.height.mas_equalTo(80);
        make.width.mas_equalTo(80);
    }];
    
    [super updateConstraints];
}
@end
