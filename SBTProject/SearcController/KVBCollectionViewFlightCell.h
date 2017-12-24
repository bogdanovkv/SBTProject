//
//  KVBCollectionViewFlightCell.h
//  SBTProject
//
//  Created by Константин Богданов on 21.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KVBCollectionViewFlightCell : UICollectionViewCell

@property(nonatomic, strong) UILabel *arrivalLabel;
@property(nonatomic, strong) UILabel *departureLabel;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *priceLabel;

@end
