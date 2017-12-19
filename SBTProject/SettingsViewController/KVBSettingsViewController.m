//
//  KVBSettingsViewController.m
//  SBTProject
//
//  Created by Константин Богданов on 14.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBSettingsViewController.h"
#import <Masonry.h>

@interface KVBSettingsViewController ()
@property(nonatomic, strong) UITableView *tableWithSettings;

@end

@implementation KVBSettingsViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _tableWithSettings = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        [_tableWithSettings registerClass:[UITableViewCell class]  forCellReuseIdentifier:@"Cell"];
        
        [self.view addSubview:_tableWithSettings];
        
        [_tableWithSettings mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
    }
    
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

@end
