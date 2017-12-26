//
//  UIViewController+J.h
//  JKitDemo
//
//  Created by elongtian on 16/1/6.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JBackButtonHandlderProtocol <NSObject>

@optional

/**
 *  获取验证码倒计时
 *
 *  @param sender 点击的btn
 */
- (void)j_getCode:(UIButton *)sender;
/**
 *  重写此方法处理返回按钮
 *
 *  @return YES:返回,NO:不返回
 */
- (BOOL)j_navigationShouldPopOnBackButton;

@end
@interface UIViewController (J)<JBackButtonHandlderProtocol>
/**
 *  触摸自动隐藏键盘
 */
- (void)j_tapDismissKeyboard;
/**
 *  创建navBar上的titleView
 *
 *  @param titleView titleView
 */
- (void)j_createNavBarTitleView:(UIView *)titleView;
/**
 *  创建navBar上的leftView
 *
 *  @param leftView leftView
 */
- (void)j_createNavBarLeftView:(UIView *)leftView;
/**
 *  创建navBar上的rightView
 *
 *  @param rightView rightView
 */
- (void)j_createNavBarRightView:(UIView *)rightView;
/**
 *  创建navBar上的backView
 *
 *  @param backView backView
 */
- (void)j_createNavBarBackView:(UIView *)backView;
@end
