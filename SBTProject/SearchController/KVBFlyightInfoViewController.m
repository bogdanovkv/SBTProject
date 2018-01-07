//
//  KVBFlyightInfoViewController.m
//  SBTProject
//
//  Created by Константин Богданов on 27.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBFlyightInfoViewController.h"
#import "Cities+CoreDataClass.h"
#import "KVBFlyightModel.h"
#import "KVBCoreDataServise.h"
#import <Masonry.h>

const NSInteger KVBElementOffsetInFlyightInfo = 15;
const NSInteger KVBButtonHeight = 40;
const NSInteger KVBElementBottomOffset = 64;
const NSInteger KVBNavigationBarSize = 64;
const NSInteger KVBCornerRadiusButton = 15;
const CGFloat KVBFontSize = 20.0f;


@interface KVBFlyightInfoViewController ()

@property(nonatomic, strong) UILabel *fromLabel;
@property(nonatomic, strong) UILabel *toLabel;
@property(nonatomic, strong) UILabel *departureDateLabel;
@property(nonatomic, strong) UILabel *backDateLabel;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIImageView *backImage;
@property(nonatomic, strong) KVBFlyightModel *flightModel;
@property(nonatomic, strong) Cities *departureCity;
@property(nonatomic, strong) Cities *arrivalCity;

@end

@implementation KVBFlyightInfoViewController

- (instancetype)initWithFlightModel:(KVBFlyightModel*)flightModel
                      departureCity:(Cities*)departureCity
                        arrivalCity:(Cities*)arrivalCity
                withCoreDataServise: (KVBCoreDataServise*) coreDataServise
{
    self = [super init];
    if (self)
    {
        UIFont *font = [UIFont fontWithName:@"Baskerville-BoldItalic"  size:KVBFontSize];
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd.MM.yyyy' 'HH:mm";
        
        _coreDataServise = coreDataServise;
        
        _flightModel = flightModel;

        _departureCity = departureCity;
        
        _arrivalCity = !arrivalCity ? [coreDataServise recieveCityByCityCode:flightModel.arrivalCode].firstObject : arrivalCity ;
        
        _flightModel.arrivalCode = _arrivalCity.codeIATA;
        _flightModel.departureCode = _departureCity.codeIATA;

        _fromLabel = [UILabel new];
        _fromLabel.numberOfLines = 0;
        _fromLabel.text = [NSString stringWithFormat:@"From:    %@", _departureCity.name];
        _fromLabel.font = font;
        _fromLabel.shadowColor = UIColor.whiteColor;

        _toLabel = [UILabel new];
        _toLabel.numberOfLines = 0;
        _toLabel.text = [NSString stringWithFormat:@"To:    %@", _arrivalCity.name];
        _toLabel.font = font;
        _toLabel.shadowColor = UIColor.whiteColor;

        _departureDateLabel = [UILabel new];
        _departureDateLabel.numberOfLines = 0;
        _departureDateLabel.text = [NSString stringWithFormat:@"Departure at %@", [dateFormatter stringFromDate:flightModel.arrivalDate]];
        _departureDateLabel.font = font;
        _departureDateLabel.shadowColor = UIColor.whiteColor;

        _backDateLabel = [UILabel new];
        _backDateLabel.numberOfLines = 0;
        _backDateLabel.text = [NSString stringWithFormat:@"Return at %@", [dateFormatter stringFromDate:flightModel.departureDate]];
        _backDateLabel.font = font;
        _backDateLabel.shadowColor = UIColor.whiteColor;
    
        _saveButton = [UIButton new];
        _saveButton.layer.cornerRadius = KVBCornerRadiusButton;
        _saveButton.backgroundColor = UIColor.grayColor;
        [_saveButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchDown];
        [_saveButton setTitle:@"Save flight" forState:UIControlStateNormal];
        
        _imageView = [UIImageView new];
        _imageView.image = [UIImage imageNamed:@"bigplane"];;
        
        _backImage = [UIImageView new];
        _backImage.image = [UIImage imageNamed:@"background"];
        
        [self.view addSubview:_backImage];
        [self.view addSubview:_fromLabel];
        [self.view addSubview:_toLabel];
        [self.view addSubview:_departureDateLabel];
        [self.view addSubview:_backDateLabel];
        [self.view addSubview:_saveButton];
        [self.view addSubview:_imageView];
        
        [self setupConstraints];
    }
    return self;
}

- (void)setupConstraints
{
    [_fromLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(KVBNavigationBarSize + KVBElementOffsetInFlyightInfo);
        make.left.equalTo(self.view.mas_left).offset(KVBElementOffsetInFlyightInfo);
        make.right.equalTo(self.view.mas_right).offset(-KVBElementOffsetInFlyightInfo);
    }];
    
    [_toLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fromLabel.mas_bottom).offset(KVBElementOffsetInFlyightInfo);
        make.left.equalTo(self.view.mas_left).offset(KVBElementOffsetInFlyightInfo);
        make.right.equalTo(self.view.mas_right).offset(-KVBElementOffsetInFlyightInfo);
    }];
    
    [_departureDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_toLabel.mas_bottom).offset(KVBElementOffsetInFlyightInfo);
        make.left.equalTo(self.view.mas_left).offset(KVBElementOffsetInFlyightInfo);
        make.right.equalTo(self.view.mas_right).offset(KVBElementOffsetInFlyightInfo);
    }];
    
    [_saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(KVBElementOffsetInFlyightInfo);
        make.height.mas_equalTo(KVBButtonHeight);
        make.right.equalTo(self.view.mas_right).offset(-KVBElementOffsetInFlyightInfo);
        make.bottom.equalTo(self.view.mas_bottom).offset(-KVBElementBottomOffset);
    }];
    
    [_backDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_saveButton.mas_top).offset(-KVBElementOffsetInFlyightInfo);
        make.left.equalTo(self.view.mas_left).offset(KVBElementOffsetInFlyightInfo);
        make.right.equalTo(self.view.mas_right).offset(-KVBElementOffsetInFlyightInfo);
    }];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    
    [_backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIColor *topColor = [UIColor colorWithRed:89 / 255.0 green:89 / 255.0 blue:89 / 255.0 alpha:1.0f];
    UIColor *middleColor = [UIColor colorWithRed:200 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1.0f];
    UIColor *bottomColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:1.0f];
   
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = @[(id)topColor.CGColor, (id)middleColor.CGColor, (id)bottomColor.CGColor ];

    [self.view.layer insertSublayer:gradient atIndex:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}


#pragma mark - UIButton Action

- (void)buttonAction
{
    [self.coreDataServise saveFlight:self.flightModel];
}

@end
