//
//  JPlaceholderView.m
//  JKitDemo
//
//  Created by Zebra on 16/4/11.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "JPlaceholderView.h"
#import "JKit.h"

@interface JPlaceholderView ()

@end
@implementation JPlaceholderView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self commonInit];
}

- (void)commonInit
{
    self.backgroundColor = [UIColor clearColor];
    
    for (UIView *view in self.subviews) {
        
        [view removeFromSuperview];
    }
    
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeCenter;
    _imageView.alpha = 0.0f;
    
    [self addSubview:_imageView];
    
    _descriptionTextView = [[UITextView alloc] init];
    [_descriptionTextView setUserInteractionEnabled:NO];
    [_descriptionTextView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    _descriptionTextView.backgroundColor = JColorWithClear;
    
    [self addSubview:_descriptionTextView];
    
    [_descriptionTextView layoutIfNeeded];
}

- (void)j_showViewWithImageName:(NSString *)imageName andTitle:(NSString *)title
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    _imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    
    _imageView.image = [UIImage imageNamed:imageName];
    
    _imageView.center = CGPointMake(self.frame.size.width /2, self.frame.size.height / 2 - image.size.height / 2);
    
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    
    style.alignment = NSTextAlignmentCenter;
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : JColorWithHex(0x666666),
                                                                                                         NSParagraphStyleAttributeName  : style,
                                                                                                         NSBackgroundColorAttributeName : JColorWithClear,
                                                                                                         NSFontAttributeName            : [UIFont systemFontOfSize:13.0f]
                                                                                                         }];
    
    if (_titleAttributedText) {
        
        _descriptionTextView.attributedText = self.titleAttributedText;
        
    } else {
        
        _descriptionTextView.attributedText = attributedString;
    }
    
    _descriptionTextView.frame = CGRectMake(20, _imageView.frame.size.height + _imageView.frame.origin.y + 10, self.frame.size.width - 40, 10);
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.alpha = 1.0f;
        
        _descriptionTextView.alpha = 1.0f;
        _imageView.alpha = 1.0f;
        
    } completion:nil];
}

- (void)setTitleAttributedText:(NSAttributedString *)titleAttributedText {
    
    _titleAttributedText = titleAttributedText;
    
    _descriptionTextView.attributedText = titleAttributedText;
}

- (void)j_hide
{
    self.alpha = 0.0f;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _descriptionTextView.frame = CGRectMake(20, _imageView.frame.size.height + _imageView.frame.origin.y + 10, self.frame.size.width - 40, 10);
    _descriptionTextView.textColor = JColorWithHex(0x999999);
    CGFloat fixedWidth = _descriptionTextView.frame.size.width;
    CGSize newSize = [_descriptionTextView sizeThatFits:CGSizeMake(fixedWidth, 20)];
    CGRect newFrame = _descriptionTextView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    newFrame.origin = CGPointMake(newFrame.origin.x, newFrame.origin.y + 10);
    _descriptionTextView.frame = newFrame;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

