//
//  KVBPopalarDirectionCell.m
//  SBTProject
//
//  Created by Константин Богданов on 21.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBPopularDirectionCell.h"
#import "KVBCollectionViewFlightCell.h"
#import "KVBFlightInfoViewController.h"
#import "KVBFlyightModel.h"
#import "KVBCoreDataService.h"
#import "Cities+CoreDataClass.h"
#import <Masonry.h>


static NSString *const KVBCollectionViewCustomCell = @"KVBCollectionViewCustomCell";
NSString *const KVBTableWithCollectionCell = @"KVBTableWithCollectionCell";


@interface KVBPopularDirectionCell()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>


@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, copy) NSArray *popularDirections;


@end


@implementation KVBPopularDirectionCell


- (instancetype)initWithCollection:(NSArray*)popularDirections
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KVBTableWithCollectionCell];
    if(self)
    {
        _popularDirections = popularDirections;
        
        UICollectionViewFlowLayout *viewLayout = [[UICollectionViewFlowLayout alloc] init];
        viewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        viewLayout.itemSize = CGSizeMake(250, 150);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:viewLayout];
        _collectionView.backgroundColor = UIColor.whiteColor;
        [_collectionView registerClass:[KVBCollectionViewFlightCell class] forCellWithReuseIdentifier:KVBCollectionViewCustomCell];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = UIColor.clearColor;
        
        self.backgroundColor = UIColor.clearColor;
        
        [self.contentView addSubview:_collectionView];

        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.left.equalTo(self.contentView.mas_left);
            make.height.mas_equalTo(150);
            make.right.equalTo(self.contentView.mas_right);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];

        [super updateConstraints];
        
        [_collectionView reloadData];

    }
    return self;
}

#pragma mark -UICollectionViewDataSource

- (KVBCollectionViewFlightCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
  
    KVBCollectionViewFlightCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KVBCollectionViewCustomCell forIndexPath:indexPath];

    KVBFlyightModel *flight = self.popularDirections[indexPath.row];
    
    Cities *arrivalCity = [self.coreDataServise recieveCityByCityCode:flight.arrivalCode].firstObject;
    Cities *departureCity = [self.coreDataServise recieveCityByCityCode:flight.departureCode].firstObject;
    
    cell.arrivalLabel.text = [NSString stringWithFormat:@"To: %@", arrivalCity.name];
    cell.departureLabel.text = [NSString stringWithFormat:@"From: %@", departureCity.name];
    cell.priceLabel.text = [NSString stringWithFormat:@"%li p.", flight.cost];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.popularDirections.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    KVBFlyightModel *model = self.popularDirections[indexPath.row];
    Cities *departureCity = [self.coreDataServise recieveCityByCityCode:model.departureCode].firstObject;
    Cities *arrivalCity = [self.coreDataServise recieveCityByCityCode:model.arrivalCode].firstObject;
    
    KVBFlightInfoViewController *flightInfoVC = [[KVBFlightInfoViewController alloc] initWithFlightModel:self.popularDirections[indexPath.row] departureCity:departureCity arrivalCity:arrivalCity withCoreDataServise:self.coreDataServise];

    [self.navController pushViewController:flightInfoVC animated:YES];
}


@end
