//
//  NSDate+J.h
//  JKitDemo
//
//  Created by Zebra on 16/3/15.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JDateFormat) {
    /**
     *  e.g.2014-03-04 13:23:35:67
     */
    JDateFormatWithAll = 0,
    
    /**
     *  e.g.2014-03-04 13:23:35
     */
    JDateFormatWithDateAndTime,
    
    /**
     *  e.g.13:23:35
     */
    JDateFormatWithTime,
    
    /**
     *  e.g.13:23
     */
    JDateFormatWithTimeHourMinute,
    
    /**
     *  e.g.13:23:35:67
     */
    JDateFormatWithPreciseTime,
    
    /**
     *  e.g.2014-03-04
     */
    JDateFormatWithYearMonthDay,
    
    /**
     *  e.g.2014-03
     */
    JDateFormatWithYearMonth,
    
    /**
     *  e.g.03-04
     */
    JDateFormatWithMonthDay,
    
    /**
     *  e.g.2014
     */
    JDateFormatWithYear,
    
    /**
     *  e.g.03
     */
    JDateFormatWithMonth,
    
    /**
     *  e.g.04
     */
    JDateFormatWithDay,
};

@interface NSDate (J)
/**
 *  将NSDate转为NSString
 *
 *  @param format jDateFormat
 *
 *  @return NSString
 */
- (NSString *)j_stringWithDateFormat:(JDateFormat)format;

/**
 *  取出年、月、日
 *
 *  @return e.g.2015-01-02
 */
- (NSDate *)j_subDateWithYearMothDay;

/**
 *  是否为今天
 *
 *  @return 是/不是
 */
- (BOOL)j_isToday;

/**
 *  是否为昨天
 *
 *  @return 是/不是
 */
- (BOOL)j_isYesterday;

/**
 *  是否为今年
 *
 *  @return 是/不是
 */
- (BOOL)j_isThisYear;

/**
 *  获得与当前时间的差距
 *
 *  @return NSDateComponents
 */
- (NSDateComponents *)j_deltaWithNow;

/**
 *  获取日
 *
 *  @return 日
 */
- (NSUInteger)j_day;

/**
 *  获取月
 *
 *  @return 月
 */
- (NSUInteger)j_month;

/**
 *  获取年
 *
 *  @return 年
 */
- (NSUInteger)j_year;

/**
 *  获取小时
 *
 *  @return 小时
 */
- (NSUInteger)j_hour;

/**
 *  获取分钟
 *
 *  @return 分钟
 */
- (NSUInteger)j_minute;

/**
 *  获取秒
 *
 *  @return 秒
 */
- (NSUInteger)j_second;

/**
 *  获取一年的总天数
 *
 *  @return 天
 */
- (NSUInteger)j_daysInYear;

/**
 *  获取某月的天数
 *
 *  @param month 月
 *
 *  @return 获取某月的天数
 */
- (NSUInteger)j_daysInMonth:(NSUInteger)month;

/**
 *  判断是否是闰年
 *
 *  @return 闰年/平年
 */
- (BOOL)j_isLeapYear;

/**
 *  years年后的日期
 *
 *  @param years 年
 *
 *  @return 日期
 */
- (NSDate *)j_offsetYears:(NSInteger)years;

/**
 *  months月后的日期
 *
 *  @param months 月
 *
 *  @return 日期
 */
- (NSDate *)j_offsetMonths:(NSInteger)months;

/**
 *  days天的日期
 *
 *  @param days 天
 *
 *  @return 日期
 */
- (NSDate *)j_offsetDays:(NSInteger)days;

/**
 *  hours小时后的日期
 *
 *  @param hours 小时
 *
 *  @return 日期
 */
- (NSDate *)j_offsetHours:(NSInteger)hours;


+ (NSString *)formatString:(JDateFormat)format;

@end

