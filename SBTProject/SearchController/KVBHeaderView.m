//
//  KVBHeaderView.m
//  SBTProject
//
//  Created by Константин Богданов on 07.01.2018.
//  Copyright © 2018 Константин Богданов. All rights reserved.
//

#import "KVBHeaderView.h"
#import <Masonry.h>


@implementation KVBHeaderView

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        _sectionNameLabel = [UILabel new];
        _sectionNameLabel.textAlignment = NSTextAlignmentCenter;
        _sectionNameLabel.text = @"TEST";
        _sectionNameLabel.backgroundColor = [UIColor colorWithRed:133 / 255.0 green:214 / 255.0 blue:213 / 255.0 alpha:1.0f];
        [self.contentView addSubview:_sectionNameLabel];
    }
    
    [self setupConstraints];
    
    return self;
}

- (void)setupConstraints
{
    [_sectionNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [super updateConstraints];
}
@end
