//
//  UITabBarController+J.m
//  JKitDemo
//
//  Created by elongtian on 16/1/28.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "UITabBarController+J.h"

@implementation UITabBarController (J)
- (void)makeTabBarHidden:(BOOL)hidden{
    if ([self.view.subviews count] < 2){
        return;
    }
    
    UIView *contentView;
    if ([[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]]){
        contentView = [self.view.subviews objectAtIndex:1];
    }
    else{
        contentView = [self.view.subviews objectAtIndex:0];
    }
    if (hidden){
        contentView.frame = self.view.bounds;
    }
    else{
        contentView.frame = CGRectMake(self.view.bounds.origin.x,
                                       self.view.bounds.origin.y,
                                       self.view.bounds.size.width,
                                       self.view.bounds.size.height - self.tabBar.frame.size.height);
    }
    
    self.tabBar.hidden = hidden;
}
@end
