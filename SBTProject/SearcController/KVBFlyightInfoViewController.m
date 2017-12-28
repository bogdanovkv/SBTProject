//
//  KVBFlyightInfoViewController.m
//  SBTProject
//
//  Created by Константин Богданов on 27.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBFlyightInfoViewController.h"
#import <Masonry.h>

const NSInteger KVBElementOffsetInFlyightInfo = 15;
const NSInteger KVBButtonHeight = 40;
const NSInteger KVBElementBottomOffset = 40;

@interface KVBFlyightInfoViewController ()

@property(nonatomic, strong) UILabel *fromLabel;
@property(nonatomic, strong) UILabel *toLabel;
@property(nonatomic, strong) UILabel *arrivalDateLabel;
@property(nonatomic, strong) UILabel *backDateLabel;
@property(nonatomic, strong) UIButton *saveButton;
@property(nonatomic, strong) UIImageView *imageView;

@end

@implementation KVBFlyightInfoViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _fromLabel = [UILabel new];
        _fromLabel.numberOfLines = 1;
        _fromLabel.text = @"test test 1";
        
        _toLabel = [UILabel new];
        _toLabel.numberOfLines = 1;
        _toLabel.text = @"test test 2";

        _arrivalDateLabel = [UILabel new];
        _arrivalDateLabel.numberOfLines = 1;
        _arrivalDateLabel.text = @"test test 3";

        _backDateLabel = [UILabel new];
        _backDateLabel.numberOfLines = 1;
        _backDateLabel.text = @"test test 4";
        
        _saveButton = [UIButton new];
        [_saveButton addTarget:self action:@selector(saveButtonAction) forControlEvents:UIControlEventTouchDown];
        [_saveButton setTitle:@"Save flight" forState:UIControlStateNormal];
        _saveButton.backgroundColor = UIColor.redColor;
        [self.view addSubview:_fromLabel];
        [self.view addSubview:_toLabel];
        [self.view addSubview:_arrivalDateLabel];
        [self.view addSubview:_backDateLabel];
        
    }
    return self;
}

- (void)setupConstraints
{
    [_fromLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(KVBElementOffsetInFlyightInfo);
        make.left.equalTo(self.view.mas_left).offset(KVBElementOffsetInFlyightInfo);
        make.right.equalTo(self.view.mas_right).offset(-KVBElementOffsetInFlyightInfo);
    }];
    
    [_toLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fromLabel.mas_top).offset(KVBElementOffsetInFlyightInfo);
        make.left.equalTo(self.view.mas_left).offset(KVBElementOffsetInFlyightInfo);
        make.right.equalTo(self.view.mas_right).offset(-KVBElementOffsetInFlyightInfo);
    }];
    [_arrivalDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(KVBElementOffsetInFlyightInfo);
        make.left.equalTo(self.view.mas_left).offset(KVBElementOffsetInFlyightInfo);
        make.right.equalTo(self.view.mas_right).offset(KVBElementOffsetInFlyightInfo);
    }];
    
    [_saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(KVBElementOffsetInFlyightInfo);
        make.height.mas_equalTo(KVBButtonHeight);
        make.right.equalTo(self.view.mas_right).offset(KVBElementOffsetInFlyightInfo);
        make.bottom.equalTo(self.view.mas_bottom).offset(-KVBElementBottomOffset);
    }];
    
    [_backDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_saveButton.mas_top).offset(-KVBElementOffsetInFlyightInfo);
        make.left.equalTo(self.view.mas_left).offset(KVBElementOffsetInFlyightInfo);
        make.right.equalTo(self.view.mas_right).offset(KVBElementOffsetInFlyightInfo);
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.greenColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}
#pragma mark - UIButton Action
- (void)saveButtonAction
{
    NSLog(@"SaveAction");
}

@end
