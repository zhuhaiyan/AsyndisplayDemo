//
//  JTabBarButton.m
//  JKitDemo
//
//  Created by Zebra on 16/6/7.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "JTabBarButton.h"

#define kImageBiLi 0.3
#define distanceWithLableAndImageView 5

@implementation JTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - 重写了UIButton的方法
#pragma mark - 控制UILabel的位置和尺寸
// contentRect其实就是按钮的位置和尺寸
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 2.5;
    CGFloat titleHeight = contentRect.size.height * (1 - kImageBiLi) - distanceWithLableAndImageView;
    CGFloat titleY = contentRect.size.height - titleHeight+5;
    CGFloat titleWidth = contentRect.size.width;
    
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}

#pragma mark -控制UIImageView的位置和尺寸
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = (self.frame.size.width-23)/2.0;
    CGFloat imageY = 3;
    CGFloat imageWidth = 28;
    //    CGFloat imageHeight = contentRect.size.height * kImageBiLi;
    return CGRectMake(imageX, imageY, imageWidth, imageWidth);
}

@end
