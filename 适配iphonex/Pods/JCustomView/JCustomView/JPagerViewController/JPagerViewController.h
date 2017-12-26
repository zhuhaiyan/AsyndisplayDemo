//
//  JPagerViewController.h
//  JKitDemo
//
//  Created by Zebra on 16/3/31.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPagerBaseViewController.h"

typedef void(^JPagerViewControllerBlock)(NSInteger index);
@interface JPagerViewController : UIView

@property (nonatomic, copy) JPagerViewControllerBlock block;

@property (nonatomic, assign) BOOL isUnnecessary;/**< 只保留最近的5个控制器，释放其他控制器的空间，如果滑到对应位置在对其重新创建加载 **/

@property (nonatomic, strong) JPagerBaseViewController *pagerView;


/**
 *  创建总控制器 类方法
 *
 *  @param titles         topTabTitle ps：必须和childVCs 数量相等
 *  @param childVCs       相关类的类名  ps：必须和titles 数量相等
 *  @param selectColor    选中时的颜色
 *  @param unselectColor  未选中时的颜色
 *  @param underlineColor 下划线的颜色
 *  @param topTabColor    顶部菜单栏的背景颜色
 *  @param index          默认显示的页数（必须和 j_setPagerViewControllerWithIndex: 混合使用）
 */

+ (void)j_createPagerViewControllerWithFrame:(CGRect)frame
                               andSuperClass:(UIViewController *)superClass
                                   andTitles:(NSArray *)titles
                                 andchildVCs:(NSArray *)childVCs
                              andSelectColor:(UIColor *)selectColor
                            andUnselectColor:(UIColor *)unselectColor
                           andUnderlineColor:(UIColor *)underlineColor
                            andTopTabBgColor:(UIColor *)topTabColor
                  andDeallocVCsIfUnnecessary:(BOOL)isUnnecessary
                             andDefaultIndex:(NSInteger)index
                                andTitleFont:(UIFont *)titleFont
                           andSelectCallBack:(JPagerViewControllerBlock)block;

/**
 *  创建总控制器 减号方法
 *
 *  @param titles         topTabTitle ps：必须和childVCs 数量相等
 *  @param childVCs       相关类的类名  ps：必须和titles 数量相等
 *  @param selectColor    选中时的颜色
 *  @param unselectColor  未选中时的颜色
 *  @param underlineColor 下划线的颜色
 *  @param topTabColor    顶部菜单栏的背景颜色
 *  @param isUnnecessary  只保留最近的5个控制器，释放其他控制器的空间，如果滑到对应位置在对其重新创建加载
 *  @param index          默认显示的页数（必须和 j_setPagerViewControllerWithIndex: 混合使用）
 */
- (instancetype)initWithFrame:(CGRect)frame
                andSuperClass:(UIViewController *)superClass
                    andTitles:(NSArray *)titles
                  andchildVCs:(NSArray *)childVCs
               andSelectColor:(UIColor *)selectColor
             andUnselectColor:(UIColor *)unselectColor
            andUnderlineColor:(UIColor *)underlineColor
             andTopTabBgColor:(UIColor *)topTabColor
   andDeallocVCsIfUnnecessary:(BOOL)isUnnecessary
              andDefaultIndex:(NSInteger)index
                 andTitleFont:(UIFont *)titleFont
            andSelectCallBack:(JPagerViewControllerBlock)block;

- (void)j_setPagerViewControllerWithIndex:(NSInteger)index;


//如果同时设置两个方法必须按顺序调用  j_1XXXX   j_2XXXX
/**
 设置topBar allWidth
 
 @param width allWidth 默认屏幕的宽
 */
- (void)j_1setPagerViewTopBarWithWidth:(CGFloat)width andHeight:(CGFloat)height andAlpha:(CGFloat)alpha;
/**
 设置下划线的宽和y值

 @param width  下划线宽 默认item.width
 @param height 下划线高 默认1
 @param y y值  默认 item.height - 1
 */
- (void)j_2setPagerViewLineViewWithWidth:(CGFloat)width andHeight:(CGFloat)height andY:(CGFloat)y;



@end
