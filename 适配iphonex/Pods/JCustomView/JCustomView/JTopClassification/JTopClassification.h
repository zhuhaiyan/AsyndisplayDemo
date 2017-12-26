//
//  TopClassification.h
//  JKitDemo
//
//  Created by SKiNN on 16/1/27.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JKit/JKit.h>

typedef void(^JTopClassificationCallBackBlock)(NSInteger index);
@interface JTopClassification : UIView

@property (nonatomic, strong) NSMutableArray *titleArr;

@property (nonatomic, strong) JTopClassificationCallBackBlock block;

/**
 *  实例化
 *
 *  @param frame     frame
 *  @param titleArr  title
 *  @param width     每个btn的宽
 *  @param isSliding 是否支持滑动
 *
 *  @return TopClassification
 */

+ (instancetype)j_topClassificationWithFrame:(CGRect)frame
                                 andTitleArr:(NSMutableArray<NSString *> *)titleArr
                            andTitleBtnWidth:(CGFloat)width
                                andIsSliding:(BOOL)isSliding JExtensionDeprecated("方法弃用并在下个版本删除，把andTitleArr:(NSMutableArray<NSString *> *)titleArr替换为 andTitles:(NSMutableArray<NSString *> *)titles");


/**
 *  实例化
 *
 *  @param frame     frame
 *  @param titles  title
 *  @param width     每个btn的宽
 *  @param isSliding 是否支持滑动
 *
 *  @return TopClassification
 */
+ (instancetype)j_topClassificationWithFrame:(CGRect)frame
                                 andTitles:(NSMutableArray<NSString *> *)titles
                            andTitleBtnWidth:(CGFloat)width
                                andIsSliding:(BOOL)isSliding
                              andSelectIndex:(NSInteger)index;

/**
 *  切换到指定item
 *
 *  @param index index
 */
- (void)j_switchItemWithIndex:(NSInteger)index;

/**
 *  title颜色
 *
 *  @param selectcolor 选中颜色
 *  @param normalcolor 未选中颜色
 */
- (void)j_setSelectedTitleColor:(UIColor *)selectcolor andNormalTitleColor:(UIColor *)normalcolor;

/**
 *  title背景
 *
 *  @param selectImg 选中img
 *  @param normalImg 未选中img
 */
- (void)j_setBackgroundSelectedImage:(UIImage *)selectImg andBackgroundNormalImage:(UIImage *)normalImg;

/**
 *  回调
 *
 *  @param block 点击btn的下标
 */
- (void)j_getTopClassificationCallBackBlock:(JTopClassificationCallBackBlock)block;
@end
