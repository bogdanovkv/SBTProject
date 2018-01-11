//
//  KVBPersistentContainer.h
//  SBTProject
//
//  Created by Константин Богданов on 11.01.2018.
//  Copyright © 2018 Константин Богданов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface KVBPersistentContainer : NSObject


@property (readonly, strong) NSPersistentContainer *persistentContainer;


@end
