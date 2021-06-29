//
//  UIImage+HKKit.m
//  HKBaseClasses
//
//  Created by hooyking on 2020/6/8.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import "UIImage+HKKit.h"

@implementation UIImage (HKKit)

- (UIImage *)drawImageWithSize:(CGSize)size {
    if (size.width <= 0 || size.height <= 0) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)drawImageWithMaxValue:(CGFloat)maxValue finishBlock:(void(^)(UIImage *resultImage, CGSize resultSize))finishBlock {
    CGFloat newWidth = 0.0f;
    CGFloat newHeight = 0.0f;
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    
    if (width > maxValue || height > maxValue) {
        if (width > height) {
            newWidth = maxValue;
            newHeight = newWidth * height / width;
        } else if (height > width) {
            newHeight = maxValue;
            newWidth = newHeight * width / height;
        } else {
            newWidth = maxValue;
            newHeight = maxValue;
        }
    } else {
        newWidth = width;
        newHeight = height;
    }
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newWidth, newHeight), NO, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    finishBlock ? finishBlock(newImage, CGSizeMake(newWidth, newHeight)) : nil;
}

- (NSData *)compressImageWithAimWidth:(CGFloat)width
                            aimLength:(NSInteger)length
                     accuracyOfLength:(NSInteger)accuracy {
    
    if (length == 0) return nil;
    UIImage *newImage = [self drawImageWithSize:CGSizeMake(width, width * self.size.height / self.size.width)];
    NSData *data = UIImageJPEGRepresentation(newImage, 1);
    NSInteger imageDataLen = [data length];

    if (imageDataLen <= length + accuracy) {
        return data;
    } else {
         NSData * imageData = UIImageJPEGRepresentation( newImage, 0.99);
         if (imageData.length < length + accuracy) {
             return imageData;
         }

         CGFloat maxQuality = 1.0;
         CGFloat minQuality = 0.0;
         int flag = 0;

         while (1) {
             CGFloat midQuality = (maxQuality + minQuality)/2;

             if (flag == 6) {
                 NSLog(@"************* %ld ******** %f *************",UIImageJPEGRepresentation(newImage, minQuality).length,minQuality);
                 return UIImageJPEGRepresentation(newImage, minQuality);
             }
             flag ++;

             NSData * imageData = UIImageJPEGRepresentation(newImage, midQuality);
             NSInteger len = imageData.length;

             if (len > length+accuracy) {
                NSLog(@"-----%d------%f------%ld-----",flag,midQuality,len);
                maxQuality = midQuality;
                continue;
            } else if (len < length-accuracy){
                NSLog(@"-----%d------%f------%ld-----",flag,midQuality,len);
                minQuality = midQuality;
                continue;
            } else{
                NSLog(@"-----%d------%f------%ld--end",flag,midQuality,len);
                return imageData;
                break;
            }
         }
     }
    
}

+ (void)mergeImages:(NSArray <UIImage *> *)images finishBlock:(void(^)(UIImage *resultImage, CGSize resultSize))finishBlock {
    CGFloat canvasHeight = 0.0;
    CGFloat lastWidth = 0.0;
    CGFloat scale = 1.0;
    NSMutableArray *widthMArray = [NSMutableArray array];
    for (int i = 0; i < images.count; i++) {
        UIImage *temImage = images[i];
        CGImageRef imageRef = temImage.CGImage;
        CGFloat width = CGImageGetWidth(imageRef);
        [widthMArray addObject:@(width)];
        lastWidth = [widthMArray.lastObject floatValue];
        if (lastWidth > kScreenW) {
            scale = kScreenW/lastWidth;
            lastWidth = kScreenW;
        }
        CGFloat height = CGImageGetHeight(imageRef)/scale;
        canvasHeight += height;
    }
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(lastWidth, canvasHeight), NO, [UIScreen mainScreen].scale);
    
    CGFloat currentHeight = 0.0;
    for (UIImage *temImage in images) {
        CGImageRef imageRef = temImage.CGImage;
        CGFloat height = CGImageGetHeight(imageRef)/scale;
        [temImage drawInRect:CGRectMake(0, currentHeight, lastWidth, height)];
        currentHeight += height;
    }
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (finishBlock) {
        finishBlock(resultImg, CGSizeMake(lastWidth, canvasHeight));
    }
}

@end
