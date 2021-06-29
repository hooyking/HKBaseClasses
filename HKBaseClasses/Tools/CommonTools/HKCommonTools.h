//
//  HKCommonTools.h
//  HKBaseClasses
//
//  Created by hooyking on 2020/5/18.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HKCommonTools : NSObject

/**
 判断字符串是否为空
 
 @param string 传入的字符串
 
 @return YES 空，NO 非空
 */
+ (BOOL)isEmptyWithString:(NSString *)string;

/**
 使用runtime获取对象的属性
 
 @param object 传入的对象
 
 @return 对象的属性数组
 */
+ (NSArray *)getPropertiesFromObject:(id)object;

/**
 使用runtime将模型转为字典
 
 @param model 传入的模型
 
 @return 模型转成的字典
 */
+ (NSDictionary *)dictionaryBeConvertWithModel:(NSObject *)model;

/**
 app内跳转url
 
 @param string 传入的urlString
 */
+ (void)applicationOpenURLString:(NSString *)string;

/**
 json转string
 
 @param object 传入的对象
 
 @return 对象转成的string
 */
+ (NSString *)stringBeConvertWithJSONObject:(id)object;

/**
 string转json对象
 
 @param jsonString 传入的string对象
 
 @return jsonString转成的对象
 */
+ (id)objectBeConvertWithJsonString:(NSString *)jsonString;

/**
 设置attribureString
 
 @param string 传入的string
 @param attributes attribute属性
 @param range 范围
 
 @return mutableAttributrdString
 */
+ (NSMutableAttributedString *)setAttributeString:(NSString *)string
                                       attributes:(NSDictionary *)attributes
                                            range:(NSRange)range;

/**
 检查当前version是否需要更新
 
 @param nowVersion 当前版本
 @param newVersion 新版本
 
 @return YES即需要更新，NO则不需要
 */
+ (BOOL)shouldUpdateNowVersion:(NSString *)nowVersion newVersion:(NSString *)newVersion;

@end

NS_ASSUME_NONNULL_END
