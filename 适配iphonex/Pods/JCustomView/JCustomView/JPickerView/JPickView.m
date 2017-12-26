//
//  JPickView.m
//  ActionSheet
//
//  Created by 陈杰 on 15/10/22.
//  Copyright © 2015年 chenjie. All rights reserved.
//

#import "JPickView.h"

#define SCREENSIZE UIScreen.mainScreen.bounds.size

@interface JPickView()

@property (nonatomic, strong) NSDate *defaultDate;

@end

@implementation JPickView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.isDate = NO;
    return self;
}
- (void)showPickView
{
    self.bgView = [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.3f;
    [self.bgView j_addTapGesture:^(UITapGestureRecognizer *gestureRecognizer) {
        [self hide];
    }];
    [JKeyWindow addSubview:self.bgView];
    
    CGRect frame = self.frame ;
    self.frame = CGRectMake(0,SCREENSIZE.height + frame.size.height, SCREENSIZE.width, frame.size.height);
    [JKeyWindow addSubview:self];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
                         self.frame = frame;
                     }
                     completion:nil];
}
- (void)hide{
    [self.bgView removeFromSuperview];
    [self removeFromSuperview];
}

+ (void)j_createPickerWithItem:(NSArray *)items title:(NSString *)title andCallBack:(JPickViewSubmit)block
{
    JPickView *pickView = [[JPickView alloc] init];
    pickView.block = block;
    pickView.isDate = NO;
    pickView.proTitleList = items;
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, 39.5)];
    header.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, SCREENSIZE.width - 80, 39.5)];
    titleLbl.text = title;
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = [pickView getColor:@"999999"];
    titleLbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.0];
    [header addSubview:titleLbl];
    
    
    
    UIButton *submit = [[UIButton alloc] initWithFrame:CGRectMake(SCREENSIZE.width - 50, 10, 50 ,29.5)];
    [submit setTitle:@"确定" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    submit.backgroundColor = [UIColor whiteColor];
    submit.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    [submit addTarget:pickView action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:submit];
    
    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50 ,29.5)];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    cancel.backgroundColor = [UIColor whiteColor];
    cancel.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    [cancel addTarget:pickView action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:cancel];
    
    [pickView addSubview:header];
    UIPickerView *pick = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, SCREENSIZE.width, 260)];
    
    pick.delegate = pickView;
    pick.backgroundColor = [UIColor whiteColor];
    [pickView addSubview:pick];
    
    
    float height = pick.j_height + 40;
    pickView.frame = CGRectMake(0, SCREENSIZE.height - height, SCREENSIZE.width, height);
    [pickView showPickView];
    
}

+ (void)j_createPickerWithTextFieldInputView:(id)textView
                                     andItem:(NSArray *)items
                                       title:(NSString *)title
                                 andCallBack:(JPickViewSubmit)block {
    
    JPickView *pickView = [[JPickView alloc] init];
    pickView.block = block;
    pickView.isDate = NO;
    pickView.proTitleList = items;
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, 39.5)];
    header.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, SCREENSIZE.width - 80, 39.5)];
    titleLbl.text = title;
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = [pickView getColor:@"999999"];
    titleLbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.0];
    [header addSubview:titleLbl];
    
    UIButton *submit = [[UIButton alloc] initWithFrame:CGRectMake(SCREENSIZE.width - 50, 10, 50 ,29.5)];
    [submit setTitle:@"确定" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    submit.backgroundColor = [UIColor whiteColor];
    submit.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    [submit addTarget:pickView action:@selector(submit1:) forControlEvents:UIControlEventTouchUpInside];
    
    [header addSubview:submit];
    
    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50 ,29.5)];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    cancel.backgroundColor = [UIColor whiteColor];
    cancel.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    [cancel addTarget:pickView action:@selector(cancel1:) forControlEvents:UIControlEventTouchUpInside];
    
    [header addSubview:cancel];
    
    [pickView addSubview:header];
    
    UIPickerView *pick = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, SCREENSIZE.width, 230)];
    
    pick.delegate = pickView;
    pick.backgroundColor = [UIColor whiteColor];
    [pickView addSubview:pick];
    
    
    float height = pick.j_height + 40;
    pickView.frame = CGRectMake(0, SCREENSIZE.height - height, SCREENSIZE.width, height);
    
    if([textView isKindOfClass:[UITextField class]]){
        ((UITextField *)textView).inputView = pickView;
    }else if([textView isKindOfClass:[UITextView class]]){
        ((UITextView *)textView).inputView = pickView;
    }
    
}

+ (void)j_createDatePickerWithTitle:(NSString *)title andDatePickerMode:(UIDatePickerMode)mode andDefaultDate:(NSDate *)defaultDate andMaxDate:(NSDate *)maxDate andMinDate:(NSDate *)minDate andCallBack:(JPickViewSubmit)block{
    
    JPickView *pickView = [[JPickView alloc] init];
    
    pickView.block = block;
    
    pickView.isDate = YES;
    pickView.mode = mode;
    pickView.proTitleList = @[];
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, 39.5)];
    header.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, SCREENSIZE.width - 80, 39.5)];
    titleLbl.text = title;
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = [pickView getColor:@"999999"];
    titleLbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.0];
    [header addSubview:titleLbl];
    
    UIButton *submit = [[UIButton alloc] initWithFrame:CGRectMake(SCREENSIZE.width - 50, 10, 50 ,29.5)];
    [submit setTitle:@"确定" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    submit.backgroundColor = [UIColor whiteColor];
    submit.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    [submit addTarget:pickView action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:submit];
    
    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50 ,29.5)];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    cancel.backgroundColor = [UIColor whiteColor];
    cancel.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    [cancel addTarget:pickView action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:cancel];
    
    [pickView addSubview:header];
    
    // 1.日期Picker    UIPickerView *pick = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, SCREENSIZE.width, pickView.j_height - 40)];
    
    UIDatePicker *datePickr = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, SCREENSIZE.width, 260)];
    datePickr.backgroundColor = [UIColor whiteColor];
    
    datePickr.maximumDate = maxDate;
    datePickr.minimumDate = minDate;
    // 1.1选择datePickr的显示风格
    if (mode) {
        [datePickr setDatePickerMode:mode];
    }else{
        [datePickr setDatePickerMode:UIDatePickerModeDate];
    }
    
    // 1.2查询所有可用的地区
    //NSLog(@"%@", [NSLocale availableLocaleIdentifiers]);
    
    // 1.3设置datePickr的地区语言, zh_Han后面是s的就为简体中文,zh_Han后面是t的就为繁体中文
    [datePickr setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"]];
    
    // 1.4监听datePickr的数值变化
    [datePickr addTarget:pickView action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    
    if (defaultDate) {
        [datePickr setDate:defaultDate animated:YES];
        pickView.defaultDate = defaultDate;
    } else {
        
        NSDate *date = [NSDate date];
        
        // 2.3 将转换后的日期设置给日期选择控件
        [datePickr setDate:date];
        pickView.defaultDate = date;
    }
    
    [pickView addSubview:datePickr];
    
    float height = datePickr.j_height + 40;
    pickView.frame = CGRectMake(0, SCREENSIZE.height - height, SCREENSIZE.width, height);
    
    [pickView showPickView];
}


+ (void)j_createDatePickerWithTextFieldInputView:(id)textView andTitle:(NSString *)title andDatePickerMode:(UIDatePickerMode)mode andDefaultDate:(NSDate *)defaultDate andMaxDate:(NSDate *)maxDate andMinDate:(NSDate *)minDate andCallBack:(JPickViewSubmit)block {
    
    JPickView *pickView = [[JPickView alloc] init];
    
    pickView.block = block;
    
    pickView.isDate = YES;
    pickView.mode = mode;
    pickView.proTitleList = @[];
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, 39.5)];
    header.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, SCREENSIZE.width - 80, 39.5)];
    titleLbl.text = title;
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = [pickView getColor:@"999999"];
    titleLbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.0];
    [header addSubview:titleLbl];
    
    UIButton *submit = [[UIButton alloc] initWithFrame:CGRectMake(SCREENSIZE.width - 50, 10, 50 ,29.5)];
    [submit setTitle:@"确定" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    submit.backgroundColor = [UIColor whiteColor];
    submit.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    [submit addTarget:pickView action:@selector(submit1:) forControlEvents:UIControlEventTouchUpInside];
    
    [header addSubview:submit];
    
    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50 ,29.5)];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    cancel.backgroundColor = [UIColor whiteColor];
    cancel.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    [cancel addTarget:pickView action:@selector(cancel1:) forControlEvents:UIControlEventTouchUpInside];
    
    [header addSubview:cancel];
    
    [pickView addSubview:header];
    
    // 1.日期Picker
    UIDatePicker *datePickr = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, SCREENSIZE.width, 230)];
    datePickr.backgroundColor = [UIColor whiteColor];

    datePickr.maximumDate = maxDate;
    datePickr.minimumDate = minDate;
    // 1.1选择datePickr的显示风格
    if (mode) {
        [datePickr setDatePickerMode:mode];
    }else{
        [datePickr setDatePickerMode:UIDatePickerModeDate];
    }
    
    // 1.2查询所有可用的地区
    //NSLog(@"%@", [NSLocale availableLocaleIdentifiers]);
    
    // 1.3设置datePickr的地区语言, zh_Han后面是s的就为简体中文,zh_Han后面是t的就为繁体中文
    [datePickr setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"]];
    
    // 1.4监听datePickr的数值变化
    [datePickr addTarget:pickView action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    
    if (defaultDate) {
        [datePickr setDate:defaultDate animated:YES];
        pickView.defaultDate = defaultDate;
    } else {
        
        NSDate *date = [NSDate date];
        
        // 2.3 将转换后的日期设置给日期选择控件
        [datePickr setDate:date];
        pickView.defaultDate = date;
    }
    
    [pickView addSubview:datePickr];
    
    float height = datePickr.j_height + 40;
    pickView.frame = CGRectMake(0, SCREENSIZE.height - height, SCREENSIZE.width, height);
    
    if([textView isKindOfClass:[UITextField class]]){
        ((UITextField *)textView).inputView = pickView;
    }else if([textView isKindOfClass:[UITextView class]]){
        ((UITextView *)textView).inputView = pickView;
    }
}

#pragma mark DatePicker监听方法
- (void)dateChanged:(UIDatePicker *)datePicker
{
    // 1.要转换日期格式, 必须得用到NSDateFormatter, 专门用来转换日期格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // 1.1 先设置日期的格式字符串
    if (self.mode == UIDatePickerModeDateAndTime) {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }else{
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    // 1.2 使用格式字符串, 将日期转换成字符串
    self.selectedStr = [formatter stringFromDate:datePicker.date];
}
- (void)cancel:(UIButton *)btn
{
    [self hide];
    
}

- (void)submit:(UIButton *)btn
{
    NSString *pickStr = self.selectedStr;
    if (!pickStr || pickStr.length == 0) {
        if(self.isDate) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            if (self.mode == UIDatePickerModeDateAndTime) {
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            }else{
                [formatter setDateFormat:@"yyyy-MM-dd"];
            }
            self.selectedStr = [formatter stringFromDate:self.defaultDate];
        } else {
            if([self.proTitleList count] > 0) {
                self.selectedStr = self.proTitleList[0];
            }
            
        }
        
        
        
    }
    JBlock(_block, self.selectedStr);
    [self hide];
    
    
}
- (void)cancel1:(UIButton *)btn
{
    [JKeyWindow endEditing:YES];
}

- (void)submit1:(UIButton *)btn
{
    [JKeyWindow endEditing:YES];
    
    NSString *pickStr = self.selectedStr;
    if (!pickStr || pickStr.length == 0) {
        if(self.isDate) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            if (self.mode == UIDatePickerModeDateAndTime) {
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            }else{
                [formatter setDateFormat:@"yyyy-MM-dd"];
            }
            self.selectedStr = [formatter stringFromDate:self.defaultDate];
        } else {
            if([self.proTitleList count] > 0) {
                self.selectedStr = self.proTitleList[0];
            }
        }
    }
    JBlock(self.block, self.selectedStr);
    
    
}

// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    
    return [self.proTitleList count];
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return 180;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    self.selectedStr = [self.proTitleList objectAtIndex:row];
    
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.proTitleList objectAtIndex:row];
    
}
- (UIColor *)getColor:(NSString*)hexColor

{
    
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:1.0f];
    
}
@end

