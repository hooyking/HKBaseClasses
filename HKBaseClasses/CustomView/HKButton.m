//
//  HKButton.m
//  HKBaseClasses
//
//  Created by hooyking on 2020/7/3.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import "HKButton.h"

@implementation HKButton

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat centerX = self.width * 0.5;
    CGFloat centerY = self.height * 0.5;

    CGFloat allWidth = self.imageView.width + self.titleLabel.width;
    CGFloat allHeight = self.imageView.height + self.titleLabel.height;
    
    if (self.buttonStyleType == HKButtonStyleTypeImageLeftTitleRight) {
        self.imageView.x = centerX - allWidth * 0.5 - self.space/2;
        self.titleLabel.x = CGRectGetMaxX(self.imageView.frame) + self.space;
    } else if (self.buttonStyleType == HKButtonStyleTypeImageRightTitleLeft) {
        self.titleLabel.x = centerX - allWidth * 0.5 - self.space/2;
        self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + self.space;
    } else if (self.buttonStyleType == HKButtonStyleTypeImageTopTitleBottom) {
        self.imageView.x = centerX - self.imageView.width * 0.5;
        self.imageView.y = centerY - allHeight * 0.5 - self.space/2;
        self.titleLabel.x = centerX - self.titleLabel.width * 0.5;
        self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + self.space;
    } else if (self.buttonStyleType == HKButtonStyleTypeImageBottomTitleTop) {
        self.titleLabel.x = centerX - self.titleLabel.width * 0.5;
        self.titleLabel.y = centerY - allHeight * 0.5 - self.space/2;
        self.imageView.x = centerX - self.imageView.width * 0.5;
        self.imageView.y = CGRectGetMaxY(self.titleLabel.frame) + self.space;
    }
}

@end
