//
//  UITextField+HKKit.h
//  HKBaseClasses
//
//  Created by hooyking on 2020/6/8.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (HKKit)

typedef NS_ENUM(NSInteger,HKInputType) {
    HKInputTypeDefault = 0,        //默认
    HKInputTypeIntegerNumber = 1,  //只许输入整数型
    HKInputTypeNumber = 2,         //只许输入数值型（整数与浮点数）
    
};

#pragma mark - Limit

/**
 textField最大输入字数（含）
 */
@property (nonatomic, assign) NSInteger maxWords;

/**
 textField输入类型
*/
@property (nonatomic, assign) HKInputType inputType;

/**
 textField是否允许含有emoji
*/
@property (nonatomic, assign) BOOL notAllowEmoji;

/**
 当前选中的range
 */
- (NSRange)selectedRange;

@end

NS_ASSUME_NONNULL_END
