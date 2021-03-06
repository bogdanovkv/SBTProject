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
#import "KVBLocationServiсe.h"
#import "Countries+CoreDataClass.h"
#import "Cities+CoreDataClass.h"
#import <CoreData/CoreData.h>
#import "KVBCoreDataService.h"
#import "KVBLocationsTableViewCell.h"
#import <Masonry.h>

static CGFloat const KVBLeftRightOffset = 20;
static NSString * const KVBLocationCellReuseIdentifier = @"KVBLocationCellReuseIdentifier";
static NSString * const KVBWelcomeLableDefaultText = @"Hello !\nPlease, choose your location:";


@interface KVBLocationViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>


@property(nonatomic, strong) UILabel *welcomeLabel;
@property(nonatomic, strong) UITextField *cityField;
@property(nonatomic, strong) UITextField *countryField;
@property(nonatomic, copy) NSArray *countriesArray;
@property(nonatomic, strong) UIButton *acceptButton;
@property(nonatomic, strong) UITableView *tableWithCities;
@property(nonatomic, weak) NSManagedObjectContext *context;
@property(nonatomic, strong) KVBLocationServiсe *servise;
@property(nonatomic, strong) Cities *city;
@property(nonatomic, strong) Countries *country;
@property(nonatomic, strong) KVBCoreDataService *coreDataService;


@end


@implementation KVBLocationViewController


- (instancetype)initWithContext:(NSManagedObjectContext*) context
{
    self = [super init];
    if (self)
    {
        
        _servise = [[KVBLocationServiсe alloc]initWithContex:context];
        
        _context = context;
        
        _coreDataService = [[KVBCoreDataService alloc] initWithContext:context];
        
        _acceptButton = [UIButton new];
        [_acceptButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_acceptButton setTitle:@"Next" forState:UIControlStateNormal];
        [_acceptButton addTarget:self action:@selector(acceptLocation) forControlEvents:UIControlEventTouchDown];
        _acceptButton.backgroundColor = UIColor.grayColor;
        _acceptButton.layer.cornerRadius = 15;
        
        _welcomeLabel = [UILabel new];
        _welcomeLabel.backgroundColor = UIColor.clearColor;
        _welcomeLabel.text = KVBWelcomeLableDefaultText;
        _welcomeLabel.numberOfLines = 0;
        _welcomeLabel.textAlignment = NSTextAlignmentCenter;
        
        _tableWithCities = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 400) style:UITableViewStyleGrouped];
        [_tableWithCities registerClass:[KVBLocationsTableViewCell class] forCellReuseIdentifier: KVBLocationCellReuseIdentifier];
        _tableWithCities.dataSource = self;
        _tableWithCities.delegate = self;

        _cityField = [UITextField new];
        _cityField.backgroundColor = UIColor.clearColor;
        _cityField.placeholder = @"City";
        _cityField.textAlignment = NSTextAlignmentCenter;
        _cityField.delegate = self;
        _cityField.inputView = _tableWithCities;
        _cityField.borderStyle = UITextBorderStyleRoundedRect;
        _cityField.clearsOnBeginEditing = YES;
        
        _countryField = [UITextField new];
        _countryField.backgroundColor = UIColor.clearColor;
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
    
    self.welcomeLabel.text = @"Please wait";
    [self updateLocation];
    
    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"Cities"] isEqualToString: @"Exist"])
    {
        [self.servise recieveAllCities:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSData *data = [NSData dataWithContentsOfURL:location];
            NSArray* reciever = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            [self.coreDataService insertCitiesInCoreDataFromDictionary:reciever];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateLocation];
            });

        }];
    }
    
    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"Countries"] isEqualToString: @"Exist"])
    {
        [self.servise recieveAllContries:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSData *data = [NSData dataWithContentsOfURL:location];
            NSArray* reciever = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            [self.coreDataService insertCountriesInCoreDataFromDictionary:reciever];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateLocation];
            });
            
        }];
    }

}


#pragma mark - Constraints

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


#pragma mark - UIButton events

- (void)acceptLocation
{
    if (self.country != nil && self.city != nil)
    {

        UITabBarController *tabBarController = [UITabBarController new];
        
        KVBSearchViewController *searchViewConctroller = [[KVBSearchViewController alloc] initWithDeparture:self.city withContext:self.context];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:searchViewConctroller];
        UIImage *searchImage = [UIImage imageNamed:@"search_icon"];
        searchImage = [searchImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        navController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Search" image:searchImage tag:0];
        
        KVBSavedFlightsViewController *sfvc = [[KVBSavedFlightsViewController alloc] initWithCoreDataService:self.coreDataService];
        UINavigationController *navControllerForSaved = [[UINavigationController alloc] initWithRootViewController:sfvc];
        UIImage *savedImage = [UIImage imageNamed:@"saved_icon"];
        savedImage = [savedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        navControllerForSaved.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Saved" image:savedImage tag:1];
        
        KVBSettingsViewController *settingVC = [[KVBSettingsViewController alloc]initWithCoreDataServise:self.coreDataService];
        UIImage *settingsImage = [UIImage imageNamed:@"settings_icon"];
        settingsImage = [settingsImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        settingVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Settings" image:settingsImage tag:2];
        
        tabBarController.viewControllers = @[navController, navControllerForSaved, settingVC];
        tabBarController.tabBar.barTintColor = [UIColor colorWithRed:0 / 255.0 green:199 / 255.0 blue:156 / 255.0 alpha:1.0f];
        [self presentViewController:tabBarController animated:YES completion:nil];
    }
    else
    {
        NSArray * pathArray = @[@(self.acceptButton.center), @(CGPointMake(self.acceptButton.center.x - 15, self.acceptButton.center.y)),@(CGPointMake(self.acceptButton.center.x + 15, self.acceptButton.center.y)), @(self.acceptButton.center)];
        
        CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        pathAnimation.values = pathArray;
        pathAnimation.duration = 1.0;
        [self.acceptButton.layer addAnimation:pathAnimation forKey:@"position"];
    }
}


#pragma mark - UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    KVBLocationsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KVBLocationCellReuseIdentifier forIndexPath:indexPath];
    
    Countries *country = self.countriesArray[indexPath.row];
    
    cell.locationName = country.name;
    
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


#pragma mark - KVBFirstStartLoadingDelegate

- (void)updateLocation
{
    BOOL hasCities = [[[NSUserDefaults standardUserDefaults] valueForKey:@"Cities"] isEqualToString: @"Exist"];
    BOOL hasCountries = [[[NSUserDefaults standardUserDefaults] valueForKey:@"Countries"] isEqualToString: @"Exist"];

    if(hasCities && hasCountries)
    {
        [self loadingComplete];
    }
}

- (void)loadingComplete
{
    [self.servise whereAreMeWithComletition:^(NSString *countryName, NSString *cityName, NSString *stringError) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
                           self.welcomeLabel.text = KVBWelcomeLableDefaultText;
                           if (stringError.length)
                           {
                               self.welcomeLabel.text = stringError;
                           }
                           
                           NSArray *countryArray = [self.coreDataService findLocationInEntity:NSStringFromClass([Countries class]) withName:countryName];
                           self.country= countryArray.firstObject;
                           
                           NSArray *cityArray = [self.coreDataService recieveCityByName:cityName inCountry:self.country];
                           self.city = cityArray.firstObject;
                           
                           self.countryField.text = self.country.name;
                           self.cityField.text = self.city.name;
                       });
    }];
}


@end

