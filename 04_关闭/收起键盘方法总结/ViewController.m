//
//  ViewController.m
//  04_关闭/收起键盘方法总结
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
    
    /**
     * 2、点击背景View收起键盘（你的View必须是继承于UIControl）
     */
    [self.view endEditing:YES];
    
    /**
     * 3、你可以在任何地方加上这句话，可以用来统一收起键盘
     */
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

/**
 *  1、点击Return按扭时收起键盘
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

@end
