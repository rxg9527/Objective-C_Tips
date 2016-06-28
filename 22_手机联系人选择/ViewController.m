//
//  ViewController.m
//  22_手机联系人选择
//
//  Created by Yuen on 16/6/22.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "ViewController.h"
#import "PKWAddressBookManager.h"
#import <AddressBookUI/AddressBookUI.h>
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)didClickButtonToAddressBook:(id)sender {
    WEAK_SELF;
    [[PKWAddressBookManager sharedInstance] presentWithContainerViewController:self
                                                             selectPersonBlock:^(NSString *name, NSString *phoneNumber) {
                                                                 STRONG_SELF;
                                                                 self.nameLabel.text = name;
                                                                 self.phoneLabel.text = phoneNumber;
                                                             }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ABPeoplePickerNavigationController *vc = [ABPeoplePickerNavigationController new];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
