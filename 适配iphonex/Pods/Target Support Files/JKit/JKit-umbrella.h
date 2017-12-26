#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "JCategory.h"
#import "JPlaceholderView.h"
#import "NSArray+J.h"
#import "NSData+J.h"
#import "NSDate+J.h"
#import "NSDictionary+J.h"
#import "NSString+J.h"
#import "UIColor+J.h"
#import "UIImage+J.h"
#import "UISearchBar+J.h"
#import "UITabBarController+J.h"
#import "UITableView+J.h"
#import "UITextField+J.h"
#import "UITextView+J.h"
#import "UIView+J.h"
#import "UIView+JPlaceholderView.h"
#import "UIViewController+J.h"
#import "UIViewController+JAlertView.h"
#import "UIViewController+JPlaceholderView.h"
#import "JMacro.h"
#import "JKit.h"

FOUNDATION_EXPORT double JKitVersionNumber;
FOUNDATION_EXPORT const unsigned char JKitVersionString[];

