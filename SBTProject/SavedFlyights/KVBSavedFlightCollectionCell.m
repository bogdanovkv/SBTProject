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
@property(nonatomic, strong) UILabel *toLabel;
@property(nonatomic, strong) UILabel *priceLabel;
@property(nonatomic, strong) UILabel *departureDateLabel;
@property(nonatomic, strong) UILabel *backDateLabel;
@property(nonatomic, strong) UILabel *classLabel;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIImageView *backImage;

@end

@implementation KVBSavedFlightCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIFont *font = [UIFont fontWithName:@"AvenirNextCondensed-MediumItalic" size:KVBFontSizeInCollectionCell];
        
        _fromLabel = [UILabel new];
        _fromLabel.font = font;
        _fromLabel.textAlignment = NSTextAlignmentCenter;
        
        _toLabel = [UILabel new];
        _toLabel.font = font;
        _toLabel.textAlignment = NSTextAlignmentCenter;

        _priceLabel = [UILabel new];
        _priceLabel.font = font;
        _priceLabel.textAlignment = NSTextAlignmentCenter;

        _departureDateLabel = [UILabel new];
        _departureDateLabel.font = font;
        _departureDateLabel.textAlignment = NSTextAlignmentCenter;

        _backDateLabel = [UILabel new];
        _backDateLabel.font = font;
        _backDateLabel.textAlignment = NSTextAlignmentCenter;

        _classLabel = [UILabel new];
        _classLabel.font = font;
        _classLabel.textAlignment = NSTextAlignmentCenter;
        

        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.contentView.bounds.size.height - KVBPlaneIconSize.height, KVBPlaneIconSize.width, KVBPlaneIconSize.height)];
        _imageView.image = [UIImage imageNamed:@"collIcon"];
        

        _backImage = [UIImageView new];
        _backImage.image = [UIImage imageNamed:@"backCollection"];
        _backImage.layer.cornerRadius = 15;
        _backImage.layer.masksToBounds = YES;
        
        self.layer.cornerRadius = 15;


        [self.contentView addSubview:_backImage];
        [self.contentView addSubview:_imageView];
        [self.contentView addSubview:_fromLabel];
        [self.contentView addSubview:_toLabel];
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
    [_backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    [_fromLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(KVBElementOffsetInCollectionCell);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
    }];
    
    [_departureDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fromLabel.mas_bottom).offset(KVBElementOffsetInCollectionCell);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(_fromLabel);
    }];
    
    [_toLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_departureDateLabel.mas_bottom).offset(KVBElementOffsetInCollectionCell);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(_departureDateLabel);
    }];

    [_backDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_toLabel.mas_bottom).offset(KVBElementOffsetInCollectionCell);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(_toLabel);
    }];

    [_classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backDateLabel.mas_bottom).offset(KVBElementOffsetInCollectionCell);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(_backDateLabel);
    }];

    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_classLabel.mas_bottom).offset(KVBElementOffsetInCollectionCell);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(_classLabel);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(- KVBPlaneIconSize.height - KVBElementOffsetInCollectionCell);
    }];
    
    [super updateConstraints];
}


#pragma mark - Setters

- (void)setTo:(NSString *)to
{
    _to = to;
    self.toLabel.text = [NSString stringWithFormat:@"To %@", _to];
}

- (void)setFrom:(NSString *)from
{
    _from = from;
    self.fromLabel.text = [NSString stringWithFormat:@"From %@", _from];
}

- (void)setBackDate:(NSDate *)backDate
{
    _backDate = backDate;
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"dd.MM.yyyy' 'HH:mm";
    self.backDateLabel.text = [NSString stringWithFormat:@"Return at %@", [dateFormatter stringFromDate:_backDate]];
}

- (void)setDepartureDate:(NSDate*)departureDate
{
    _departureDate = departureDate;
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"dd.MM.yyyy' 'HH:mm";
    self.departureDateLabel.text =  [NSString stringWithFormat:@"Departure at %@", [dateFormatter stringFromDate:_departureDate]];
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
