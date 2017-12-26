//
//  UITableView+J.m
//  JKitDemo
//
//  Created by Zebra on 16/6/24.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "UITableView+J.h"

@implementation UITableView (J)

- (void)j_hiddenExtraCellLine{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [self setTableFooterView:view];
}

@end
