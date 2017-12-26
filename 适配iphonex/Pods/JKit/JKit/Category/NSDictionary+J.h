//
//  NSDictionary+J.h
//  JKitDemo
//
//  Created by elongtian on 16/1/13.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary<KeyType, ObjectType> (J)

/**
 *  取值(防止为Null)
 *
 *  @param key  key
 *
 *  @return nil 或者 值
 */
- (ObjectType)j_objectForKey:(KeyType)key;

/**
 *  post 提交参数转化为URL
 */
- (ObjectType)j_urlValue;

/**
 *  打印时unicode
 */
- (ObjectType)j_description;

@end
