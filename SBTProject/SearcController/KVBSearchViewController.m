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
#import <Masonry.h>

@interface KVBSearchViewController ()<UITableViewDelegate>

@property(nonatomic, strong) KVBViewWithParametres *searchView;
@property(nonatomic, strong) UIButton *searchButton;
@property(nonatomic, strong) UITableView *tableWithFlights;
@property(nonatomic, strong) KVBFlightsTableDataSource *dataSourse;
@end

@implementation KVBSearchViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _searchView = [KVBViewWithParametres new];
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

-(void) startSearch
{
    NSLog(@"Start search");
    

}


@end
