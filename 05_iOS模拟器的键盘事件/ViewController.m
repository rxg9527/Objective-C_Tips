//
//  ViewController.m
//  05_iOS模拟器的键盘事件
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
     *  当iOS模拟器 选择了Keybaord->Connect Hardware keyboard 后，不弹出键盘。
     
     使用如下代码进行键盘事件的获取。那么在此情景下将不会调用-keyboardWillHide.
     因为没有键盘的隐藏和显示。
     */
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)keyboardWillHide {
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
