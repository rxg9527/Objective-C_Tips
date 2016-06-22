//
//  ViewController.m
//  21_AreaPickerView
//
//  Created by Yuen on 16/6/21.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "ViewController.h"
#import "XGAreaPickerView.h"

@interface ViewController () <XGAreaPickerViewDelegate>

@property (strong, nonatomic)  NSDictionary *areaInfoDict;  ///< 从plist中读取的省市区数据
@property (strong, nonatomic)  NSArray *provinces;
@property (strong, nonatomic)  NSArray *city;
@property (strong, nonatomic)  NSArray *district;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    XGAreaPickerView *view = [[[NSBundle mainBundle] loadNibNamed:@"XGAreaPickerView" owner:nil options:nil] firstObject];
    view.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 48+260*[UIScreen mainScreen].bounds.size.width/375);
    view.delegate = self;
    [self.view addSubview:view];
}

- (void)didClickConfirmButtonInAreaPickerView:(XGAreaPickerView *)pickerView provinceString:(NSString *)provinceInfo {
    NSLog(@"%@", provinceInfo);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
