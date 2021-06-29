//
//  HKCommonTools.m
//  HKBaseClasses
//
//  Created by hooyking on 2020/5/18.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import "HKCommonTools.h"
#import <objc/runtime.h>

@implementation HKCommonTools

+ (BOOL)isEmptyWithString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    } else if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    } else if ([string length] == 0) {
        return YES;
    }
    return NO;
}

+ (NSArray *)getPropertiesFromObject:(id)object {
    u_int count;
    objc_property_t *properties = class_copyPropertyList([object class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        const char *propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;
}

+ (NSDictionary *)dictionaryBeConvertWithModel:(NSObject *)object {
    if ([object isKindOfClass:[UIViewController class]]) {
        @throw [NSException exceptionWithName:@"模型转字典抛出异常" reason:@"模型转字典只适用于Model，不可传入viewController" userInfo:nil];
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([object class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:cName];
        NSObject *value = [object valueForKey:name];//valueForKey返回的数字和字符串都是对象
        if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
            //string , bool, int ,NSinteger
            [dic setObject:value forKey:name];
        } else if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
            //字典或数组
            [dic setObject:[self arrayOrDicWithObject:(NSArray *)value] forKey:name];
        } else if (value == nil) {
            //什么都不做
        } else {
            //model
            [dic setObject:[self dictionaryBeConvertWithModel:value] forKey:name];
        }
    }
    return [dic copy];
}

+ (id)arrayOrDicWithObject:(id)origin {
    if ([origin isKindOfClass:[NSArray class]]) {
        //数组
        NSMutableArray *array = [NSMutableArray array];
        for (NSObject *object in origin) {
            if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]]) {
                //string , bool, int ,NSinteger
                [array addObject:object];
            } else if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]]) {
                //数组或字典
                [array addObject:[self arrayOrDicWithObject:(NSArray *)object]];
            } else {
                //model
                [array addObject:[self dictionaryBeConvertWithModel:object]];
            }
        }
        return [array copy];
    } else if ([origin isKindOfClass:[NSDictionary class]]) {
        NSDictionary *originDic = (NSDictionary *)origin;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        for (NSString *key in originDic.allKeys) {
            id object = [originDic objectForKey:key];
            if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]]) {
                //string , bool, int ,NSinteger
                [dic setObject:object forKey:key];
            } else if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]]) {
                //数组或字典
                [dic setObject:[self arrayOrDicWithObject:object] forKey:key];
            } else {
                //model
                [dic setObject:[self dictionaryBeConvertWithModel:object] forKey:key];
            }
        }
        return [dic copy];
    }
    return [NSNull null];
}

+ (void)applicationOpenURLString:(NSString *)string {
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]
                                           options:@{UIApplicationOpenURLOptionsSourceApplicationKey:@YES}
                                 completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
    }
}

+ (NSString *)stringBeConvertWithJSONObject:(id)object {
    if (!object || [object isKindOfClass:[NSNull class]]) {
        return NULL;
    }
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = @"";
    if (!jsonData) {
        HKLog(@"JSON对象转String错误: %@", error);
    }else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return jsonString;
}

+ (id)objectBeConvertWithJsonString:(NSString *)jsonString {
    if (jsonString.length == 0) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    id object = [NSJSONSerialization JSONObjectWithData:jsonData
                                                options:NSJSONReadingMutableContainers
                                                  error:&error];
    if(error) {
        HKLog(@"string转JSON对象错误：%@",error);
        return nil;
    }
    return object;
}

+ (NSMutableAttributedString *)setAttributeString:(NSString *)string
                                attributes:(NSDictionary *)attributes
                                     range:(NSRange)range {
    
    NSMutableAttributedString *mAttributeString = [[NSMutableAttributedString alloc] initWithString:string];
    [mAttributeString addAttributes:attributes range:range];
    return mAttributeString;
}

+ (BOOL)shouldUpdateNowVersion:(NSString *)nowVersion newVersion:(NSString *)newVersion {
   NSComparisonResult result = [newVersion compare:nowVersion options:NSNumericSearch];
   switch (result) {
       case NSOrderedDescending:
           return YES;
           
       default:
           return NO;
   }
}

@end
