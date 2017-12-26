//
//  JCustomPickerView.m
//  JKitDemo
//
//  Created by Zebra on 16/4/11.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "JCustomPickerView.h"
#import <JKit/JKit.h>

@interface JCustomPickerView ()

@property (strong, nonatomic) UIToolbar *toolBar;

@property (strong, nonatomic) UIBarButtonItem *spaceBarButtonItem;

@property (strong, nonatomic) UIBarButtonItem *edgeBarButtonItem;

@property (strong, nonatomic) UIBarButtonItem *cancelBarButtonItem;

@property (strong, nonatomic) UIBarButtonItem *doneBarButtonItem;

@property (strong, nonatomic) UIControl *control;

@property (strong, nonatomic) UIView *backgroundView;

@property (assign, nonatomic) BOOL isShow;

@property (copy, nonatomic) dispatch_block_t cancelBlock;

@property (copy, nonatomic) dispatch_block_t doneBlock;

@end

@implementation JCustomPickerView
- (UIPickerView *)pickerView {
    
    if (!_j_pickerView) {
        
        _j_pickerView = [[UIPickerView alloc] init];
        _j_pickerView.delegate = self.j_delegate;
        _j_pickerView.dataSource = self.j_dataSource;
        _j_pickerView.backgroundColor = JColorWithWhite;
        
        _j_pickerView.frame = CGRectMake(0, JScreenHeight - 216, JScreenWidth, 216);
    }
    
    return _j_pickerView;
}

- (UIToolbar *)toolBar {
    
    if (!_toolBar) {
        
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, JScreenHeight - 44 - 216, JScreenWidth, 44)];
        
        _toolBar.items = @[self.edgeBarButtonItem, self.cancelBarButtonItem, self.spaceBarButtonItem, self.doneBarButtonItem, self.edgeBarButtonItem];
    }
    
    return _toolBar;
}

- (UIBarButtonItem *)spaceBarButtonItem {
    
    if (!_spaceBarButtonItem) {
        
        _spaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    }
    
    return _spaceBarButtonItem;
}

- (UIBarButtonItem *)edgeBarButtonItem {
    
    if (!_edgeBarButtonItem) {
        
        _edgeBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 0)]];
    }
    
    return _edgeBarButtonItem;
}

- (UIBarButtonItem *)cancelBarButtonItem {
    
    if (!_cancelBarButtonItem) {
        
        _cancelBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAction)];
    }
    
    return _cancelBarButtonItem;
}

- (void)setCancelBarButtonItemTitle:(NSString *)cancelBarButtonItemTitle{
    [_cancelBarButtonItem setTitle:cancelBarButtonItemTitle];
}

- (UIBarButtonItem *)doneBarButtonItem {
    
    if (!_doneBarButtonItem) {
        
        _doneBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(doneAction)];
    }
    
    return _doneBarButtonItem;
}

- (void)setDoneBarButtonItemTitle:(NSString *)doneBarButtonItemTitle{
    [_doneBarButtonItem setTitle:doneBarButtonItemTitle];
}

- (void)j_addBarItem:(UIBarButtonItem *)barItem attributes:(NSDictionary *)attributes
{
    if (attributes) {
        [barItem setTitleTextAttributes:attributes forState:UIControlStateNormal];
    }else if (self.j_itemBarAttributes) {
        [barItem setTitleTextAttributes:self.j_itemBarAttributes forState:UIControlStateNormal];
    }
    
    self.toolBar.items = @[self.edgeBarButtonItem, self.cancelBarButtonItem, self.spaceBarButtonItem, barItem, self.spaceBarButtonItem, self.doneBarButtonItem, self.edgeBarButtonItem];
}

- (void)j_showPickerViewWithCancel:(dispatch_block_t)cancelAction done:(dispatch_block_t)doneAction
{
    if (self.j_itemBarAttributes) {
        
        [self.cancelBarButtonItem setTitleTextAttributes:self.j_itemBarAttributes forState:UIControlStateNormal];
        [self.doneBarButtonItem setTitleTextAttributes:self.j_itemBarAttributes forState:UIControlStateNormal];
    }
    
    self.cancelBlock = cancelAction;
    self.doneBlock = doneAction;
    
    if (_isShow) {
        
        [self cancelAction];
        
        return;
    }
    
    _isShow = YES;
    
    _control = [[UIControl alloc] initWithFrame:JScreenBounds];
    _backgroundView = [[UIView alloc] initWithFrame:JScreenBounds];
    
    _control.j_top = JScreenHeight;
    
    [UIView animateWithDuration:.25 animations:^{
        
        _control.j_top = 0;
        
    }];
    
    [UIView animateWithDuration:.25 animations:^{
        
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }];
    
    [_control addSubview:self.toolBar];
    [_control addSubview:self.pickerView];
    [[UIApplication sharedApplication].keyWindow addSubview:_backgroundView];
    [[UIApplication sharedApplication].keyWindow addSubview:_control];
    
    if (IOS8) {
        
        [_control j_addTapGesture:^(UITapGestureRecognizer *gestureRecognizer) {
            
            [self cancelAction];
        }];
        
    } else {
        
        [_backgroundView j_addTapGesture:^(UITapGestureRecognizer *gestureRecognizer) {
            
            [self cancelAction];
        }];
    }
}

- (void)j_dismiss
{
    if (!_isShow) {
        
        return;
    }
    
    _isShow = NO;
    
    [UIView animateWithDuration:.25 animations:^{
        
        _control.j_top = JScreenHeight;
        _backgroundView.backgroundColor = JColorWithClear;
        
    } completion:^(BOOL finished) {
        
        if (finished) {
            
            [_j_pickerView removeFromSuperview];
            [_control removeFromSuperview];
            [_backgroundView removeFromSuperview];
        }
    }];
}

- (void)cancelAction
{
    JBlock(self.cancelBlock);
    
    [self j_dismiss];
}

- (void)doneAction
{
    JBlock(self.doneBlock);
    
    [self j_dismiss];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
