//
//  NSDate+J.m
//  JKitDemo
//
//  Created by Zebra on 16/3/15.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "NSDate+J.h"
#import "NSString+J.h"

@implementation NSDate (J)

#pragma mark 将NSDate转为NSString

- (NSString *)j_stringWithDateFormat:(JDateFormat)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:[NSDate formatString:format]];
    NSString *date_time = [NSString stringWithString:[dateFormatter stringFromDate:self]];
    
    return date_time;
}

+ (NSString *)formatString:(JDateFormat)format
{
    NSString *formatString;
    switch (format) {
        case JDateFormatWithAll:
            formatString = @"yyyy-MM-dd HH:mm:ss:SS";
            break;
        case JDateFormatWithDateAndTime:
            formatString = @"yyyy-MM-dd HH:mm:ss";
            break;
        case JDateFormatWithTime:
            formatString = @"HH:mm:ss";
            break;
        case JDateFormatWithTimeHourMinute:
            formatString = @"HH:mm";
            break;
        case JDateFormatWithPreciseTime:
            formatString = @"HH:mm:ss:SS";
            break;
        case JDateFormatWithYearMonthDay:
            formatString = @"yyyy-MM-dd";
            break;
        case JDateFormatWithYearMonth:
            formatString = @"yyyy-MM";
            break;
        case JDateFormatWithMonthDay:
            formatString = @"MM-dd";
            break;
        case JDateFormatWithYear:
            formatString = @"yyyy";
            break;
        case JDateFormatWithMonth:
            formatString = @"MM";
            break;
        case JDateFormatWithDay:
            formatString = @"dd";
            break;
            
        default:
            break;
    }
    
    return formatString;
}

#pragma mark -.-

#pragma mark 取出年、月、日

- (NSDate *)j_subDateWithYearMothDay
{
    return [[self j_stringWithDateFormat:JDateFormatWithYearMonthDay] j_dateWithDateFormat:JDateFormatWithYearMonthDay];
}

#pragma mark 是否为今天

- (BOOL)j_isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    NSDateComponents *nowComponents = [calendar components:unit fromDate:[NSDate date]];
    
    NSDateComponents *selfComponents = [calendar components:unit fromDate:self];
    
    return (selfComponents.year == nowComponents.year) && (selfComponents.month == nowComponents.month) && (selfComponents.day == nowComponents.day);
}

#pragma mark 是否为昨天

- (BOOL)j_isYesterday
{
    NSDate *nowDate = [[NSDate date] j_subDateWithYearMothDay];
    NSDate *selfDate = [self j_subDateWithYearMothDay];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.day == 1;
}

#pragma mark 是否为今年

- (BOOL)j_isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unit = NSCalendarUnitYear;
    
    NSDateComponents *nowComponents = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfComponents = [calendar components:unit fromDate:self];
    
    return nowComponents.year == selfComponents.year;
}

#pragma mark 获得与当前时间的差距

- (NSDateComponents *)j_deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSUInteger unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

#pragma mark - 获取日、月、年、小时、分钟、秒

- (NSUInteger)j_day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay) fromDate:self];
#else
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit) fromDate:self];
#endif
    
    return [components day];
}

- (NSUInteger)j_month
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitMonth) fromDate:self];
#else
    NSDateComponents *components = [calendar components:(NSMonthCalendarUnit) fromDate:self];
#endif
    
    return [components month];
}

- (NSUInteger)j_year
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear) fromDate:self];
#else
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit) fromDate:self];
#endif
    
    return [components year];
}

- (NSUInteger)j_hour
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour) fromDate:self];
#else
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit) fromDate:self];
#endif
    
    return [components hour];
}

- (NSUInteger)j_minute
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitMinute) fromDate:self];
#else
    NSDateComponents *components = [calendar components:(NSMinuteCalendarUnit) fromDate:self];
#endif
    
    return [components minute];
}

- (NSUInteger)j_second
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitSecond) fromDate:self];
#else
    NSDateComponents *components = [calendar components:(NSSecondCalendarUnit) fromDate:self];
#endif
    
    return [components second];
}

#pragma mark - 获取一年的总天数

- (NSUInteger)j_daysInYear
{
    return [self j_isLeapYear] ? 366 : 365;
}

#pragma mark - 获取某月的天数

- (NSUInteger)j_daysInMonth:(NSUInteger)month
{
    if (month > 12) {
        
        return 0;
    }
    
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            return 31;
            break;
        case 2:
            return [self j_isLeapYear] ? 29 : 28;
        default:
            return 30;
            break;
    }
}

#pragma mark - 判断是否是闰年

- (BOOL)j_isLeapYear
{
    NSUInteger year = [self j_year];
    
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        
        return YES;
    }
    
    return NO;
}

#pragma mark - offset后的日期

- (NSDate *)j_offsetYears:(NSInteger)years
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:years];
    
    return [gregorian dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)j_offsetMonths:(NSInteger)months
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:months];
    
    return [gregorian dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)j_offsetDays:(NSInteger)days
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:days];
    
    return [gregorian dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)j_offsetHours:(NSInteger)hours
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:hours];
    
    return [gregorian dateByAddingComponents:components toDate:self options:0];
}

@end
