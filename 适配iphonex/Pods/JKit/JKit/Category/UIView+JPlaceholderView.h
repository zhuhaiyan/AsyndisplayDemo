//
//  UIView+JPlaceholderView.h
//  PrivateDoctorUser
//
//  Created by Zebra on 16/9/12.
//  Copyright © 2016年 Zebra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPlaceholderView.h"

@interface UIView (JPlaceholderView)

@property (strong, nonatomic) JPlaceholderView *j_placeholderView;

- (void)j_showPlaceholderInitWithBackgroundColor:(UIColor *)color imageName:(NSString *)imageName andTitle:(NSString *)title andRefresBlock:(dispatch_block_t)block;

- (void)j_showPlaceholderInitWithBackgroundColor:(UIColor *)color imageName:(NSString *)imageName andTitle:(NSString *)title andFrame:(CGRect)frame andRefresBlock:(dispatch_block_t)block;

- (void)j_showPlaceholderInitWithImageName:(NSString *)imageName andTitle:(NSString *)title andRefresBlock:(dispatch_block_t)block;

- (void)j_showPlaceholderInitWithImageName:(NSString *)imageName andTitle:(NSString *)title andFrame:(CGRect)frame andRefresBlock:(dispatch_block_t)block;

- (void)j_hidePlaceholder;

@end
