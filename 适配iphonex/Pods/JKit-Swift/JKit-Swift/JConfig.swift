//
//  JConfig.swift
//  JKitDemo
//
//  Created by Zebra on 2017/7/20.
//  Copyright © 2017年 Zebra. All rights reserved.
//

import UIKit

/// UIScreen.main.bounds
public let JScreenBounds: CGRect = UIScreen.main.bounds

/// UIScreen.main.bounds.size
public let JScreenSize: CGSize = JScreenBounds.size

/// UIScreen.main.bounds.size.width
public let JScreenWidth: CGFloat  = JScreenSize.width

/// UIScreen.main.bounds.size.height
public let JScreenHeight: CGFloat = JScreenSize.height

/// 当前系统版本
public let JVersion: Float = (UIDevice.current.systemVersion as NSString).floatValue

public let JiPhone4: Bool = (JScreenWidth == 480)
public let JiPhone5: Bool = (JScreenWidth == 568)
public let JiPhone6: Bool = (JScreenWidth == 667)
public let JiPhone6P: Bool = (JScreenWidth == 736)
public let JiPhoneX: Bool = (JScreenWidth == 818)

public let JiOS8: Bool = (JVersion >= 8 && JVersion < 9)
public let JiOS9: Bool = (JVersion >= 9 && JVersion < 10)
public let JiOS10: Bool = (JVersion >= 10 && JVersion < 11)
public let JiOS11: Bool = (JVersion >= 11 && JVersion < 12)

/// UIApplication.shared.delegate!
public let JDelegate: UIApplicationDelegate = UIApplication.shared.delegate!

/// UIApplication.shared.delegate!.window!!
public let JWindow: UIWindow = JDelegate.window!!

/// UIApplication.shared.keyWindow!
public let JKeyWindow: UIWindow = UIApplication.shared.keyWindow!

public func JFont ( _ size: CGFloat ) -> UIFont { return UIFont.systemFont(ofSize: size) }

public func JBoldFont ( _ size: CGFloat ) -> UIFont { return UIFont.boldSystemFont(ofSize: size) }



		
