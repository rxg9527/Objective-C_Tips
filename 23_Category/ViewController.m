//
//  ViewController.m
//  23_Category
//
//  Created by Yuen on 16/6/28.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "ViewController.h"
#import "NSString+XGCategory.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *timeStr = [NSString getStringWithTimestamp:1466750984 formatter:@"yyyy-MM-dd HH:mm:ss"];
    NSLog(@"%@", timeStr);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
