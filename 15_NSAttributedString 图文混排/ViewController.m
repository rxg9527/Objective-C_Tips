//
//  ViewController.m
//  15_NSAttributedString 图文混排
//
//  Created by Yuen-iMac on 16/5/26.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:@"哈哈哈哈哈123456789"];

    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = [UIImage imageNamed:@"base_goto_page_black_icon"];
    // 设置图片大小
    attch.bounds = CGRectMake(0, 0, 14, 24);

    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri appendAttributedString:string];

    // 用label的attributedText属性来使用富文本
    self.label.attributedText = attri;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
