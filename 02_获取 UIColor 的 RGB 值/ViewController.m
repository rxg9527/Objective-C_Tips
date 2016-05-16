//
//  ViewController.m
//  02_获取 UIColor 的 RGB 值
//
//  Created by Yuen on 16/5/15.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSUInteger R = (arc4random() % 256);
    NSUInteger G = (arc4random() % 256);
    NSUInteger B = (arc4random() % 256);
    UIColor *randomColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];

    /**
     *  通过 CGColorGetComponents 获取 UIColor 的 RGB 值
     */
    const CGFloat *components = CGColorGetComponents(randomColor.CGColor);
    NSLog(@"Red: %f", components[0]);
    NSLog(@"Green: %f", components[1]);
    NSLog(@"Blue: %f", components[2]);
    NSLog(@"Alpha: %f", components[3]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
