//
//  KVBTableViewFlightCell.h
//  SBTProject
//
//  Created by Константин Богданов on 22.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KVBTableViewFlightCell : UITableViewCell
@property(nonatomic, strong) UILabel *arrivalLabel;
@property(nonatomic, strong) UILabel *departureLabel;
@property(nonatomic, strong) UIImageView *customImage;
@property(nonatomic, strong) UILabel *priceLabel;
@end
