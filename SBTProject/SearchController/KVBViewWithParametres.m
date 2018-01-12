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
#import "KVBLocationsTableViewCell.h"
#import "KVBDatePicker.h"
#import <Masonry.h>

const CGFloat KVBLeftRightOffsetInView = 20;
static NSString * const KVBDefaulrCellIdentifier = @"KVBDefaulrCellIdentifier";


@interface KVBViewWithParametres()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, KVBDatePickerDelegate>


@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIView *inputView;
@property(nonatomic, strong) UIView *seperatorView;
@property(nonatomic, strong) UITableView *tableWithCities;
@property(nonatomic, strong) UITableView *tableWithCountries;
@property(nonatomic, strong) UITextField *departureDateLabel;
@property(nonatomic, strong) UITextField *arrivalDateLabel;
@property(nonatomic, strong) KVBCoreDataServise *coreDataServise;
@property(nonatomic, copy) NSArray *countriesArray;
@property(nonatomic, copy) NSArray *citiesArray;
@property(nonatomic, strong) UITapGestureRecognizer *tapRecognaiser;
@property(nonatomic, strong) KVBDatePicker *datePicker;


@end


@implementation KVBViewWithParametres


- (instancetype)initWithContext: (NSManagedObjectContext*) context
{
    self = [super init];
    if (self)
    {
        _tapRecognaiser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeWidth)];
        
        _datePicker = [[KVBDatePicker alloc] initWithFrame:CGRectMake(0, 0, 0, 320)];
        _datePicker.delegate = self;
        
        _departureDateLabel = [UITextField new];
        _departureDateLabel.placeholder = @"de.pa.rture";
        _departureDateLabel.backgroundColor = UIColor.clearColor;
        _departureDateLabel.borderStyle = UITextBorderStyleRoundedRect;
        _departureDateLabel.backgroundColor = UIColor.whiteColor;
        _departureDateLabel.alpha = 0.8;
        _departureDateLabel.inputView = _datePicker;
        
        _arrivalDateLabel = [UITextField new];
        _arrivalDateLabel.placeholder = @"ar.ri.val";
        _arrivalDateLabel.backgroundColor = UIColor.clearColor;
        _arrivalDateLabel.borderStyle = UITextBorderStyleRoundedRect;
        _arrivalDateLabel.backgroundColor = UIColor.whiteColor;
        _arrivalDateLabel.alpha = 0.8;
        _arrivalDateLabel.inputView = _datePicker;
        
        _tableWithCities = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        _tableWithCities.delegate = self;
        _tableWithCities.dataSource = self;
        [_tableWithCities registerClass:[KVBLocationsTableViewCell class] forCellReuseIdentifier:KVBDefaulrCellIdentifier];
        [_tableWithCities addGestureRecognizer:_tapRecognaiser];
     
        _tableWithCountries = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        _tableWithCountries.delegate = self;
        _tableWithCountries.dataSource = self;
        [_tableWithCountries registerClass:[KVBLocationsTableViewCell class] forCellReuseIdentifier:KVBDefaulrCellIdentifier];
        
        _inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 320)];
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
        [self addSubview:_departureDateLabel];
        [self addSubview:_arrivalDateLabel];

        [self setupConstreints];
        
    }
    return self;
}


#pragma mark - Contraints

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
    
    [_departureDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_departureField.mas_bottom).offset(KVBLeftRightOffsetInView);
        make.left.equalTo(self.mas_left).offset(KVBLeftRightOffsetInView);
        make.right.equalTo(_arrivalDateLabel.mas_left).offset(-KVBLeftRightOffsetInView);
        make.height.equalTo(@(20));
        make.width.equalTo(_arrivalDateLabel.mas_width);
    }];
    
    [_arrivalDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_arrivalField.mas_bottom).offset(KVBLeftRightOffsetInView);
        make.right.equalTo(self.mas_right).offset(-KVBLeftRightOffsetInView);
        make.height.equalTo(_departureField.mas_height);
        make.bottom.equalTo(self.mas_bottom).offset(-KVBLeftRightOffsetInView);
    }];
    
    [self.tableWithCountries mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputView.mas_top);
        make.left.equalTo(self.inputView.mas_left);
        make.width.mas_equalTo(UIScreen.mainScreen.bounds.size.width * 0.8);
        make.right.equalTo(self.tableWithCities.mas_left).offset(-5);
        make.bottom.equalTo(self.inputView.mas_bottom);
    }];
    
    [self.tableWithCities mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputView.mas_top);
        make.right.equalTo(self.inputView.mas_right);
        make.bottom.equalTo(self.inputView.mas_bottom);
    }];
    
    [super updateConstraints];
}


#pragma mark - UITableViewDataSourse

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    KVBLocationsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KVBDefaulrCellIdentifier];

    if ([tableView isEqual:self.tableWithCountries])
    {
        Countries *country = self.countriesArray[indexPath.row];
        cell.locationName = [NSString stringWithFormat:@"%@", country.name];
    }
    if ([tableView isEqual:self.tableWithCities])
    {
        Cities *city = self.citiesArray[indexPath.row];
        cell.locationName = [NSString stringWithFormat:@"%@", city.name];
    }

    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [tableView isEqual:self.tableWithCities] ? @"Cities" :  @"Countries";
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


#pragma mark - UITextFields events

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


#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return NO;
}


#pragma mark - Animations

- (void)changeWidth
{
    
    CGFloat width = self.bounds.size.width * 0.8;
    
    if(self.tableWithCountries.bounds.size.width > width/2)
    {
        width = self.bounds.size.width * 0.2;
        [self.tableWithCities removeGestureRecognizer:self.tapRecognaiser];
        [self.tableWithCountries addGestureRecognizer:self.tapRecognaiser];
    }
    else
    {
        [self.tableWithCountries removeGestureRecognizer:self.tapRecognaiser];
        [self.tableWithCities addGestureRecognizer:self.tapRecognaiser];
    }
    
    [self.inputView layoutIfNeeded];

    [self.tableWithCountries mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputView.mas_top);
        make.left.equalTo(self.inputView.mas_left);
        make.width.mas_equalTo(width);
        make.right.equalTo(self.tableWithCities.mas_left).offset(-5);
        make.bottom.equalTo(self.inputView.mas_bottom);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.inputView layoutIfNeeded];
    }];
}

#pragma mark - KVBDatePickerDelegate


- (void)dateChanged:(NSDate *)newDate
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"dd.MM.yy";
    
    if ([self.arrivalDateLabel isFirstResponder])
    {
        self.arrivalDate = newDate;
        self.arrivalDateLabel.text = [dateFormatter stringFromDate:newDate];
        [self.arrivalDateLabel resignFirstResponder];
        [self.delegate arrivalDateChangedWithDate:newDate];
    }
    if ([self.departureDateLabel isFirstResponder])
    {
        self.depatrtureDate = newDate;
        self.departureDateLabel.text = [dateFormatter stringFromDate:newDate];
        [self.departureDateLabel resignFirstResponder];
        [self.delegate departureDateChangedWithDate:newDate];
    }
}

@end
