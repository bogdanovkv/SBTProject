//
//  KVBSearchViewController.m
//  SBTProject
//
//  Created by Константин Богданов on 13.12.17.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBSearchViewController.h"
#import "KVBViewWithParametres.h"
#import "KVBFlightsTableDataSource.h"
#import "KVBFlyightsRequests.h"
#import "Cities+CoreDataClass.h"
#import "Countries+CoreDataClass.h"
#import "Airpots+CoreDataClass.h"
#import "KVBFlyightsRequests.h"
#import "KVBFlyightModel.h"
#import <Masonry.h>

@interface KVBSearchViewController ()<UITableViewDelegate, NSURLSessionDataDelegate, NSURLSessionDelegate>
@property(nonatomic, strong) UITableView *tableWithFlights;
@property(nonatomic, strong) Cities *currentLocation;
@property(nonatomic, strong) KVBViewWithParametres *searchView;
@property(nonatomic, strong) UIButton *searchButton;
@property(nonatomic, strong) KVBFlightsTableDataSource *dataSourse;
@property(nonatomic,strong) KVBFlyightsRequests *request;


@end

@implementation KVBSearchViewController

- (instancetype)initWithDeparture: (Cities*) city
{
    self = [super init];
    if (self) {
        
        _currentLocation = city;
        
        _request = [KVBFlyightsRequests new];
        _request.user = self;
        
        _searchView = [KVBViewWithParametres new];
        _searchView.departureLabel.text = [NSString stringWithFormat:@"%@, %@", city.name, city.parrentCountry.name];
        _searchView.backgroundColor = UIColor.whiteColor;
        
        _searchButton = [UIButton new];
        _searchButton.backgroundColor = UIColor.blueColor;
        [_searchButton setTitle:@"Search" forState:UIControlStateNormal];
        [_searchButton addTarget:self action:@selector(startSearch) forControlEvents:UIControlEventTouchDown];
        _searchButton.layer.cornerRadius = 7.5;
        
        _tableWithFlights = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _tableWithFlights.delegate = self;
        [_tableWithFlights registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        _dataSourse = [KVBFlightsTableDataSource new];
        _tableWithFlights.dataSource = _dataSourse;
        
        [self.view addSubview:_searchView];
        [self.view addSubview:_searchButton];
        [self.view addSubview:_tableWithFlights];
        
        [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top);
            make.right.equalTo(self.view.mas_right);
            make.left.equalTo(self.view.mas_left);
        }];
        
        [_searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_searchView.mas_bottom);
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.height.equalTo(@(30));
                                
        }];
        
        [_tableWithFlights mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_searchButton.mas_bottom);
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
            
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Buttons

- (void) startSearch
{
#pragma mark -LayoutIfNeeded is needed?
    
    [self.request recievePopularDirectionFRomCity:self.currentLocation onPage:0];

    [self.view layoutIfNeeded];
    [UIView animateWithDuration:1 animations:^{
        [self.searchButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(0));
        }];
        [self.view layoutIfNeeded];
    }];
   

}

#pragma mark -NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error
{
    
}

#pragma mark -NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    NSDictionary *recievedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    

    dispatch_async(dispatch_get_main_queue(), ^{
        self.dataSourse.popularDirections = [KVBFlyightModel arrayFromDictionaries:recievedData[@"data"]];
        
        [self.tableWithFlights reloadData];
    });
    
}


#pragma mark -Animations



@end
