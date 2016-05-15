//
//  ViewController.m
//  07_StatusBar文字颜色
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
    
    // http://www.pchou.info/ios/2015/08/22/oc-statusbar.html
    
    /**
     *  对状态栏的控制分两种情况：全局设置和分页面设置。控制这两种模式的开关是info.plist文件的View controller-based status bar appearance配置项。
     */
    
    /**
     *  全局设置状态栏
     将info.plist文件的View controller-based status bar appearance设置为NO，即可开启全局设置，也就是说你在VC中对状态栏的控制都将无效，相比之下，是通过下面的代码来全局控制：
     */
    //设置状态栏的字体颜色模式
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //设置状态栏是否隐藏
    [[UIApplication sharedApplication] setStatusBarHidden:YES];

    /**
     *  分页面设置状态栏
     将info.plist文件的View controller-based status bar appearance设置为YES，即可开启由VC来控制状态栏的功能，在这种模式下，全局的设置将无效！！所以我们必须逐个页面对状态栏进行设置，否则状态栏将维持默认的黑色字体和默认为显示状态。
     */
    /**
     *
     对于设置状态栏字体颜色，分两种情况：VC是否属于UINavigationController中：
     
     1) 当VC不在UINavigationController中时，在VC中添加一个方法
     
     - (UIStatusBarStyle)preferredStatusBarStyle
     {
     //返回白色
     return UIStatusBarStyleLightContent;
     //返回黑色
     //return UIStatusBarStyleDefault;
     }
     保险起见，在view的某个加载阶段比如viewWillAppear中，执行：
     
     [self setNeedsStatusBarAppearanceUpdate];
     2) 当VC在UINavigationController中时，VC并不能通过1)的方式控制状态栏的颜色，详见本文后面的参考资料，那么这个时候，有一个trick的方法可以在VC中间接的控制：
     
     self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
