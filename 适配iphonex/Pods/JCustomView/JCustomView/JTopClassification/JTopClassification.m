//
//  JTopClassification.m
//  JKitDemo
//
//  Created by SKiNN on 16/1/27.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "JTopClassification.h"

#define Tag 235468912

@interface JTopClassification ()<UIScrollViewDelegate>{
    /**
     *  是否支持滑动
     */
    BOOL _isSliding;
    UIScrollView *_scrollView;
    NSInteger _selectIndex;
}

@end

@implementation JTopClassification

+ (instancetype)j_topClassificationWithFrame:(CGRect)frame
                                 andTitleArr:(NSMutableArray *)titleArr
                            andTitleBtnWidth:(CGFloat)width
                                andIsSliding:(BOOL)isSliding {
    
    JTopClassification * topView = [[JTopClassification alloc]initWithFrame:frame];
    if (isSliding) {
        [topView createUIWithTitleArr:titleArr andTitleBtnWidth:width andIsSliding:isSliding andSelectIndex:0];
        topView.backgroundColor = JColorWithWhite;
    }else{
        [topView createUIWithTitleArr:titleArr andTitleBtnWidth:JScreenWidth / titleArr.count andIsSliding:isSliding andSelectIndex:0];
        topView.backgroundColor = JColorWithWhite;
    }
    return topView;

}

+ (instancetype)j_topClassificationWithFrame:(CGRect)frame
                                   andTitles:(NSMutableArray<NSString *> *)titles
                            andTitleBtnWidth:(CGFloat)width
                                andIsSliding:(BOOL)isSliding
                              andSelectIndex:(NSInteger)index {
    
    JTopClassification * topView = [[JTopClassification alloc]initWithFrame:frame];
    if (isSliding) {
        [topView createUIWithTitleArr:titles andTitleBtnWidth:width andIsSliding:isSliding andSelectIndex:index];
        topView.backgroundColor = JColorWithWhite;
    }else{
        [topView createUIWithTitleArr:titles andTitleBtnWidth:JScreenWidth / titles.count andIsSliding:isSliding andSelectIndex:index];
        topView.backgroundColor = JColorWithWhite;
    }
    return topView;
    
}

- (void)createUIWithTitleArr:(NSMutableArray *)titleArr
            andTitleBtnWidth:(CGFloat)width
                andIsSliding:(BOOL)isSliding
              andSelectIndex:(NSInteger)index {
    
    CGFloat height = self.frame.size.height;
    _titleArr = titleArr;
    if (isSliding) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, height - 1)];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.showsVerticalScrollIndicator = NO; //垂直方向的滚动指示
        _scrollView.alwaysBounceVertical = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(_titleArr.count * width, -10);
        [self addSubview:_scrollView];
        for (int i = 0; i < _titleArr.count; i++) {
            
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [_scrollView addSubview:btn];
            btn.frame = CGRectMake(width * i, 0, width, height);
            [btn setTitle:titleArr[i] forState:UIControlStateNormal];
            btn.tag = Tag + i;
            btn.titleLabel.font = JFont(14);
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            btn.adjustsImageWhenHighlighted = NO;
            if (i == index) {
                btn.selected = YES;
            }else{
                btn.selected = NO;
            }
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
    }else{
        for (int i = 0; i < titleArr.count; i++) {
            
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:btn];
            btn.frame = CGRectMake(width * i, 0, width, height);
            [btn setTitle:titleArr[i] forState:UIControlStateNormal];
            btn.tag = Tag + i;
            btn.titleLabel.font = JFont(14);
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            btn.adjustsImageWhenHighlighted = NO;

            if (i == index) {
                btn.selected = YES;
            }else{
                btn.selected = NO;
            }
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
}

- (void)btnClicked:(UIButton *)btn{
    
    NSInteger index= btn.tag-Tag;
    [UIView animateWithDuration:0.1 animations:^{
        _scrollView.userInteractionEnabled=NO;
        
    } completion:^(BOOL finished){
        _scrollView.userInteractionEnabled=YES;
        _selectIndex=index;
    }];
    
    if (_scrollView.contentSize.width > JScreenWidth) {
        
        if (btn.frame.origin.x > JScreenWidth / 2 - btn.frame.size.width / 2) {
            if (_scrollView.contentSize.width - JScreenWidth > btn.frame.origin.x - JScreenWidth / 2 + btn.frame.size.width / 2) {
                [UIView animateWithDuration:0.5 animations:^{
                    _scrollView.contentOffset=CGPointMake(btn.frame.origin.x - JScreenWidth / 2 + btn.frame.size.width / 2, 0);
                } completion:nil];
            }else{
                [UIView animateWithDuration:0.5 animations:^{
                    _scrollView.contentOffset=CGPointMake(_scrollView.contentSize.width - JScreenWidth, 0);
                } completion:nil];
            }
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                _scrollView.contentOffset=CGPointMake(0, 0);
            } completion:nil];
        }
    }

    for (int i = 0; i < _titleArr.count; i++) {
        UIButton * btn = [self viewWithTag:Tag + i];
        btn.selected = NO;
    }
    btn.selected = YES;
    JBlock(_block, btn.tag - Tag);
    
}

- (void)j_setTitleArr:(NSMutableArray *)titleArr{
    _titleArr = titleArr;
    for (int i = 0; i < titleArr.count; i++) {
        UIButton * btn = [self viewWithTag:Tag + i];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
    }
}
- (void)j_setSelectedTitleColor:(UIColor *)selectcolor andNormalTitleColor:(UIColor *)normalcolor{
    for (int i = 0; i < _titleArr.count; i++) {
        UIButton * btn = [self viewWithTag:Tag + i];
        [btn setTitleColor:selectcolor forState:UIControlStateSelected];
        [btn setTitleColor:normalcolor forState:UIControlStateNormal];
    }
}
- (void)j_setBackgroundSelectedImage:(UIImage *)selectImg andBackgroundNormalImage:(UIImage *)normalImg{
    for (int i = 0; i < _titleArr.count; i++) {
        UIButton * btn = [self viewWithTag:Tag + i];
        [btn setBackgroundImage:selectImg forState:UIControlStateSelected];
        [btn setBackgroundImage:normalImg forState:UIControlStateNormal];
    }
}

- (void)j_switchItemWithIndex:(NSInteger)index {
    for (int i = 0; i < _titleArr.count; i++) {
        UIButton * btn = [self viewWithTag:Tag + i];
        if (i == index) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
}



- (void)j_getTopClassificationCallBackBlock:(JTopClassificationCallBackBlock)block{
    _block = block;
}
@end
