//
//  UITextField+MaxLength.h
//  为 UITextField 增加 MaxLength 特性
//
//  Created by Chaos on 15/8/5.
//  Copyright (c) 2015年 Chaos. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface UITextField (MaxLength)

@property (assign, nonatomic) IBInspectable NSUInteger maxLength;

@end
