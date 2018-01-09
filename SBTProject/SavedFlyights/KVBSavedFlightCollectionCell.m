//
//  KVBSavedFlightCollectionCell.m
//  SBTProject
//
//  Created by Константин Богданов on 29.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBSavedFlightCollectionCell.h"
#import <Masonry.h>

const NSInteger KVBFontSizeInCollectionCell = 22;
const NSInteger KVBElementOffsetInCollectionCell = 15;
const CGSize KVBPlaneIconSize = {30,30};


@interface KVBSavedFlightCollectionCell()

@property(nonatomic, strong) UILabel *fromLabel;
@property(nonatomic, strong) UILabel *timeLabel;
@property(nonatomic, strong) UILabel *toLabel;
@property(nonatomic, strong) UILabel *backTimeLabel;
@property(nonatomic, strong) UILabel *priceLabel;
@property(nonatomic, strong) UILabel *departureDateLabel;
@property(nonatomic, strong) UILabel *backDateLabel;
@property(nonatomic, strong) UILabel *classLabel;
@property(nonatomic, strong) UIImageView *imageView;

@end

@implementation KVBSavedFlightCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIFont *font = [UIFont fontWithName:@"AvenirNextCondensed-MediumItalic" size:KVBFontSizeInCollectionCell];
        UIColor *labelColor = [UIColor colorWithRed:133 / 255.0 green:214 / 255.0 blue:213 / 255.0 alpha:1.0f];
        
        _fromLabel = [UILabel new];
        _fromLabel.font = font;
        _fromLabel.backgroundColor = labelColor;
        
        _timeLabel = [UILabel new];
        _timeLabel.font = font;
        
        _toLabel = [UILabel new];
        _toLabel.font = font;
        _toLabel.backgroundColor = labelColor;

        _priceLabel = [UILabel new];
        _priceLabel.font = font;
        _priceLabel.backgroundColor = labelColor;

        _backTimeLabel = [UILabel new];
        _backTimeLabel.font = font;
        
        _departureDateLabel = [UILabel new];
        _departureDateLabel.font = font;

        _backDateLabel = [UILabel new];
        _backDateLabel.font = font;

        _classLabel = [UILabel new];
        _classLabel.font = font;
        _classLabel.textAlignment = NSTextAlignmentCenter;
        

        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.contentView.bounds.size.height - KVBPlaneIconSize.height, KVBPlaneIconSize.width, KVBPlaneIconSize.height)];
        _imageView.image = [UIImage imageNamed:@"collIcon"];
        

       
        self.layer.cornerRadius = 15;
        self.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:246 / 255.0 blue:196 / 255.0 alpha:1.0f];

        [self.contentView addSubview:_imageView];
        [self.contentView addSubview:_timeLabel];
        [self.contentView addSubview:_fromLabel];
        [self.contentView addSubview:_toLabel];
        [self.contentView addSubview:_backTimeLabel];
        [self.contentView addSubview:_priceLabel];
        [self.contentView addSubview:_departureDateLabel];
        [self.contentView addSubview:_backDateLabel];
        [self.contentView addSubview:_classLabel];
        
        [self setupConstraints];
    }
    return self;
}


#pragma mark - Constreints

- (void)setupConstraints
{
    [_fromLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(KVBElementOffsetInCollectionCell);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fromLabel.mas_bottom).offset(KVBElementOffsetInCollectionCell);
        make.left.equalTo(self.contentView.mas_left);
        make.height.equalTo(_fromLabel);
        make.width.equalTo(_backTimeLabel);
    }];
    
    [_departureDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fromLabel.mas_bottom).offset(KVBElementOffsetInCollectionCell);
        make.left.equalTo(_timeLabel.mas_right).offset(KVBElementOffsetInCollectionCell);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(_fromLabel);
    }];
    
    [_toLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_departureDateLabel.mas_bottom).offset(KVBElementOffsetInCollectionCell);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(_fromLabel);
    }];
    
    [_backTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_toLabel.mas_bottom).offset(KVBElementOffsetInCollectionCell);
        make.left.equalTo(self.contentView.mas_left);
        make.height.equalTo(_fromLabel);
    }];
    
    [_backDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_toLabel.mas_bottom).offset(KVBElementOffsetInCollectionCell);
        make.left.equalTo(_backTimeLabel.mas_right).offset(KVBElementOffsetInCollectionCell);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(_fromLabel);
    }];

    [_classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backDateLabel.mas_bottom).offset(KVBElementOffsetInCollectionCell);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(_fromLabel);
    }];

    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_classLabel.mas_bottom).offset(KVBElementOffsetInCollectionCell);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(_fromLabel);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(- KVBPlaneIconSize.height - KVBElementOffsetInCollectionCell);
    }];
    
    [super updateConstraints];
}


#pragma mark - Setters

- (void)setBack:(NSString *)back
{
    _back = back;
    self.toLabel.text = _back;
}

- (void)setFrom:(NSString *)from
{
    _from = from;
    self.fromLabel.text = _from;
}

- (void)setBackDate:(NSDate *)backDate
{
    _backDate = backDate;
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"MMM d, yyyy, EEEE";
    self.backDateLabel.text = [dateFormatter stringFromDate:_backDate];
    dateFormatter.dateFormat = @"HH:mm";
    self.backTimeLabel.text = [dateFormatter stringFromDate:backDate];

}

- (void)setDepartureDate:(NSDate*)departureDate
{
    _departureDate = departureDate;
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"MMM d, yyyy, EEEE";
    self.departureDateLabel.text = [dateFormatter stringFromDate:_departureDate];
    dateFormatter.dateFormat = @"HH:mm";
    self.timeLabel.text = [dateFormatter stringFromDate:_departureDate];
}

- (void)setPrice:(NSInteger)price
{
    _price = price;
    self.priceLabel.text = [NSString stringWithFormat:@"Price %li p.", _price];
}

- (void)setClassNumber:(NSInteger)classNumber
{
    _classNumber = classNumber;
    self.classLabel.text = [NSString stringWithFormat:@"Class %li", _classNumber];
}


#pragma mark - Animation

- (void)startAnimation
{
    CGPoint newCenter = CGPointMake( - self.imageView.center.x + self.contentView.bounds.size.width, self.imageView.center.y);
    
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.values = @[@(CGPointMake(self.imageView.center.x, self.imageView.center.y)), @(CGPointMake( - self.imageView.center.x + self.contentView.bounds.size.width, self.imageView.center.y)), ];
    pathAnimation.duration = 5.0;
    [self.imageView.layer addAnimation:pathAnimation forKey:@"position"];
    
    self.imageView.center = newCenter;
}

@end
