//
//  UIColor+Ext.swift
//  JKit-SwiftDemo
//
//  Created by Zebra on 2017/7/25.
//  Copyright © 2017年 Zebra. All rights reserved.
//

import UIKit

public func RGBA ( r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat ) -> UIColor {
    
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

public func JColorFromHex( _ hex: UInt ) -> UIColor {
    
    return UIColor.j_color(fromHex: hex)
}

extension UIColor {
    
    //MARK: -16进制转为UIColor
    public static func j_color( fromHex hex: UInt, alpha: CGFloat = 1.0) -> UIColor {
        
        return RGBA(r: CGFloat((hex & 0xFF0000) >> 16) , g: CGFloat((hex & 0x00FF00) >> 8), b: CGFloat((hex & 0x0000FF)) , a: alpha)
    }
    
    public static func j_color( fromHex hex: UInt ) -> UIColor {
        
        return UIColor.j_color(fromHex: hex, alpha: 1.0)
    }
    
    //MARK: -16进制字符串转为UIColor
    public static func j_color( fromHexString hexString: String ) -> UIColor {
        
        var cString: String = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        if cString.characters.count < 6 {
            
            return UIColor.black
        }
        
        if cString.hasPrefix("0X") || cString.hasPrefix("0x") {
            
            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 2))
        }
        
        if cString.hasPrefix("#") {
            
            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 1))
        }
        
        if cString.characters.count != 6 {
            
            return UIColor.black
        }
        
        var range: NSRange = NSMakeRange(0, 2)
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        
        Scanner.init(string: rString).scanHexInt32(&r)
        Scanner.init(string: gString).scanHexInt32(&g)
        Scanner.init(string: bString).scanHexInt32(&b)
        
        return RGBA(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b), a: 1)
    }
    
    //MARK: -随机色
    public static func j_colorFromRamdom() -> UIColor {
        
        return RGBA(r: CGFloat(arc4random_uniform(256) / 255), g: CGFloat(arc4random_uniform(256) / 255), b: CGFloat(arc4random_uniform(256) / 255), a: 1.0)
    }
    
}

