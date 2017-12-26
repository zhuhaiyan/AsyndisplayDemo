//
//  Comment.swift
//  适配iphonex
//
//  Created by 朱海燕 on 2017/12/26.
//  Copyright © 2017年 朱海燕. All rights reserved.
//

import UIKit
import JKit_Swift

let JVersion = Double(UIDevice.current.systemVersion)!
let IOS11 = (JVersion > 11.00 && JVersion < 12.00)


/// frame
let KWidth = UIScreen.main.bounds.size.width
let KHight = UIScreen.main.bounds.size.height
let kNavBarHeight: CGFloat = (JiPhoneX ? 88 : 64)
let kTabBarHeight: CGFloat = (JiPhoneX ? 83 : 49)
let kBottomSpace: CGFloat = (JiPhoneX ? 34.0 : 0.0)
public let JiPhoneX: Bool = (KHight == 812)


///字体
let kFont_7 = UIFont.systemFont(ofSize: 7)
let kFont_9 = UIFont.systemFont(ofSize: 9)
let kFont_10 = UIFont.systemFont(ofSize: 10)
let kFont_11 = UIFont.systemFont(ofSize: 11)
let kFont_12 = UIFont.systemFont(ofSize: 12)
let kFont_13 = UIFont.systemFont(ofSize: 13)
let kFont_14 = UIFont.systemFont(ofSize: 14)
let kFont_15 = UIFont.systemFont(ofSize: 15)
let kFont_16 = UIFont.systemFont(ofSize: 16)
let kFont_17 = UIFont.systemFont(ofSize: 17)
let kFont_18 = UIFont.systemFont(ofSize: 18)

///加粗字体
let kFont_10_bold = UIFont.boldSystemFont(ofSize: 10)
let kFont_12_bold = UIFont.boldSystemFont(ofSize: 12)
let kFont_14_bold = UIFont.boldSystemFont(ofSize: 14)
let kFont_16_bold = UIFont.boldSystemFont(ofSize: 16)
let kFont_18_bold = UIFont.boldSystemFont(ofSize: 18)


/// color
/// 白色
let kColor_white = UIColor.white
/// 深灰色
let kColor_darkColor = UIColor.darkGray
/// 占位文字颜色
let kColor_PlaceHolderColor = JColorFromHex(0x777777)
/// 浅灰色
let kColor_lightGray = UIColor.lightGray
/// 黑色
let kColor_333333  = JColorFromHex(0x333333)
/// 灰色
let kColor_666666  = JColorFromHex(0x666666)
/// 浅灰色
let kColor_999999  = JColorFromHex(0x999999)

let BgColor        = JColorFromHex(0xf2f2f2)
let KColor_MyFoucus = RGBA(r: 232.0, g: 232.0, b: 232.0, a: 1.0)
/// 分割线颜色
let kColor_line    = JColorFromHex(0xe5e5e5)
/// 主题色
let ThemeColor     = RGBA(r: 210.0, g: 35.0, b: 48.0, a: 1.0)
/// 标签栏颜色
let TabBarBGColor  = RGBA(r: 254.0, g: 218.0, b: 22.0, a: 1.0)
/// 可点的文字的蓝色
let SelectTextBlue = JColorFromHex(0x0085C7)

///图片占位图
let kPlaceholderImage: UIImage? = UIImage.init(named: "image_defalut")
