//
//  JCustomPickerView.h
//  JKitDemo
//
//  Created by Zebra on 16/4/11.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCustomPickerView : UIView

@property (assign,nonatomic) id <UIPickerViewDataSource> j_dataSource;
@property (assign, nonatomic) id <UIPickerViewDelegate> j_delegate;

@property (strong, nonatomic) UIPickerView *j_pickerView;

/**
 *  @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17], NSForegroundColorAttributeName: JColorWithRed}
 */
@property (strong, nonatomic) NSDictionary *j_itemBarAttributes;

- (void)j_addBarItem:(UIBarButtonItem *)barItem attributes:(NSDictionary *)attributes;

- (void)setCancelBarButtonItemTitle:(NSString *)cancelBarButtonItemTitle;

- (void)setDoneBarButtonItemTitle:(NSString *)doneBarButtonItemTitle;

- (void)j_showPickerViewWithCancel:(dispatch_block_t)cancelAction done:(dispatch_block_t)doneAction;

- (void)j_dismiss;
@end
