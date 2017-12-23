//
//  KVBPopalarDirectionCell.m
//  SBTProject
//
//  Created by Константин Богданов on 21.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBPopalarDirectionCell.h"
#import "KVBCollectionViewFlightCell.h"
#import "KVBFlyightModel.h"
#import <Masonry.h>
static NSString *const KVBCollectionViewCustomCell = @"KVBCollectionViewCustomCell";

@interface KVBPopalarDirectionCell()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, copy) NSArray *popularDirections;
@end


@implementation KVBPopalarDirectionCell


- (instancetype)initWithCollection:(NSArray *)popularDirections
{
    self = [super init];
    if(self)
    {
        _popularDirections = popularDirections;
        
        UICollectionViewFlowLayout *viewLayout = [[UICollectionViewFlowLayout alloc] init];
        viewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        viewLayout.itemSize = UICollectionViewFlowLayoutAutomaticSize;
        viewLayout.estimatedItemSize = CGSizeMake(100, 100);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:viewLayout];
        _collectionView.backgroundColor = UIColor.whiteColor;
        [_collectionView registerClass:[KVBCollectionViewFlightCell class] forCellWithReuseIdentifier:KVBCollectionViewCustomCell];
        _collectionView.dataSource = self;
        [self.contentView addSubview:_collectionView];

        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.left.equalTo(self.contentView.mas_left);
            make.height.mas_equalTo(180);
            make.right.equalTo(self.contentView.mas_right);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
        [_collectionView reloadData];

        [super updateConstraints];

    }
    return self;
}

#pragma mark -UICollectionViewDataSource

- (KVBCollectionViewFlightCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
  
    KVBCollectionViewFlightCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KVBCollectionViewCustomCell forIndexPath:indexPath];

    KVBFlyightModel *flight = self.popularDirections[indexPath.row];
    
    cell.arrivalLabel.text = flight.arrivalCode;
    cell.departureLabel.text = flight.destinationCode;
    cell.priceLabel.text = [NSString stringWithFormat:@"%li", flight.cost];

    cell.backgroundColor = UIColor.grayColor;
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.popularDirections.count;
}


@end
