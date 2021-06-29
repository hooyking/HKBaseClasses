//
//  NSString+HKKit.h
//  HKBaseClasses
//
//  Created by hooyking on 2020/5/18.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HKKit)

#pragma mark - 数据校验

/**
 是否是整型（含负数）
 
 @return YES 整型，NO 非整型
 */
- (BOOL)isInteger;

/**
 是否是数字(含负数)
 
 @return YES 数字，NO 非数字
 */
- (BOOL)isNumber;

/**
 是否合法的密码（6-18位且同时含有数字与字母）
 
 @return YES 合法的密码，NO 不合法之
 */
- (BOOL)isValidPassword;

/**
 是否合法的身份证号（15或18位）
 
 @return YES 合法的身份证号，NO 不合法之
 */
- (BOOL)isValidIdCard;

/**
 是否合法的URL
 
 @return YES 合法的URL，NO 不合法之
 */
- (BOOL)isValidURL;

/**
 是否合法的电话号码
 
 @return YES 合法的电话号码，NO 不合法之
 */
- (BOOL)isValidMobileNumber;

/**
 是否合法的邮箱
 
 @return YES 合法的邮箱，NO 不合法之
 */
- (BOOL)isValidEmailAddress;

/**
 是否合法的护照号码
 
 @return YES 合法的护照号码，NO 不合法之
 */
- (BOOL)isValidPassportNumber;

/**
 是否合法的车牌号
 
 @return YES 合法的车牌号，NO 不合法之
 */
- (BOOL)isValidCarId;

/**
 是否合法的验证码（6位纯数字）
 
 @return YES 合法的验证码，NO 不合法之
 */
- (BOOL)isValidCaptcha;

/**
 是否合法的银行卡号
 
 @return YES 合法的银行卡号，NO 不合法之
 */
- (BOOL)isValidBankCardNumber;

/**
 是否含有中文
 
 @return YES 含有中文，NO 不含之
 */
- (BOOL)isContainsChinese;

/**
 是否含有特殊字符
 
 @return YES 含有特殊字符，NO 不含之
 */
- (BOOL)isContainSpecialCharacters;

/**
 是否含有emoji
 
 @return YES 含有emoji，NO 不含之
 */
- (BOOL)isContainsEmoji;

#pragma mark - 对字符串的处理

/**
 用新字符串替换旧字符串
 
 @param oldString 旧字符串
 @param newString 新字符串
 
 @return 新生成的字符串
 */
- (NSString *)replaceOldString:(NSString *)oldString withNewString:(NSString *)newString;

/**
 去掉首尾空格
 
 @return 新生成的字符串
 */
- (NSString *)removeForeAftWhitesSpace;

/**
 去掉所有空格

 @return 新生成的字符串
 */
- (NSString *)removeAllWhitesSpace;

/**
 去除小数点后为0的数值（例2.00变为2）

 @return 新生成的字符串
 */
- (NSString *)removeFloatPointLaterWithZero;

/**
 去除emoji（先判断是否含有emoji）

 @return 新生成的字符串
 */
- (NSString*)removeEmojiString;

/**
 金额格式化 (例99,999,000.00)

 @return 新生成的字符串
 */
- (NSString *)formatMoneryWithComma;

/**
 手机号格式化（例132****8888）

 @return 新生成的字符串
 */
- (NSString *)formatMobileNumberWithAsterisk;

/**
 金额转大写（例123转壹佰贰拾叁元整)

 @return 新生成的字符串
 */
- (NSString *)formatMoneyUpper;

/**
 urlString进行编码操作

 @return 编码后的urlString
 */
- (NSString *)stringByURLEncoded;

/**
 urlString进行解码操作

 @return 解码后的urlString
 */
- (NSString *)stringByURLDecoded;

#pragma mark - 根据字符串得到相关数据

/**
 获取字符串的size
 
 @param size 文字承载者的size
 @param font 字号
 
 @return 文字的width或height固定后动态的size
 */
- (CGSize)stringSizeWithSize:(CGSize)size font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
