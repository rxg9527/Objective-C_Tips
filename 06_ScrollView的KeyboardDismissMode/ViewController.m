//
//  ViewController.m
//  06_ScrollView的KeyboardDismissMode
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
    UIScrollView *bgScrollView = ({
        UIScrollView *view = [UIScrollView new];
        [self.view addSubview:view];
        view;
    });
    /**
     *  像Messages app一样在滚动的时候可以让键盘消失是一种非常好的体验
     然而，将这种行为整合到你的app很难。幸运的是，苹果给UIScrollView添加了一个很好用的属性keyboardDismissMode，这样可以方便很多。
     */
    bgScrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:bgScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
