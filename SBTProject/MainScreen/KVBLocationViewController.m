//
//  KVBLocationViewController.m
//  
//
//  Created by Константин Богданов on 23.12.2017.
//

#import "KVBLocationViewController.h"

#import "KVBSearchViewController.h"
#import "KVBSavedFlightsViewController.h"
#import "KVBSettingsViewController.h"
#import "KVBRequest.h"
#import "Countries+CoreDataClass.h"
#import "Cities+CoreDataClass.h"
#import <CoreData/CoreData.h>
#import "KVBCoreDataServise.h"
#import <Masonry.h>

const CGFloat KVBLeftRightOffset = 20;
static NSString *const KVBCityIdentifier = @"CitiesCell";

@interface KVBLocationViewController ()<NSURLSessionDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property(nonatomic, strong) UILabel *welcomeLabel;
@property(nonatomic, strong) UITextField *cityField;
@property(nonatomic, strong) UITextField *countryField;
@property(nonatomic, copy) NSArray *countriesArray;
@property(nonatomic, strong) UIButton *acceptButton;
@property(nonatomic, strong) UITableView *tableWithCities;
@property(nonatomic, weak) NSManagedObjectContext *context;
@property(nonatomic, strong) KVBRequest *request;
@property(nonatomic, strong) Cities *city;
@property(nonatomic, strong) Countries *country;
@property(nonatomic, strong) KVBCoreDataServise *coreDataService;


@end

@implementation KVBLocationViewController

- (instancetype)initWithContext:(NSManagedObjectContext*) context
{
    self = [super init];
    if (self)
    {
        
        _request = [KVBRequest new];
        _request.delegate = self;
        
        _context = context;
        
        _coreDataService = [[KVBCoreDataServise alloc] initWithContext:context];
        
        _acceptButton = [UIButton new];
        [_acceptButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_acceptButton setTitle:@"Next" forState:UIControlStateNormal];
        [_acceptButton addTarget:self action:@selector(acceptLocation) forControlEvents:UIControlEventTouchDown];
        _acceptButton.backgroundColor = UIColor.grayColor;
        _acceptButton.layer.cornerRadius = 15;
        
        _welcomeLabel = [UILabel new];
        _welcomeLabel.backgroundColor = UIColor.clearColor;
        _welcomeLabel.text = @"Hello !\nPlease, choose your location:";
        _welcomeLabel.numberOfLines = 0;
        _welcomeLabel.textAlignment = NSTextAlignmentCenter;
        
        _tableWithCities = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 400) style:UITableViewStyleGrouped];
        [_tableWithCities registerClass:[UITableViewCell class] forCellReuseIdentifier: KVBCityIdentifier];
        _tableWithCities.dataSource = self;
        _tableWithCities.delegate = self;
        
        _cityField = [UITextField new];
        _cityField.backgroundColor = UIColor.clearColor;
        _cityField.text = @"Loading";
        _cityField.placeholder = @"City";
        _cityField.textAlignment = NSTextAlignmentCenter;
        _cityField.delegate = self;
        _cityField.inputView = _tableWithCities;
        _cityField.borderStyle = UITextBorderStyleRoundedRect;
        _cityField.clearsOnBeginEditing = YES;
        
        _countryField = [UITextField new];
        _countryField.backgroundColor = UIColor.clearColor;
        _countryField.text = @"Loading";
        _countryField.placeholder = @"Country";
        _countryField.textAlignment = NSTextAlignmentCenter;
        _countryField.delegate = self;
        _countryField.inputView = _tableWithCities;
        _countryField.borderStyle = UITextBorderStyleRoundedRect;
        _countryField.clearsOnBeginEditing = YES;

        [self.view addSubview:_acceptButton];
        [self.view addSubview:_welcomeLabel];
        [self.view addSubview:_cityField];
        [self.view addSubview:_countryField];
        
        [self setupConstraints];
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
}

- (void) setupConstraints
{
    [self.acceptButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cityField.mas_bottom).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-KVBLeftRightOffset);
        make.left.equalTo(self.view.mas_left).offset(KVBLeftRightOffset);
        make.height.mas_equalTo(40);
        
    }];
    
    [self.welcomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(20);
        make.left.equalTo(self.view.mas_left).offset(KVBLeftRightOffset);
        make.right.equalTo(self.view.mas_right).offset(-KVBLeftRightOffset);
        make.height.equalTo(@(120));
        
    }];
    
    [self.cityField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_welcomeLabel.mas_bottom).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-KVBLeftRightOffset);
        make.width.equalTo(_countryField.mas_width);
        
    }];
    
    [self.countryField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_welcomeLabel.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(KVBLeftRightOffset);
        make.right.equalTo(_cityField.mas_left).offset(-KVBLeftRightOffset);
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UIButton events

- (void)acceptLocation
{
    if (self.country != nil && self.city != nil)
    {

        UITabBarController *tabBarController = [UITabBarController new];
        
        KVBSearchViewController *searchViewConctroller = [[KVBSearchViewController alloc] initWithDeparture:self.city withContext:self.context];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:searchViewConctroller];
        navController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:0];
        
        KVBSavedFlightsViewController *sfvc = [[KVBSavedFlightsViewController alloc] initWithCoreDataService:self.coreDataService];
        UINavigationController *navControllerForSaved = [[UINavigationController alloc] initWithRootViewController:sfvc];
        navControllerForSaved.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:1];
        
        KVBSettingsViewController *settingVC = [KVBSettingsViewController new];
        settingVC.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemHistory tag:2];
        
        tabBarController.viewControllers = @[navController, navControllerForSaved, settingVC];

        [self presentViewController:tabBarController animated:YES completion:nil];
    }
    else
    {
        NSArray * pathArray = @[@(self.acceptButton.center), @(CGPointMake(self.acceptButton.center.x -15, self.acceptButton.center.y)),@(CGPointMake(self.acceptButton.center.x + 15, self.acceptButton.center.y)), @(self.acceptButton.center)];
        
        CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        pathAnimation.values = pathArray;
        pathAnimation.duration = 1.0;
        [self.acceptButton.layer addAnimation:pathAnimation forKey:@"position"];
    }
}


#pragma mark -NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error
{
    if(error)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
                           self.welcomeLabel.text = [NSString stringWithFormat:@"%@ Please write your location.", error.localizedDescription];
                           self.cityField.text = nil;
                       });
    }
    
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    
    NSDictionary *recievedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    self.request.currentLoacation = recievedData;
    NSString *countryName = recievedData[@"country_name"];
    NSString *cityName = recievedData[@"name"];
    
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       NSArray *countryArray = [self.coreDataService findLocationInEntity:NSStringFromClass([Countries class]) withName:countryName];
                       self.country= countryArray.firstObject;
                       
                       NSArray *cityArray = [self.coreDataService recieveCityByName:cityName inCountry:self.country];
                       self.city = cityArray.firstObject;
                       
                       self.countryField.text = self.country.name;
                       self.cityField.text = self.city.name;
                       
                   });
    
}


#pragma mark - UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KVBCityIdentifier forIndexPath:indexPath];
    
    Countries *country = self.countriesArray[indexPath.row];
    
    cell.textLabel.text = country.name;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.countriesArray.count;
}


#pragma mark -UITexFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([textField isEqual:self.countryField])
    {
        self.country = nil;
        self.countriesArray = [self.coreDataService recieveCountries];
        [self.tableWithCities reloadData];
    }
    if([textField isEqual:self.cityField])
    {
        self.city = nil;
        self.countriesArray = [self.coreDataService recieveCitiesFromCountry:self.country];
        [self.tableWithCities reloadData];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
        return NO;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.cityField isFirstResponder])
    {
        Cities* city = self.countriesArray[indexPath.row];
        self.cityField.text = city.name;
        self.city = city;
        
        [self.cityField resignFirstResponder];
    }
    if ([self.countryField isFirstResponder])
    {
        Countries* country = self.countriesArray[indexPath.row];
        self.countryField.text = country.name;
        self.country = country;
        
        [self.cityField becomeFirstResponder];
    }
}

@end
