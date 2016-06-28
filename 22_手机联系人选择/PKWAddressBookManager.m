//
//  PKWAddressBookManager.m
//  Objective-C_201605
//
//  Created by Yuen on 16/6/22.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#define IOS_VERSION             [[[UIDevice currentDevice] systemVersion] floatValue]

#import "PKWAddressBookManager.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface PKWAddressBookManager () <ABPeoplePickerNavigationControllerDelegate>

@property (nonatomic, strong) UIViewController *containerViewController;
@property (nonatomic, copy) void (^selectPersonBlock)(NSString *name, NSString *phoneNumber);
@end

@implementation PKWAddressBookManager

+ (instancetype)sharedInstance
{
    static PKWAddressBookManager* instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [PKWAddressBookManager new];
    });

    return instance;
}

- (void)presentWithContainerViewController:(UIViewController *)containerViewController
                         selectPersonBlock:(void (^)(NSString *name, NSString *phoneNumber))selectPersonBlock {
    self.containerViewController = containerViewController;
    self.selectPersonBlock = selectPersonBlock;

    switch (ABAddressBookGetAuthorizationStatus()) {
        case kABAuthorizationStatusAuthorized:
            [self accessGrantedForAddressBook];
            break;
        case kABAuthorizationStatusNotDetermined:
            [self requestAddressBookAccess];
            break;
        case kABAuthorizationStatusDenied:
        case kABAuthorizationStatusRestricted: {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"通讯录提示" message:@"请在iPhone的[设置]->[隐私]->[通讯录]，允许配夸海淘访问你的通讯录" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return;
        } break;
        default:
            break;
    }
}

#pragma mark - 联系人
#pragma mark 请求访问通讯录权限
- (void)requestAddressBookAccess
{
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    WEAK_SELF;
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        STRONG_SELF;
        if (granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self accessGrantedForAddressBook];
                
            });
        }
    });
}

#pragma mark 弹出选联系人页面
- (void)accessGrantedForAddressBook
{
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    // Display only a person's phone, email, and birthdate
    NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty],
                               [NSNumber numberWithInt:kABPersonEmailProperty],
                               [NSNumber numberWithInt:kABPersonBirthdayProperty], nil];
//    if (IOS_VERSION >= 8) { //iOS8以上需要这句话，不然直接退出
//        picker.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];
//    }
    picker.displayedProperties = displayedItems;
    [self.containerViewController presentViewController:picker animated:YES completion:nil];
}

#pragma mark 点击取消按钮
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker;
{
    [self.containerViewController dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark iOS8以下
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    NSString *name = @"";
    NSString *phoneNum = @"";
    CFStringRef firstNameLabel = ABPersonCopyLocalizedPropertyName(kABPersonFirstNameProperty);
    CFStringRef lastNameLabel = ABPersonCopyLocalizedPropertyName(kABPersonLastNameProperty);
    CFStringRef firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    // 姓
    CFStringRef lastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
    NSLog(@"%@ %@ - %@ %@", lastNameLabel, lastName, firstNameLabel, firstName);
    if (firstName == NULL) {
        name = (__bridge NSString *)lastName;
    } else if (lastName == NULL) {
        name = (__bridge NSString *)firstName;
    } else {
        name = [NSString stringWithFormat:@"%@%@", (__bridge NSString *)lastName, (__bridge NSString *)firstName];
    }
    CFRelease(firstNameLabel);
    CFRelease(lastNameLabel);
    if (firstName) {
        CFRelease(firstName);
    }
    if (lastName) {
        CFRelease(lastName);
    }

    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    if (ABMultiValueGetCount(phone) > 0) {
        long index = ABMultiValueGetIndexForIdentifier(phone, identifier);
        CFStringRef phoneRef = ABMultiValueCopyValueAtIndex(phone, index);
        phoneNum = (__bridge NSString *)phoneRef;
        
        if ([phoneNum hasPrefix:@"+"]) {
            phoneNum = [phoneNum substringFromIndex:3];
        }
        phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSLog(@"%@", phoneNum);
        CFRelease(phone);
        CFRelease(phoneRef);
    }
    if (self.selectPersonBlock) {
        self.selectPersonBlock(name, phoneNum);
    }
    [self.containerViewController dismissViewControllerAnimated:YES completion:NULL];
    return YES;
}

#pragma mark iOS8以上
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    NSString *name = @"";
    NSString *phoneNum = @"";
    CFStringRef firstNameLabel = ABPersonCopyLocalizedPropertyName(kABPersonFirstNameProperty);
    CFStringRef lastNameLabel = ABPersonCopyLocalizedPropertyName(kABPersonLastNameProperty);
    CFStringRef firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    // 姓
    CFStringRef lastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
    NSLog(@"%@ %@ - %@ %@", lastNameLabel, lastName, firstNameLabel, firstName);
    if (firstName == NULL) {
        name = (__bridge NSString *)lastName;
    } else if (lastName == NULL) {
        name = (__bridge NSString *)firstName;
    } else {
        name = [NSString stringWithFormat:@"%@%@", (__bridge NSString *)lastName, (__bridge NSString *)firstName];
    }
    CFRelease(firstNameLabel);
    CFRelease(lastNameLabel);
    if (firstName) {
        CFRelease(firstName);
    }
    if (lastName) {
        CFRelease(lastName);
    }
    
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    if (ABMultiValueGetCount(phone) > 0) {
        long index = ABMultiValueGetIndexForIdentifier(phone, identifier);
        CFStringRef phoneRef = ABMultiValueCopyValueAtIndex(phone, index);
        phoneNum = (__bridge NSString *)phoneRef;
        
        if ([phoneNum hasPrefix:@"+"]) {
            phoneNum = [phoneNum substringFromIndex:3];
        }
        phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSLog(@"%@", phoneNum);
        CFRelease(phone);
    }
    if (self.selectPersonBlock) {
        self.selectPersonBlock(name, phoneNum);
    }
    [self.containerViewController dismissViewControllerAnimated:YES completion:NULL];
}
@end
