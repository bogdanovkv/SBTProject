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
#import "KVBPopalarDirectionCell.h"
#import "KVBTableViewFlightCell.h"
#import "KVBCoreDataServise.h"
#import "Cities+CoreDataClass.h"
#import "Countries+CoreDataClass.h"
#import "Airpots+CoreDataClass.h"
#import "KVBFlyightsRequests.h"
#import "KVBFlyightModel.h"
#import "KVBFlyightInfoViewController.h"
#import <Masonry.h>

@interface KVBSearchViewController ()<UITableViewDelegate, NSURLSessionDataDelegate, NSURLSessionDelegate, KVBSearchViewDelegate>
@property(nonatomic, strong) UITableView *tableWithFlights;
@property(nonatomic, strong) Cities *departureCity;
@property(nonatomic, strong) Cities *arrivalCity;
@property(nonatomic, strong) KVBViewWithParametres *searchView;
@property(nonatomic, strong) UIButton *searchButton;
@property(nonatomic, strong) KVBFlightsTableDataSource *dataSourse;
@property(nonatomic,strong) KVBFlyightsRequests *request;


@end

@implementation KVBSearchViewController

- (instancetype)initWithDeparture: (Cities*) city withContext: (NSManagedObjectContext*) context
{
    self = [super init];
    if (self)
    {
        _departureCity = city;
        
        _request = [KVBFlyightsRequests new];
        _request.user = self;
        
        _searchView = [[KVBViewWithParametres alloc]initWithContext:context];
        _searchView.departureField.text = [NSString stringWithFormat:@"%@, %@", city.parrentCountry.codeIATA, city.name];
        _searchView.backgroundColor = UIColor.whiteColor;
        _searchView.delegate = self;
        
        _searchButton = [UIButton new];
        _searchButton.backgroundColor = UIColor.blueColor;
        [_searchButton setTitle:@"Search" forState:UIControlStateNormal];
        [_searchButton addTarget:self action:@selector(startSearch) forControlEvents:UIControlEventTouchDown];
        _searchButton.layer.cornerRadius = 7.5;
        
        _tableWithFlights = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _tableWithFlights.delegate = self;
        [_tableWithFlights registerClass:[KVBTableViewFlightCell class] forCellReuseIdentifier:KVBCustomFlightCellIdentifier];
        [_tableWithFlights registerClass:[KVBPopalarDirectionCell class] forCellReuseIdentifier:@"Cell"];
        _dataSourse = [KVBFlightsTableDataSource new];
        _dataSourse.coreDataServise = [[KVBCoreDataServise alloc]initWithContext:context];
        _tableWithFlights.dataSource = _dataSourse;
        _tableWithFlights.estimatedRowHeight = 44.0;
        _tableWithFlights.rowHeight = UITableViewAutomaticDimension;
        
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
    [self updatePopularDirectionsFromCity];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark -Buttons

- (void) startSearch
{
#pragma mark -LayoutIfNeeded is needed?
    self.dataSourse.departureCity = self.departureCity;
    self.dataSourse.arrivalCity = self.arrivalCity;
    
    [self.request recieveCheapTicketsFromCity:self.departureCity departmentDate:nil toCity:self.arrivalCity arrivalDate:nil withCompletitionHandler:^(NSData *data, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *recievedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

            NSDictionary *cheap = recievedData[@"data"];
            self.dataSourse.cheapTickets = [KVBFlyightModel arrayFromDictionariesWithjClassType:cheap];
            [self.tableWithFlights reloadData];
        });
    }];
//    [self.view layoutIfNeeded];
//    [UIView animateWithDuration:1 animations:^{
//        [self.searchButton mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@(0));
//        }];
//        [self.searchButton setTitle:nil forState:UIControlStateNormal];
//        [self.view layoutIfNeeded];
//    }];
}

- (void)updatePopularDirectionsFromCity
{
    [self.request recievePopularDirectionFRomCity:self.departureCity onPage:0 withCompletitionHandler:^(NSData *data, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSDictionary *recievedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            self.dataSourse.popularDirections = [KVBFlyightModel arrayFromDictionaries:recievedData[@"data"]];
            self.dataSourse.cell = [[KVBPopalarDirectionCell alloc] initWithCollection:self.dataSourse.popularDirections];
            [self.tableWithFlights reloadData];
        });
    }];
}


#pragma mark - KVBSearchViewDelegate

- (void)arrivalCityChangedWithCity:(Cities *)city
{
   self.arrivalCity = city;
}

- (void)arrivalDateChangedWithDate:(NSDate *)date
{
    
}

- (void)departureCityChangedWithCity:(Cities *)city
{
    self.departureCity = city;
    [self updatePopularDirectionsFromCity];
}

- (void)departureDateChangedWithDate:(NSDate *)date
{
    
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KVBFlyightInfoViewController *flightInfoVC = [KVBFlyightInfoViewController new];
    
    [self.navigationController pushViewController:flightInfoVC animated:YES];
}

@end
