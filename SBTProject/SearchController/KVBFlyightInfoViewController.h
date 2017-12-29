//
//  KVBFlyightInfoViewController.h
//  SBTProject
//
//  Created by Константин Богданов on 27.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KVBCoreDataServise;
@class KVBFlyightModel;
@class Cities;

@interface KVBFlyightInfoViewController : UIViewController

- (instancetype)initWithFlightModel:(KVBFlyightModel*)flightModel departureCity:(Cities*)departureCity arrivalCity:(Cities*)arrivalCity         withCoreDataServise: (KVBCoreDataServise*) coreDataServise;

@end
