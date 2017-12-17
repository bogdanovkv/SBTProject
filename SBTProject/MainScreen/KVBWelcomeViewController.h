//
//  ViewController.h
//  SBTProject
//
//  Created by Константин Богданов on 11.12.17.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface KVBWelcomeViewController : UIViewController
@property(nonatomic, weak) NSPersistentContainer *persistentContainer;

@end

