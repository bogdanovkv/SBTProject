//
//  KVBSavedFlightsViewController.h
//  SBTProject
//
//  Created by Константин Богданов on 14.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KVBCoreDataServise;
@interface KVBSavedFlightsViewController : UIViewController

- (instancetype)initWithCoreDataService:(KVBCoreDataServise*)coreDataServise;

@end
