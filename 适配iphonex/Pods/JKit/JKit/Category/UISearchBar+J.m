//
//  UISearchBar+J.m
//  JKitDemo
//
//  Created by elongtian on 16/1/6.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "UISearchBar+J.h"
#import "JMacro.h"
#import "UIColor+J.h"
@implementation UISearchBar (J)

- (void)j_backgroundColor:(UIColor *)backgroundColor
{
    static NSInteger backgroundTag = 99999;
    
    UIView *view = [[self subviews] firstObject];
    
    [[view subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        
        if (obj.tag == backgroundTag) {
            
            [obj removeFromSuperview];
        }
    }];
    
    if (backgroundColor) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = JColorWithHex(0xda2c4e);

        imageView.frame = CGRectMake(0, -20, JScreenWidth, JScreenHeight + 20);
        imageView.tag = backgroundTag;
        
        [[[self subviews] firstObject] insertSubview:imageView atIndex:1];
    }
}

@end
