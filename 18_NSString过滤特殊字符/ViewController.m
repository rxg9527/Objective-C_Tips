//
//  ViewController.m
//  18_NSString过滤特殊字符
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
    /**
     *  没有作用？？？？？？？
     */
    NSString *trimString = @"334$%&sdh^&：￥352";
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""];
    // 过滤字符串的特殊字符
    NSString *newString = [trimString stringByTrimmingCharactersInSet:set];
    NSLog(@"%@", newString);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
