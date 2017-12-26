//
//  JPicScrollerView.h
//  JKitDemo
//
//  Created by elongtian on 16/1/19.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PageControlStyle) {
    PageControlAtCenter,
    PageControlAtRight,
};

@interface JPicScrollerView : UIView

/**
 *  占位图片
 */
@property (nonatomic,strong) UIImage *placeImage;

/**
 *  default is 2.0f,如果小于0.5不自动播放
 */
@property (nonatomic,assign) NSTimeInterval AutoScrollDelay;

/**
 *  设置PageControl位置,default is PageControlAtCenter
 */
@property (nonatomic,assign) PageControlStyle style;

/**
 *  设置后显示label,自动设置PageControlAtRight 轮播图title
 */
@property (nonatomic,copy) NSArray<NSString *> *titleData;

/**
 *  图片被点击会调用该block,index从0开始
 */
@property (nonatomic,copy) void(^imageViewDidTapAtIndex)(NSInteger index);

/**
 *  图片数据源
 */
@property (nonatomic,strong) NSArray *imageUrlStrings;
/**
 *  创建轮播图 包含image数组
 *  @param frame frame
 *  @param imageUrl imageUrl/imageUrlString/imageName,本地加载只需图片名字数组,网络加载urlsring必须为http:// 开头,
 */
+ (instancetype)j_picScrollViewWithFrame:(CGRect)frame WithImageUrls:(NSArray<NSString *> *)imageUrl;
/**
 *  创建轮播图 不包含image数组
 *  @param frame frame
 */
+ (instancetype)j_picScrollViewWithFrame:(CGRect)frame;

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


//default is [[UIColor alloc] initWithWhite:0.5 alpha:1]
@property (nonatomic,strong) UIColor *textColor;

@property (nonatomic,strong) UIFont *font;

/**
 设置图片 UIViewContentMode
 
 @param contentMode <#contentMode description#>
 */
- (void)setImageContentMode:(UIViewContentMode)contentMode;

@end
