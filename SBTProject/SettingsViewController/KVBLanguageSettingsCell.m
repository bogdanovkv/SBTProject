//
//  KVBLanguageSettingsCell.m
//  
//
//  Created by Константин Богданов on 01.01.2018.
//

#import "KVBLanguageSettingsCell.h"
#import <Masonry.h>

const NSInteger KVBLabelsOffset = 15;

@interface KVBLanguageSettingsCell()

@property(nonatomic, strong) UILabel *englishLabel;
@property(nonatomic, strong) UILabel *russianLabel;
@property(nonatomic, strong) UISwitch *languageSwitch;

@end

@implementation KVBLanguageSettingsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _englishLabel = [UILabel new];
        _englishLabel.text = @"English";
    
        _russianLabel = [UILabel new];
        _russianLabel.text = @"Russian";
        _russianLabel.textAlignment = NSTextAlignmentRight;
        
        _languageSwitch = [UISwitch new];
        [_languageSwitch addTarget:self action:@selector(switchLanguage) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_englishLabel];
        [self.contentView addSubview:_russianLabel];
        [self.contentView addSubview:_languageSwitch];

        [self setupConstraints];
    }
    return self;
}


- (void)setupConstraints
{
    [_englishLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(KVBLabelsOffset);
    }];
    
    [_russianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-KVBLabelsOffset);
    }];
    
    [_languageSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.left.equalTo(_englishLabel.mas_right);
        make.right.equalTo(_russianLabel.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    [super updateConstraints];
}


#pragma mark - UISwitch action

- (void)switchLanguage
{
    
}
@end
