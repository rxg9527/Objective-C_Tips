//
//  ViewController.m
//  25_自定义View
//
//  Created by Yuen on 16/6/29.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "ViewController.h"
#import "CurveView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    CurveView *view = [[CurveView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
