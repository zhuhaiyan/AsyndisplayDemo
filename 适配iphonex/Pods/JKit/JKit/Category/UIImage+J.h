//
//  UIImage+J.h
//  JKitDemo
//
//  Created by elongtian on 16/1/6.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^j_WriteToSavedPhotosSuccess)();
typedef void(^j_WriteToSavedPhotosError)(NSError *error);
@interface UIImage (J)
/**
 *  将UIColor转为UIImage
 *
 *  @param color UIColor
 *
 *  @return UIImage
 */
+ (UIImage *)j_imageWithColor:(UIColor *)color;

/**
 *  将UIColor转为UIImage
 *
 *  @param color UIColor
 *  @param frame CGRect
 *
 *  @return UIImage
 */
+ (UIImage *)j_imageWithColor:(UIColor *)color withFrame:(CGRect)frame;

/**
 *  保存到相簿
 *
 *  @param success 成功回调
 *  @param error   失败回调
 */
- (void)j_writeToSavedPhotosAlbumWithSuccess:(j_WriteToSavedPhotosSuccess)success error:(j_WriteToSavedPhotosError)error;

/**
 *  根据图片的大小返回data
 *
 *  @param KB 图片最大多少KB
 */
- (NSData *)j_pressImageWithLessThanSizeKB:(CGFloat)KB;
/**
 *  修改大小 消除白边  图片最大 1242 * 2208  5.5寸
 */
- (UIImage *)scaleAndRotateImage;

/**
 *  改变图片尺寸
 *
 *  @param newSize 尺寸
 */
- (UIImage*)j_imageWithscaledToSize:(CGSize)newSize;

/**
 *  根据图片url获取图片尺寸
 *
 *  @param imageURL 图片url
 *
 *  @param newSize 尺寸
 */
+ (CGSize)j_getImageSizeWithURL:(id)imageURL;

/**
 *  改变图片相关
 *
 *  @param color 需要改变的颜色
 *
 *  @return 新的图片
 */
-(UIImage*)j_tintedImageWithColor:(UIColor*)color;
-(UIImage*)j_tintedImageWithColor:(UIColor*)color level:(CGFloat)level;
-(UIImage*)j_tintedImageWithColor:(UIColor*)color rect:(CGRect)rect;
-(UIImage*)j_tintedImageWithColor:(UIColor*)color rect:(CGRect)rect level:(CGFloat)level;
-(UIImage*)j_tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets;
-(UIImage*)j_tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets level:(CGFloat)level;

-(UIImage*)j_lightenWithLevel:(CGFloat)level;
-(UIImage*)j_lightenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets;
-(UIImage*)j_lightenRect:(CGRect)rect withLevel:(CGFloat)level;

-(UIImage*)j_darkenWithLevel:(CGFloat)level;
-(UIImage*)j_darkenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets;
-(UIImage*)j_darkenRect:(CGRect)rect withLevel:(CGFloat)level;



@end
