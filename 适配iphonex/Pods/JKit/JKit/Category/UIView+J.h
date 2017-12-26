//
//  UIView+J.h
//  JKitDemo
//
//  Created by elongtian on 16/1/6.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^j_TapGestureBlock)(UITapGestureRecognizer *gestureRecognizer);
typedef void(^j_LongPressGestureBlock)(UILongPressGestureRecognizer *gestureRecognizer);
typedef void(^j_PanGestureBlock)(UIPanGestureRecognizer *gestureRecognizer);

@interface UIView (J)
#pragma mark - frame

@property (nonatomic, assign) CGPoint j_origin;
@property (nonatomic, assign) CGSize j_size;

@property (nonatomic) CGFloat j_width;
@property (nonatomic) CGFloat j_height;

@property (nonatomic) CGFloat j_centerX;
@property (nonatomic) CGFloat j_centerY;

@property (nonatomic) CGFloat j_top;
@property (nonatomic) CGFloat j_bottom;
@property (nonatomic) CGFloat j_left;
@property (nonatomic) CGFloat j_right;

/**
 *  画虚线
 *
 *  @param lineLength  虚线的宽度
 *  @param lineSpacing 虚线的间距
 *  @param lineColor   虚线的颜色
 */
- (void)j_drawDashLineWithLineLength:(int)lineLength andLineSpacing:(int)lineSpacing andLineColor:(UIColor *)lineColor;

#pragma mark - TapGesture

/**
 *  TapGesture回调
 *
 *  @param panAction j_TapGestureBlock
 *
 *  @return UITapGestureRecognizer
 */
- (UITapGestureRecognizer *)j_addTapGesture:(j_TapGestureBlock)tapAction;

/**
 *  LongPressGesture回调
 *
 *  @param panAction j_LongPressGestureBlock
 *
 *  @return UILongPressGestureRecognizer
 */
- (UILongPressGestureRecognizer *)j_addLongPressGesture:(j_LongPressGestureBlock)longPressAction;

/**
 *  PanGesture回调
 *
 *  @param panAction j_GestureBlock
 *
 *  @return UIPanGestureRecognizer
 */
- (UIPanGestureRecognizer *)j_addPanGesture:(j_PanGestureBlock)panAction;
@end
