//
//  JPicScrollerLabel.m
//  JKitDemo
//
//  Created by Zebra on 16/7/12.
//  Copyright © 2016年 陈杰. All rights reserved.
//
#define myWidth self.frame.size.width
#define myHeight self.frame.size.height / 3.0
#define pageSize (myHeight * 0.2 > 25 ? 25 : myHeight * 0.2)
#define myContentOffset myHeight / 5



#import "JPicScrollerLabel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <JKit/JKit.h>

@interface JPicScrollerLabel () <UIScrollViewDelegate>

@end

@implementation JPicScrollerLabel{
    
    __weak  UIImageView *_leftLeftImageView, *_leftImageView, *_centerImageView, *_rightImageView, *_rightRightImageView;
    
    __weak  UILabel *_leftLeftTitleLabel, *_leftTitleLabel, *_centerTitleLabel, *_rightTitleLabel, *_rightRightTitleLabel;
    
    __weak  UIScrollView *_scrollView;
    
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
    
    [self setUpTimer];
    [self changeImageLeftLeftIndex:_MaxImageCount-2 left:_MaxImageCount-1 center:0 right:1 rightRight:2];
}


- (void)imageViewDidTap {
    if (self.imageViewDidTapAtIndex != nil) {
        self.imageViewDidTapAtIndex(_currentIndex);
    }
}

+ (instancetype)j_picScrollLabelWithFrame:(CGRect)frame{
    return [[JPicScrollerLabel alloc]initWithFrame:frame];
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
//    _scrollView.pagingEnabled = YES;
    _scrollView.scrollEnabled = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    
    _scrollView.contentSize = CGSizeMake(0,myHeight * 5);
    
    _AutoScrollDelay = 2.0f;
    _currentIndex = 0;
}

- (void)prepareImageView {
    UIImageView *leftLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,myWidth, myHeight)];
    UIImageView *left = [[UIImageView alloc] initWithFrame:CGRectMake(0, myHeight,myWidth, myHeight)];
    UIImageView *center = [[UIImageView alloc] initWithFrame:CGRectMake(0, myHeight * 2,myWidth, myHeight)];
    UIImageView *right = [[UIImageView alloc] initWithFrame:CGRectMake(0, myHeight * 3,myWidth, myHeight)];
    UIImageView *rightRight= [[UIImageView alloc] initWithFrame:CGRectMake(0, myHeight * 4,myWidth, myHeight)];

//    left.backgroundColor = JColorWithBlack;
//    center.backgroundColor = JColorWithBlack;
//    right.backgroundColor = JColorWithBlack;
//    leftLeft.backgroundColor = JColorWithBlack;
//    rightRight.backgroundColor = JColorWithBlack;


    
    center.userInteractionEnabled = YES;
    [center addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidTap)]];
    
    [_scrollView addSubview:leftLeft];
    [_scrollView addSubview:left];
    [_scrollView addSubview:center];
    [_scrollView addSubview:right];
    [_scrollView addSubview:rightRight];
    
    _leftLeftImageView = leftLeft;
    _leftImageView = left;
    _centerImageView = center;
    _rightImageView = right;
    _rightRightImageView = rightRight;
    
}



- (void)setTitleData:(NSArray<NSString *> *)titleData {
    if (titleData.count < 1)  return;
    
    if (titleData.count == 1) {
        _leftTitleLabel.text = titleData.firstObject;
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
    [self changeImageLeftLeftIndex:_MaxImageCount-2 left:_MaxImageCount-1 center:0 right:1 rightRight:2];
}


- (void)prepareTitleLabel {
    
    UILabel *leftLeft = [[UILabel alloc] initWithFrame:CGRectMake(0,0, myWidth,myHeight)];
    leftLeft.textAlignment = NSTextAlignmentCenter;
    leftLeft.backgroundColor = [UIColor clearColor];
    leftLeft.textColor = [UIColor whiteColor];
    leftLeft.font = [UIFont systemFontOfSize:11];
    
    UILabel *left = [[UILabel alloc] initWithFrame:CGRectMake(0,0, myWidth,myHeight)];
    left.textAlignment = NSTextAlignmentCenter;
    left.backgroundColor = [UIColor clearColor];
    left.textColor = [UIColor whiteColor];
    left.font = [UIFont systemFontOfSize:11];
    
    UILabel *center = [[UILabel alloc] initWithFrame:CGRectMake(0,0, myWidth,myHeight)];
    center.textAlignment = NSTextAlignmentCenter;
    center.backgroundColor = [UIColor clearColor];
    center.textColor = [UIColor redColor];
    center.font = [UIFont systemFontOfSize:11];
    
    UILabel *right = [[UILabel alloc] initWithFrame:CGRectMake(0,0, myWidth,myHeight)];
    right.textAlignment = NSTextAlignmentCenter;
    right.backgroundColor = [UIColor clearColor];
    right.textColor = [UIColor whiteColor];
    right.font = [UIFont systemFontOfSize:11];
    
    UILabel *rightRight = [[UILabel alloc] initWithFrame:CGRectMake(0,0, myWidth,myHeight)];
    rightRight.textAlignment = NSTextAlignmentCenter;
    rightRight.backgroundColor = [UIColor clearColor];
    rightRight.textColor = [UIColor whiteColor];
    rightRight.font = [UIFont systemFontOfSize:11];
    
    [_leftLeftImageView addSubview:leftLeft];
    [_leftImageView addSubview:left];
    [_centerImageView addSubview:center];
    [_rightImageView addSubview:right];
    [_rightRightImageView addSubview:rightRight];

    _leftLeftTitleLabel = leftLeft;
    _leftTitleLabel = left;
    _centerTitleLabel = center;
    _rightTitleLabel = right;
    _rightRightTitleLabel = rightRight;

}




- (void)setTextColors:(NSArray <UIColor *> *)textColors {
    _textColors = textColors;
    _leftLeftTitleLabel.textColor = [textColors j_objectAtIndex:0];
    _leftTitleLabel.textColor = [textColors j_objectAtIndex:0];
    _centerTitleLabel.textColor = [textColors j_objectAtIndex:1];
    _rightTitleLabel.textColor = [textColors j_objectAtIndex:2];
    _rightRightTitleLabel.textColor = [textColors j_objectAtIndex:2];
}

- (void)setFonts:(NSArray <UIFont *> *)fonts {
    _fonts = fonts;
    _leftLeftTitleLabel.font = [fonts j_objectAtIndex:0];
    _leftTitleLabel.font = [fonts j_objectAtIndex:0];
    _centerTitleLabel.font = [fonts j_objectAtIndex:1];
    _rightTitleLabel.font = [fonts j_objectAtIndex:2];
    _rightRightTitleLabel.font = [fonts j_objectAtIndex:2];
}

#pragma mark scrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self setUpTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self changeImageWithOffset:scrollView.contentOffset.y];
    double x = scrollView.contentOffset.y - myHeight;
    int y = myContentOffset;
    
    
    CGFloat remainder = x / y;
    
    if (_fonts.count && _textColors.count) {
        
        CGFloat edge = _fonts[0].pointSize;
        CGFloat center = _fonts[1].pointSize;
        
        CGFloat poor = (center - edge) / 5.0;
        
        if (remainder >= 0 && remainder < 1) {
            
            _leftTitleLabel.font = _fonts[0];
            _centerTitleLabel.font = _fonts[1];
            _rightTitleLabel.font = _fonts[2];
            
            _leftTitleLabel.textColor = _textColors[0];
            _centerTitleLabel.textColor = _textColors[1];
            _rightTitleLabel.textColor = _textColors[2];
            
        }else if (remainder >= 1 && remainder < 2) {
            
            _leftTitleLabel.font = JFont(edge + poor);
            _centerTitleLabel.font = JFont(center - poor);
            _rightTitleLabel.font = JFont(edge + poor);
            
            _leftTitleLabel.textColor = _textColors[0];
            _centerTitleLabel.textColor = _textColors[1];
            _rightTitleLabel.textColor = _textColors[2];
            
        }else if (remainder >= 2 && remainder < 3) {
            
            _leftTitleLabel.font = JFont(edge + poor * 2);
            _centerTitleLabel.font = JFont(center - poor * 2);
            _rightTitleLabel.font = JFont(edge + poor * 2);
            
            _leftTitleLabel.textColor = _textColors[0];
            _centerTitleLabel.textColor = _textColors[0];
            _rightTitleLabel.textColor = _textColors[2];
            
        }else if (remainder >= 3 && remainder < 4) {
            
            _leftTitleLabel.font = JFont(edge + poor * 3);
            _centerTitleLabel.font = JFont(center - poor * 3);
            _rightTitleLabel.font = JFont(edge + poor * 3);
            
            _leftTitleLabel.textColor = _textColors[0];
            _centerTitleLabel.textColor = _textColors[0];
            _rightTitleLabel.textColor = _textColors[2];
            
        }else{
            
            _leftTitleLabel.font = JFont(edge + poor * 4);
            _centerTitleLabel.font = JFont(center - poor * 4);
            _rightTitleLabel.font = JFont(edge + poor * 4);
            
            _leftTitleLabel.textColor = _textColors[0];
            _centerTitleLabel.textColor = _textColors[0];
            _rightTitleLabel.textColor = _textColors[2];
            
        }
    }

    
}


- (void)changeImageWithOffset:(CGFloat)offsetX {
    
    if (offsetX >= myHeight * 2) {
        _currentIndex++;
        
        if (_currentIndex == _MaxImageCount-1) {
            
            [self changeImageLeftLeftIndex:_MaxImageCount-3 left:_MaxImageCount-2 center:_MaxImageCount-1 right:0 rightRight:1];

        }else if (_currentIndex == _MaxImageCount) {
            
            _currentIndex = 0;
            [self changeImageLeftLeftIndex:_MaxImageCount-2 left:_MaxImageCount-1 center:0 right:1 rightRight:2];
            
        }else{
            
            if (_currentIndex == _MaxImageCount - 2) {
                [self changeImageLeftLeftIndex:_currentIndex - 2 left:_currentIndex - 1 center:_currentIndex right:_currentIndex + 1 rightRight:0];
            }else if(_currentIndex == 1){
                [self changeImageLeftLeftIndex:_MaxImageCount - _currentIndex left:_currentIndex - 1 center:_currentIndex right:_currentIndex + 1 rightRight:_currentIndex + 2];
            }else{
                [self changeImageLeftLeftIndex:_currentIndex - 2 left:_currentIndex - 1 center:_currentIndex right:_currentIndex + 1 rightRight:_currentIndex + 2];
            }

        }
    }
    
    if (offsetX <= 0) {
        _currentIndex--;
        
        if (_currentIndex == 0) {
            
            [self changeImageLeftLeftIndex:_MaxImageCount-2 left:_MaxImageCount-1 center:0 right:1 rightRight:2];
            
        }else if (_currentIndex == -1) {
            
            _currentIndex = _MaxImageCount-1;
            [self changeImageLeftLeftIndex:_currentIndex-2 left:_currentIndex-1 center:_currentIndex right:0 rightRight:1];
            
        }else {
            if (_currentIndex == _MaxImageCount - 2) {
                [self changeImageLeftLeftIndex:_currentIndex - 2 left:_currentIndex - 1 center:_currentIndex right:_currentIndex + 1 rightRight:0];
            }else if(_currentIndex == 1){
                [self changeImageLeftLeftIndex:_MaxImageCount - _currentIndex  left:_currentIndex-1 center:_currentIndex right:_currentIndex + 1 rightRight:_currentIndex + 2];
            }else{
                [self changeImageLeftLeftIndex:_currentIndex - 2 left:_currentIndex-1 center:_currentIndex right:_currentIndex + 1 rightRight:_currentIndex + 2];
            }
            

        }
        
    }
    
}

- (void)changeImageLeftLeftIndex:(NSInteger)leftLeftIndex left:(NSInteger)leftIndex center:(NSInteger)centerIndex right:(NSInteger)rightIndex rightRight:(NSInteger)rightRightIndex{
    
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
        if ([[_imageUrlStrings j_objectAtIndex:leftIndex] isKindOfClass:[NSString class]]  && [[_imageUrlStrings j_objectAtIndex:leftIndex] rangeOfString:@"http"].location !=NSNotFound) {
            
            [_leftImageView sd_setImageWithURL:[self setUrlWithIndex:leftIndex] placeholderImage:_placeImage];
            
        }else if([[_imageUrlStrings j_objectAtIndex:leftIndex] isKindOfClass:[NSString class]]){
            
            _leftImageView.image = [self setImageWithIndex:leftIndex];
            
        }else{
            
            _leftImageView.image = [_imageUrlStrings j_objectAtIndex:leftIndex];
            
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
        _leftLeftTitleLabel.text = [self.titleData objectAtIndex:leftLeftIndex];
        _leftTitleLabel.text = [self.titleData objectAtIndex:leftIndex];
        _centerTitleLabel.text = JStringAndString([self.titleData objectAtIndex:centerIndex], @">") ;
        _rightTitleLabel.text = [self.titleData objectAtIndex:rightIndex];
        _rightRightTitleLabel.text = [self.titleData objectAtIndex:rightRightIndex];
    }
    
    [_scrollView setContentOffset:CGPointMake(0, myHeight)];
}

-(void)setPlaceImage:(UIImage *)placeImage {
//    if (!_isNetwork) return;
    
    _placeImage = placeImage;
    if (_MaxImageCount < 2 && _centerImageView) {
        _centerImageView.image = _placeImage;
    }else {
        [self changeImageLeftLeftIndex:_MaxImageCount-2 left:_MaxImageCount-1 center:0 right:1 rightRight:2];
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
    [_scrollView setContentOffset:CGPointMake(0,_scrollView.contentOffset.y + myHeight) animated:YES];
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

-(void)dealloc {
    [self removeTimer];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
