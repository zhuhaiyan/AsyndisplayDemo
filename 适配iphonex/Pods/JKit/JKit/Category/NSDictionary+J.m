//
//  NSDictionary+J.m
//  JKitDemo
//
//  Created by elongtian on 16/1/13.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "NSDictionary+J.h"
#import "JMacro.h"
@implementation NSDictionary (J)

#pragma mark -取值(防止为Null)
- (instancetype)j_objectForKey:(NSString *)key{
    if ([[self objectForKey:key] isEqual:[NSNull null]]) {
        return nil;
    }else{
        return [self objectForKey:key];
    }
}

- (NSString *)j_description {
    NSString *desc = [self description];
    desc = [NSString stringWithCString:[desc cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    return desc;
}

- (NSString *)j_urlValue{
    NSString *url = @"";
    NSArray *keyArr = [self allKeys];
    NSArray *valueArr = [self allValues];
    for (int i = 0; i < keyArr.count; i++) {
        url = [NSString stringWithFormat:@"%@&%@=%@",url,JStringWithObject(keyArr[i]),JStringWithObject(valueArr[i])];
    }
    return url;
}
@end
