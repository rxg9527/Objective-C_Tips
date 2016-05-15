//
//  ViewController.m
//  03_计算两点之间的距离
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
    CGPoint pointA = CGPointMake(200, 200);
    CGPoint pointB = CGPointMake(50, 50);
    NSLog(@"%@", @(CGPointDistanceBetweenTwoPoints(pointA, pointB)));
}

/**
 *  static inline function是干嘛的?
 如果你的.m文件需要频繁调用一个函数,可以用static inline来声明,这相当于把函数体当做一个大号的宏定义.不过这也不是百分之百有效,到底能不能把函数体转换为大号宏定义来用要看编译器心情,它要是觉得你的方法太复杂,他就不转了.他直接调用函数.
 */
static inline CGFloat CGPointDistanceBetweenTwoPoints(CGPoint point1, CGPoint point2) {
    CGFloat dx = point2.x - point1.x;
    CGFloat dy = point2.y - point1.y;
    return sqrt(dx * dx + dy * dy);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
