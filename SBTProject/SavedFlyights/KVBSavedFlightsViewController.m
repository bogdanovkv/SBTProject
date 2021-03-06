//
//  KVBSavedFlightsViewController.m
//  SBTProject
//
//  Created by Константин Богданов on 14.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBSavedFlightsViewController.h"
#import "KVBFlightsDataSource.h"
#import "KVBCoreDataService.h"
#import "KVBSavedFlightCollectionCell.h"
#import "KVBFlyightModel.h"
#import "Flyight+CoreDataClass.h"
#import "KVBFlyightDetailedViewController.h"
#import <Masonry.h>


@interface KVBSavedFlightsViewController ()<UICollectionViewDelegate, NSFetchedResultsControllerDelegate>


@property(nonatomic, strong) UICollectionView *collectionWithFlyights;
@property(nonatomic, strong) KVBFlightsDataSource *dataSourse;
@property(nonatomic, strong) KVBCoreDataService* coreDataService;
@property(nonatomic, strong) UIImageView *backImage;
@property(nonatomic, strong) NSFetchedResultsController *fetchController;


@end


@implementation KVBSavedFlightsViewController


- (instancetype)initWithCoreDataService:(KVBCoreDataService*)coreDataServise
{
    self = [super init];
    if (self) {
        
        UICollectionViewFlowLayout *viewLayout = [[UICollectionViewFlowLayout alloc] init];
        viewLayout.itemSize = CGSizeMake(300,300);
        viewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _coreDataService = coreDataServise;
        
        _fetchController = [[NSFetchedResultsController alloc] initWithFetchRequest:[Flyight fetchRequest]
                                                               managedObjectContext:coreDataServise.context
                                                                 sectionNameKeyPath:nil
                                                                          cacheName:nil];
        
        _dataSourse = [[KVBFlightsDataSource alloc]initWithFetchController:_fetchController];
        
        _collectionWithFlyights = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:viewLayout];
        _collectionWithFlyights.backgroundColor = UIColor.whiteColor;
        [_collectionWithFlyights registerClass:[KVBSavedFlightCollectionCell class] forCellWithReuseIdentifier:KVBSavedFlightsCellIdentifier];
        _collectionWithFlyights.dataSource = _dataSourse;
        _collectionWithFlyights.delegate = self;
        
        _collectionWithFlyights.backgroundColor = [UIColor colorWithRed:40 / 255.0 green:73 / 255.0 blue:82 / 255.0 alpha:1.0f];
        
        _fetchController.delegate = self;
        
        [_fetchController performFetch:nil];
        
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];
}


#pragma mark -  NSFetchedResultsControllerDelegate

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(nullable NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(nullable NSIndexPath *)newIndexPath
{
    switch(type) {
        case NSFetchedResultsChangeDelete:
        case NSFetchedResultsChangeInsert:
        {
            [_collectionWithFlyights reloadData];
            break;
        }
        case NSFetchedResultsChangeUpdate:
        case NSFetchedResultsChangeMove:
            break;
    }
}


#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath
{
    Flyight *flight = [self.fetchController objectAtIndexPath:indexPath];

    KVBFlyightModel *flightModel = [[KVBFlyightModel alloc]initWithFlight:flight];
    
    KVBFlyightDetailedViewController *detailedVC = [[KVBFlyightDetailedViewController alloc]initWithFlightModel:flightModel
                                                                                                  departureCity:flight.departure
                                                                                                    arrivalCity:flight.arrival
                                                                                            withCoreDataServise:self.coreDataService];
    detailedVC.flight = flight;
    
    [self.navigationController pushViewController:detailedVC animated:YES];
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    KVBSavedFlightCollectionCell *customCell = (KVBSavedFlightCollectionCell*)cell;
    [customCell startAnimation];
}


@end
