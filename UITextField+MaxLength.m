//
//  UITextField+MaxLength.m
//  
//
//  Created by Chaos on 15/8/5.
//  Copyright (c) 2015年 Chaos. All rights reserved.
//

#import "UITextField+MaxLength.h"
#import <objc/runtime.h>

static char kMaxLength;

@interface UItextFieldMaxLengthObserver : NSObject

@end

@implementation UItextFieldMaxLengthObserver

- (void)textChange:(UITextField *)textField {
    NSString *destText = textField.text;
    NSUInteger maxLength = textField.maxLength;
    
    // 对中文的特殊处理，shouldChangeCharactersInRangeWithReplacementString 并不响应中文输入法的选择事件
    // 如拼音输入时，拼音字母处于选中状态，此时不判断是否超长
    UITextRange *selectedRange = [textField markedTextRange];
    if (!selectedRange || !selectedRange.start) {
        if (destText.length > maxLength) {
            textField.text = [destText substringToIndex:maxLength];
        }
    }
}


@end

static UItextFieldMaxLengthObserver *observer;

@implementation UITextField (MaxLength)

@dynamic maxLength;

+ (void)load {
    observer = [[UItextFieldMaxLengthObserver alloc] init];
}


- (void)setMaxLength:(NSUInteger)maxLength {
    objc_setAssociatedObject(self, &kMaxLength, @(maxLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (maxLength) {
        [self addTarget:observer
                 action:@selector(textChange:)
       forControlEvents:UIControlEventEditingChanged];
    }
}

-(NSUInteger)maxLength {
    NSNumber *number = objc_getAssociatedObject(self, &kMaxLength);
    return [number integerValue];
}

@end