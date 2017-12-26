//
//  NSArray+J.m
//  JKitDemo
//
//  Created by elongtian on 16/1/6.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "NSArray+J.h"
#import "JKit.h"

@implementation NSArray (J)

- (BOOL)j_isContains:(NSString *)obj{
    for (NSString * object in self) {
        if ([object isEqualToString:obj]) {
            return YES;
        }
    }
    return NO;
}

- (instancetype)j_objectAtIndex:(NSInteger)index{
    if (self.count > index) {
        return [self objectAtIndex:index];
    }
    return nil;
}

- (NSArray *)j_ChineseSort{
    
    NSMutableArray *pinyinArr = [NSMutableArray array];
    
    for (NSString *ChineseStr in self) {
        [pinyinArr addObject:[ChineseStr j_pinyinWithoutBlank]];
    }
    
    NSArray *resultPinyinSort = [pinyinArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    NSMutableArray *resultSort = [NSMutableArray arrayWithArray:self];
    
    for (int i = 0; i<self.count; i++) {
        NSString *pinyinStr = [self[i] j_pinyinWithoutBlank];
        for (int j = 0; j<resultPinyinSort.count; j++) {
            NSString *pinyinSort = resultPinyinSort[j];
            if ([pinyinStr isEqualToString:pinyinSort]) {
                resultSort[j] = self[i];
            }
        }

    }
    
    return resultSort;
}

@end
