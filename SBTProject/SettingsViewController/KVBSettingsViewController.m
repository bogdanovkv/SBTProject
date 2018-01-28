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
#import "KVBCoreDataService.h"
#import <Masonry.h>

@interface KVBSettingsViewController()<UITableViewDelegate, KVBCustomCellProtocol>


@property(nonatomic, strong) UITableView *tableWithSettings;
@property(nonatomic, strong) KVBSettingTableDataSourse *dataSourse;
@property(nonatomic, strong) KVBCoreDataService *coreDataServise;


@end


@implementation KVBSettingsViewController

- (instancetype)initWithCoreDataServise:(KVBCoreDataService*)coreDataServise
{
    self = [super init];
    if (self)
    {
        _coreDataServise = coreDataServise;
        
        _dataSourse = [KVBSettingTableDataSourse new];
        
        _tableWithSettings = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _tableWithSettings.dataSource = _dataSourse;
        _tableWithSettings.delegate = self;
        _tableWithSettings.estimatedRowHeight = 44;
        _tableWithSettings.rowHeight = UITableViewAutomaticDimension;
        _tableWithSettings.separatorColor = UIColor.clearColor;
        _tableWithSettings.backgroundColor = [UIColor colorWithRed:40 / 255.0 green:73 / 255.0 blue:82 / 255.0 alpha:1.0f];
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:0];
    KVBResetAllSettingsCell *cell = [self.tableWithSettings cellForRowAtIndexPath:indexPath];
    [cell removeDeleteButton];
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    KVBResetAllSettingsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.delegate = self;
    [cell showButton];
}


#pragma mark - DeleteAction

- (void)deleteFromCoreData
{
    [self.coreDataServise deleAllFlights];
}
@end
