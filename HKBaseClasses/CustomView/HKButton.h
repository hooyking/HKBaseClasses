//
//  HKButton.h
//  HKBaseClasses
//
//  Created by hooyking on 2020/7/3.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HKButtonStyleType) {
    HKButtonStyleTypeImageLeftTitleRight = 0,   //图片在左, 文字在右
    HKButtonStyleTypeImageRightTitleLeft = 1,   //图片在右, 文字在左
    HKButtonStyleTypeImageTopTitleBottom = 2,   //图片在上, 文字在下
    HKButtonStyleTypeImageBottomTitleTop = 3    //图片在下, 文字在上
};

@interface HKButton : UIButton

/**
 按钮上图片文字位置类型
 */
@property (nonatomic, assign) HKButtonStyleType buttonStyleType;

/**
 图片文字间距
 */
@property (nonatomic, assign) CGFloat space;

@end

NS_ASSUME_NONNULL_END
