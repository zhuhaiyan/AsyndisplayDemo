//
//  JPicScrollerView.m
//  JKitDemo
//
//  Created by elongtian on 16/1/19.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#define myWidth self.frame.size.width
#define myHeight self.frame.size.height
#define pageSize (myHeight * 0.2 > 25 ? 25 : myHeight * 0.2)

#import "JPicScrollerView.h"
#import "JPageControl.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <JKit/JKit.h>

@interface JPicScrollerView () <UIScrollViewDelegate>

@end

@implementation JPicScrollerView{
    
    __weak  UIImageView *_leftImageView,*_centerImageView,*_rightImageView;

    __weak  UILabel *_titleLabel;

    __weak  UIScrollView *_scrollView;

    __weak  JPageControl *_PageControl;

    NSTimer *_timer;

    NSInteger _currentIndex;

    NSInteger _MaxImageCount;

    BOOL _isNetwork;

    BOOL _hasTitle;
    
    UIImageView *_img;
    
    UIView *_titleView;
}


- (void)setMaxImageCount:(NSInteger)MaxImageCount {
    _MaxImageCount = MaxImageCount;
    
    [self prepareImageView];
    [self preparePageControl];
    
    [self setUpTimer];
    
//    _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
// 
//    _centerImageView.contentMode = UIViewContentModeScaleAspectFill;
//
//    _rightImageView.contentMode = UIViewContentModeScaleAspectFill;

    [self changeImageLeft:_MaxImageCount-1 center:0 right:1];
}


- (void)imageViewDidTap {
    if (self.imageViewDidTapAtIndex != nil) {
        self.imageViewDidTapAtIndex(_currentIndex);
    }
}

+ (instancetype)j_picScrollViewWithFrame:(CGRect)frame WithImageUrls:(NSArray<NSString *> *)imageUrl {
    return  [[JPicScrollerView alloc] initWithFrame:frame WithImageNames:imageUrl];
}
+ (instancetype)j_picScrollViewWithFrame:(CGRect)frame{
    return [[JPicScrollerView alloc]initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame WithImageNames:(NSArray<NSString *> *)ImageName {
    self = [super initWithFrame:frame];
    if (ImageName.count) {
        [self setImageUrlStrings:ImageName];
    }
    return self;
}

- (void)setImageUrlStrings:(NSArray *)imageUrlStrings{
    _imageUrlStrings = imageUrlStrings;
    if (_imageUrlStrings.count < 1) {
        return ;
    }
    [self prepareScrollView];
    [self setMaxImageCount:self.imageUrlStrings.count];
}
- (void)prepareScrollView {
    
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:sc];
    
    _scrollView = sc;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    
    _scrollView.contentSize = CGSizeMake(myWidth * 3,0);
    
    _AutoScrollDelay = 2.0f;
    _currentIndex = 0;
}

- (void)prepareImageView {
    
    UIImageView *left = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,myWidth, myHeight)];
    UIImageView *center = [[UIImageView alloc] initWithFrame:CGRectMake(myWidth, 0,myWidth, myHeight)];
    UIImageView *right = [[UIImageView alloc] initWithFrame:CGRectMake(myWidth * 2, 0,myWidth, myHeight)];
    
    center.userInteractionEnabled = YES;
    [center addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidTap)]];
    
    [_scrollView addSubview:left];
    [_scrollView addSubview:center];
    [_scrollView addSubview:right];
    
    _leftImageView = left;
    _centerImageView = center;
    _rightImageView = right;
    
}

- (void)preparePageControl {
    
    JPageControl *page = [[JPageControl alloc] initWithFrame:CGRectMake(0,myHeight - pageSize,myWidth, 7)];
    
    
    page.pageIndicatorTintColor = [UIColor lightGrayColor];
    page.currentPageIndicatorTintColor =  [UIColor whiteColor];
    page.numberOfPages = _MaxImageCount;
    page.currentPage = 0;
    
    [self addSubview:page];
    
    
    _PageControl = page;
}

- (void)setStyle:(PageControlStyle)style {
    CGFloat w = _MaxImageCount * 17.5;
    _PageControl.frame = CGRectMake(0, 0, w, 7);
    
    if (style == PageControlAtRight || _hasTitle) {
        _PageControl.center = CGPointMake(myWidth-w*0.5, myHeight-pageSize * 0.5);
    }else if(style == PageControlAtCenter) {
        _PageControl.center = CGPointMake(myWidth * 0.5,myHeight-pageSize * 0.5);
    }
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    _PageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    _PageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}

- (void)setImagePageStateNormal:(UIImage *)imagePageStateNormal{
    _PageControl.imagePageStateNormal = imagePageStateNormal;
}
- (void)setImagePageStateHighlighted:(UIImage *)imagePageStateHighlighted{
    _PageControl.imagePageStateHighlighted = imagePageStateHighlighted;
}



- (void)setTitleData:(NSArray<NSString *> *)titleData {
    if (titleData.count < 1)  return;
    
    if (titleData.count == 1) {
        _titleLabel.text = titleData.firstObject;
        return;
    }
    
    if (titleData.count < _imageUrlStrings.count) {
        NSMutableArray *temp = [NSMutableArray arrayWithArray:titleData];
        for (int i = 0; i < _imageUrlStrings.count - titleData.count; i++) {
            [temp addObject:@""];
        }
        _titleData = temp;
    }else {
        
        _titleData = titleData;
    }
    
    [self prepareTitleLabel];
    _hasTitle = YES;
    [self changeImageLeft:_MaxImageCount-1 center:0 right:1];
}


- (void)prepareTitleLabel {
    
    [self setStyle:PageControlAtRight];
    
    UIView *titleView = [self creatLabelBgView];
    
    _titleLabel = (UILabel *)titleView.subviews.firstObject;
    
    [self addSubview:titleView];
    
    [self bringSubviewToFront:_PageControl];
}



- (UIView *)creatLabelBgView {
    
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, myHeight-pageSize, myWidth, pageSize)];
    v.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8,0, myWidth-_PageControl.frame.size.width-16,pageSize)];
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:pageSize*0.5];
    
    [v addSubview:label];
    
    return v;
}

- (void)setTextColor:(UIColor *)textColor {
    _titleLabel.textColor = textColor;
}

- (void)setFont:(UIFont *)font {
    _titleLabel.font = font;
}

#pragma mark scrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self setUpTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self changeImageWithOffset:scrollView.contentOffset.x];
}


- (void)changeImageWithOffset:(CGFloat)offsetX {
    
    if (offsetX >= myWidth * 2) {
        _currentIndex++;
        
        if (_currentIndex == _MaxImageCount-1) {
            
            [self changeImageLeft:_currentIndex-1 center:_currentIndex right:0];
            
        }else if (_currentIndex == _MaxImageCount) {
            
            _currentIndex = 0;
            [self changeImageLeft:_MaxImageCount-1 center:0 right:1];
            
        }else {
            [self changeImageLeft:_currentIndex-1 center:_currentIndex right:_currentIndex+1];
        }
        _PageControl.currentPage = _currentIndex;
        
    }
    
    if (offsetX <= 0) {
        _currentIndex--;
        
        if (_currentIndex == 0) {
            
            [self changeImageLeft:_MaxImageCount-1 center:0 right:1];
            
        }else if (_currentIndex == -1) {
            
            _currentIndex = _MaxImageCount-1;
            [self changeImageLeft:_currentIndex-1 center:_currentIndex right:0];
            
        }else {
            [self changeImageLeft:_currentIndex-1 center:_currentIndex right:_currentIndex+1];
        }
        
        _PageControl.currentPage = _currentIndex;
    }
    
}

- (void)changeImageLeft:(NSInteger)LeftIndex center:(NSInteger)centerIndex right:(NSInteger)rightIndex {
    
    if (self.imageUrlStrings.count == 1) {
        if ([[_imageUrlStrings j_objectAtIndex:0] isKindOfClass:[NSString class]] && [[_imageUrlStrings j_objectAtIndex:0] rangeOfString:@"http"].location !=NSNotFound) {
            
            [_leftImageView sd_setImageWithURL:[self setUrlWithIndex:0] placeholderImage:_placeImage];
            [_centerImageView sd_setImageWithURL:[self setUrlWithIndex:0] placeholderImage:_placeImage];
            [_rightImageView sd_setImageWithURL:[self setUrlWithIndex:0] placeholderImage:_placeImage];
            
        }else if([[_imageUrlStrings j_objectAtIndex:0] isKindOfClass:[NSString class]]){
            
            _leftImageView.image =  [self setImageWithIndex:0];
            _centerImageView.image = [self setImageWithIndex:0];
            _rightImageView.image = [self setImageWithIndex:0];
            
        }else{
            
            _leftImageView.image = [_imageUrlStrings j_objectAtIndex:0];
            _centerImageView.image = [_imageUrlStrings j_objectAtIndex:0];
            _rightImageView.image = [_imageUrlStrings j_objectAtIndex:0];
            
        }
        
        
    }else{
        if ([[_imageUrlStrings j_objectAtIndex:LeftIndex] isKindOfClass:[NSString class]]  && [[_imageUrlStrings j_objectAtIndex:LeftIndex] rangeOfString:@"http"].location !=NSNotFound) {
            
            [_leftImageView sd_setImageWithURL:[self setUrlWithIndex:LeftIndex] placeholderImage:_placeImage];
            
        }else if([[_imageUrlStrings j_objectAtIndex:LeftIndex] isKindOfClass:[NSString class]]){
            
            _leftImageView.image = [self setImageWithIndex:LeftIndex];
            
        }else{
            
            _leftImageView.image = [_imageUrlStrings j_objectAtIndex:LeftIndex];

        }
        
        if ([[_imageUrlStrings j_objectAtIndex:centerIndex] isKindOfClass:[NSString class]] && [[_imageUrlStrings j_objectAtIndex:centerIndex] rangeOfString:@"http"].location !=NSNotFound) {
            
            [_centerImageView sd_setImageWithURL:[self setUrlWithIndex:centerIndex] placeholderImage:_placeImage];
            
        }else if([[_imageUrlStrings j_objectAtIndex:centerIndex] isKindOfClass:[NSString class]]){
            
            _centerImageView.image = [self setImageWithIndex:centerIndex];
            
        }else{
            
            _centerImageView.image = [_imageUrlStrings j_objectAtIndex:centerIndex];
            
        }
        
        if ([[_imageUrlStrings j_objectAtIndex:rightIndex] isKindOfClass:[NSString class]] && [[_imageUrlStrings j_objectAtIndex:rightIndex] rangeOfString:@"http"].location !=NSNotFound) {
            
            [_rightImageView sd_setImageWithURL:[self setUrlWithIndex:rightIndex] placeholderImage:_placeImage];
            
        }else if([[_imageUrlStrings j_objectAtIndex:rightIndex] isKindOfClass:[NSString class]]){
            
            _rightImageView.image = [self setImageWithIndex:rightIndex];
            
        }else{
            
            _rightImageView.image = [_imageUrlStrings j_objectAtIndex:rightIndex];
            
        }
    }

    
    if (_hasTitle) {
        _titleLabel.text = [self.titleData objectAtIndex:centerIndex];
    }
    
    [_scrollView setContentOffset:CGPointMake(myWidth, 0)];
}

-(void)setPlaceImage:(UIImage *)placeImage {
//    if (!_isNetwork) return;
    
    _placeImage = placeImage;
    if (_MaxImageCount < 2 && _centerImageView) {
        _centerImageView.image = _placeImage;
    }else {
        [self changeImageLeft:_MaxImageCount-1 center:0 right:1];
    }
}

- (NSURL *)setUrlWithIndex:(NSInteger)index {
    if (index < 0||index >= self.imageUrlStrings.count) {
        return nil;
    }
    return [NSURL URLWithString:(NSString *)[_imageUrlStrings j_objectAtIndex:index]];
}
- (UIImage *)setImageWithIndex:(NSInteger)index {
    if (index < 0||index >= self.imageUrlStrings.count) {
        return _placeImage;
    }
    UIImage *image = [UIImage imageNamed:(NSString *)[_imageUrlStrings j_objectAtIndex:index]];
    return image ? image : _placeImage;
}


- (void)scorll {
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x + myWidth, 0) animated:YES];
}

- (void)setAutoScrollDelay:(NSTimeInterval)AutoScrollDelay {
    _AutoScrollDelay = AutoScrollDelay;
    [self removeTimer];
    [self setUpTimer];
}

- (void)setUpTimer {
    if (_AutoScrollDelay < 0.5||_timer != nil || _imageUrlStrings.count == 1) return;
    
    _timer = [NSTimer timerWithTimeInterval:_AutoScrollDelay target:self selector:@selector(scorll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer {
    if (_timer == nil) return;
    [_timer invalidate];
    _timer = nil;
}

- (void)setImageContentMode:(UIViewContentMode)contentMode {
    
    _leftImageView.contentMode = contentMode;
    
    _centerImageView.contentMode = contentMode;
    
    _rightImageView.contentMode = contentMode;
    
    _leftImageView.clipsToBounds = YES;
    
    _centerImageView.clipsToBounds = YES;
    
    _rightImageView.clipsToBounds = YES;
}

-(void)dealloc {
    [self removeTimer];
}
@end
