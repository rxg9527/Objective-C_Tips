//
//  PKWAddressBookManager.h
//  Objective-C_201605
//
//  Created by Yuen on 16/6/22.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import <UIKit/UIKit.h>
#define WEAK_SELF __weak typeof(self)weakSelf = self
#define STRONG_SELF __strong typeof(weakSelf)self = weakSelf

//@protocol PKWAddressBookManager <NSObject>
//
//- (void)didSelectPersonWithFirstName:(NSString *)firstName LastName:(NSString *)lastName phoneNumber:(NSString *)phoneNumber;
//
//@end

@interface PKWAddressBookManager : NSObject

+ (instancetype)sharedInstance;
- (void)presentWithContainerViewController:(UIViewController *)containerViewController
                         selectPersonBlock:(void (^)(NSString *name, NSString *phoneNumber))block;

@end
