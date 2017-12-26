//
//  JPagerViewController.m
//  JKitDemo
//
//  Created by Zebra on 16/3/31.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "JPagerViewController.h"
#import "JPagerMacro.h"
#import <JKit/JKit.h>


#define MaxNums  10
@interface JPagerViewController ()<NSCacheDelegate> {
    
    CGFloat _topBarHeight;
    
}

@property (nonatomic, strong)NSCache *limitControllerCache; /**< 内存管理，避免创建过多的控制器所导致内存过于庞大   **/
@property (strong, nonatomic) UIColor *selectColor; /**<  选中时的颜色   **/
@property (strong, nonatomic) UIColor *unselectColor; /**<  未选中时的颜色   **/
@property (strong, nonatomic) UIColor *underlineColor; /**<  下划线的颜色   **/
@property (strong, nonatomic) UIColor *topTabColor; /**<  顶部菜单栏的背景颜色   **/
@property (copy, nonatomic) NSString *PageIndex; /**< 所在的控制器index或点击上方button的index **/


@property (nonatomic, strong) NSArray *myArray;

@property (nonatomic, strong)  NSArray *classArray;

@property (nonatomic, strong) UIViewController *superClass;

@property (nonatomic, assign) NSInteger defaultIndex;

@end

@implementation JPagerViewController
{
    NSMutableArray *viewNumArray;
    NSMutableArray *vcsTagArray;
    NSMutableArray *vcsArray;
    BOOL viewAlloc[MaxNums];
    BOOL fontChangeColor;
}

- (void)setIsUnnecessary:(BOOL)isUnnecessary{
    _isUnnecessary = isUnnecessary;
}

+ (void)j_createPagerViewControllerWithFrame:(CGRect)frame
                               andSuperClass:(UIViewController *)superClass
                                   andTitles:(NSArray *)titles
                                 andchildVCs:(NSArray *)childVCs
                              andSelectColor:(UIColor *)selectColor
                            andUnselectColor:(UIColor *)unselectColor
                           andUnderlineColor:(UIColor *)underlineColor
                            andTopTabBgColor:(UIColor *)topTabColor
                  andDeallocVCsIfUnnecessary:(BOOL)isUnnecessary
                             andDefaultIndex:(NSInteger)index
                                andTitleFont:(UIFont *)titleFont
                           andSelectCallBack:(JPagerViewControllerBlock)block {
    
    JPagerViewController *ninaPagerView = [[JPagerViewController alloc] initWithFrame:frame];
    ninaPagerView.superClass = superClass;
    ninaPagerView.myArray = titles;
    ninaPagerView.classArray = childVCs;
    ninaPagerView.selectColor = selectColor;
    ninaPagerView.unselectColor = unselectColor;
    ninaPagerView.topTabColor = topTabColor;
    ninaPagerView.underlineColor = underlineColor;
    ninaPagerView.isUnnecessary = isUnnecessary;
    ninaPagerView.defaultIndex = index;
    ninaPagerView.block = block;
    [superClass.view addSubview:ninaPagerView];
    
    [ninaPagerView createPagerViewWithFrame:frame andTitleFont:titleFont];
    
}

- (instancetype)initWithFrame:(CGRect)frame
                andSuperClass:(UIViewController *)superClass
                    andTitles:(NSArray *)titles
                  andchildVCs:(NSArray *)childVCs
               andSelectColor:(UIColor *)selectColor
             andUnselectColor:(UIColor *)unselectColor
            andUnderlineColor:(UIColor *)underlineColor
             andTopTabBgColor:(UIColor *)topTabColor
   andDeallocVCsIfUnnecessary:(BOOL)isUnnecessary
              andDefaultIndex:(NSInteger)index
                 andTitleFont:(UIFont *)titleFont
            andSelectCallBack:(JPagerViewControllerBlock)block {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.superClass = superClass;
        self.myArray = titles;
        self.classArray = childVCs;
        self.selectColor = selectColor;
        self.unselectColor = unselectColor;
        self.topTabColor = topTabColor;
        self.underlineColor = underlineColor;
        self.isUnnecessary = isUnnecessary;
        self.defaultIndex = index;
        self.block = block;
        
        [self createPagerViewWithFrame:frame andTitleFont:titleFont];
    }
    return self;
}

#pragma mark - NSCache
- (NSCache *)limitControllerCache {
    if (!_limitControllerCache) {
        _limitControllerCache = [NSCache new];
        _limitControllerCache.delegate = self;
    }
    /**< 设置最大控制器的数量   **/
    _limitControllerCache.countLimit = 5;
    return _limitControllerCache;
}

#pragma mark - CreateView
- (void)createPagerViewWithFrame:(CGRect)frame andTitleFont:(UIFont *)titleFont{
    viewNumArray = [NSMutableArray array];
    vcsArray = [NSMutableArray array];
    vcsTagArray = [NSMutableArray array];
    if (!_topBarHeight) {
        _topBarHeight = PageBtn;
    }
    if (_myArray.count > self.defaultIndex && _classArray.count > self.defaultIndex) {
        _pagerView = [[JPagerBaseViewController alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) WithSelectColor:_selectColor WithUnselectorColor:_unselectColor WithUnderLineColor:_underlineColor WithtopTabColor:_topTabColor andTitleFont:titleFont];
        _pagerView.titleArray = _myArray;
        [_pagerView addObserver:self forKeyPath:@"currentPage" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
        [self addSubview:_pagerView];
        //First ViewController present to the screen
        if (_classArray.count > self.defaultIndex && _myArray.count > self.defaultIndex) {
            NSString *className = _classArray[self.defaultIndex];
            Class class = NSClassFromString(className);
            if (class) {
                UIViewController *ctrl = class.new;
                
                ctrl.view.frame = CGRectMake(FUll_VIEW_WIDTH * self.defaultIndex, 0, FUll_VIEW_WIDTH, FUll_CONTENT_HEIGHT - _topBarHeight);
                [_pagerView.scrollView addSubview:ctrl.view];
                viewAlloc[self.defaultIndex] = YES;
                [vcsArray addObject:ctrl];
                [vcsTagArray addObject:[NSString stringWithFormat:@"%ld",(long)self.defaultIndex]];
                JLog(@"现在是控制器%ld",(long)self.defaultIndex);
                self.PageIndex = [NSString stringWithFormat:@"%ld",(long)self.defaultIndex];
                _block(self.defaultIndex);
//                /**< 利用NSCache对内存进行管理测试 **/
//                [self.limitControllerCache setObject:ctrl forKey:@(0)];
//                NSLog(@"%@", [self.limitControllerCache objectForKey:@(0)]);
//                UIView *view = class.new;
//                view.frame = CGRectMake(FUll_VIEW_WIDTH * 0, 0, FUll_VIEW_WIDTH, FUll_CONTENT_HEIGHT - PageBtn);
//                [_pagerView.scrollView addSubview:view];
//                viewAlloc[0] = YES;
            }
        }
    }else {
        JLog(@"You should correct titlesArray or childVCs count!");
    }
}

- (void)j_setPagerViewControllerWithIndex:(NSInteger)index {
    [_pagerView.scrollView setContentOffset:CGPointMake(FUll_VIEW_WIDTH * index, 0) animated:YES];
    _pagerView.currentPage = (FUll_VIEW_WIDTH * index + FUll_VIEW_WIDTH / 2) / FUll_VIEW_WIDTH;
}



#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"currentPage"]) {
        if (!_topBarHeight) {
            _topBarHeight = PageBtn;
        }
        NSInteger page = [change[@"new"] integerValue];
        JLog(@"现在是控制器%li",(long)page);
        self.PageIndex = @(page).stringValue;
        _block(page);
        if (_myArray.count > 5) {
            CGFloat topTabOffsetX = 0;
            if (page >= 2) {
                if (page <= _myArray.count - 3) {
                    topTabOffsetX = (page - 2) * More5LineWidth;
                }
                else {
                    if (page == _myArray.count - 2) {
                        topTabOffsetX = (page - 3) * More5LineWidth;
                    }else {
                        topTabOffsetX = (page - 4) * More5LineWidth;
                    }
                }
            }
            else {
                if (page == 1) {
                    topTabOffsetX = 0 * More5LineWidth;
                }else {
                    topTabOffsetX = page * More5LineWidth;
                }
            }
            [_pagerView.topTab setContentOffset:CGPointMake(topTabOffsetX, 0) animated:YES];
        }
        for (NSInteger i = 0; i < _myArray.count; i++) {
            if (page == i && i <= _classArray.count - 1) {
                NSString *className = _classArray[i];
                Class class = NSClassFromString(className);
                if (class && viewAlloc[i] == NO) {
                    UIViewController *ctrl = class.new;
                    [vcsArray addObject:ctrl];
                    NSString *tagStr = @(i).stringValue;
                    [vcsTagArray addObject:tagStr];
                    /**< 利用NSCache管理内存的尝试 **/
                    //                    [self.limitControllerCache setObject:ctrl forKey:@(i + 1)];
                    //                    NSLog(@"%@", [self.limitControllerCache objectForKey:@(i + 1)]);
                    /**<  内存管理限制控制器最大数量为5个   **/
                    if (vcsArray.count > 5 && _isUnnecessary) {
                        UIViewController *deallocVC = [vcsArray firstObject];
                        [deallocVC.view removeFromSuperview];
                        deallocVC.view = nil;
                        deallocVC = nil;
                        [vcsArray removeObjectAtIndex:0];
                        NSInteger deallocTag = [[vcsTagArray firstObject] integerValue];
                        viewAlloc[deallocTag] = NO;
                        JLog(@"控制器%li被清除了",(long)deallocTag + 1);
                        [vcsTagArray removeObjectAtIndex:0];
                    }else if (vcsArray.count > 1 && !_isUnnecessary){
                        UIViewController *deallocVC = [vcsArray firstObject];
                        [deallocVC.view removeFromSuperview];
                        deallocVC.view = nil;
                        deallocVC = nil;
                        [vcsArray removeObjectAtIndex:0];
                        NSInteger deallocTag = [[vcsTagArray firstObject] integerValue];
                        viewAlloc[deallocTag] = NO;
                        JLog(@"控制器%li被清除了",(long)deallocTag + 1);
                        [vcsTagArray removeObjectAtIndex:0];
                    }
                    ctrl.view.frame = CGRectMake(FUll_VIEW_WIDTH * i, 0, FUll_VIEW_WIDTH, FUll_CONTENT_HEIGHT - _topBarHeight);
                    [_pagerView.scrollView addSubview:ctrl.view];
                    viewAlloc[i] = YES;
                    //                    UIView *view = class.new;
                    //                    view.frame = CGRectMake(FUll_VIEW_WIDTH * i, 0, FUll_VIEW_WIDTH, FUll_CONTENT_HEIGHT - PageBtn);
                    //                    [pagerView.scrollView addSubview:view];
                    //                    viewAlloc[i] = YES;
                }else if (!class) {
                    JLog(@"您所提供的vc%li类并没有找到。  Your Vc%li is not found in this project!",(long)i + 1,(long)i + 1);
                }
            }else if (page == i && i > _classArray.count - 1) {
                JLog(@"您没有配置对应Title%li的VC",(long)i + 1);
            }else {
                /**<  内存管理限制控制器最大数量为5个   **/
                if (vcsArray.count > 5 && _isUnnecessary) {
                    UIViewController *deallocVC = [vcsArray firstObject];
                    [deallocVC.view removeFromSuperview];
                    deallocVC.view = nil;
                    deallocVC = nil;
                    [vcsArray removeObjectAtIndex:0];
                    NSInteger deallocTag = [[vcsTagArray firstObject] integerValue];
                    viewAlloc[deallocTag] = NO;
                    [vcsTagArray removeObjectAtIndex:0];
                }else if (vcsArray.count > 1 && !_isUnnecessary){
                    UIViewController *deallocVC = [vcsArray firstObject];
                    [deallocVC.view removeFromSuperview];
                    deallocVC.view = nil;
                    deallocVC = nil;
                    [vcsArray removeObjectAtIndex:0];
                    NSInteger deallocTag = [[vcsTagArray firstObject] integerValue];
                    viewAlloc[deallocTag] = NO;
                    JLog(@"控制器%li被清除了",(long)deallocTag + 1);
                    [vcsTagArray removeObjectAtIndex:0];
                }
                
            }
        }
    }
}

- (void)j_1setPagerViewTopBarWithWidth:(CGFloat)width andHeight:(CGFloat)height andAlpha:(CGFloat)alpha {
    
    _topBarHeight = height;
    
    [_pagerView setPagerViewTopBarWithWidth:width andHeight:height andAlpha:alpha];
    
    for (UIViewController *vc in vcsArray) {
        
        vc.view.frame = CGRectMake(FUll_VIEW_WIDTH * self.defaultIndex, 0, FUll_VIEW_WIDTH, FUll_CONTENT_HEIGHT - _topBarHeight);
        
    }
    
}

- (void)j_2setPagerViewLineViewWithWidth:(CGFloat)width andHeight:(CGFloat)height andY:(CGFloat)y {
    
    [_pagerView setPagerViewLineViewWithWidth:width andHeight:height andY:y];
    
}

- (void)dealloc {
    [_pagerView removeObserver:self forKeyPath:@"currentPage"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  NSCache的代理方法，打印当前清除对象 */
- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    JLog(@"清除了-------> %@", obj);
}



@end
