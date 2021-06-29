//
//  UIImage+HKKit.h
//  HKBaseClasses
//
//  Created by hooyking on 2020/6/8.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (HKKit)

/**
 根据指定尺寸得出新的image
 
 @param size 新的图片size
 
 @return 新的image
 */
- (UIImage *)drawImageWithSize:(CGSize)size;

/**
 通过指定图片最长边，获得等比例的图片
 
 @param maxValue 边长最大值
 @param finishBlock 图片block（包含图片及尺寸）
 */
- (void)drawImageWithMaxValue:(CGFloat)maxValue finishBlock:(void(^)(UIImage *resultImage, CGSize resultSize))finishBlock;

/**
 压缩图片到指定大小（这儿上传到服务器时用jpeg格式，图片大小才不会变）
 
 @param width 目标宽
 @param length 目标大小（单位B）
 @param accuracy 精确度（单位B）
 
 @return 压缩后的图片二进制数据
 */
- (NSData *)compressImageWithAimWidth:(CGFloat)width
                            aimLength:(NSInteger)length
                     accuracyOfLength:(NSInteger)accuracy;

/**
 合并多张图片
 
 @param images 待合并图片数组
 @param finishBlock 合并完成block（含最终生成的图片和此图大小）
 */
+ (void)mergeImages:(nonnull NSArray <UIImage *> *)images finishBlock:(void(^)(UIImage *resultImage, CGSize resultSize))finishBlock;

@end

NS_ASSUME_NONNULL_END
