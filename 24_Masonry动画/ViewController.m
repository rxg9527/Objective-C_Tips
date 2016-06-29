//
//  ViewController.m
//  24_Masonry动画
//
//  Created by Yuen on 16/6/29.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()
@property (strong, nonatomic) UIView *aniView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.aniView = ({
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor redColor];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
             make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
        }];
        view;
    });

    //方法1
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.aniView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(UIEdgeInsetsMake(50, 50, 50, 50));
//        }];
//        
//        [UIView animateWithDuration:3 animations:^{
//            [self.view layoutIfNeeded];
//        }];
//    });

}

- (void)viewDidAppear:(BOOL)animated {
    //方法2 写在 viewWillAppear 中无效
    [self.aniView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(50, 50, 50, 50));
    }];

    [UIView animateWithDuration:3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
