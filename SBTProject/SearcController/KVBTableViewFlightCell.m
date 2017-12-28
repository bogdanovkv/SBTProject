//
//  KVBTableViewFlightCell.m
//  SBTProject
//
//  Created by Константин Богданов on 22.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBTableViewFlightCell.h"
#import <Masonry.h>
const NSInteger KVBElementOffsetTable = 10;
const NSInteger KVBPhotoSize = 50;

@interface KVBTableViewFlightCell()
@property(nonatomic, strong) UILabel *arrivalLabel;
@property(nonatomic, strong) UILabel *departureLabel;
@property(nonatomic, strong) UILabel *priceLabel;
@property(nonatomic, strong) UILabel *arrivalDateLabel;
@property(nonatomic, strong) UILabel *departureDateLabel;
@end

@implementation KVBTableViewFlightCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        _arrivalLabel = [UILabel new];
        _arrivalLabel.numberOfLines = 0;
        _arrivalLabel.backgroundColor = UIColor.clearColor;
        _arrivalLabel.textAlignment = NSTextAlignmentRight;
        
        _arrivalDateLabel = [UILabel new];
        _arrivalDateLabel.numberOfLines = 0;
        _arrivalDateLabel.backgroundColor = UIColor.clearColor;
        _arrivalDateLabel.textAlignment = NSTextAlignmentRight;
        
        _departureLabel = [UILabel new];
        _departureLabel.numberOfLines = 0;
        _departureLabel.backgroundColor = UIColor.clearColor;
        
        _departureDateLabel = [UILabel new];
        _departureDateLabel.numberOfLines = 0;
        _departureDateLabel.backgroundColor = UIColor.clearColor;
        
        _priceLabel = [UILabel new];
        _priceLabel.numberOfLines = 0;
        _priceLabel.backgroundColor = UIColor.clearColor;
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        
        _customImage = [UIImageView new];
        _customImage.image = [UIImage imageNamed:@"flight.png"];
        
        self.layer.cornerRadius = 15;
        
        [self.contentView addSubview:_customImage];
        [self.contentView addSubview:_arrivalLabel];
        [self.contentView addSubview:_arrivalDateLabel];
        [self.contentView addSubview:_departureLabel];
        [self.contentView addSubview:_departureDateLabel];
        [self.contentView addSubview:_priceLabel];
        
        [self setupConstraints];
    }
    return self;
}

- (void)setupConstraints
{
    [_arrivalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-KVBElementOffsetTable);
        make.left.equalTo(_customImage.mas_right).offset(KVBElementOffsetTable);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [_arrivalDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_arrivalLabel.mas_bottom).offset(KVBElementOffsetTable);
        make.right.equalTo(self.contentView.mas_right).offset(-KVBElementOffsetTable);
        make.left.equalTo(_customImage.mas_right).offset(KVBElementOffsetTable);
    }];
    
    [_departureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(KVBElementOffsetTable);
        make.right.equalTo(_customImage.mas_left).offset(-KVBElementOffsetTable);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [_departureDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_departureLabel.mas_bottom).offset(KVBElementOffsetTable);
        make.left.equalTo(self.contentView.mas_left).offset(KVBElementOffsetTable);
        make.right.equalTo(_customImage.mas_left).offset(-KVBElementOffsetTable);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-KVBElementOffsetTable);
    }];
    
    [_customImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(KVBElementOffsetTable);
        make.height.mas_equalTo(KVBPhotoSize);
        make.width.mas_equalTo(KVBPhotoSize);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_customImage.mas_bottom).offset(KVBElementOffsetTable);
        make.left.equalTo(self.contentView.mas_left).offset(KVBElementOffsetTable);
        make.right.equalTo(self.contentView.mas_right).offset(-KVBElementOffsetTable);
    }];
    [super updateConstraints];
}

- (void)setDeparture:(NSString *)departure
{
    _departure = departure;
    _departureLabel.text = _departure;
}

- (void)setPrice:(NSString *)price
{
    _price = price;
    _priceLabel.text = _price;
}

- (void)setArrival:(NSString *)arrival
{
    _arrival = arrival;
    _arrivalLabel.text = _arrival;
}

- (void)setArrivalDate:(NSDate *)arrivalDate
{
    _arrivalDate = arrivalDate;
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"dd.MM.yyyy' 'HH:mm";
    _arrivalDateLabel.text = [dateFormatter stringFromDate:_arrivalDate];
}

- (void)setDepartureDate:(NSDate *)departureDate
{
    _departureDate = departureDate;
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"dd.MM.yyyy' 'HH:mm";
    _departureDateLabel.text = [dateFormatter stringFromDate:_departureDate];
}
@end
