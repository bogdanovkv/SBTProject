//
//  ViewController.m
//  SBTProject
//
//  Created by Константин Богданов on 11.12.17.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBWelcomeViewController.h"
#import "KVBSearchViewController.h"
#import "KVBSavedFlightsViewController.h"
#import "KVBSettingsViewController.h"
#import "KVBRequest.h"
#import "Countries+CoreDataClass.h"
#import "Cities+CoreDataClass.h"
#import <CoreData/CoreData.h>
#import <Masonry.h>

const CGFloat KVBLeftRightOffset = 20;
static NSString *const KVBCityIdentifier = @"CitiesCell";


@interface KVBWelcomeViewController ()<NSURLSessionDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property(nonatomic, strong) UILabel *welcomeLabel;
@property(nonatomic, strong) UITextField *locationField;
@property(nonatomic, strong) UILabel *auestionLabel;
@property(nonatomic, strong) UIButton *changeLocationButton;
@property(nonatomic, strong) UIButton *acceptButton;
@property(nonatomic, strong) NSString *currenLocation;
@property(nonatomic, strong) NSString *countryCode;
@property(nonatomic, strong) KVBRequest *request;
@property(nonatomic, strong) UITableView *tableWithCities;
@property(nonatomic, strong) NSArray<Cities*> *countriesNames;
@property(nonatomic, strong) NSArray *names;
@property(nonatomic, strong) NSArray *locationSet;





@end

@implementation KVBWelcomeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _currenLocation = @"Loading your location";
        
        _countryCode = @"RU";
        
        _names = [NSArray array];
        
        _request = [KVBRequest new];
        _request.delegate = self;
        
        _changeLocationButton = [UIButton new];
        [_changeLocationButton setTitleColor:UIColor.greenColor forState:UIControlStateNormal];
        [_changeLocationButton setTitle:@"Change" forState:UIControlStateNormal];
        [_changeLocationButton addTarget:self action:@selector(changeLocation) forControlEvents:UIControlEventTouchDown];
        
        _acceptButton = [UIButton new];
        [_acceptButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
        [_acceptButton setTitle:@"Next" forState:UIControlStateNormal];
        [_acceptButton addTarget:self action:@selector(acceptLocation) forControlEvents:UIControlEventTouchDown];
        _acceptButton.backgroundColor = UIColor.clearColor;
        
        _welcomeLabel = [UILabel new];
        _welcomeLabel.backgroundColor = UIColor.clearColor;
        _welcomeLabel.text = @"Hello !\nPlease, choose your location:";
        _welcomeLabel.numberOfLines = 2;
        _welcomeLabel.textAlignment = NSTextAlignmentCenter;
        
        _locationField = [UITextField new];
        _locationField.backgroundColor = UIColor.clearColor;
        _locationField.text = _currenLocation;
        _locationField.textAlignment = NSTextAlignmentCenter;
        _locationField.delegate = self;
        
        _tableWithCities = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        [_tableWithCities registerClass:[UITableViewCell class] forCellReuseIdentifier: KVBCityIdentifier];
        _tableWithCities.dataSource = self;
        _tableWithCities.delegate = self;
        
        [self.view addSubview:_changeLocationButton];
        [self.view addSubview:_acceptButton];
        [self.view addSubview:_welcomeLabel];
        [self.view addSubview:_locationField];
        [self.view addSubview:_tableWithCities];

        [_acceptButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_locationField.mas_bottom).offset(10);
            make.right.equalTo(self.view.mas_right).offset(-KVBLeftRightOffset);
            make.height.equalTo(_changeLocationButton.mas_height);
            make.width.equalTo(_changeLocationButton.mas_width);
            
        }];

        [_changeLocationButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_locationField.mas_bottom).offset(10);
            make.left.equalTo(self.view.mas_left).offset(KVBLeftRightOffset);
            make.height.equalTo(@(20));
            make.right.equalTo(_acceptButton.mas_left).offset(KVBLeftRightOffset);
            
        }];
        
        [_welcomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(20);
            make.left.equalTo(self.view.mas_left).offset(KVBLeftRightOffset);
            make.right.equalTo(self.view.mas_right).offset(-KVBLeftRightOffset);
            make.height.equalTo(@(120));
            
        }];
        
        [_locationField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_welcomeLabel.mas_bottom).offset(20);
            make.left.equalTo(self.view.mas_left).offset(KVBLeftRightOffset);
            make.right.equalTo(self.view.mas_right).offset(-KVBLeftRightOffset);
            
        }];
        
        [_tableWithCities mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_acceptButton.mas_bottom).offset(20);
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.request whereAreMe];
    
    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"isDataExist"] isEqualToString: @"Exist"])
    {
        [self.request recieveAllContriesWithCities];

    }

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIButton events
- (void)changeLocation
{
    [self.tableWithCities reloadData];
}

- (void)acceptLocation
{
    UITabBarController *tabBarController = [UITabBarController new];
    
    KVBSearchViewController *searchViewConctroller = [KVBSearchViewController new];
    searchViewConctroller.currentLocation = self.currenLocation;
    searchViewConctroller.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:0];
    
    KVBSavedFlightsViewController *sfvc = [KVBSavedFlightsViewController new];
    sfvc.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:1];
    
    KVBSettingsViewController *settingVC = [KVBSettingsViewController new];
    settingVC.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemHistory tag:2];
    
    tabBarController.viewControllers = @[searchViewConctroller, sfvc, settingVC];
    
    [self presentViewController:tabBarController animated:YES completion:nil];
}

#pragma mark -NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    NSDictionary *recievedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    self.request.currentLoacation = recievedData;
    NSString *countryName = recievedData[@"country_name"];
    NSString *cityName = recievedData[@"name"];
    
    dispatch_async(dispatch_get_main_queue(), ^
    {
        self.locationField.text = [NSString stringWithFormat:@"%@, %@", countryName, cityName];
        
    });

}
#pragma mark - UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KVBCityIdentifier forIndexPath:indexPath];
    
    Countries *country = self.names[indexPath.row];
    
    cell.textLabel.text = country.name;
    
    return cell;
    
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSString *entity;
    NSPredicate *predicate = nil;

    if (self.locationSet.count == 1)
    {
        entity = @"Countries";
        predicate = [NSPredicate predicateWithFormat:@"name CONTAINS %@ OR nameRu CONTAINS %@", [self.locationSet[0] capitalizedString] ,[self.locationSet[0] capitalizedString]];
    }
    else
    {
        if(self.locationSet.count == 2)
        {
            entity = @"Cities";
            predicate = [NSPredicate predicateWithFormat:@"countryCode==%@ AND (name CONTAINS %@ OR nameRu CONTAINS %@)", self.countryCode, [self.locationSet[1] capitalizedString], [self.locationSet[1] capitalizedString]];
        }
        
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entity];
    fetchRequest.predicate = predicate;
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    if (predicate != nil)
    {
        self.names = [self.persistentContainer.viewContext executeFetchRequest:fetchRequest error:nil];

    }
    
    return self.names.count;
}

#pragma mark -UITexFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@","];
    NSString *resultstring = [self.locationField.text stringByReplacingCharactersInRange:range withString:string ];
    
    NSArray *citiWithCountry = [resultstring componentsSeparatedByCharactersInSet:set];
    NSMutableOrderedSet *setLocation = [NSMutableOrderedSet new];
    [setLocation addObjectsFromArray:citiWithCountry];
    [setLocation removeObject:@""];
    
    NSMutableArray *mutableArray = [NSMutableArray new];
    
    for(NSString *string in setLocation)
    {
        NSString *cityOrCountry = [self deleteWhiteSpaces:string];
        [mutableArray addObject:cityOrCountry];
    }
    
    self.locationSet = mutableArray;
    
    if (self.locationSet.count == 1)
    {
        [self setupNativeCountryCode];
    }
   
    
    [self.tableWithCities reloadData];
    return YES;
}

- (NSString*)deleteWhiteSpaces: (NSString*) stringWithSpaces
{
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@" "];

    NSArray *stringComponents = [stringWithSpaces componentsSeparatedByCharactersInSet:characterSet];
    NSMutableOrderedSet *set = [NSMutableOrderedSet new];
    [set addObjectsFromArray:stringComponents];
    [set removeObject:@""];
    
    if (set.count == 1)
    {
        return [set firstObject];
    }
    
    if (set.count > 1)
    {
        NSString *result = [NSString new];
        for(NSString *string in set)
        {
            result = [NSString stringWithFormat:@"%@ %@", result,string];
        }
        return result;
    }
        

    
    return @"";
}
- (void) setupNativeCountryCode
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Countries class])];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"name == (%@) OR nameRu == %@",[self.locationSet[0] capitalizedString] ,[self.locationSet[0] capitalizedString]];
    NSArray *nativeCoutry = [self.persistentContainer.viewContext executeFetchRequest:fetchRequest error:nil];
    
    if(nativeCoutry.count != 0)
    {
        Countries *country = nativeCoutry[0];
        self.countryCode = country.codeIATA;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if (self.locationSet.count == 1)
    {
        Countries *country = self.names[indexPath.row];
        self.countryCode = country.codeIATA;
        self.currenLocation = country.name;
        self.locationField.text = [NSString stringWithFormat:@"%@,", [tableView cellForRowAtIndexPath:indexPath].textLabel.text];

    }
    if(self.locationSet.count == 2)
        

    {
        self.locationField.text = [NSString stringWithFormat:@"%@, %@",self.currenLocation, [tableView cellForRowAtIndexPath:indexPath].textLabel.text];
    }
}


@end
