//
//  KVBViewWithParametres.m
//  SBTProject
//
//  Created by Константин Богданов on 13.12.17.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "KVBViewWithParametres.h"
#import "KVBCoreDataServise.h"
#import "Cities+CoreDataClass.h"
#import "Countries+CoreDataClass.h"
#import <Masonry.h>

const CGFloat KVBLeftRightOffsetInView = 20;
static NSString * const KVBDefaulrCellIdentifier = @"KVBDefaulrCellIdentifier";

@interface KVBViewWithParametres()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIView *inputView;
@property(nonatomic, strong) UITableView *tableWithCities;
@property(nonatomic, strong) UITableView *tableWithCountries;
@property(nonatomic, strong) KVBCoreDataServise *coreDataServise;
@property(nonatomic, copy) NSArray *countriesArray;
@property(nonatomic, copy) NSArray *citiesArray;

@end

@implementation KVBViewWithParametres

- (instancetype)initWithContext: (NSManagedObjectContext*) context
{
    self = [super init];
    if (self)
    {
        
        _departureDate = [UITextField new];
        _departureDate.placeholder = @"te.st.date";
        _departureDate.backgroundColor = UIColor.clearColor;
        _departureDate.borderStyle = UITextBorderStyleRoundedRect;
        _departureDate.backgroundColor = UIColor.whiteColor;
        _departureDate.alpha = 0.8;

        _arrivalDate = [UITextField new];
        _arrivalDate.placeholder = @"te.st.date";
        _arrivalDate.backgroundColor = UIColor.clearColor;
        _arrivalDate.borderStyle = UITextBorderStyleRoundedRect;
        _arrivalDate.backgroundColor = UIColor.whiteColor;
        _arrivalDate.alpha = 0.8;

        _tableWithCities = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        _tableWithCities.delegate = self;
        _tableWithCities.dataSource = self;
        [_tableWithCities registerClass:[UITableViewCell class] forCellReuseIdentifier:KVBDefaulrCellIdentifier];
        
        _tableWithCountries = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        _tableWithCountries.delegate = self;
        _tableWithCountries.dataSource = self;
        [_tableWithCountries registerClass:[UITableViewCell class] forCellReuseIdentifier:KVBDefaulrCellIdentifier];
        
        _inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 400)];
        [_inputView addSubview:_tableWithCountries];
        [_inputView addSubview:_tableWithCities];
        
        _departureField = [UITextField new];
        _departureField.placeholder = @"Departure";
        _departureField.backgroundColor = UIColor.clearColor;
        _departureField.borderStyle = UITextBorderStyleRoundedRect;
        _departureField.backgroundColor = UIColor.whiteColor;
        _departureField.alpha = 0.8;
        _departureField.inputView = _inputView;
        
        _arrivalField = [UITextField new];
        _arrivalField.placeholder = @"Arrival";
        _arrivalField.backgroundColor = UIColor.clearColor;
        _arrivalField.borderStyle = UITextBorderStyleRoundedRect;
        _arrivalField.backgroundColor = UIColor.whiteColor;
        _arrivalField.alpha = 0.8;
        _arrivalField.inputView = _inputView;
        
        _imageView = [UIImageView new];
        _imageView.image = [UIImage imageNamed:@"backimg.jpg"];
        
        _coreDataServise = [[KVBCoreDataServise alloc]initWithContext:context];
        
        _countriesArray = [_coreDataServise recieveCountries];
        
        [self.tableWithCountries reloadData];
        
        [self addSubview:_imageView];
        [self addSubview:_departureField];
        [self addSubview:_arrivalField];
        [self addSubview:_departureDate];
        [self addSubview:_arrivalDate];

        [self setupConstreints];
    }
    return self;
}

- (void)setupConstreints
{
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_departureField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(KVBLeftRightOffsetInView);
        make.left.equalTo(self.mas_left).offset(KVBLeftRightOffsetInView);
        make.right.equalTo(_arrivalField.mas_left).offset(-KVBLeftRightOffsetInView);
        make.height.equalTo(@(20));
        make.width.equalTo(_arrivalField.mas_width);
    }];
    
    [_arrivalField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(KVBLeftRightOffsetInView);
        make.right.equalTo(self.mas_right).offset(-KVBLeftRightOffsetInView);
        make.height.equalTo(@(20));
    }];
    
    [_departureDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_departureField.mas_bottom).offset(KVBLeftRightOffsetInView);
        make.left.equalTo(self.mas_left).offset(KVBLeftRightOffsetInView);
        make.right.equalTo(_arrivalDate.mas_left).offset(-KVBLeftRightOffsetInView);
        make.height.equalTo(@(20));
        make.width.equalTo(_arrivalDate.mas_width);
    }];
    
    [_arrivalDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_arrivalField.mas_bottom).offset(KVBLeftRightOffsetInView);
        make.right.equalTo(self.mas_right).offset(-KVBLeftRightOffsetInView);
        make.height.equalTo(_departureField.mas_height);
        make.bottom.equalTo(self.mas_bottom).offset(-KVBLeftRightOffsetInView);
    }];
    
    [self.tableWithCountries mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputView.mas_top);
        make.left.equalTo(self.inputView.mas_left);
        make.right.equalTo(self.tableWithCities.mas_left).offset(5);
        make.width.equalTo(self.tableWithCities.mas_width);
        make.bottom.equalTo(self.inputView.mas_bottom);
    }];
    
    [self.tableWithCities mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputView.mas_top);
        make.right.equalTo(self.inputView.mas_right);
        make.bottom.equalTo(self.inputView.mas_bottom);
    }];
    
}


#pragma mark - UITableViewDataSourse

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KVBDefaulrCellIdentifier];
    
    if ([tableView isEqual:self.tableWithCountries])
    {
        Countries *country = self.countriesArray[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", country.name];
    }
    if ([tableView isEqual:self.tableWithCities])
    {
        Cities *city = self.citiesArray[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", city.name];
    }

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([tableView isEqual:self.tableWithCountries])
    {
        return self.countriesArray.count;
    }
    if ([tableView isEqual:self.tableWithCities])
    {
       
        return self.citiesArray.count;

    }
    return 0;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableWithCountries])
    {
        Countries *country = self.countriesArray[indexPath.row];
        self.citiesArray = [self.coreDataServise recieveCitiesFromCountry:country];
        
        [self.tableWithCities reloadData];
    }
    if ([tableView isEqual:self.tableWithCities])
    {
        Cities *city = self.citiesArray[indexPath.row];
        [self updateTextFieldWithCity:city];
    }

}

- (void)updateTextFieldWithCity:(Cities*)city
{
    if ([self.arrivalField isFirstResponder])
    {
        [self updateTextField:self.arrivalField withCity:city];
        [self.delegate arrivalCityChangedWithCity:city];
        [self.arrivalField resignFirstResponder];
    }
    if ([self.departureField isFirstResponder])
    {
        [self updateTextField:self.departureField withCity:city];
        [self.delegate departureCityChangedWithCity:city];
        [self.departureField resignFirstResponder];

    }
}

- (void)updateTextField:(UITextField*)textField withCity:(Cities *)city
{
    textField.text = [NSString stringWithFormat:@"%@, %@", city.parrentCountry.codeIATA, city.name];
}

@end
