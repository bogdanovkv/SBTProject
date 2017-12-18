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
@property(nonatomic, strong) UIButton *acceptButton;
@property(nonatomic, strong) KVBRequest *request;
@property(nonatomic, strong) UITableView *tableWithCities;
@property(nonatomic, copy) NSArray *names;        //array in table or cities or countries
@property(nonatomic, copy) NSArray *locationSet;  //names of coutry and city
@property(nonatomic, copy) NSString *countryCode; //code of current contry
@property(nonatomic, strong) Cities *city;

@end

@implementation KVBWelcomeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _countryCode = @"RU";
        
        _names = [NSArray array];
        
        _request = [KVBRequest new];
        _request.delegate = self;
        
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
        _locationField.text = @"Loading";
        _locationField.textAlignment = NSTextAlignmentCenter;
        _locationField.delegate = self;
        
        _tableWithCities = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        [_tableWithCities registerClass:[UITableViewCell class] forCellReuseIdentifier: KVBCityIdentifier];
        _tableWithCities.dataSource = self;
        _tableWithCities.delegate = self;
        
        [self.view addSubview:_acceptButton];
        [self.view addSubview:_welcomeLabel];
        [self.view addSubview:_locationField];
        [self.view addSubview:_tableWithCities];

        [_acceptButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_locationField.mas_bottom).offset(10);
            make.right.equalTo(self.view.mas_right).offset(-KVBLeftRightOffset);
            make.left.equalTo(self.view.mas_left).offset(KVBLeftRightOffset);
            make.height.mas_equalTo(40);
            
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
            make.bottom.equalTo(self.view.mas_bottom).offset(-216);
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

- (void)acceptLocation
{
    
    if([self checkNames])
    {
        UITabBarController *tabBarController = [UITabBarController new];
        
        KVBSearchViewController *searchViewConctroller = [KVBSearchViewController new];
        searchViewConctroller.currentLocation = self.city;
        searchViewConctroller.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:0];
        
        KVBSavedFlightsViewController *sfvc = [KVBSavedFlightsViewController new];
        sfvc.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:1];
        
        KVBSettingsViewController *settingVC = [KVBSettingsViewController new];
        settingVC.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemHistory tag:2];
        
        tabBarController.viewControllers = @[searchViewConctroller, sfvc, settingVC];
        
        [self presentViewController:tabBarController animated:YES completion:nil];
    }
    else
    {
        NSArray * pathArray = @[@(self.locationField.center), @(CGPointMake(self.locationField.center.x -15, self.locationField.center.y)),@(CGPointMake(self.locationField.center.x + 15, self.locationField.center.y)), @(self.locationField.center)];
        
        CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        pathAnimation.values = pathArray;
        pathAnimation.duration = 1.0;
        [self.locationField.layer addAnimation:pathAnimation forKey:@"position"];
    }
   
}

- (BOOL) checkNames
{
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@","];
    NSArray *array = [self.locationField.text componentsSeparatedByCharactersInSet:characterSet];
    NSMutableOrderedSet *mutableSet = [NSMutableOrderedSet orderedSetWithArray:array];
    [mutableSet removeObject:@""];
    
    if(mutableSet.count == 2)
    {
        NSString *countryName = [self deleteWhiteSpaces:mutableSet.firstObject];
        NSString *cityName = [self deleteWhiteSpaces:mutableSet.lastObject];
        
        NSArray<Countries*> *country = [self findLocationInEntity:NSStringFromClass([Countries class]) withName:countryName];
        NSArray<Cities*> *city = [self findLocationInEntity:NSStringFromClass([Cities class]) withName:cityName];

        if(country.count == 1 && city.count == 1)
        {
            Cities *nativeCity = city[0];
            NSLog(@"%@", nativeCity.nameRu);
            NSLog(@"%@", nativeCity.parrentCountry.nameRu);

            Countries *nativeCountry = country[0];
            nativeCity.parrentCountry = nativeCity.parrentCountry == nil ? nativeCountry : nativeCity.parrentCountry;
            NSLog(@"%@", nativeCity.parrentCountry.nameRu);

            self.city = nativeCity;
            if ([self.persistentContainer.viewContext hasChanges])
            {
                [self.persistentContainer.viewContext save:nil];
            }
            return YES;
        }
    }
    return NO;

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
        self.locationSet = @[countryName, cityName];
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
    
    if(self.locationSet.count >= 1)
    {
        [self setupNativeCountryCode];
    }
   else
   {
       self.names = nil;
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
- (void)setupNativeCountryCode
{

    NSArray *nativeCoutry = [self findLocationInEntity:NSStringFromClass([Countries class]) withName:[self.locationSet[0] capitalizedString]];
    
    if(nativeCoutry.count != 0)
    {
        Countries *country = nativeCoutry[0];
        self.countryCode = country.codeIATA;
    }
}

- (NSArray*) findLocationInEntity:(NSString*) entity withName:(NSString*) name
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entity];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"name == (%@) OR nameRu == %@",[name capitalizedString] ,[name capitalizedString]];
    return [self.persistentContainer.viewContext executeFetchRequest:fetchRequest error:nil];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if (self.locationSet.count == 1)
    {
        Countries *country = self.names[indexPath.row];
        self.countryCode = country.codeIATA;
        self.locationField.text = [NSString stringWithFormat:@"%@,", [tableView cellForRowAtIndexPath:indexPath].textLabel.text];

    }
    if(self.locationSet.count == 2)
        

    {
        Cities *city = self.names[indexPath.row];
        NSMutableArray *array = [NSMutableArray arrayWithArray:self.locationSet];
        array[1] = city;
        self.locationSet = array;
        self.locationField.text = [NSString stringWithFormat:@"%@, %@",self.locationSet[0], city.name];
    }
}


@end
