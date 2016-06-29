//
//  NSString+XGCategory.h
//  Objective-C_201605
//
//  Created by Yuen on 16/6/28.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (XGCategory)

/**抹除运费小数末尾的0*/
- (NSString *)removeUnwantedZero;

//去掉前后空格
- (NSString *)trimmedString;

#pragma mark 宽高、Size
- (CGFloat)widthForFont:(UIFont *)font;
- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;
+ (CGFloat)heightWithString:(NSString *)string fontSize:(CGFloat)fontSize width:(CGFloat)width;

#pragma mark 时间
+ (NSString *)compareCurrentTime:(NSTimeInterval)compareDate;
+ (NSString *)getStringWithTimestamp:(NSTimeInterval)timestamp formatter:(NSString *)formatter;
+ (NSString *)getDateStringWithTimestamp:(NSTimeInterval)timestamp;

#pragma mark 加密
+ (NSString *)getSecrectStringWithPhoneNumber:(NSString *)phoneNum;
+ (NSString *)getSecrectStringWithAccountNo:(NSString *)accountNo;

#pragma mark AttributeString
+ (NSMutableAttributedString *)setAttributeString:(NSString *)attributedString
                                      totalString:(NSString *)totalString
                                            color:(UIColor *)color;

@end


@interface NSString (Valid)

//有效的电话号码
- (BOOL)isValidMobileNumber;
//有效的真实姓名
- (BOOL)isValidRealName;
//有效的验证码
- (BOOL)isValidVerifyCode;
//有效的银行卡号
- (BOOL)isValidBankCardNumber;
//有效的邮箱
- (BOOL)isValidEmail;
//有效的字母数字密码
- (BOOL)isValidAlphaNumberPassword;
//有效的身份证号
- (BOOL)isValidIdentityCardNumber;
//限制只能输入数字
- (BOOL)validateNumber:(NSString *)number;
//限制只能输入数字和小数点且小数点后保留两位
- (BOOL)validateCashWith:(UITextField *)textField Range:(NSRange)range;

@end


@interface NSString (URLEncode)

- (NSString *)URLEncodedString;

@end


@interface NSString (Base64)

+ (NSString *)base64StringFromData:(NSData *)data length:(NSUInteger)length;

@end


@interface NSString (Format)

+ (NSString *)stringMobileFormat:(NSString *)mobile;
+ (NSString *)stringChineseFormat:(double)value;

@end
