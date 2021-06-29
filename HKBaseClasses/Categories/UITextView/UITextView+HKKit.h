//
//  UITextView+HKKit.h
//  HKBaseClasses
//
//  Created by hooyking on 2020/6/8.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (HKKit)

/**
 textField最大输入字数（含）
 */
@property (nonatomic, assign) NSInteger maxWords;

/**
 placeholderTextView
 */
@property (nonatomic, strong) UITextView *placeholderTextView;

/**
 textView占位符
 */
@property (nonatomic, copy) NSString *placeholderText;

/**
 textView是否允许含有emoji
*/
@property (nonatomic, assign) BOOL notAllowEmoji;

@end

NS_ASSUME_NONNULL_END
