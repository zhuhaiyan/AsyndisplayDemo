//
//  JPagerTopTabView.h
//  JKitDemo
//
//  Created by Zebra on 16/3/31.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPagerTopTabView : UIView

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title withTitleColor:(UIColor *)titleColor withUnselectedImage:(NSString *)unselectedImage withSelectedImage:(NSString *)selectedImage ;

@property (nonatomic, strong) UIImageView *unselectedImage; /**<  未被选中时的图片   **/
@property (nonatomic, strong) UIImageView *selectedImage; /**<  被选中时的图片   **/
@property (nonatomic, strong) UILabel *title; /**<  按钮中间的标题   **/

@end
