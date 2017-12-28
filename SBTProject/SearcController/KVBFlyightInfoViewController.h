//
//  KVBFlyightInfoViewController.h
//  SBTProject
//
//  Created by Константин Богданов on 27.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KVBFlyightModel;
@class Cities;

@interface KVBFlyightInfoViewController : UIViewController

@property(nonatomic, strong) KVBFlyightModel *flightModel;
@property(nonatomic, strong) Cities *departureCity;
@property(nonatomic, strong) Cities *arrivalCity;

@end
