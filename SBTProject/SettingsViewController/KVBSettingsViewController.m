//
//  KVBSettingsViewController.m
//  SBTProject
//
//  Created by Константин Богданов on 14.12.2017.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBSettingsViewController.h"
#import "KVBSettingTableDataSourse.h"
#import "KVBResetAllSettingsCell.h"
#import "KVBLanguageSettingsCell.h"

#import <Masonry.h>

@interface KVBSettingsViewController ()
@property(nonatomic, strong) UITableView *tableWithSettings;
@property(nonatomic, strong) KVBSettingTableDataSourse *dataSourse;

@end

@implementation KVBSettingsViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _dataSourse = [KVBSettingTableDataSourse new];
        
        _tableWithSettings = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _tableWithSettings.dataSource = _dataSourse;
        [_tableWithSettings registerClass:[KVBLanguageSettingsCell class]  forCellReuseIdentifier:KVBLanguageSettingCell];
        [_tableWithSettings registerClass:[KVBResetAllSettingsCell class]  forCellReuseIdentifier:KVBResetTableViewCell];
        
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
