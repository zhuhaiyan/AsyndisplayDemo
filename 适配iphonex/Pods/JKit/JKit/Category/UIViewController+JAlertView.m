//
//  UIViewController+JAlertView.m
//  JKitDemo
//
//  Created by Zebra on 16/5/17.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "UIViewController+JAlertView.h"
#import <objc/runtime.h>
#import "JKit.h"

@interface UIViewController ()
@property (nonatomic, strong)dispatch_block_t block;

@property (nonatomic, strong)NSString *allowPlayCount;

@end

static char const JBlockKey, JAllowPlayCountKey;

@implementation UIViewController (JAlertView)

- (void)setBlock:(dispatch_block_t)block{
    objc_setAssociatedObject(self, &JBlockKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
-(dispatch_block_t)block{
    return objc_getAssociatedObject(self, &JBlockKey);
}

- (void)setAllowPlayCount:(NSString *)allowPlayCount{
    objc_setAssociatedObject(self, &JAllowPlayCountKey, allowPlayCount, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)allowPlayCount{
    return objc_getAssociatedObject(self, &JAllowPlayCountKey);
}

- (void)j_isAllowPlay:(BOOL)isAllowPlay{
    if (isAllowPlay) {
        self.allowPlayCount = @"1";
    }else{
        self.allowPlayCount = @"0";
    }
}

- (void)j_showAlert:(NSString *)message{
    
    if ([self.allowPlayCount integerValue] == 1 || [self.allowPlayCount integerValue] == 0) {
        if ([self.allowPlayCount integerValue] == 1) {
            self.allowPlayCount = @"2";
        }
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        
        [alertView show];
        
        
        __block int timeout = 1; //倒计时时间
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout == 0){ //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [alertView dismissWithClickedButtonIndex:0 animated:YES];
                });
            }else{
                timeout --;
            }
        });
        dispatch_resume(_timer);
    }
}

- (void)j_showAlert:(NSString *)message andBlock:(dispatch_block_t)block{
    
    if ([self.allowPlayCount integerValue] == 1 || [self.allowPlayCount integerValue] == 0) {
        if ([self.allowPlayCount integerValue] == 1) {
            self.allowPlayCount = @"2";
        }
        self.block = block;
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        if(message){
            [alertView show];
        }
        
        
        __block int timeout = 1; //倒计时时间
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout == 0){ //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    JBlock(self.block);
                    [alertView dismissWithClickedButtonIndex:0 animated:YES];

                });
            }else{
                timeout --;
            }
        });
        dispatch_resume(_timer);
    }
}
@end
