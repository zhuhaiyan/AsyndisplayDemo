//
//  JTabBarController.m
//  JKitDemo
//
//  Created by Zebra on 16/6/7.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "JTabBarController.h"
#import "JTabBarButton.h"

@interface JTabBarController ()<UIAlertViewDelegate>{
    NSInteger count;
    NSMutableArray * btnArray;
}

@end

@implementation JTabBarController

- (instancetype)init{
    self = [super init];
    if (self) {
        
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideTabBar:) name:JTabBarHidden object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mTabSelectIndex:) name:JTabBarSelectIndex object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    btnArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self hideOriginalTab];
    self.tabBarView = [[UIView alloc]init];
    self.tabBarView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49, [UIScreen mainScreen].bounds.size.width, 49);
    self.tabBarView.backgroundColor = JColorWithHex(0xffffff);
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, JScreenWidth, 0.5)];
    lineView.backgroundColor = JColorWithHex(0xebe8e8);
    [self.tabBarView addSubview:lineView];
    [self.view addSubview:self.tabBarView];
}

- (void)backBtnClick:(NSNotification *)notif {
    [self.navigationController popViewControllerAnimated:YES];
}

//隐藏tabbar  yes 隐藏  no 显示
- (void)hideTabBar:(NSNotification *)notify {
    
    BOOL value = [notify.object boolValue];

    self.tabBar.translucent = value;
    
    [UIView animateWithDuration:0.2
                          delay:0.00
                        options:UIViewAnimationOptionTransitionCurlUp animations:^(void){
                            if (value) {
                                self.tabBarView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 49);
                            }else{
                                self.tabBarView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49, [UIScreen mainScreen].bounds.size.width, 49);
                            }
                        }completion:nil];
}


//给tabbar自定义按钮或其他控件
- (void)setTabWithArray:(NSArray *)tabArray
    andNormalImageArray:(NSArray *)normalImages
  andSelectedImageArray:(NSArray *)selectedImages
              andTitles:(NSArray *)titles{
    
    self.viewControllers = tabArray;
    count = [tabArray count];
    if([btnArray count]==0)
    {
        if (tabArray.count > 0) {
            
            for (int i = 0; i < [tabArray count]; i ++) {
                JTabBarButton *btn = [JTabBarButton buttonWithType:UIButtonTypeCustom];
                btn.adjustsImageWhenHighlighted = NO;
                [btn setBackgroundImage:[UIImage imageNamed:[selectedImages objectAtIndex:i]] forState:UIControlStateSelected];
                [btn setBackgroundImage:[UIImage imageNamed:[normalImages objectAtIndex:i]] forState:UIControlStateNormal];
                [btn setBackgroundColor:[UIColor clearColor]];
                [btn setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
                btn.titleEdgeInsets = UIEdgeInsetsMake(30, 0, 0, 0);
                btn.titleLabel.font = [UIFont systemFontOfSize:10];
                btn.tag = i ;
                if (btn.tag == self.selectedIndex){
                    btn.selected = YES;
                }else{
                    btn.selected = NO;
                }
                btn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/[tabArray count]*i, 0, [UIScreen mainScreen].bounds.size.width/[tabArray count], 49);
                
                [btn addTarget:self action:@selector(selectTab:) forControlEvents:UIControlEventTouchUpInside];
                [self.tabBarView addSubview:btn];
                [btnArray addObject:btn];
            }
        }
    }
}


- (void)setTabWithArray:(NSArray *)tabArray
         andNomalTitles:(NSArray *)nomalTitles
      andSelectedTitles:(NSArray *)selectedTitles
     andNomalTitleColor:(UIColor *)nomalTitleColor
  andSelectedTitleColor:(UIColor *)selectedTitleColor
    andNormalImageArray:(NSArray *)normalImages
  andSelectedImageArray:(NSArray *)selectedImages
      andNomalBackimage:(NSArray *)nomalBackImages
   andSelectedBackimage:(NSArray *)selectedBackImages
{
    self.viewControllers = tabArray;
    count = [tabArray count];
    if([btnArray count] == 0)
    {
        if (tabArray.count > 0) {
            
            for (int i = 0; i < [tabArray count]; i ++) {
                UIButton *btn;
                if ([UIImage imageNamed:[nomalBackImages objectAtIndex:i]]) {
                    btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    [btn setImage:[UIImage imageNamed:[nomalBackImages objectAtIndex:i]] forState:UIControlStateNormal];
                    [btn setImage:[UIImage imageNamed:[selectedBackImages objectAtIndex:i]] forState:UIControlStateSelected];
                }else{
                    btn = [JTabBarButton buttonWithType:UIButtonTypeCustom];
                    [btn setImage:[UIImage imageNamed:[selectedImages objectAtIndex:i]] forState:UIControlStateSelected];
                    [btn setImage:[UIImage imageNamed:[normalImages objectAtIndex:i]] forState:UIControlStateNormal];
                    [btn setTitle:[nomalTitles objectAtIndex:i] forState:UIControlStateNormal];
                    [btn setTitle:[selectedTitles objectAtIndex:i] forState:UIControlStateSelected];
                    [btn setTitleColor:nomalTitleColor forState:UIControlStateNormal];
                    [btn setTitleColor:selectedTitleColor forState:UIControlStateSelected];
                }
                
                btn.titleLabel.font = [UIFont boldSystemFontOfSize:10.0f];
                btn.adjustsImageWhenHighlighted = NO;
                
                btn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/[tabArray count]*i, 0, [UIScreen mainScreen].bounds.size.width/[tabArray count], 49);
                [btn setBackgroundColor:[UIColor clearColor]];
                btn.titleLabel.textAlignment = NSTextAlignmentCenter;
                btn.tag = i;
                if (btn.tag == self.selectedIndex){
                    btn.selected = YES;
                }else{
                    btn.selected = NO;
                }
                
                [btn addTarget:self action:@selector(selectTab:) forControlEvents:UIControlEventTouchUpInside];
                [self.tabBarView addSubview:btn];
                [btnArray addObject:btn];
                
            }
        }
        
    }
    
}

- (void)setBlock:(JTabBarSelectIndexBlock)block {
    
    _block = block;
    
}

- (void)selectTab:(UIButton *)selectBtn {
    
    
    if (_block) {
        
        BOOL isDelegate = _block(selectBtn.tag);
        
        if(selectBtn.selected == NO && isDelegate == YES)
        {
            NSInteger selectTag = selectBtn.tag;
            selectBtn.selected = YES;
            
            UIViewController *selectVC = [self.viewControllers objectAtIndex:selectTag];
            
            self.selectedViewController = selectVC;
            
            for(int i = 0; i < count; i++)
            {
                UIButton *btn = (UIButton *)[btnArray objectAtIndex:i];
                if (btn.tag != selectTag){
                    btn.selected = NO;
                }
                else{
                    btn.selected = YES;
                }
            }
        }

        
    } else if(selectBtn.selected == NO) {
        NSInteger selectTag = selectBtn.tag;
        selectBtn.selected = YES;
        
        UIViewController *selectVC = [self.viewControllers objectAtIndex:selectTag];
        
        self.selectedViewController = selectVC;
        
        for(int i = 0; i < count; i++)
        {
            UIButton *btn = (UIButton *)[btnArray objectAtIndex:i];
            if (btn.tag != selectTag){
                btn.selected = NO;
            }
            else{
                btn.selected = YES;
            }
        }
    }
}

- (void)hideOriginalTab {
    NSArray *array = [self.view subviews];
    for (int i = 0; i < array.count; i++) {
        UIView *originalTabView = [array objectAtIndex:i];
        originalTabView.frame = CGRectMake(0,[UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 49);
        originalTabView.backgroundColor = [UIColor clearColor];
        UIView *newTabView = [array objectAtIndex:0];
        newTabView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }
    
}




- (void)mTabSelectIndex:(NSNotification *)notify{
    NSInteger value = [notify.object integerValue];
    UIViewController *selectVC = [self.viewControllers objectAtIndex:value];
    self.selectedViewController = selectVC;
    for(int i = 0; i < count; i++) {
        UIButton *btn = (UIButton *)[btnArray objectAtIndex:i];
        if (btn.tag != value)
            btn.selected = NO;
        else
            btn.selected = YES;
    }
}


- (void)selectIndex:(int)index
{
    UIViewController *selectVC = [self.viewControllers objectAtIndex:index];
    self.selectedViewController = selectVC;
    for(int i = 0; i < count; i++) {
        UIButton *btn = (UIButton *)[btnArray objectAtIndex:i];
        if (btn.tag != index)
            btn.selected = NO;
        else
            btn.selected = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
