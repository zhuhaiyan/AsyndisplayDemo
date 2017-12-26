//
//  UIImage+J.m
//  JKitDemo
//
//  Created by elongtian on 16/1/6.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "UIImage+J.h"
@interface UIImage ()

@property(copy, nonatomic) j_WriteToSavedPhotosSuccess writeToSavedPhotosSuccess;

@property(copy, nonatomic) j_WriteToSavedPhotosError writeToSavedPhotosError;

@end
@implementation UIImage (J)
#pragma mark 将UIColor转为UIImage

+ (UIImage *)j_imageWithColor:(UIColor *)color
{
    return [UIImage j_imageWithColor:color withFrame:CGRectMake(0, 0, 1, 1)];
}

+ (UIImage *)j_imageWithColor:(UIColor *)color withFrame:(CGRect)frame
{
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, frame);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

#pragma mark -保存到相簿
- (void)j_writeToSavedPhotosAlbumWithSuccess:(j_WriteToSavedPhotosSuccess)success error:(j_WriteToSavedPhotosError)error
{
    self.writeToSavedPhotosSuccess = success;
    self.writeToSavedPhotosError = error;
    
    UIImageWriteToSavedPhotosAlbum(self, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        
        if (self.writeToSavedPhotosError) {
            self.writeToSavedPhotosError(error);
        }
        
    } else {
        
        if (self.writeToSavedPhotosSuccess) {
            self.writeToSavedPhotosSuccess();
        }
    }
}

#pragma mark -图片压缩系数
- (NSData *)j_pressImageWithLessThanSizeKB:(CGFloat )KB{
    
    NSData *data;
    UIImage *image = [self scaleAndRotateImage];
    if (self) {
        data = UIImageJPEGRepresentation(image, 1);
    }else{
        return nil;
    }
    if ([data length] < 1024*KB) {
        return data;
    }else{
        for (double i = 1.0; i>0; i -= 0.05) {
            data = UIImageJPEGRepresentation(image, i);
            if ([data length] <= 1024*KB) {
                return data;
            }
        }
    }
    return data;
}
#pragma mark -改变图片尺寸
- (UIImage*)j_imageWithscaledToSize:(CGSize)newSize{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

#pragma mark -根据图片url获取图片尺寸
+ (CGSize)j_getImageSizeWithURL:(id)imageURL {
    
    NSURL* URL = nil;
    
    if([imageURL isKindOfClass:[NSURL class]]){
        
        URL = imageURL;
    }
    
    if([imageURL isKindOfClass:[NSString class]]){
        
        URL = [NSURL URLWithString:imageURL];
    }
    
    if(URL == nil) {
        
        return CGSizeZero;                  // url不正确返回CGSizeZero
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    
    if([pathExtendsion isEqualToString:@"png"]) {
        
        size =  [self j_getPNGImageSizeWithRequest:request];
        
    } else if([pathExtendsion isEqual:@"gif"]) {
        
        size =  [self j_getGIFImageSizeWithRequest:request];
        
    } else {
        
        size = [self j_getJPGImageSizeWithRequest:request];
    }
    
    // 如果获取文件头信息失败,发送异步请求请求原图
    if(CGSizeEqualToSize(CGSizeZero, size)) {
        
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        
        UIImage* image = [UIImage imageWithData:data];
        
        if(image) {
            
            size = image.size;
        }
    }
    
    return size;
}

#pragma mark -获取PNG图片的大小
+ (CGSize)j_getPNGImageSizeWithRequest:(NSMutableURLRequest*)request {
    
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if(data.length == 8) {
        
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        
        return CGSizeMake(w, h);
    }
    
    return CGSizeZero;
}

#pragma mark -获取gif图片的大小
+ (CGSize)j_getGIFImageSizeWithRequest:(NSMutableURLRequest*)request {
    
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if(data.length == 4) {
        
        short w1 = 0, w2 = 0;
        
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        
        short w = w1 + (w2 << 8);
        
        short h1 = 0, h2 = 0;
        
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        
        short h = h1 + (h2 << 8);
        
        return CGSizeMake(w, h);
    }
    
    return CGSizeZero;
}

#pragma mark -获取jpg图片的大小
+ (CGSize)j_getJPGImageSizeWithRequest:(NSMutableURLRequest*)request {
    
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58) {
        
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        
        short w1 = 0, w2 = 0;
        
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        
        short w = (w1 << 8) + w2;
        
        short h1 = 0, h2 = 0;
        
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        
        short h = (h1 << 8) + h2;
        
        return CGSizeMake(w, h);
        
    } else {
        
        short word = 0x0;
        
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        
        if (word == 0xdb) {
            
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            
            if (word == 0xdb) {// 两个DQT字段
                
                short w1 = 0, w2 = 0;
                
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                
                short w = (w1 << 8) + w2;
                
                short h1 = 0, h2 = 0;
                
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                
                short h = (h1 << 8) + h2;
                
                return CGSizeMake(w, h);
                
            } else {// 一个DQT字段
                
                short w1 = 0, w2 = 0;
                
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                
                short w = (w1 << 8) + w2;
                
                short h1 = 0, h2 = 0;
                
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                
                short h = (h1 << 8) + h2;
                
                return CGSizeMake(w, h);
            }
            
        } else {
            
            return CGSizeZero;
        }
    }
}




// Tint: Color
-(UIImage*)j_tintedImageWithColor:(UIColor*)color {
    return [self j_tintedImageWithColor:color level:1.0f];
}

// Tint: Color + level
-(UIImage*)j_tintedImageWithColor:(UIColor*)color level:(CGFloat)level {
    CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    return [self j_tintedImageWithColor:color rect:rect level:level];
}

// Tint: Color + Rect
-(UIImage*)j_tintedImageWithColor:(UIColor*)color rect:(CGRect)rect {
    return [self j_tintedImageWithColor:color rect:rect level:1.0f];
}

// Tint: Color + Rect + level
-(UIImage*)j_tintedImageWithColor:(UIColor*)color rect:(CGRect)rect level:(CGFloat)level {
    CGRect imageRect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self drawInRect:imageRect];
    
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextSetAlpha(ctx, level);
    CGContextSetBlendMode(ctx, kCGBlendModeSourceAtop);
    CGContextFillRect(ctx, rect);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *darkImage = [UIImage imageWithCGImage:imageRef
                                             scale:self.scale
                                       orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    
    UIGraphicsEndImageContext();
    
    return darkImage;
}

// Tint: Color + Insets
-(UIImage*)j_tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets {
    return [self j_tintedImageWithColor:color insets:insets level:1.0f];
}

// Tint: Color + Insets + level
-(UIImage*)j_tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets level:(CGFloat)level {
    CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    return [self j_tintedImageWithColor:color rect:UIEdgeInsetsInsetRect(rect, insets) level:level];
}

// Light: Level
-(UIImage*)j_lightenWithLevel:(CGFloat)level {
    return [self j_tintedImageWithColor:[UIColor whiteColor] level:level];
}

// Light: Level + Insets
-(UIImage*)j_lightenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets {
    return [self j_tintedImageWithColor:[UIColor whiteColor] insets:insets level:level];
}

// Light: Level + Rect
-(UIImage*)j_lightenRect:(CGRect)rect withLevel:(CGFloat)level {
    return [self j_tintedImageWithColor:[UIColor whiteColor] rect:rect level:level];
}

// Dark: Level
-(UIImage*)j_darkenWithLevel:(CGFloat)level {
    return [self j_tintedImageWithColor:[UIColor blackColor] level:level];
}

// Dark: Level + Insets
-(UIImage*)j_darkenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets {
    return [self j_tintedImageWithColor:[UIColor blackColor] insets:insets level:level];
}

// Dark: Level + Rect
-(UIImage*)j_darkenRect:(CGRect)rect withLevel:(CGFloat)level {
    return [self j_tintedImageWithColor:[UIColor blackColor] rect:rect level:level];
}

#pragma mark -修改大小 消除白边
- (UIImage *)scaleAndRotateImage {
    CGImageRef imgRef = self.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGSize size = CGSizeMake(1242, 2208);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    
    if (width > size.width || height > size.height) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = size.width;
            bounds.size.height = bounds.size.width / ratio;
        } else {
            bounds.size.height = size.height;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    
    UIImageOrientation orient = self.imageOrientation;
    switch(orient) {
        case UIImageOrientationUp:
            transform = CGAffineTransformIdentity;
            break;
        case UIImageOrientationUpMirrored:
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
        case UIImageOrientationDown:
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
        case UIImageOrientationLeftMirrored:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationLeft:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationRightMirrored:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        case UIImageOrientationRight:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(floorf(bounds.size.width), floorf(bounds.size.height)));
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    } else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, floorf(width), floorf(height)), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;
}


@end
