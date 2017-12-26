//
//  UIView+J.m
//  JKitDemo
//
//  Created by elongtian on 16/1/6.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "UIView+J.h"
#import <objc/runtime.h>
@interface UIView ()

@property (copy, nonatomic) j_TapGestureBlock tapGestureAction;

@property (copy, nonatomic) j_LongPressGestureBlock longPressGestureAction;

@property (copy, nonatomic) j_PanGestureBlock panGestureAction;

@end

static char tapGestureBlockKey, longPressGestureBlockKey, panGestureBlockKey;
@implementation UIView (J)
#pragma mark - frame

- (CGPoint)j_origin {
    
    return self.frame.origin;
}

- (void)setJ_origin:(CGPoint)j_origin {
    
    CGRect frame = self.frame;
    frame.origin = j_origin;
    
    self.frame = frame;
}

- (CGSize)j_size {
    
    return self.frame.size;
}

- (void)setJ_size:(CGSize)j_size {
    
    CGRect frame = self.frame;
    frame.size = j_size;
    
    self.frame = frame;
}

- (CGFloat)j_width {
    
    return self.frame.size.width;
}

- (void)setJ_width:(CGFloat)j_width {
    
    CGRect frame = self.frame;
    frame.size.width = j_width;
    
    self.frame = frame;
}

- (CGFloat)j_height {
    
    return self.frame.size.height;
}

- (void)setJ_height:(CGFloat)j_height {
    
    CGRect frame = self.frame;
    frame.size.height = j_height;
    
    self.frame = frame;
}

- (CGFloat)j_centerX {
    
    return self.center.x;
}

- (void)setJ_centerX:(CGFloat)j_centerX {
    
    self.center = CGPointMake(j_centerX, self.center.y);
}

- (CGFloat)j_centerY {
    
    return self.center.y;
}

- (void)setJ_centerY:(CGFloat)j_centerY {
    
    self.center = CGPointMake(self.center.x, j_centerY);
}

- (CGFloat)j_top {
    
    return self.frame.origin.y;
}

- (void)setJ_top:(CGFloat)j_top {
    
    CGRect frame = self.frame;
    frame.origin.y = j_top;
    
    self.frame = frame;
}

- (CGFloat)j_bottom {
    
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setJ_bottom:(CGFloat)j_bottom {
    
    CGRect frame = self.frame;
    frame.origin.y = j_bottom - self.frame.size.height;
    
    self.frame = frame;
}

- (CGFloat)j_left {
    
    return self.frame.origin.x;
}

- (void)setJ_left:(CGFloat)j_left {
    
    CGRect frame = self.frame;
    frame.origin.x = j_left;
    
    self.frame = frame;
}

- (CGFloat)j_right {
    
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setJ_right:(CGFloat)j_right {
    
    CGRect frame = self.frame;
    frame.origin.x = j_right - self.frame.size.width;
    
    self.frame = frame;
}

#pragma mark -虚线
- (void)j_drawDashLineWithLineLength:(int)lineLength andLineSpacing:(int)lineSpacing andLineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(self.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(self.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}

#pragma mark -.-

- (void)setTapAction:(j_TapGestureBlock)tapAction {
    
    objc_setAssociatedObject(self, &tapGestureBlockKey, tapAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (j_TapGestureBlock)tapGestureAction {
    
    return objc_getAssociatedObject(self, &tapGestureBlockKey);
}

- (void)setLongPressGestureAction:(j_LongPressGestureBlock)longPressGestureAction {
    
    objc_setAssociatedObject(self, &longPressGestureBlockKey, longPressGestureAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (j_LongPressGestureBlock)longPressGestureAction {
    
    return objc_getAssociatedObject(self, &longPressGestureBlockKey);
}

- (void)setPanGestureAction:(j_PanGestureBlock)panGestureAction {
    
    objc_setAssociatedObject(self, &panGestureBlockKey, panGestureAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (j_PanGestureBlock)panGestureAction {
    
    return objc_getAssociatedObject(self, &panGestureBlockKey);
}

#pragma mark TapGesture回调

- (UITapGestureRecognizer *)j_addTapGesture:(j_TapGestureBlock)tapAction
{
    self.tapAction = tapAction;
    
    if (![self gestureRecognizers]) {
        
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(j_tapGesture:)];
        [self addGestureRecognizer:tapGesture];
        
        return tapGesture;
    }
    
    return nil;
}

#pragma mark LongPressGesture回调

- (UILongPressGestureRecognizer *)j_addLongPressGesture:(j_LongPressGestureBlock)longPressAction
{
    self.longPressGestureAction = longPressAction;
    
    if (![self gestureRecognizers]) {
        
        self.userInteractionEnabled = YES;
        
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(j_longGesture:)];
        [self addGestureRecognizer:longPressGesture];
        
        return longPressGesture;
    }
    
    return nil;
}

#pragma mark PanGesture回调

- (UIPanGestureRecognizer *)j_addPanGesture:(j_PanGestureBlock)panAction
{
    self.panGestureAction = panAction;
    
    if (![self gestureRecognizers]) {
        
        self.userInteractionEnabled = YES;
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(j_panGesture:)];
        [self addGestureRecognizer:panGesture];
        
        return panGesture;
    }
    
    return nil;
}

- (void)j_tapGesture:(UITapGestureRecognizer *)gestureRecognizer
{
    if (self.tapGestureAction) {
        
        self.tapGestureAction(gestureRecognizer);
    }
}

- (void)j_longGesture:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (self.longPressGestureAction) {
        
        self.longPressGestureAction(gestureRecognizer);
    }
}

- (void)j_panGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (self.panGestureAction) {
        
        self.panGestureAction(gestureRecognizer);
    }
}
@end
