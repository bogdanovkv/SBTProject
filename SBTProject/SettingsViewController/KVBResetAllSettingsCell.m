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
        
        _deleteLabel = [UILabel new];
        _deleteLabel.text = @"Delete all flights";
        
        _deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [self.contentView addSubview:_deleteLabel];
        [self.contentView addSubview:_deleteButton];

        [self setupConstraints];
    }
    return self;
}

- (void)setupConstraints
{
    [_deleteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left).offset(KVBOffsetForSettings);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(40);
    }];
    
    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.width.mas_equalTo(0);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [super updateConstraints];
}


#pragma mark - Animation

- (void)showButton
{
    [self.contentView addSubview:self.deleteButton];
    
    [self.contentView layoutIfNeeded];
    
    [self.deleteButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.width.mas_equalTo(80);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    [self.deleteButton addTarget:self.delegate action:@selector(deleteFromCoreData) forControlEvents:UIControlEventTouchDown];
    
    [UIView animateWithDuration:1.5 animations:^{
        [self.contentView layoutIfNeeded];
        [self.deleteButton setTitle:@"delete" forState:UIControlStateNormal];
    }];
}

@end
