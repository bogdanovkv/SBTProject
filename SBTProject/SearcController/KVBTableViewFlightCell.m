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

@implementation KVBTableViewFlightCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        _arrivalLabel = [UILabel new];
        _arrivalLabel.text = @"TestTest";
        _arrivalLabel.numberOfLines = 0;
        _arrivalLabel.backgroundColor = UIColor.clearColor;
        _arrivalLabel.textAlignment = NSTextAlignmentRight;
        
        _departureLabel = [UILabel new];
        _departureLabel.text = @"TestTest";
        _departureLabel.numberOfLines = 0;
        _departureLabel.backgroundColor = UIColor.clearColor;
        
        _priceLabel = [UILabel new];
        _priceLabel.text = @"TestTest";
        _priceLabel.numberOfLines = 0;
        _priceLabel.backgroundColor = UIColor.clearColor;
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _customImage = [UIImageView new];
        _customImage.image = [UIImage imageNamed:@"flight.png"];
        
        self.layer.cornerRadius = 15;
        
        [self.contentView addSubview:_customImage];
        [self.contentView addSubview:_arrivalLabel];
        [self.contentView addSubview:_departureLabel];
        [self.contentView addSubview:_priceLabel];
        
        [_arrivalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-KVBElementOffsetTable);
            make.left.equalTo(_customImage.mas_right).offset(KVBElementOffsetTable);
            make.centerY.equalTo(self.contentView.mas_centerY);
            
        }];
        
        [_departureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(KVBElementOffsetTable);
            make.right.equalTo(_customImage.mas_left).offset(-KVBElementOffsetTable);
            make.centerY.equalTo(self.contentView.mas_centerY);

        }];

        [_customImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(50);
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
        }];
        
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_customImage.mas_bottom).offset(KVBElementOffsetTable);
            make.left.equalTo(self.contentView.mas_left).offset(KVBElementOffsetTable);
            make.right.equalTo(self.contentView.mas_right).offset(-KVBElementOffsetTable);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-KVBElementOffsetTable);
            
        }];
        [super updateConstraints];


    }
    return self;
}
@end
