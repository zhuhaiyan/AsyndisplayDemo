//
//  JTabBarController.h
//  JKitDemo
//
//  Created by Zebra on 16/6/7.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JKit/JKit.h>

static NSString *const JTabBarHidden = @"JTabbarHidden";
static NSString *const JTabBarSelectIndex = @"JTabBarSelectIndex";

typedef BOOL(^JTabBarSelectIndexBlock)(NSInteger selectIndex);

@interface JTabBarController : UITabBarController

@property (strong, nonatomic) UIView * tabBarView;

@property (nonatomic, copy) JTabBarSelectIndexBlock block;

- (void)setBlock:(JTabBarSelectIndexBlock)block;

/**
 *  创建tabbar
 *
 *  @param tabArray       item
 *  @param normalImages   默认图片
 *  @param selectedImages 选中图片
 *  @param titles         title
 */
- (void)setTabWithArray:(NSArray *)tabArray
    andNormalImageArray:(NSArray *)normalImages
  andSelectedImageArray:(NSArray *)selectedImages
              andTitles:(NSArray *)titles;


/**
 *  创建tabbar
 *
 *  @param tabArray           item
 *  @param nomalTitles        默认文字
 *  @param selectedTitles     选中文字
 *  @param normalImages       默认图片
 *  @param selectedImages     选中图片
 *  @param nomalBackImages    默认背景图片
 *  @param selectedBackImages 选中背景图片
 *  @param nomalTitleColor    默认文字颜色
 *  @param selectedTitleColor 选中文字颜色
 */
- (void)setTabWithArray:(NSArray *)tabArray
         andNomalTitles:(NSArray *)nomalTitles
      andSelectedTitles:(NSArray *)selectedTitles
     andNomalTitleColor:(UIColor *)nomalTitleColor
  andSelectedTitleColor:(UIColor *)selectedTitleColor
    andNormalImageArray:(NSArray *)normalImages
  andSelectedImageArray:(NSArray *)selectedImages
      andNomalBackimage:(NSArray *)nomalBackImages
   andSelectedBackimage:(NSArray *)selectedBackImages;

/**
 *  tabbar跳转
 *
 *  @param index index
 */
- (void)selectIndex:(int)index;


@end
