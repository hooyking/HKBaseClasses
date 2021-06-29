//
//  UITextField+HKKit.m
//  HKBaseClasses
//
//  Created by hooyking on 2020/6/8.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import "UITextField+HKKit.h"
#import <objc/runtime.h>

static const void *TextFieldInputLimitMaxWords = &TextFieldInputLimitMaxWords;
static const void *TextFieldInputType = &TextFieldInputType;
static const void *TextFieldNotAllowEmoji = &TextFieldNotAllowEmoji;

@implementation UITextField (HKKit)

#pragma mark - Limit

- (NSInteger)maxWords {
    return [objc_getAssociatedObject(self, TextFieldInputLimitMaxWords) integerValue];
}

- (void)setMaxWords:(NSInteger)maxWords {
    objc_setAssociatedObject(self, TextFieldInputLimitMaxWords, @(maxWords), OBJC_ASSOCIATION_ASSIGN);
    [self addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (HKInputType)inputType {
    return [objc_getAssociatedObject(self, TextFieldInputType) integerValue];
}

- (void)setInputType:(HKInputType)inputType {
    objc_setAssociatedObject(self, TextFieldInputType, @(inputType), OBJC_ASSOCIATION_ASSIGN);
    [self addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (BOOL)notAllowEmoji {
    return [objc_getAssociatedObject(self, TextFieldNotAllowEmoji) boolValue];
}

- (void)setNotAllowEmoji:(BOOL)notAllowEmoji {
    objc_setAssociatedObject(self, TextFieldNotAllowEmoji, @(notAllowEmoji), OBJC_ASSOCIATION_ASSIGN);
    [self addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldChanged:(UITextField *)textField {
    if (self.maxWords > 0) {
        if (textField.text.length > self.maxWords) {
            textField.text = [textField.text substringToIndex:self.maxWords];
        }
    }
    if (self.notAllowEmoji && [textField.text isContainsEmoji]) {
        textField.text = [textField.text removeEmojiString];
    }
    switch (self.inputType) {
        case HKInputTypeDefault:
            
            break;
            
        case HKInputTypeIntegerNumber:{
            for (int i = 0; i < textField.text.length; i++) {
                unichar single = [textField.text characterAtIndex:i];
                if (!(single >= '0' && single <= '9')) {
                    textField.text = [textField.text substringToIndex:i];
                    break;
                }
            }
        }
            break;
            
        case HKInputTypeNumber:{
            BOOL hasPoint = NO;
            for (int i = 0; i < textField.text.length; i++) {
                unichar single = [textField.text characterAtIndex:i];
                if (single == '.' && i == 0) {
                    textField.text = nil;
                    break;
                }
                if (single == '.' && i != 0 && hasPoint) {
                    textField.text = [textField.text substringToIndex:i];
                }
                if (single == '.') {
                    hasPoint = YES;
                }
                if (!((single >= '0' && single <= '9') || single == '.')) {
                    textField.text = [textField.text substringToIndex:i];
                    break;
                }
            }
        }
            break;
            
        default:
            break;
    }
}

- (NSRange)selectedRange {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextRange *selectedRange = self.selectedTextRange;
    UITextPosition *selectionStart = selectedRange.start;
    UITextPosition *selectionEnd = selectedRange.end;
    
    NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}

@end
