//
//  UITextView+J.m
//  JKitDemo
//
//  Created by elongtian on 16/1/6.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "UITextView+J.h"
#import <objc/runtime.h>

@interface UITextView ()

@property(strong, nonatomic) UITextView * placeholderTextView;

@end

static char placeholderTextViewKey;

@implementation UITextView (J)

- (void)setPlaceholderTextView:(UITextView *)placeholderTextView {
    
    objc_setAssociatedObject(self, &placeholderTextViewKey, placeholderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITextView *)placeholderTextView {
    
    return objc_getAssociatedObject(self, &placeholderTextViewKey);
}

#pragma mark 占位提示

- (void)j_placeholder:(NSString *)j_placeholder {
    
    if (![self placeholderTextView]) {
        
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor grayColor];
        textView.userInteractionEnabled = NO;
        [self addSubview:textView];
        
        [self setPlaceholderTextView:textView];
        textView.hidden = self.text.length;
        
        NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:UITextViewTextDidChangeNotification object:nil queue:mainQuene usingBlock:^(NSNotification *note) {
            
            textView.hidden = self.text.length;
        }];
    }
    
    self.placeholderTextView.font = self.font;
    self.placeholderTextView.text = j_placeholder;
}
#pragma mark 占位提示

- (void)j_placeholder:(NSString *)j_placeholder andTextColor:(UIColor *)textColor{
    
    if (![self placeholderTextView]) {
        
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = textColor;
        textView.userInteractionEnabled = NO;
        [self addSubview:textView];
        
        [self setPlaceholderTextView:textView];
        textView.hidden = self.text.length;
        
        NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:UITextViewTextDidChangeNotification object:nil queue:mainQuene usingBlock:^(NSNotification *note) {
            
            textView.hidden = self.text.length;
        }];
    }
    
    self.placeholderTextView.font = self.font;
    self.placeholderTextView.text = j_placeholder;
}
#pragma mark 限制输入长度

- (void)j_limitLength:(NSUInteger)length
{
    NSOperationQueue *mainQuene = [NSOperationQueue mainQueue];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UITextViewTextDidChangeNotification object:nil queue:mainQuene usingBlock:^(NSNotification *note) {
        
        if (self.text.length > length && !self.markedTextRange) {
            
            self.text = [self.text substringWithRange: NSMakeRange(0, length)];
        }
    }];
}
@end
