//
//  KVBPopalarDirectionCell.h
//  SBTProject
//
//  Created by Константин Богданов on 21.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KVBCoreDataServise;
@interface KVBPopalarDirectionCell : UITableViewCell

- (instancetype)initWithCollection:(NSArray *)popularDirections;

@property(nonatomic, weak) UINavigationController *navController;
@property(nonatomic, weak) KVBCoreDataServise *coreDataServise;
@end
