//
//  NSString+HKKit.m
//  HKBaseClasses
//
//  Created by hooyking on 2020/5/18.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import "NSString+HKKit.h"


@implementation NSString (HKKit)

#pragma mark - 数据校验

- (BOOL)isInteger {
    if (self == nil || [self length] <= 0) {
        return NO;
    }
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"-0123456789"] invertedSet];
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    if (![self isEqualToString:filtered]) {
        return NO;
    }
    return YES;
}

- (BOOL)isNumber {
    if (self == nil || [self length] <= 0) {
        return NO;
    }
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"-0123456789."] invertedSet];
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    if (![self isEqualToString:filtered]) {
        return NO;
    }
    return YES;
}

- (BOOL)isValidPassword {
    NSString *ruleString = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    return [self isValidByRegex:ruleString];
}

- (BOOL)isValidIdCard {
    NSString *ruleString = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    return [self isValidByRegex:ruleString];
}

- (BOOL)isValidURL {
    NSString *ruleString = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    return [self isValidByRegex:ruleString];
}

- (BOOL)isValidMobileNumber {
    NSString *ruleString = @"^1(3[0-9]|4[56789]|5[0-9]|6[6]|7[0-9]|8[0-9]|9[189])\\d{8}$";
    return [self isValidByRegex:ruleString];
}

- (BOOL)isValidEmailAddress {
    NSString *ruleString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self isValidByRegex:ruleString];
}

- (BOOL)isValidPassportNumber {
    NSString *ruleString = @"/^1[45][0-9]{7}$|([P|p|S|s]\\d{7}$)|([S|s|G|g|E|e]\\d{8}$)|([Gg|Tt|Ss|Ll|Qq|Dd|Aa|Ff]\\d{8}$)|([H|h|M|m]\\d{8,10})$/";
    return [self isValidByRegex:ruleString];
}

- (BOOL)isValidCarId {
    NSString *ruleString = @"^(([京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领][A-Z](([0-9]{5}[DF])|([DF]([A-HJ-NP-Z0-9])[0-9]{4})))|([京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领][A-Z][A-HJ-NP-Z0-9]{4}[A-HJ-NP-Z0-9挂学警港澳使领]))$";
    return [self isValidByRegex:ruleString];
}

- (BOOL)isValidBankCardNumber {
    //这里用到了银行卡规则Luhn算法
    int oddSum = 0;     // 奇数和
    int evenSum = 0;    // 偶数和
    int allSum = 0;     // 总和
    // 循环加和
    for (NSInteger i = 1; i <= self.length; i++) {
        NSString *theNumber = [self substringWithRange:NSMakeRange(self.length-i, 1)];
        int lastNumber = [theNumber intValue];
        if (i%2 == 0) {
            // 偶数位
            lastNumber *= 2;
            if (lastNumber > 9) {
                lastNumber -=9;
            }
            evenSum += lastNumber;
        } else {
            // 奇数位
            oddSum += lastNumber;
        }
    }
    allSum = oddSum + evenSum;
    // 是否合法
    if (allSum%10 == 0) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isValidCaptcha {
    NSString *ruleString = @"^(\\d{6})";;
    return [self isValidByRegex:ruleString];
}

- (BOOL)isContainsChinese {
    for(int i=0; i< [self length];i++) {
        int a = [self characterAtIndex:i];
        if(a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isContainSpecialCharacters {
    NSString *ruleString =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    return ![self isValidByRegex:ruleString];
}

- (BOOL)isContainsEmoji {
    __block BOOL returnValue = NO;
     
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar high = [substring characterAtIndex: 0];
                                // Surrogate pair (U+1D000-1F9FF)
                                if (0xD800 <= high && high <= 0xDBFF) {
                                    const unichar low = [substring characterAtIndex: 1];
                                    const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
                                     
                                    if (0x1D000 <= codepoint && codepoint <= 0x1F9FF){
                                        returnValue = YES;
                                    }
                                     
                                    // Not surrogate pair (U+2100-27BF)
                                } else {
                                    if (0x2100 <= high && high <= 0x27BF){
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

- (BOOL)isValidByRegex:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

#pragma mark - 对字符串的处理

- (NSString *)replaceOldString:(NSString *)oldString withNewString:(NSString *)newString {
    return [self stringByReplacingOccurrencesOfString:oldString withString:newString];
}

- (NSString *)removeForeAftWhitesSpace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)removeAllWhitesSpace {
    return [[self removeForeAftWhitesSpace] replaceOldString:@" " withNewString:@""];
}

- (NSString *)removeFloatPointLaterWithZero {
    NSString *inputString = [self formatCorrectUserDecimalInput];
    NSArray *currentArr;
    NSString *resultStr = inputString;
    if ([resultStr containsString:@"."]) {
        currentArr = [resultStr componentsSeparatedByString:@"."];
        NSString *firstStr = currentArr.firstObject;
        NSString *lastStr = currentArr[1];
        if (lastStr.length > 0 && ([lastStr floatValue] == 0)) {
            resultStr = firstStr.length > 0 ? firstStr : @"0";
        }
    }
    return resultStr;
}

- (NSString*)removeEmojiString {
    //去除emoji规则
    //  \u0020-\\u007E  标点符号，大小写字母，数字
    //  \u00A0-\\u00BE  特殊标点  (¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾)
    //  \u2E80-\\uA4CF  繁简中文,日文，韩文 彝族文字
    //  \uF900-\\uFAFF  部分汉字
    //  \uFE30-\\uFE4F  特殊标点(︴︵︶︷︸︹)
    //  \uFF00-\\uFFEF  日文  (ｵｶｷｸｹｺｻ)
    //  \u2000-\\u201f  特殊字符(‐‑‒–—―‖‗‘’‚‛“”„‟)
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"                            options:NSRegularExpressionCaseInsensitive
                               error:nil];
    
    NSString *modifiedString = [regex stringByReplacingMatchesInString:self
                                                               options:0
                                                                 range:NSMakeRange(0, self.length)
                                                          withTemplate:@""];
    return modifiedString;
}

- (NSString *)formatCorrectUserDecimalInput {
    NSString *result = self;
    if (result.length > 0) {
        if ([result containsString:@"."]) {
            NSString *headerString = [result componentsSeparatedByString:@"."].firstObject;
            NSString *footerString = [result componentsSeparatedByString:@"."][1];
            if (headerString.length == 0) {
                headerString = @"0";
            }
            if (headerString.length > 0 && [headerString floatValue] == 0) {
                headerString = @"0";
            }
            result = [NSString stringWithFormat:@"%@%@",headerString,[footerString length] > 0 ? [NSString stringWithFormat:@".%@",footerString] : @""];
        }
        if ([result floatValue] == 0) {
            result = @"0";
        }
    }
    return result;
}

- (NSString *)formatMoneryWithComma {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setCurrencySymbol:@""];
    [formatter setNegativeFormat:@""];
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:[self replaceOldString:@"," withNewString:@""]];
    return [[formatter stringFromNumber:number] removeAllWhitesSpace];
}

- (NSString *)formatMobileNumberWithAsterisk {
    if (![self isValidMobileNumber]) {
        return nil;
    }
    return [self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
}

- (NSString *)formatMoneyUpper {
    if (self.length > 16) {
        return @"金额最多支持16位数大写转换";
    }
    if ([self isEqualToString:@"0"]) {
        return @"0元整";
    }
    NSString *strValue = [self replaceOldString:@"," withNewString:@""];
    NSRange range = [strValue rangeOfString:@"."];

    if (range.location != NSNotFound) {//0.5549999
        NSString* pointStr = [strValue substringFromIndex:range.location+1];
        if ([pointStr length] > 3) {
            strValue = [strValue substringToIndex:range.location + 4];
        }
    }

    NSString *str = [NSString stringWithFormat:@"%f", ([strValue doubleValue] + 0.005)];
    range = [str rangeOfString:@"."];

    NSString* yuanStr = nil;
    NSString* jiaoAndFenStr = nil;
    NSArray* arr = @[@"零",@"壹",@"贰",@"叁",@"肆",@"伍",@"陆",@"柒",@"捌",@"玖"];
    NSMutableString* hanziStr = [NSMutableString stringWithString:@""];

    if (range.location != NSNotFound) {
        yuanStr = [str substringToIndex:range.location];
        jiaoAndFenStr = [str substringFromIndex:range.location+1];
    }
    else{
        yuanStr = str;
        jiaoAndFenStr = @"";
    }

    NSInteger yuanAdd0Count = 16 - yuanStr.length;
    NSInteger jiaoAndFenAdd0Count = 2 - jiaoAndFenStr.length;
    NSMutableString* yuanStrAfterAdd0 = [NSMutableString stringWithString:@""];
    NSMutableString* jiaoAndFenStrAfterAdd0 = [NSMutableString stringWithString:@""];

    for (int i = 0; i < yuanAdd0Count; i++) {
        [yuanStrAfterAdd0 appendString:@"0"];
    }
    [yuanStrAfterAdd0 appendString:yuanStr];
    [jiaoAndFenStrAfterAdd0 appendString:jiaoAndFenStr];
    for (int j = 0; j < jiaoAndFenAdd0Count; j++) {
        [jiaoAndFenStrAfterAdd0 appendString:@"0"];
    }

    NSString* zhaoStr = [yuanStrAfterAdd0 substringToIndex:4];
    NSString* hanziZhaoStr = [NSString stringWithFormat:@"%@%@%@%@",[[zhaoStr substringToIndex:1] intValue] != 0 ? [NSString stringWithFormat:@"%@仟",arr[[[zhaoStr substringToIndex:1] intValue]]]:@"零",[[zhaoStr substringWithRange:NSMakeRange(1, 1)] intValue] != 0 ? [NSString stringWithFormat:@"%@佰",arr[[[zhaoStr substringWithRange:NSMakeRange(1, 1)] intValue]]]:@"零",[[zhaoStr substringWithRange:NSMakeRange(2, 1)] intValue] != 0 ? [NSString stringWithFormat:@"%@拾",arr[[[zhaoStr substringWithRange:NSMakeRange(2, 1)] intValue]]]:@"零",arr[[[zhaoStr substringFromIndex:3] intValue]]];
    for (int k = 0; k < 3; k++) {
        hanziZhaoStr = [hanziZhaoStr stringByReplacingOccurrencesOfString:@"零零" withString:@"零"];
    }
    if ([hanziZhaoStr hasSuffix:@"零"]) {
        if (hanziZhaoStr.length - 1 == 0) {
            hanziZhaoStr = @"";
        }
        else{
            hanziZhaoStr = [hanziZhaoStr substringToIndex:hanziZhaoStr.length-1];
        }
    }
    if ([hanziZhaoStr length] > 0) {
        [hanziStr appendString:hanziZhaoStr];
        [hanziStr appendString:@"兆"];
    }

    NSString* yiStr = [yuanStrAfterAdd0 substringWithRange:NSMakeRange(4,4)];
    NSString* hanziYiStr = [NSString stringWithFormat:@"%@%@%@%@",[[yiStr substringToIndex:1] intValue] != 0 ? [NSString stringWithFormat:@"%@仟",arr[[[yiStr substringToIndex:1] intValue]]]:@"零",[[yiStr substringWithRange:NSMakeRange(1, 1)] intValue] != 0 ? [NSString stringWithFormat:@"%@佰",arr[[[yiStr substringWithRange:NSMakeRange(1, 1)] intValue]]]:@"零",[[yiStr substringWithRange:NSMakeRange(2, 1)] intValue] != 0 ? [NSString stringWithFormat:@"%@拾",arr[[[yiStr substringWithRange:NSMakeRange(2, 1)] intValue]]]:@"零",arr[[[yiStr substringFromIndex:3] intValue]]];
    for (int k = 0; k < 3; k++) {
        hanziYiStr = [hanziYiStr stringByReplacingOccurrencesOfString:@"零零" withString:@"零"];
    }
    if ([hanziYiStr hasSuffix:@"零"]) {
        if (hanziYiStr.length - 1 == 0) {
            hanziYiStr = @"";
        }
        else{
            hanziYiStr = [hanziYiStr substringToIndex:hanziYiStr.length-1];
        }
    }
    if ([hanziYiStr length] > 0) {
        [hanziStr appendString:hanziYiStr];
        [hanziStr appendString:@"亿"];
    }

    NSString* wanStr = [yuanStrAfterAdd0 substringWithRange:NSMakeRange(8,4)];
    NSString* hanziWanStr = [NSString stringWithFormat:@"%@%@%@%@",[[wanStr substringToIndex:1] intValue] != 0 ? [NSString stringWithFormat:@"%@仟",arr[[[wanStr substringToIndex:1] intValue]]]:@"零",[[wanStr substringWithRange:NSMakeRange(1, 1)] intValue] != 0 ? [NSString stringWithFormat:@"%@佰",arr[[[wanStr substringWithRange:NSMakeRange(1, 1)] intValue]]]:@"零",[[wanStr substringWithRange:NSMakeRange(2, 1)] intValue] != 0 ? [NSString stringWithFormat:@"%@拾",arr[[[wanStr substringWithRange:NSMakeRange(2, 1)] intValue]]]:@"零",arr[[[wanStr substringFromIndex:3] intValue]]];
    for (int k = 0; k < 3; k++) {
        hanziWanStr = [hanziWanStr stringByReplacingOccurrencesOfString:@"零零" withString:@"零"];
    }
    if ([hanziWanStr hasSuffix:@"零"]) {
        if (hanziWanStr.length - 1 == 0) {
            hanziWanStr = @"";
        }
        else{
            hanziWanStr = [hanziWanStr substringToIndex:hanziWanStr.length-1];
        }
    }
    if ([hanziWanStr length] > 0) {
        [hanziStr appendString:hanziWanStr];
        [hanziStr appendString:@"万"];
    }

    NSString* geStr = [yuanStrAfterAdd0 substringWithRange:NSMakeRange(12,4)];
    NSString* hanziGeStr = [NSString stringWithFormat:@"%@%@%@%@",[[geStr substringToIndex:1] intValue] != 0 ? [NSString stringWithFormat:@"%@仟",arr[[[geStr substringToIndex:1] intValue]]]:@"零",[[geStr substringWithRange:NSMakeRange(1, 1)] intValue] != 0 ? [NSString stringWithFormat:@"%@佰",arr[[[geStr substringWithRange:NSMakeRange(1, 1)] intValue]]]:@"零",[[geStr substringWithRange:NSMakeRange(2, 1)] intValue] != 0 ? [NSString stringWithFormat:@"%@拾",arr[[[geStr substringWithRange:NSMakeRange(2, 1)] intValue]]]:@"零",arr[[[geStr substringFromIndex:3] intValue]]];
    for (int k = 0; k < 3; k++) {
        hanziGeStr = [hanziGeStr stringByReplacingOccurrencesOfString:@"零零" withString:@"零"];
    }
    if ([hanziGeStr hasSuffix:@"零"]) {
        if (hanziGeStr.length - 1 == 0) {
            hanziGeStr = @"";
        }
        else{
            hanziGeStr = [hanziGeStr substringToIndex:hanziGeStr.length-1];
        }
    }
    if ([hanziGeStr length] > 0) {
        [hanziStr appendString:hanziGeStr];
    }
    NSString* returnHanziStr = hanziStr;

    if ([hanziStr hasPrefix:@"零"]) {
        returnHanziStr = [hanziStr substringFromIndex:1];
    }
    if (returnHanziStr.length > 0) {
        returnHanziStr = [NSString stringWithFormat:@"%@元",returnHanziStr];
    }

    if ([[jiaoAndFenStrAfterAdd0 substringWithRange:NSMakeRange(1,1)] intValue] != 0) {
        NSString* JiaoFen = [NSString stringWithFormat:@"%@%@分",[[jiaoAndFenStrAfterAdd0 substringToIndex:1] intValue] != 0 ? [NSString stringWithFormat:@"%@角",arr[[[jiaoAndFenStrAfterAdd0 substringToIndex:1] intValue]]]:@"零",arr[[[jiaoAndFenStrAfterAdd0 substringWithRange:NSMakeRange(1,1)] intValue]]];
        NSString* realStr = [NSString stringWithFormat:@"%@%@",returnHanziStr,JiaoFen];
        if ([realStr hasPrefix:@"零"]) {
            realStr = [realStr substringFromIndex:1];
        }
        return realStr;
    } else {
        NSString* Jiao = [[jiaoAndFenStrAfterAdd0 substringToIndex:1] intValue] != 0 ? [NSString stringWithFormat:@"%@角",arr[[[jiaoAndFenStrAfterAdd0 substringToIndex:1] intValue]]]:returnHanziStr.length>0 ? @"整":@"";
        return [NSString stringWithFormat:@"%@%@",returnHanziStr,Jiao];
    }
}

- (NSString *)stringByURLEncoded {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

- (NSString *)stringByURLDecoded {
    return [self stringByRemovingPercentEncoding];
}

#pragma mark - 根据字符串得到相关数据

- (CGSize)stringSizeWithSize:(CGSize)size font:(UIFont *)font {
    
    return [self boundingRectWithSize:size
                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:@{NSFontAttributeName:font}
                              context:nil].size;
}

@end
