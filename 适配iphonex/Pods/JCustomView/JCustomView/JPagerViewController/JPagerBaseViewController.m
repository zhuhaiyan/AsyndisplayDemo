//
//  JPagerBaseViewController.m
//  JKitDemo
//
//  Created by Zebra on 16/3/31.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "JPagerBaseViewController.h"
#import <JKit/JKit.h>

@implementation JPagerBaseViewController{

    NSMutableArray *btnArray;
    NSArray *titlesArray; /**<  标题   **/
    NSInteger arrayCount; /**<  topTab数量   **/
    UIColor *selectBtn;
    UIColor *unselectBtn;
    UIColor *underline;
    UIColor *topTabColors;
    
    //下划线width 和 y
    CGFloat _width;
    CGFloat _height;
    CGFloat _y;
    
    //topBar
    CGFloat _topBarWidth;
    CGFloat _topBarHeight;
    CGFloat _topBarAlpha;
    UIFont *_titleFont;

}

- (instancetype)initWithFrame:(CGRect)frame WithSelectColor:(UIColor *)selectColor WithUnselectorColor:(UIColor *)unselectColor WithUnderLineColor:(UIColor *)underlineColor WithtopTabColor:(UIColor *)topTabColor andTitleFont:(UIFont *)titleFont {
    self = [super initWithFrame:frame];
    if (self) {
        _titleFont = titleFont ? titleFont : [UIFont systemFontOfSize:14];
        if ([selectColor isKindOfClass:[UIColor class]]) {
            selectBtn = selectColor;
        }else {
            JLog(@"please change the selectColor into UIColor!");
        }
        if ([unselectColor isKindOfClass:[UIColor class]]) {
            unselectBtn = unselectColor;
        }else {
            JLog(@"please change the unselectColor into UIColor!");
        }
        if ([underlineColor isKindOfClass:[UIColor class]]) {
            underline = underlineColor;
        }else {
            JLog(@"please change the underlineColor into UIColor!");
        }
        if ([topTabColor isKindOfClass:[UIColor class]]) {
            topTabColors = topTabColor;
        }else {
            JLog(@"please change the topTabColor into UIColor!");
        }
    }
    return self;
}

#pragma mark - SetMethod
- (void)setTitleArray:(NSArray *)titleArray {
    titlesArray = titleArray;
    arrayCount = titleArray.count;
    
    if (!_topBarWidth) {
        _topBarWidth = FUll_VIEW_WIDTH;
    }
    
    if (!_topBarHeight) {
        _topBarHeight = PageBtn;
    }
    
    self.topTab.frame = CGRectMake(0, 0, _topBarWidth, _topBarHeight);
    self.scrollView.frame = CGRectMake(0, _topBarHeight, FUll_VIEW_WIDTH, self.frame.size.height - _topBarHeight);
    [self addSubview:self.topTab];
    [self addSubview:self.scrollView];
}

#pragma mark - GetMethod
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[JScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.tag = 318;
        _scrollView.backgroundColor = JColorWithClear;
        _scrollView.contentSize = CGSizeMake(FUll_VIEW_WIDTH * titlesArray.count, -1);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.alwaysBounceHorizontal = YES;
//        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (UIScrollView *)topTab {
    if (!_topTab) {
        _topTab = [[JScrollView alloc] init];
        _topTab.delegate = self;
        if (topTabColors) {
            _topTab.backgroundColor = topTabColors;
        }else {
            _topTab.backgroundColor = [UIColor whiteColor];
        }
        _topTab.tag = 917;
        _topTab.scrollEnabled = YES;
        _topTab.alwaysBounceHorizontal = YES;
        _topTab.showsHorizontalScrollIndicator = NO;
//        _topTab.bounces = NO;
        CGFloat additionCount = 0;
        if (arrayCount > 5) {
            additionCount = (arrayCount - 5.0) / 5.0;
        }
        _topTab.contentSize = CGSizeMake((1 + additionCount) * _topBarWidth, -10);
        btnArray = [NSMutableArray array];
        for (NSInteger i = 0; i < titlesArray.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = i;
            button.titleLabel.font = _titleFont;
            if ([titlesArray[i] isKindOfClass:[NSString class]]) {
                [button setTitle:titlesArray[i] forState:UIControlStateNormal];
            }else {
                JLog(@"您所提供的标题%li格式不正确。 Your title%li not fit for topTab,please correct it to NSString!",(long)i + 1,(long)i + 1);
            }
            if (titlesArray.count > 5) {
                button.frame = CGRectMake(_topBarWidth / 5 * i, 0, _topBarWidth / 5, _topBarHeight);
            }else {
                button.frame = CGRectMake(_topBarWidth / titlesArray.count * i, 0, _topBarWidth / titlesArray.count, _topBarHeight);
            }
            [_topTab addSubview:button];
            [button addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
            [btnArray addObject:button];
            if (i == 0) {
                if (selectBtn) {
                    [button setTitleColor:selectBtn forState:UIControlStateNormal];
                }else {
                    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                }
                [UIView animateWithDuration:0.3 animations:^{
                    button.transform = CGAffineTransformMakeScale(1.15, 1.15);
                }];
            } else {
                if (unselectBtn) {
                    [button setTitleColor:unselectBtn forState:UIControlStateNormal];
                }else {
                    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                }
            }
        }
        //创建tabTop下方总览线
        _topTabBottomLine = [UIView new];
        _topTabBottomLine.backgroundColor = UIColorFromRGB(0xcecece);
        [_topTab addSubview:_topTabBottomLine];
        //创建选中移动线
        _lineBottom = [UIView new];
        if (underline) {
            _lineBottom.backgroundColor = underline;
        }else {
            _lineBottom.backgroundColor = UIColorFromRGB(0xff6262);
        }
        [_topTab addSubview:_lineBottom];
        [self initUI];

    }
    return _topTab;
}

#pragma mark - BtnMethod
- (void)touchAction:(UIButton *)button {
    [_scrollView setContentOffset:CGPointMake(FUll_VIEW_WIDTH * button.tag, 0) animated:YES];
    self.currentPage = (FUll_VIEW_WIDTH * button.tag + FUll_VIEW_WIDTH / 2) / FUll_VIEW_WIDTH;

}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.tag == 318) {
        self.currentPage = (NSInteger)((scrollView.contentOffset.x + FUll_VIEW_WIDTH / 2) / FUll_VIEW_WIDTH);

    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (scrollView.tag == 318) {
        self.currentPage = (NSInteger)((scrollView.contentOffset.x + FUll_VIEW_WIDTH / 2) / FUll_VIEW_WIDTH);
        
        if (self.currentPage) {
            self.currentPage = self.currentPage - 1;
            self.currentPage = self.currentPage + 1;
        }else {
            
            self.currentPage = self.currentPage + 1;
            
        }
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag == 318) {
        
        NSInteger yourPage = (NSInteger)((scrollView.contentOffset.x + FUll_VIEW_WIDTH / 2) / FUll_VIEW_WIDTH);
        
        CGFloat additionCount = 0;
        CGFloat yourCount = 1.0 / arrayCount;
        
        if (arrayCount > 5) {
            additionCount = (arrayCount - 5.0) / 5.0;
            yourCount = 1.0 / 5.0;
            if (!_width || !_y) {
                _width = yourCount * _topBarWidth;
                _y = _topBarHeight - 2;
            }
            _lineBottom.frame = CGRectMake(scrollView.contentOffset.x / 5 - ((FUll_VIEW_WIDTH - _topBarWidth) / 5) * scrollView.contentOffset.x / FUll_VIEW_WIDTH + (yourCount * _topBarWidth - _width) / 2, _y, _width, _height ? _height : 1);
        }else {
            if (!_width || !_y) {
                _width = yourCount * _topBarWidth;
                _y = _topBarHeight - 2;
            }
//            scrollView.contentOffset.x / arrayCount : 最初起始点
//            (FUll_VIEW_WIDTH - _topBarWidth) / arrayCount: topBar宽度剩余的偏移量
//             * scrollView.contentOffset.x / FUll_VIEW_WIDTH ：页码
//            (yourCount * _topBarWidth - _width)/2 ：下划线偏移的Point
//            起始点 - 设置topBar宽度时偏移量 * 页码
            _lineBottom.frame = CGRectMake(scrollView.contentOffset.x / arrayCount - (FUll_VIEW_WIDTH - _topBarWidth) / arrayCount * scrollView.contentOffset.x / FUll_VIEW_WIDTH + (yourCount * _topBarWidth - _width)/2, _y, _width, _height ? _height : 1);
        }
        for (NSInteger i = 0;  i < btnArray.count; i++) {
            if (unselectBtn) {
                [btnArray[i] setTitleColor:unselectBtn forState:UIControlStateNormal];
            }else {
                [btnArray[i] setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
            UIButton *changeButton = btnArray[i];
            [UIView animateWithDuration:0.3 animations:^{
                changeButton.transform = CGAffineTransformMakeScale(1, 1);
            }];
        }
        if (selectBtn) {
            [(UIButton *)[btnArray j_objectAtIndex:yourPage] setTitleColor:selectBtn forState:UIControlStateNormal];
        }else {
            [(UIButton *)[btnArray j_objectAtIndex:yourPage] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        UIButton *changeButton = (UIButton *)[btnArray j_objectAtIndex:yourPage];
        [UIView animateWithDuration:0.3 animations:^{
            changeButton.transform = CGAffineTransformMakeScale(1.15, 1.15);
        }];
    }
}

#pragma mark - LayOutSubViews
- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)initUI {
    CGFloat yourCount = 1.0 / arrayCount;
    CGFloat additionCount = 0;
    if (arrayCount > 5) {
        additionCount = (arrayCount - 5.0) / 5.0;
        yourCount = 1.0 / 5.0;
    }
    
    if (!_topBarHeight) {
        _topBarHeight = PageBtn;
    }
    
    if (!_width || !_y) {
        _y = _topBarHeight - 1;
        _width = yourCount * _topBarWidth;
    }
    
    _lineBottom.frame = CGRectMake((yourCount * _topBarWidth - _width), _y,_width, 1);
    _topTabBottomLine.frame = CGRectMake(-1000, _topBarHeight - 1, (1 + additionCount) * FUll_VIEW_WIDTH + 2000, 1);
}

- (void)setPagerViewLineViewWithWidth:(CGFloat)width andHeight:(CGFloat)height andY:(CGFloat)y {
    
    _width = width;
    _y = y;
    _height = height;
    
    CGFloat yourCount = 1.0 / arrayCount;
    CGFloat additionCount = 0;
    if (arrayCount > 5) {
        additionCount = (arrayCount - 5.0) / 5.0;
        yourCount = 1.0 / 5.0;
    }
    _lineBottom.frame = CGRectMake((yourCount * _topBarWidth - width) / 2, _y, _width, _height ? _height : 1);
    
}

- (void)setPagerViewTopBarWithWidth:(CGFloat)width andHeight:(CGFloat)height andAlpha:(CGFloat)alpha {
    
    _topBarWidth = width;
    
    _topBarHeight = height;
    
    _topBarAlpha = alpha;

    [self.topTab removeFromSuperview];
    
    self.topTab = nil;
    
    self.topTab.frame = CGRectMake(0, 0, _topBarWidth, height);
    
    self.scrollView.frame = CGRectMake(0, _topBarHeight, FUll_VIEW_WIDTH, self.frame.size.height - _topBarHeight);
    
    self.topTab.alpha = alpha;
    
    [self addSubview:self.topTab];

}

@end
