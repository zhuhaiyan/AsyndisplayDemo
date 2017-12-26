//
//  JPageControl.m
//  JKitDemo
//
//  Created by elongtian on 16/1/19.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "JPageControl.h"

@implementation JPageControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame { // 初始化
    self = [super initWithFrame:frame];
    return self;
}
- (void)setImagePageStateNormal:(UIImage *)image {  // 设置正常状态点按钮的图片
    _imagePageStateHighlighted = image;
    [self updateDots];
}
- (void)setImagePageStateHighlighted:(UIImage *)image { // 设置高亮状态点按钮图片
    _imagePageStateNormal = image;
    [self updateDots];
}
- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event { // 点击事件
    [super endTrackingWithTouch:touch withEvent:event];
    [self updateDots];
}
- (void)updateDots { // 更新显示所有的点按钮
    if (_imagePageStateNormal || _imagePageStateHighlighted)
    {
        NSArray *subview = self.subviews;  // 获取所有子视图
        for (NSInteger i = 0; i < [subview count]; i++)
        {
            UIImageView *dot = [subview objectAtIndex:i];  // 以下不解释, 看了基本明白
            dot.image = self.currentPage == i ? _imagePageStateNormal : _imagePageStateHighlighted;
        }
    }
}
- (void)dealloc { // 释放内存
    _imagePageStateNormal = nil;
    _imagePageStateHighlighted = nil;
}
@end
