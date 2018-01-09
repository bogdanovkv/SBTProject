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
@property(nonatomic, copy) NSString *back;
@property(nonatomic, strong) NSDate *departureDate;
@property(nonatomic, strong) NSDate *backDate;
@property(nonatomic, assign) NSInteger classNumber;
@property(nonatomic, assign) NSInteger price;

- (void)startAnimation;

@end
