//
//  UITextField+J.m
//  JKitDemo
//
//  Created by elongtian on 16/1/6.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "UITextField+J.h"

@implementation UITextField (J)
#pragma mark 限制输入长度

- (void)j_limitLength:(NSUInteger)length
{
    NSOperationQueue *mainQuene = [NSOperationQueue mainQueue];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidChangeNotification object:nil queue:mainQuene usingBlock:^(NSNotification *note) {
        
        if (self.text.length > length && !self.markedTextRange) {
            
            self.text = [self.text substringWithRange: NSMakeRange(0, length)];
        }
    }];
}@end
