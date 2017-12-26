//
//  UITextView+J.h
//  JKitDemo
//
//  Created by elongtian on 16/1/6.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (J)
/**
 *  限制输入长度
 *
 *  @param length 限制长度值
 */
- (void)j_limitLength:(NSUInteger)length;

/**
 *  Placeholder
 *
 *  @param placeholer 占位提示
 */
- (void)j_placeholder:(NSString *)placeholder;

/**
 *  Placeholder
 *
 *  @param j_placeholder 占位提示
 *  @param textColor     占位提示文字颜色
 */
- (void)j_placeholder:(NSString *)j_placeholder andTextColor:(UIColor *)textColor;
@end
