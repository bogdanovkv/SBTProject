//
//  KVBSavedFlightsViewController.m
//  SBTProject
//
//  Created by Константин Богданов on 14.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBSavedFlightsViewController.h"
#import "KVBFlightsDataSource.h"
#import <Masonry.h>
@interface KVBSavedFlightsViewController ()
@property(nonatomic, strong) UICollectionView *collectionWithFlyights;
@property(nonatomic, strong) KVBFlightsDataSource *dataSourse;
@end

@implementation KVBSavedFlightsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UICollectionViewFlowLayout *viewLayout = [[UICollectionViewFlowLayout alloc] init];
        viewLayout.itemSize = CGSizeMake(200,200);
        viewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _dataSourse = [KVBFlightsDataSource new];
        
        _collectionWithFlyights = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:viewLayout];
        _collectionWithFlyights.backgroundColor = UIColor.whiteColor;
        [_collectionWithFlyights registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
        _collectionWithFlyights.dataSource = _dataSourse;
        
        [self.view addSubview:_collectionWithFlyights];
        
        [_collectionWithFlyights mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
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



@end
