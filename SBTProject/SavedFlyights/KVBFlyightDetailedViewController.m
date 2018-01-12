//
//  KVBFlyightInfoViewController.m
//  SBTProject
//
//  Created by Константин Богданов on 30.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBFlyightDetailedViewController.h"
#import "KVBCoreDataServise.h"

@interface KVBFlyightInfoViewController ()

@end

@implementation KVBFlyightDetailedViewController

-(instancetype)initWithFlightModel:(KVBFlyightModel *)flightModel departureCity:(Cities *)departureCity arrivalCity:(Cities *)arrivalCity withCoreDataServise:(KVBCoreDataServise *)coreDataServise
{
   self =  [super initWithFlightModel:flightModel departureCity:departureCity arrivalCity:arrivalCity withCoreDataServise:coreDataServise];
    
    if(self)
    {
        [self.saveButton setTitle:@"Delete flight" forState:UIControlStateNormal];
    }
    return self;
}
-(void)buttonAction
{
    [self.coreDataServise deleteFlight:self.flight];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
