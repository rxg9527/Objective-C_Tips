//
//  ViewController.m
//  20_TextField
//
//  Created by Yuen-iMac on 16/6/6.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (nonatomic, copy) NSString *text1;
@property (nonatomic, copy) NSString *text2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.textField1.delegate = self;
    self.textField2.delegate = self;
}

/**
 *  - (void)textFieldDidEndEditing:(UITextField *)textField; 当在tf中输入时，去点击一个button，tf并不会resignFirstResponder，需要在button的点击方法中主动调用
 *
 *  @param sender <#sender description#>
 */
- (IBAction)didClickActionButton:(id)sender {
    [self.view endEditing:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.textField1) {
        self.text1 = textField.text;
    } else if (textField == self.textField2) {
        self.text2 = textField.text;
    }
    NSLog(@"%@, %@", self.text1, self.text2);
}

@end
