//
//  KVBLocationsTableViewCell.m
//  SBTProject
//
//  Created by Константин Богданов on 03.01.2018.
//  Copyright © 2018 Константин Богданов. All rights reserved.
//

#import "KVBLocationsTableViewCell.h"
#import <Masonry.h>


@interface KVBLocationsTableViewCell()


@property(nonatomic, strong) UILabel *locationLabel;


@end


@implementation KVBLocationsTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _locationLabel = [UILabel new];
        _locationLabel.font = [UIFont systemFontOfSize:30];
        
        self.layer.cornerRadius  = 10;
        
        [self.contentView addSubview:_locationLabel];
        
        [self setupConstraints];
    }
    return self;
}


#pragma mark - Constraints

- (void)setupConstraints
{
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.left.equalTo(self.contentView.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    [super updateConstraints];
}

#pragma mark - Setters

-(void)setLocationName:(NSString *)locationName
{
    _locationName = locationName;
    _locationLabel.text = _locationName;
}

@end
