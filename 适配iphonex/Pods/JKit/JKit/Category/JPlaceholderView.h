//
//  JPlaceholderView.h
//  JKitDemo
//
//  Created by Zebra on 16/4/11.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPlaceholderView : UIView

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UITextView *descriptionTextView;

- (void)j_showViewWithImageName:(NSString *)imageName andTitle:(NSString *)title;

- (void)j_hide;

@property (nonatomic, strong) NSAttributedString *titleAttributedText;

//- (void)setImageViewFrame:(CGRect)frame;

@end
