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
#import "KVBFlightService.h"
#import "KVBPopularDirectionCell.h"
#import "KVBTableViewFlightCell.h"
#import "KVBCoreDataService.h"
#import "Cities+CoreDataClass.h"
#import "Countries+CoreDataClass.h"
#import "Airpots+CoreDataClass.h"
#import "KVBFlightService.h"
#import "KVBFlyightModel.h"
#import "KVBFlightInfoViewController.h"
#import "KVBHeaderView.h"
#import <Masonry.h>

static NSInteger const KVBSearchButtonSize = 35;

@interface KVBSearchViewController ()<UITableViewDelegate, KVBSearchViewDelegate>


@property(nonatomic, strong) UITableView *tableWithFlights;
@property(nonatomic, strong) Cities *departureCity;
@property(nonatomic, strong) Cities *arrivalCity;
@property(nonatomic, strong) KVBViewWithParametres *searchView;
@property(nonatomic, strong) UIButton *searchButton;
@property(nonatomic, strong) KVBFlightsTableDataSource *dataSourse;
@property(nonatomic, strong) KVBFlightService *flightServise;
@property(nonatomic,getter=isHide, assign) BOOL hide;


@end


@implementation KVBSearchViewController


- (instancetype)initWithDeparture: (Cities*) city withContext: (NSManagedObjectContext*) context
{
    self = [super init];
    if (self)
    {
        _hide = NO;
        
        _departureCity = city;
        
        _flightServise = [KVBFlightService new];
        
        _dataSourse = [KVBFlightsTableDataSource new];
        _dataSourse.coreDataServise = [[KVBCoreDataService alloc]initWithContext:context];
        
        _searchView = [[KVBViewWithParametres alloc]initWithContext:context];
        _searchView.departureField.text = [NSString stringWithFormat:@"%@, %@", city.parrentCountry.codeIATA, city.name];
        _searchView.backgroundColor = UIColor.whiteColor;
        _searchView.delegate = self;
        
        _searchButton = [UIButton new];
        _searchButton.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:199 / 255.0 blue:156 / 255.0 alpha:1.0f];
        [_searchButton setTitle:@"Search" forState:UIControlStateNormal];
        [_searchButton addTarget:self action:@selector(startSearch) forControlEvents:UIControlEventTouchDown];
        _searchButton.layer.cornerRadius = 7.5;
        
        _tableWithFlights = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _tableWithFlights.delegate = self;
        [_tableWithFlights registerClass:[KVBTableViewFlightCell class] forCellReuseIdentifier:KVBCustomFlightCellIdentifier];
        [_tableWithFlights registerClass:[KVBPopularDirectionCell class] forCellReuseIdentifier:@"Cell"];
        [_tableWithFlights registerClass:[KVBHeaderView class] forHeaderFooterViewReuseIdentifier:KVBHeaderIdentifier];
        _tableWithFlights.dataSource = _dataSourse;
        _tableWithFlights.estimatedRowHeight = 44.0;
        _tableWithFlights.rowHeight = UITableViewAutomaticDimension;
        _tableWithFlights.backgroundColor = [UIColor colorWithRed:40 / 255.0 green:73 / 255.0 blue:82 / 255.0 alpha:1.0f];
        _tableWithFlights.separatorColor = UIColor.clearColor;
        
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
            make.height.mas_equalTo(KVBSearchButtonSize);
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


#pragma mark - Buttons

- (void) startSearch
{
    self.dataSourse.departureCity = self.departureCity;
    self.dataSourse.arrivalCity = self.arrivalCity;
    
    [self.flightServise recieveCheapTicketsFromCity:self.departureCity departureDate:self.searchView.depatrtureDate toCity:self.arrivalCity arrivalDate:self.searchView.arrivalDate withCompletitionHandler:^(NSData *data, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error)
            {
                [self updateTableView:self.tableWithFlights WithNewArray:nil inSection:1];
                return ;
            }
            NSDictionary *recievedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

            NSDictionary *cheap = recievedData[@"data"];
            
            [self updateTableView:self.tableWithFlights WithNewArray:[KVBFlyightModel arrayFromDictionariesWithClassType:cheap] inSection:1];
        });
    }];
    [self hideSearchButton];
}

- (void)updatePopularDirectionsFromCity
{
    [self.flightServise recievePopularDirectionFRomCity:self.departureCity onPage:0 withCompletitionHandler:^(NSData *data, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(error)
            {
                [self.dataSourse noPopularDirections];
                [self.tableWithFlights reloadData];
                return ;
            }
            
            NSDictionary *recievedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            self.dataSourse.popularDirections = [KVBFlyightModel arrayFromDictionaries:recievedData[@"data"]];
            self.dataSourse.cell = [[KVBPopularDirectionCell alloc] initWithCollection:self.dataSourse.popularDirections];
            self.dataSourse.cell.navController = self.navigationController;
            self.dataSourse.cell.coreDataServise = self.dataSourse.coreDataServise;
    
            [self.tableWithFlights reloadData];
        });
    }];
}


#pragma mark - KVBSearchViewDelegate

- (void)arrivalCityChangedWithCity:(Cities *)city
{
    self.arrivalCity = city;
    [self showSearchButton];
}

- (void)arrivalDateChangedWithDate:(NSDate *)date
{
    [self showSearchButton];
}

- (void)departureCityChangedWithCity:(Cities *)city
{
    self.departureCity = city;
    [self updatePopularDirectionsFromCity];
    [self showSearchButton];
}

- (void)departureDateChangedWithDate:(NSDate *)date
{
    [self showSearchButton];
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!indexPath.section)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    if(![[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:[KVBTableViewFlightCell class]])
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    
    KVBFlightInfoViewController *flightInfoVC = [[KVBFlightInfoViewController alloc] initWithFlightModel:self.dataSourse.cheapTickets[indexPath.row] departureCity:self.departureCity arrivalCity:self.arrivalCity withCoreDataServise:self.dataSourse.coreDataServise];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController pushViewController:flightInfoVC animated:YES];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    KVBHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:KVBHeaderIdentifier];
    if(!section)
    {
        headerView.sectionNameLabel.text = @"Popular directions";
    }
    else
    {
        headerView.sectionNameLabel.text = @"Tickets";
    }
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 24.0;
}


#pragma mark - Animations

- (void)showSearchButton
{
    if (!self.isHide){
        return;
    }
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:1 animations:^{
        [self.searchButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(KVBSearchButtonSize);
        }];
        [self.searchButton setTitle:@"Search" forState:UIControlStateNormal];
        [self.view layoutIfNeeded];
    }];
    self.hide = NO;
}

- (void)hideSearchButton
{
    if(self.isHide)
    {
        return;
    }
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:1 animations:^{
        [self.searchButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        [self.searchButton setTitle:nil forState:UIControlStateNormal];
        [self.view layoutIfNeeded];
    }];
    self.hide = YES;
}


#pragma mark - UITableView animations

- (void)updateTableView:(UITableView*)tableView WithNewArray:(NSArray*)newArray inSection:(NSInteger)section
{
    NSMutableArray *oldIndexPathes = [NSMutableArray array];
    NSMutableArray *newIndexPathes = [NSMutableArray array];
    
    if(!newArray.count)
    {
        newArray = [self.dataSourse noChepTickets];
    }
    
    for (int i = 0; i<self.dataSourse.cheapTickets.count; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
        [oldIndexPathes addObject:indexPath];
    }
    for (int i = 0; i<newArray.count; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
        [newIndexPathes addObject:indexPath];
    }

    [tableView performBatchUpdates:^{
        [tableView deleteRowsAtIndexPaths:oldIndexPathes withRowAnimation:UITableViewRowAnimationLeft];
        self.dataSourse.cheapTickets = nil;
    } completion:^(BOOL finished) {
        [tableView performBatchUpdates:^{
            [tableView insertRowsAtIndexPaths:newIndexPathes withRowAnimation:UITableViewRowAnimationLeft];
            self.dataSourse.cheapTickets = newArray;
        } completion:nil];
    }];
}

@end
