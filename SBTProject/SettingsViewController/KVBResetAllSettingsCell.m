//
//  KVBResetAllSettingsCell.m
//  SBTProject
//
//  Created by Константин Богданов on 01.01.2018.
//  Copyright © 2018 Константин Богданов. All rights reserved.
//

#import "KVBResetAllSettingsCell.h"
#import <Masonry.h>

const NSInteger KVBOffsetForSettings = 10;
const NSInteger KVBDeleteButtonHeight = 40;

@interface KVBResetAllSettingsCell()

@property(nonatomic, strong) UIButton* deleteButton;
@property(nonatomic, strong) UILabel* deleteLabel;

@end

@implementation KVBResetAllSettingsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _deleteButton = [UIButton new];
        _deleteButton.backgroundColor = UIColor.grayColor;
        _deleteButton.layer.cornerRadius = 15;
        [_deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteFromCoreData) forControlEvents:UIControlEventTouchDown];
        
        _deleteLabel = [UILabel new];
        _deleteLabel.text = @"Clear saved";
        
        [self.contentView addSubview:_deleteButton];
        [self.contentView addSubview:_deleteLabel];

        [self setupConstraints];
    }
    return self;
}

- (void)setupConstraints
{
    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(KVBOffsetForSettings);
        make.height.mas_greaterThanOrEqualTo(40);
        make.right.equalTo(self.contentView.mas_right).offset(-KVBOffsetForSettings);
        make.width.equalTo(_deleteLabel);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-KVBOffsetForSettings);
    }];
    
    [_deleteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_lessThanOrEqualTo(self.contentView.mas_top);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(KVBOffsetForSettings);
        make.bottom.mas_lessThanOrEqualTo(self.contentView.mas_bottom);
    }];
    
    [super updateConstraints];
}


#pragma mark - UIButton Action

- (void)deleteFromCoreData
{
    
}

@end
