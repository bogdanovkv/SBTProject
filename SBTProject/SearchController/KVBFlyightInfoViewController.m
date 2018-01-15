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

static NSInteger const KVBElementOffsetInFlyightInfo = 15;
static NSInteger const KVBButtonHeight = 40;
static NSInteger const KVBElementBottomOffset = 64;
static NSInteger const KVBNavigationBarSize = 64;
static NSInteger const KVBButtonCornerRadius = 15;

@interface KVBFlyightInfoViewController ()

@property(nonatomic, strong) UILabel *fromLabel;
@property(nonatomic, strong) UILabel *backLabel;
@property(nonatomic, strong) UILabel *timeLabel;
@property(nonatomic, strong) UILabel *departureDateLabel;
@property(nonatomic, strong) UILabel *backTimeLabel;
@property(nonatomic, strong) UILabel *backDateLabel;
@property(nonatomic, strong) UILabel *priceLabel;
@property(nonatomic, strong) UIImageView *imageView;
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
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd.MM.yyyy' 'HH:mm";
        
        UIColor *lightGreen = [UIColor colorWithRed:133 / 255.0 green:214 / 255.0 blue:213 / 255.0 alpha:1.0f];
        
        _coreDataServise = coreDataServise;
        
        _flightModel = flightModel;

        _departureCity = departureCity;
        
        _arrivalCity = !arrivalCity ? [coreDataServise recieveCityByCityCode:flightModel.arrivalCode].firstObject : arrivalCity ;
        
        _flightModel.arrivalCode = _arrivalCity.codeIATA;
        _flightModel.departureCode = _departureCity.codeIATA;

        _fromLabel = [UILabel new];
        _fromLabel.text = [NSString stringWithFormat:@"%@ - %@",departureCity.name , _arrivalCity.name];
        _fromLabel.backgroundColor = lightGreen;
        
        _timeLabel = [UILabel new];
        dateFormatter.dateFormat = @"HH:mm";
        _timeLabel.text = [dateFormatter stringFromDate:flightModel.departureDate];
        _timeLabel.layer.cornerRadius = 5.0;
        _timeLabel.clipsToBounds = YES;
        _timeLabel.backgroundColor = [UIColor colorWithRed:133 / 255.0 green:214 / 255.0 blue:213 / 255.0 alpha:1.0f];
        
        _departureDateLabel = [UILabel new];
        dateFormatter.dateFormat = @"MMM d, yyyy, EEEE";
        _departureDateLabel.text = [dateFormatter stringFromDate:flightModel.departureDate];
        _departureDateLabel.textColor = UIColor.whiteColor;
        
        _backLabel = [UILabel new];
        _backLabel.text = [NSString stringWithFormat:@"%@ - %@",_arrivalCity.name , _departureCity.name];
        _backLabel.backgroundColor = lightGreen;
        
        _backTimeLabel = [UILabel new];
        dateFormatter.dateFormat = @"HH:mm";
        _backTimeLabel.text = [dateFormatter stringFromDate:flightModel.arrivalDate];
        _backTimeLabel.layer.cornerRadius = 5.0;
        _backTimeLabel.clipsToBounds = YES;
        _backTimeLabel.backgroundColor = [UIColor colorWithRed:133 / 255.0 green:214 / 255.0 blue:213 / 255.0 alpha:1.0f];
        
        _backDateLabel = [UILabel new];
        dateFormatter.dateFormat = @"MMM d, yyyy, EEEE";
        _backDateLabel.text = [dateFormatter stringFromDate:flightModel.arrivalDate];
        _backDateLabel.textColor = UIColor.whiteColor;
        
        _priceLabel = [UILabel new];
        _priceLabel.text = [NSString stringWithFormat:@"Price %li p.", flightModel.cost];
        _priceLabel.backgroundColor = lightGreen;
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        
        _saveButton = [UIButton new];
        [_saveButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_saveButton setTitle:@"Save flight" forState:UIControlStateNormal];
        [_saveButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchDown];
        _saveButton.backgroundColor = lightGreen;
        _saveButton.layer.cornerRadius = KVBButtonCornerRadius;
        _saveButton.tintColor = UIColor.whiteColor;
        
        _imageView = [UIImageView new];
        _imageView.image = [UIImage imageNamed:@"collIcon"];
        _imageView.frame = CGRectMake(-40, -40, 40, 40);
        
        self.view.backgroundColor = [UIColor colorWithRed:40 / 255.0 green:73 / 255.0 blue:82 / 255.0 alpha:1.0f];
        
        [self.view addSubview:_fromLabel];
        [self.view addSubview:_timeLabel];
        [self.view addSubview:_departureDateLabel];
        [self.view addSubview:_backLabel];
        [self.view addSubview:_backTimeLabel];
        [self.view addSubview:_backDateLabel];
        [self.view addSubview:_priceLabel];
        [self.view addSubview:_saveButton];
        [self.view addSubview:_imageView];
        
        [self setupConstraints];
    }
    return self;
}

- (void)setupConstraints
{
    [_fromLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(KVBNavigationBarSize);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fromLabel.mas_bottom).offset(KVBElementOffsetInFlyightInfo);
        make.left.equalTo(self.view.mas_left).offset(KVBElementOffsetInFlyightInfo);
    }];
    
    [_departureDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fromLabel.mas_bottom).offset(KVBElementOffsetInFlyightInfo);
        make.left.equalTo(_timeLabel.mas_right).offset(KVBElementOffsetInFlyightInfo);
    }];
    
    [_backLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_departureDateLabel.mas_bottom).offset(KVBElementOffsetInFlyightInfo);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    
    [_backTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backLabel.mas_bottom).offset(KVBElementOffsetInFlyightInfo);
        make.left.equalTo(self.view.mas_left).offset(KVBElementOffsetInFlyightInfo);
    }];

    [_backDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backLabel.mas_bottom).offset(KVBElementOffsetInFlyightInfo);
        make.left.equalTo(_backTimeLabel.mas_right).offset(KVBElementOffsetInFlyightInfo);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backDateLabel.mas_bottom).offset(KVBElementOffsetInFlyightInfo);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    
    [_saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(KVBElementOffsetInFlyightInfo);
        make.right.equalTo(self.view.mas_right).offset(- KVBElementOffsetInFlyightInfo);;
        make.height.mas_equalTo(KVBButtonHeight);
        make.bottom.equalTo(self.view.mas_bottom).offset(- KVBElementOffsetInFlyightInfo - KVBElementBottomOffset);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:40 / 255.0 green:73 / 255.0 blue:82 / 255.0 alpha:1.0f];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0 / 255.0 green:199 / 255.0 blue:156 / 255.0 alpha:1.0f];
}


#pragma mark - UIButton Action

- (void)buttonAction
{
    [self.coreDataServise saveFlight:self.flightModel];
    [self startAnimation];
    
}


#pragma mark - Animation

- (void)startAnimation
{
    double duration  = 1.7;
    
    NSMutableArray *array = [NSMutableArray array];
    CGFloat funcOfX;
    CGFloat x;
    CGFloat dx = 0.5 * self.view.bounds.size.width / 100;
    CGFloat a =  (self.view.bounds.size.height - KVBElementBottomOffset) / pow(0.5 * self.view.bounds.size.width, 2) ; // y = ax^2
    
    for (int i = 0; i<100; i++)
    {
        x = i * dx;
        funcOfX = a * pow(x, 2);
        [array addObject:@(CGPointMake(x, funcOfX))];
    }
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    basicAnimation.fromValue  = @0;
    basicAnimation.toValue = @1.5;
    basicAnimation.duration = duration;
    
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.values = array;
    pathAnimation.duration = duration;
    [self.imageView.layer addAnimation:pathAnimation forKey:@"position"];
    [self.imageView.layer addAnimation:basicAnimation forKey:@"transform.rotation"];
}
@end
