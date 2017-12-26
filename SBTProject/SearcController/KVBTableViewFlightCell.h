//
//  KVBTableViewFlightCell.h
//  SBTProject
//
//  Created by Константин Богданов on 22.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KVBTableViewFlightCell : UITableViewCell

@property(nonatomic, strong) NSString *arrival;
@property(nonatomic, strong) NSString *departure;
@property(nonatomic, strong) UIImageView *customImage;
@property(nonatomic, strong) NSString *price;
@property(nonatomic, strong) NSDate *departureDate;
@property(nonatomic, strong) NSDate *arrivalDate;

@end
