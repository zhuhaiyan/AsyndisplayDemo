//
//  JPickView.h
//  ActionSheet
//
//  Created by 陈杰 on 15/10/22.
//  Copyright © 2015年 chenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JKit/JKit.h>

typedef void (^JPickViewSubmit)(NSString*selectStr);

@interface JPickView : UIView<UIPickerViewDelegate>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) NSArray *proTitleList;

@property (nonatomic, copy) NSString *selectedStr;

@property (nonatomic, assign) BOOL isDate;

@property (nonatomic, assign) UIDatePickerMode mode;



/**
 *  PickerView
 *
 *  @param items 一维数组
 *  @param title title
 */
+ (void)j_createPickerWithItem:(NSArray *)items
                         title:(NSString *)title
                   andCallBack:(JPickViewSubmit)block;
/**
 *  textField 或者 textView  inputView
 *
 *  @param textView UITextField 或者 UITextView
 *  @param items    一维数组
 *  @param title    title
 */
+ (void)j_createPickerWithTextFieldInputView:(id)textView
                                     andItem:(NSArray *)items
                                       title:(NSString *)title
                                 andCallBack:(JPickViewSubmit)block;

/**
 *  DatePickerView
 *
 *  @param title title
 */
+ (void)j_createDatePickerWithTitle:(NSString *)title
                  andDatePickerMode:(UIDatePickerMode)mode
                     andDefaultDate:(NSDate *)defaultDate
                         andMaxDate:(NSDate *)maxDate
                         andMinDate:(NSDate *)minDate
                        andCallBack:(JPickViewSubmit)block;

/**
 *  textField 或者 textView  inputView
 *
 *  @param textView    UITextField 或者 UITextView
 *  @param title       title
 *  @param mode        pickerView类型
 *  @param defaultDate 默认显示时间
 *  @param maxDate     最大时间
 *  @param minDate     最小时间
 *  @param block       确定回调
 */
+ (void)j_createDatePickerWithTextFieldInputView:(id)textView
                                        andTitle:(NSString *)title
                               andDatePickerMode:(UIDatePickerMode)mode
                                  andDefaultDate:(NSDate *)defaultDate
                                      andMaxDate:(NSDate *)maxDate
                                      andMinDate:(NSDate *)minDate
                                     andCallBack:(JPickViewSubmit)block;

@property(nonatomic,copy)JPickViewSubmit block;
@end
