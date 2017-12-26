//
//  JPicScrollerLabel.h
//  JKitDemo
//
//  Created by Zebra on 16/7/12.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPicScrollerLabel : UIView

/**
 *  占位图片
 */
@property (nonatomic,strong) UIImage *placeImage;

/**
 *  default is 2.0f,如果小于0.5不自动播放
 */
@property (nonatomic,assign) NSTimeInterval AutoScrollDelay;

/**
 *  图片被点击会调用该block,index从0开始
 */
@property (nonatomic,copy) void(^imageViewDidTapAtIndex)(NSInteger index);

/**
 *  图片数据源
 */
@property (nonatomic,strong) NSArray *imageUrlStrings;

/**
 *  创建轮播图 不包含image数组
 *  @param frame frame
 */
+ (instancetype)j_picScrollLabelWithFrame:(CGRect)frame;

@property (nonatomic,strong) UIColor *pageIndicatorTintColor;

@property (nonatomic,strong) UIColor *currentPageIndicatorTintColor;
/**
 *  pageContro 默认image  不设置默认为：pageIndicatorTintColor
 */
@property (nonatomic, retain) UIImage *imagePageStateNormal;
/**
 *  pageContro 高亮image  不设置默认为：currentPageIndicatorTintColor
 */
@property (nonatomic, retain) UIImage *imagePageStateHighlighted;

/**
 *  设置后显示label,自动设置PageControlAtRight 轮播图title
 */
@property (nonatomic,copy) NSArray<NSString *> *titleData;

//default is [[UIColor alloc] initWithWhite:0.5 alpha:1]
@property (nonatomic,strong) NSArray <UIColor *> *textColors;

@property (nonatomic,strong) NSArray <UIFont *> *fonts;

@end
