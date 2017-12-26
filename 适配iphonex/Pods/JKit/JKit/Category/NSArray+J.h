//
//  NSArray+J.h
//  JKitDemo
//
//  Created by elongtian on 16/1/6.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray<ObjectType> (J)

/**
 *  数组是否包含该字符串
 *
 *  @param obj 被包含字符串
 *
 *  @return YES or NO
 */
- (BOOL)j_isContains:(NSString *)obj;

/**
 *  取值(防止数组越界)
 *
 *  @param index 下标
 *
 *  @return nil 或者 id
 */
- (ObjectType)j_objectAtIndex:(NSInteger)index;

/**
 *  汉字排序
 *
 *  @return 排序结果
 */
- (NSArray *)j_ChineseSort;

@end
