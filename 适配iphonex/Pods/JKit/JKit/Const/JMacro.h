//
//  JMacro.h
//  JKitDemo
//
//  Created by elongtian on 16/1/6.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#ifndef JMacro_h
#define JMacro_h

// 过期
#define JExtensionDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

#define JScreenWidth [UIScreen mainScreen].bounds.size.width
#define JScreenHeight [UIScreen mainScreen].bounds.size.height
#define JScreenSize [UIScreen mainScreen].bounds.size
#define JScreenBounds [UIScreen mainScreen].bounds

#define JDelegate [[UIApplication sharedApplication] delegate]
#define JKeyWindow [[UIApplication sharedApplication] keyWindow]
#define JWindow [[[UIApplication sharedApplication] delegate] window]

#define JVersion [[[UIDevice currentDevice] systemVersion] floatValue]

#define IOS7 (JVersion >= 7 && JVersion < 8)

#define IOS8 (JVersion >= 8 && JVersion < 9)

#define IOS9 (JVersion >= 9 && JVersion < 10)

#define IOS10 (JVersion >= 10 && JVersion < 11)

#define IOS11 (JVersion >= 11 && JVersion < 12)

#define JiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define JiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define JScreenMax (MAX(JScreenWidth, JScreenHeight))
#define JScreenMin (MIN(JScreenWidth, JScreenHeight))

#define IPhone4 (JiPhone && JScreenMax == 480.0)
#define IPhone5 (JiPhone && JScreenMax == 568.0)
#define IPhone6 (JiPhone && JScreenMax == 667.0)
#define IPhone6Plus (JiPhone && JScreenMax == 736.0)
#define IPhoneX (JiPhone && JScreenMax == 812.0)

#define JFont(s) ([UIFont systemFontOfSize:s])
#define JBoldFont(s) ([UIFont boldSystemFontOfSize:s])

#define JStringWithInteger(integer) [NSString stringWithFormat:@"%ld",(long)integer]
#define JStringWithInt(int) [NSString stringWithFormat:@"%d",(int)int]
#define JStringWithDouble(double) [NSString stringWithFormat:@"%.2lf",(double)double]
#define JStringWithFloat(float) [NSString stringWithFormat:@"%.2f",(float)float]

#define JStringAndString(str1,str2) [NSString stringWithFormat:@"%@%@",str1,str2]

#define JBlock(block, ...) block ? block(__VA_ARGS__) : nil

#ifdef DEBUG
#define JString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define JLog(...) printf("%s: %s 第%d行: %s\n\n",[[NSString j_date] UTF8String], [JString UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);

#else
#define JLog(...)
#endif

//#ifdef DEBUG
//# define JLog(fmt, ...) NSLog((@"\n[文件名:%s]" "\n[函数名:%s]" "\n[行号:%d]\n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
//#else
//# define JLog(...);
//#endif


#define JSingletonInterface(className) + (instancetype)shared##className;

#if __has_feature(objc_arc)
#define JSingletonImplementation(className) \
static id instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [super allocWithZone:zone]; \
}); \
return instance; \
} \
+ (instancetype)shared##className { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [[self alloc] init]; \
}); \
return instance; \
} \
- (id)copyWithZone:(NSZone *)zone { \
return instance; \
}
#else
#define JSingletonImplementation(className) \
static id instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [super allocWithZone:zone]; \
}); \
return instance; \
} \
+ (instancetype)shared##className { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [[self alloc] init]; \
}); \
return instance; \
} \
- (id)copyWithZone:(NSZone *)zone { \
return instance; \
} \
- (oneway void)release {} \
- (instancetype)retain {return instance;} \
- (instancetype)autorelease {return instance;} \
- (NSUInteger)retainCount {return ULONG_MAX;}

#endif



static inline BOOL JIsEmpty(id objcet) {
    
    return objcet == nil || [objcet isEqual:[NSNull null]] || ([objcet respondsToSelector:@selector(length)] && [(NSData *)objcet length] == 0) || ([objcet respondsToSelector:@selector(count)] && [(NSArray *)objcet count] == 0);
}

static inline BOOL JIsNoEmpty(id objct) {
    
    return !JIsEmpty(objct);
}

static inline NSString *JStringWithObject(id object) {
    
    if (object == nil || [object isEqual:[NSNull null]]) {
        
        return @"";
        
    } else if ([object isKindOfClass:[NSString class]]) {
        
        return object;
        
    } else if ([object respondsToSelector:@selector(stringValue)]){
        
        return [object stringValue];
        
    } else {
        
        return [object description];
    }
}

UIKIT_STATIC_INLINE UIViewController *JCurrentViewController() {
    
    UIViewController *topViewController = [[UIApplication sharedApplication].keyWindow rootViewController];
    
    if ([topViewController isKindOfClass:[UITabBarController class]]) {
        
        topViewController = ((UITabBarController *)topViewController).selectedViewController;
    }
    
    if ([topViewController presentedViewController]) {
        
        topViewController = [topViewController presentedViewController];
    }
    
    if ([topViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController *)topViewController topViewController]) {
        
        return [(UINavigationController*)topViewController topViewController];
    }
    
    return topViewController;
}


#endif /* JMacro_h */
