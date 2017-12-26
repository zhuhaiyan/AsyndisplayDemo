//
//  JPageControl.h
//  JKitDemo
//
//  Created by elongtian on 16/1/19.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPageControl : UIPageControl
- (id)initWithFrame:(CGRect)frame;
@property (nonatomic, retain) UIImage *imagePageStateNormal;
@property (nonatomic, retain) UIImage *imagePageStateHighlighted;
@end
