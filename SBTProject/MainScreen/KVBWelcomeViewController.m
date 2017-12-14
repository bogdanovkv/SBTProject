//
//  ViewController.m
//  SBTProject
//
//  Created by Константин Богданов on 11.12.17.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBWelcomeViewController.h"
#import "KVBSearchViewController.h"
#import "KVBSavedFlightsViewController.h"
#import "KVBSettingsViewController.h"
#import "KVBRequest.h"
#import <Masonry.h>

const CGFloat KVBLeftRightOffset = 20;

@interface KVBWelcomeViewController ()<NSURLSessionDelegate>

@property(nonatomic, strong) UILabel *welcomeLabel;
@property(nonatomic, strong) UILabel *locationLabel;
@property(nonatomic, strong) UILabel *auestionLabel;
@property(nonatomic, strong) UIButton *changeLocationButton;
@property(nonatomic, strong) UIButton *acceptButton;
@property(nonatomic, strong) NSString *currenLocation;
@property(nonatomic, strong) KVBRequest *request;


@end

@implementation KVBWelcomeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _currenLocation = @"TestLocation";
        
        _request = [KVBRequest new];
        _request.delegate = self;
        
        _changeLocationButton = [UIButton new];
        [_changeLocationButton setTitleColor:UIColor.greenColor forState:UIControlStateNormal];
        [_changeLocationButton setTitle:@"Change" forState:UIControlStateNormal];
        [_changeLocationButton addTarget:self action:@selector(changeLocation) forControlEvents:UIControlEventTouchDown];
        
        _acceptButton = [UIButton new];
        [_acceptButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
        [_acceptButton setTitle:@"Next" forState:UIControlStateNormal];
        [_acceptButton addTarget:self action:@selector(acceptLocation) forControlEvents:UIControlEventTouchDown];
        _acceptButton.backgroundColor = UIColor.clearColor;
        
        _welcomeLabel = [UILabel new];
        _welcomeLabel.backgroundColor = UIColor.clearColor;
        _welcomeLabel.text = @"Hello !\nPlease, choose your location:";
        _welcomeLabel.numberOfLines = 2;
        _welcomeLabel.textAlignment = NSTextAlignmentCenter;
        
        _locationLabel = [UILabel new];
        _locationLabel.backgroundColor = UIColor.clearColor;
        _locationLabel.text = @"Test location";
        _locationLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview:_changeLocationButton];
        [self.view addSubview:_acceptButton];
        [self.view addSubview:_welcomeLabel];
        [self.view addSubview:_locationLabel];
        
        [_acceptButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_locationLabel.mas_bottom).offset(10);
            make.right.equalTo(self.view.mas_right).offset(-KVBLeftRightOffset);
            make.height.equalTo(_changeLocationButton.mas_height);
            make.width.equalTo(_changeLocationButton.mas_width);
            
        }];

        [_changeLocationButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_locationLabel.mas_bottom).offset(10);
            make.left.equalTo(self.view.mas_left).offset(KVBLeftRightOffset);
            make.height.equalTo(@(20));
            make.right.equalTo(_acceptButton.mas_left).offset(KVBLeftRightOffset);
            
        }];
        
        [_welcomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(20);
            make.left.equalTo(self.view.mas_left).offset(KVBLeftRightOffset);
            make.right.equalTo(self.view.mas_right).offset(-KVBLeftRightOffset);
            make.height.equalTo(@(120));
            
        }];
        
        [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_welcomeLabel.mas_bottom).offset(20);
            make.left.equalTo(self.view.mas_left).offset(KVBLeftRightOffset);
            make.right.equalTo(self.view.mas_right).offset(-KVBLeftRightOffset);
            
        }];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.request whereAreMe];

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIButton events
- (void)changeLocation
{
    NSLog(@"Change location");

}

- (void)acceptLocation
{
    UITabBarController *tabBarController = [UITabBarController new];
    
    KVBSearchViewController *searchViewConctroller = [KVBSearchViewController new];
    searchViewConctroller.currentLocation = self.currenLocation;
    searchViewConctroller.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:0];
    
    KVBSavedFlightsViewController *sfvc = [KVBSavedFlightsViewController new];
    sfvc.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:1];
    
    KVBSettingsViewController *settingVC = [KVBSettingsViewController new];
    settingVC.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemHistory tag:2];
    
    tabBarController.viewControllers = @[searchViewConctroller, sfvc, settingVC];
    
    [self presentViewController:tabBarController animated:YES completion:nil];
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    NSDictionary *recievedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSString *countryName = recievedData[@"country_name"];
    NSString *cityName = recievedData[@"name"];
    dispatch_async(dispatch_get_main_queue(), ^{
                self.locationLabel.text = [NSString stringWithFormat:@"%@, %@", countryName, cityName];
    });

}

@end
