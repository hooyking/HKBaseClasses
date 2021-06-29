//
//  UITextView+HKKit.m
//  HKBaseClasses
//
//  Created by hooyking on 2020/6/8.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import "UITextView+HKKit.h"
#import <objc/runtime.h>

static const void *TextViewInputLimitMaxWords = &TextViewInputLimitMaxWords;
static const void *PlaceholderTextView = &PlaceholderTextView;
static const void *TextViewNotAllowEmoji = &TextViewNotAllowEmoji;

@implementation UITextView (HKKit)

#pragma mark - Limit

- (NSInteger)maxWords {
    return [objc_getAssociatedObject(self, TextViewInputLimitMaxWords) integerValue];
}

- (void)setMaxWords:(NSInteger)maxWords {
    objc_setAssociatedObject(self, TextViewInputLimitMaxWords, @(maxWords), OBJC_ASSOCIATION_ASSIGN);
    kNotifyAdd(textViewChanged:, UITextViewTextDidChangeNotification);
}

- (BOOL)notAllowEmoji {
    return [objc_getAssociatedObject(self, TextViewNotAllowEmoji) boolValue];
}

- (void)setNotAllowEmoji:(BOOL)notAllowEmoji {
    objc_setAssociatedObject(self, TextViewNotAllowEmoji, @(notAllowEmoji), OBJC_ASSOCIATION_ASSIGN);
    kNotifyAdd(textViewChanged:, UITextViewTextDidChangeNotification);
}

- (void)textViewChanged:(UITextView *)textView {
    if (self.maxWords > 0) {
        if (self.text.length > self.maxWords) {
            self.text = [self.text substringToIndex:self.maxWords];
        }
    }
    if (self.notAllowEmoji && [self.text isContainsEmoji]) {
        self.text = [self.text removeEmojiString];
    }
    if (self.text.length == 0) {
        self.placeholderTextView.hidden = NO;
    } else {
        self.placeholderTextView.hidden = YES;
    }
}

- (UITextView *)placeholderTextView {
    return objc_getAssociatedObject(self, PlaceholderTextView);
}

- (void)setPlaceholderTextView:(UITextView *)placeholderTextView {
    objc_setAssociatedObject(self, PlaceholderTextView, placeholderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)placeholderText {
    return self.placeholderTextView.text;
}

- (void)setPlaceholderText:(NSString *)placeholderText {
    if (!self.placeholderTextView) {
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.font = self.font;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = kUIColorFromHexString(0xc8c8ca);
        textView.userInteractionEnabled = NO;
        textView.text = placeholderText;
        [self addSubview:textView];
        [self setPlaceholderTextView:textView];
    }
    self.placeholderTextView.text = placeholderText;
}

- (void)dealloc {
    kNotifyRemove(UITextViewTextDidChangeNotification);
}

@end
