//
//  ViewController.m
//  17_打印所有子视图
//
//  Created by Yuen-iMac on 16/5/31.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview: ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        view.backgroundColor = [UIColor redColor];
        view;
    })];
    [self.view addSubview: ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 300, 300)];
        view.backgroundColor = [UIColor blueColor];
        view;
    })];
    /**
     *  在控制台里输入 po [self.view recursiveDescription]
     <UIView: 0x7fa0e9ce5190; frame = (0 0; 414 736); autoresize = W+H; layer = <CALayer: 0x7fa0e9ce2d70>>
     | <_UILayoutGuide: 0x7fa0e9ce5560; frame = (0 0; 0 0); hidden = YES; layer = <CALayer: 0x7fa0e9ce3790>>
     | <_UILayoutGuide: 0x7fa0e9ce60c0; frame = (0 0; 0 0); hidden = YES; layer = <CALayer: 0x7fa0e9ce2d10>>
     | <UIView: 0x7fa0e9ce4800; frame = (0 0; 300 300); layer = <CALayer: 0x7fa0e9ce2510>>
     | <UIView: 0x7fa0e9f73de0; frame = (0 300; 300 300); layer = <CALayer: 0x7fa0e9f47f00>>
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
