//
//  KVBSavedFlightCollectionCell.h
//  SBTProject
//
//  Created by Константин Богданов on 29.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KVBSavedFlightCollectionCell : UICollectionViewCell

@property(nonatomic, copy) NSString *from;
@property(nonatomic, copy) NSString *to;
@property(nonatomic, copy) NSString *price;
@property(nonatomic, strong) NSDate *departureDate;
@property(nonatomic, strong) NSDate *backDate;
@property(nonatomic, assign) NSInteger classNumber;

- (void)startAnimation;

@end
