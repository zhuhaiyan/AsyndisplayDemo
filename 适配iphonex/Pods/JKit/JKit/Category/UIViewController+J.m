//
//  UIViewController+J.m
//  JKitDemo
//
//  Created by elongtian on 16/1/6.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "UIViewController+J.h"
#import <objc/runtime.h>

@implementation UIViewController (J)

- (void)j_getCode:(UIButton *)sender {
    UIButton *btn = (UIButton *)sender;
    btn.enabled = NO;
    __block int timeout = 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout == 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [btn setTitle:@"再次发送" forState:UIControlStateNormal];
                btn.enabled = YES;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                timeout --;
                [btn setTitle:[NSString stringWithFormat:@"%d秒后重发",timeout] forState:UIControlStateNormal];
                
            });
            
        }
    });
    dispatch_resume(_timer);
}

#pragma mark 触摸自动隐藏键盘

- (void)j_tapDismissKeyboard
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    UITapGestureRecognizer *singleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(j_tapAnywhereToDismissKeyboard:)];
    
    __weak UIViewController *weakSelf = self;
    
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    
    [nc addObserverForName:UIKeyboardWillShowNotification object:nil queue:mainQuene usingBlock:^(NSNotification *note) {
        
        [weakSelf.view addGestureRecognizer:singleTapGR];
    }];
    
    [nc addObserverForName:UIKeyboardWillHideNotification object:nil queue:mainQuene usingBlock:^(NSNotification *note) {
        
        [weakSelf.view removeGestureRecognizer:singleTapGR];
    }];
}

- (void)j_tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}

#pragma mark -navBar创建titleView
- (void)j_createNavBarTitleView:(UIView *)titleView{
    self.navigationItem.titleView = titleView;
}
#pragma mark -navBar创建leftView

- (void)j_createNavBarLeftView:(UIView *)leftView{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftView];
}
#pragma mark -navBar创建rightView

- (void)j_createNavBarRightView:(UIView *)rightView{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
}
#pragma mark -navBar创建backView

- (void)j_createNavBarBackView:(UIView *)backView{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backView];
}

@end



@implementation UINavigationController (ShouldPopOnBackButton)

/**
 *  感谢https://github.com/onegray/UIViewController-BackButtonHandler
 */
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    if (self.viewControllers.count < navigationBar.items.count) {
        
        return YES;
    }
    
    BOOL shouldPop = YES;
    
    UIViewController *viewController = self.topViewController;
    
    if ([viewController respondsToSelector:@selector(j_navigationShouldPopOnBackButton)]) {
        
        shouldPop = [viewController j_navigationShouldPopOnBackButton];
    }
    
    if (shouldPop) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
        
    } else {
        
        for (UIView *subView in [navigationBar subviews]) {
            
            if (subView.alpha < 1.0) {
                
                [UIView animateWithDuration:0.25 animations:^{
                    subView.alpha = 1.0;
                }];
            }
        }
    }
    
    return NO;
}



@end