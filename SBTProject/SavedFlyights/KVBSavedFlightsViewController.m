//
//  KVBSavedFlightsViewController.m
//  SBTProject
//
//  Created by Константин Богданов on 14.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBSavedFlightsViewController.h"
#import "KVBFlightsDataSource.h"
#import "KVBCoreDataServise.h"
#import "KVBSavedFlightCollectionCell.h"
#import <Masonry.h>

@interface KVBSavedFlightsViewController ()<UICollectionViewDelegate>

@property(nonatomic, strong) UICollectionView *collectionWithFlyights;
@property(nonatomic, strong) KVBFlightsDataSource *dataSourse;
@property(nonatomic, strong) KVBCoreDataServise* coreDataService;
@property(nonatomic, strong) UIImageView *backImage;

@end

@implementation KVBSavedFlightsViewController

- (instancetype)initWithCoreDataService:(KVBCoreDataServise*)coreDataServise
{
    self = [super init];
    if (self) {
        
        UICollectionViewFlowLayout *viewLayout = [[UICollectionViewFlowLayout alloc] init];
        viewLayout.itemSize = CGSizeMake(300,300);
        viewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _dataSourse = [KVBFlightsDataSource new];
        
        _collectionWithFlyights = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:viewLayout];
        _collectionWithFlyights.backgroundColor = UIColor.whiteColor;
        [_collectionWithFlyights registerClass:[KVBSavedFlightCollectionCell class] forCellWithReuseIdentifier:@"Cell"];
        _collectionWithFlyights.dataSource = _dataSourse;
        _collectionWithFlyights.delegate = self;
        
        _backImage = [UIImageView new];
        _backImage.image = [UIImage imageNamed:@"asphalt"];
        _collectionWithFlyights.backgroundView = _backImage;

        [self.view addSubview:_collectionWithFlyights];

        [self setupConstraints];
}
    return self;
}

- (void)setupConstraints
{
    [_backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);

    }];

    [_collectionWithFlyights mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.redColor;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    KVBSavedFlightCollectionCell *customCell = (KVBSavedFlightCollectionCell*)cell;
    [customCell startAnimation];
}


@end
