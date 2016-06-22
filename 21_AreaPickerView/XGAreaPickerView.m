//
//  XGAreaPickerView.m
//  FNMarket
//
//  Created by Yuen on 10/15/15.
//  Copyright © 2015 Yuen. All rights reserved.
//

#import "XGAreaPickerView.h"

@interface XGAreaPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@property (strong, nonatomic)  NSDictionary *areaInfoDict;  ///< 从plist中读取的省市区数据
@property (strong, nonatomic)  NSArray *provinces;
@property (strong, nonatomic)  NSArray *city;
@property (strong, nonatomic)  NSArray *district;
@property (strong, nonatomic)  NSString *selectedProvince;

@end

@implementation XGAreaPickerView

- (void)awakeFromNib {
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;

    NSArray *sortedArray = [[self.areaInfoDict allKeys] sortedArrayUsingComparator: ^(id obj1, id obj2) {
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        } else if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        } else {
            return (NSComparisonResult)NSOrderedSame;
        }
    }];

    NSMutableArray *provinceTemp = [[NSMutableArray alloc] init];
    for (int i = 0; i < [sortedArray count]; i++) {
        NSString *key = [sortedArray objectAtIndex:i];
        NSArray *tmp = [[self.areaInfoDict objectForKey:key] allKeys]; // @[省]
        [provinceTemp addObject:[tmp firstObject]];
    }
    _provinces = [[NSArray alloc] initWithArray:provinceTemp];

    NSString *index = [sortedArray firstObject]; // 0
    NSString *selected = [_provinces firstObject]; // 北京市
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[[self.areaInfoDict objectForKey:index] objectForKey:selected]]; // @[@"0":@{@"北京市": @[……]
                                 //         }]

    NSArray *cityArray = [dic allKeys]; // @[@"0"]
    NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary:[dic objectForKey:[cityArray firstObject]]];
    _city = [[NSArray alloc] initWithArray:[cityDic allKeys]];

    NSString *selectedCity = [_city firstObject];
    _district = [[NSArray alloc] initWithArray:[cityDic objectForKey:selectedCity]]; // @[XX区，XX区……]

    _selectedProvince = [_provinces firstObject];
}

- (NSDictionary *)areaInfoDict {
    if (!_areaInfoDict) {
        _areaInfoDict = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"]];
    }
    return _areaInfoDict;
}

#pragma mark - UIPickerViewDataSource
#define PROVINCE_COMPONENT  0
#define CITY_COMPONENT      1
#define DISTRICT_COMPONENT  2
- (IBAction)didClickConfirmButton:(UIButton *)sender {
    NSInteger provinceIndex = [self.pickerView selectedRowInComponent:PROVINCE_COMPONENT];
    NSInteger cityIndex = [self.pickerView selectedRowInComponent:CITY_COMPONENT];
    NSInteger districtIndex = [self.pickerView selectedRowInComponent:DISTRICT_COMPONENT];
    
    NSString *provinceStr = [self.provinces objectAtIndex:provinceIndex];
    NSString *cityStr = [self.city objectAtIndex:cityIndex];
    NSString *districtStr = [self.district objectAtIndex:districtIndex];

    NSString *addressInfo = [NSString stringWithFormat:@"%@ %@ %@", provinceStr, cityStr, districtStr];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickConfirmButtonInAreaPickerView:provinceString:)]) {
        [self.delegate didClickConfirmButtonInAreaPickerView:self provinceString:addressInfo];
    }
}

- (IBAction)didClickCancelButton:(UIButton *)sender {
    [self removeFromSuperview];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == PROVINCE_COMPONENT) {
        return [self.provinces count];
    } else if (component == CITY_COMPONENT) {
        return [self.city count];
    } else {
        return [self.district count];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == PROVINCE_COMPONENT) {
        return 100*[UIScreen mainScreen].bounds.size.width/320;
    }
    else if (component == CITY_COMPONENT) {
        return 100*[UIScreen mainScreen].bounds.size.width/320;
    }
    else {
        return 100*[UIScreen mainScreen].bounds.size.width/320;
    }
}

#pragma mark - UIPickerViewDelegate
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *myView = nil;
    
    if (component == PROVINCE_COMPONENT) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100*[UIScreen mainScreen].bounds.size.width/320, 30)];
        myView.text = [_provinces objectAtIndex:row];
    }
    else if (component == CITY_COMPONENT) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100*[UIScreen mainScreen].bounds.size.width/320, 30)];
        myView.text = [_city objectAtIndex:row];
    }
    else {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100*[UIScreen mainScreen].bounds.size.width/320, 30)];
        myView.text = [_district objectAtIndex:row];
    }
    myView.textAlignment = NSTextAlignmentCenter;
    myView.font = [UIFont boldSystemFontOfSize:15];
    myView.textColor = [UIColor colorWithRed:28/255 green:28/255 blue:28/255 alpha:1];
    myView.backgroundColor = [UIColor clearColor];
    
    return myView;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == PROVINCE_COMPONENT) {
        _selectedProvince = [_provinces objectAtIndex:row];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary:[self.areaInfoDict objectForKey:[NSString stringWithFormat:@"%ld", (long)row]]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[tmp objectForKey:_selectedProvince]];
        NSArray *cityArray = [dic allKeys];
        NSArray *sortedArray = [cityArray sortedArrayUsingComparator:^(id obj1, id obj2) {

          if ([obj1 integerValue] > [obj2 integerValue]) {
              return (NSComparisonResult)NSOrderedDescending; //递减
          }

          if ([obj1 integerValue] < [obj2 integerValue]) {
              return (NSComparisonResult)NSOrderedAscending; //上升
          }
          return (NSComparisonResult)NSOrderedSame;
        }];

        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i = 0; i < [sortedArray count]; i++) {
            NSString *index = [sortedArray objectAtIndex:i];
            NSArray *temp = [[dic objectForKey:index] allKeys];
            [array addObject:[temp objectAtIndex:0]];
        }

        _city = [[NSArray alloc] initWithArray:array];

        NSDictionary *cityDic = [dic objectForKey:[sortedArray objectAtIndex:0]];
        _district = [[NSArray alloc] initWithArray:[cityDic objectForKey:[_city objectAtIndex:0]]];
        [pickerView selectRow:0 inComponent:CITY_COMPONENT animated:YES];
        [pickerView selectRow:0 inComponent:DISTRICT_COMPONENT animated:YES];
        [pickerView reloadComponent:CITY_COMPONENT];
        [pickerView reloadComponent:DISTRICT_COMPONENT];
    }
    else if (component == CITY_COMPONENT) {
        NSString *provinceIndex = [NSString stringWithFormat:@"%lu", (unsigned long)[_provinces indexOfObject:_selectedProvince]];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary:[self.areaInfoDict objectForKey:provinceIndex]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[tmp objectForKey:_selectedProvince]];
        NSArray *dicKeyArray = [dic allKeys];
        NSArray *sortedArray = [dicKeyArray sortedArrayUsingComparator:^(id obj1, id obj2) {

          if ([obj1 integerValue] > [obj2 integerValue]) {
              return (NSComparisonResult)NSOrderedDescending;
          }

          if ([obj1 integerValue] < [obj2 integerValue]) {
              return (NSComparisonResult)NSOrderedAscending;
          }
          return (NSComparisonResult)NSOrderedSame;
        }];

        NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary:[dic objectForKey:[sortedArray objectAtIndex:row]]];
        NSArray *cityKeyArray = [cityDic allKeys];

        _district = [[NSArray alloc] initWithArray:[cityDic objectForKey:[cityKeyArray objectAtIndex:0]]];
        [pickerView selectRow:0 inComponent:DISTRICT_COMPONENT animated:YES];
        [pickerView reloadComponent:DISTRICT_COMPONENT];
    }
}

@end



