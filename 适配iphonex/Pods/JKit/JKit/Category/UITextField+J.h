//
//  UITextField+J.h
//  JKitDemo
//
//  Created by elongtian on 16/1/6.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (J)

/**
 *  限制输入长度
 *
 *  @param length 限制长度值
 */
- (void)j_limitLength:(NSUInteger)length;
@end
