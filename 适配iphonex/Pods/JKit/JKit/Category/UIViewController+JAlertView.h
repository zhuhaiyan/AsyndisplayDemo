//
//  UIViewController+JAlertView.h
//  JKitDemo
//
//  Created by Zebra on 16/5/17.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import <UIKit/UIKit.h>

#define JShowAlert(message) [self j_showAlert:message]

@interface UIViewController (JAlertView)

- (void)j_showAlert:(NSString *)message;

- (void)j_showAlert:(NSString *)message andBlock:(dispatch_block_t)block;

/**
 *  限制alert弹出次数
 *
 *  @param count NO 不限制 YES 限制一次
 */
- (void)j_isAllowPlay:(BOOL)isAllowPlay;
@end
