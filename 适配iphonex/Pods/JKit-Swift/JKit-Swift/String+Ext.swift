//
//  String+Ext.swift
//  JKit-SwiftDemo
//
//  Created by Zebra on 2017/7/25.
//  Copyright © 2017年 Zebra. All rights reserved.
//

import UIKit

/// 正则验证
///
/// - email: 邮箱
/// - phoneNum: 手机号
/// - username: 用户名
/// - password: 密码
/// - nickname: 昵称
/// - URL:  url
/// - IP: IP
///
/// **用法**
///
///Validate.URL("https://www.baidu.com").isRight
///
public enum Validate {
    
    case email( _: String )
    
    case phoneNum( _: String )
    
    case username( _: String )
    
    case password( _: String )
    
    case nickname( _: String )
    
    case URL( _: String )
    
    case IP( _: String )
    
    case chinese( _: String)
    
    case number( _: String)
    
    case money( _: String)
    
    case identityCard( _: String )
    
    var isRight: Bool {
        
        var predicateStr: String!
        var currObject: String!
        
        switch self {
            
        case let .email(str):
            predicateStr = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
            currObject = str
            
        case let .phoneNum(str):
            predicateStr = "^((13[0,0-9])|(15[0,0-9])|(17[0,0-9])|(18[0,0-9]))\\d{8}$"
            currObject = str
            
        case let .username(str):
            predicateStr = "^[A-Za-z0-9]{6,18}+$"
            currObject = str
            
        case let .password(str):
            predicateStr = "^[a-zA-Z0-9]{6,18}+$"
            currObject = str
            
        case let .nickname(str):
            predicateStr = "^[\\u4e00-\\u9fa5]{4,8}$"
            currObject = str
            
        case let .URL(str):
            predicateStr = "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
            currObject = str
            
        case let .IP(str):
            predicateStr = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
            currObject = str
            
        case let .chinese(str):
            predicateStr = "^[\\u4e00-\\u9fa5]+$"
            currObject = str
            
        case let .number(str):
            predicateStr = "^[0-9]*$"
            currObject = str
            
        case let .money(str):
            predicateStr = "^(0|[1-9][0-9]*)(\\.[0-9]{0,2})?$"
            currObject = str
            
        case let .identityCard(str):
            predicateStr = "^(\\d{14}|\\d{17})(\\d|[xX])$"
            currObject = str
        }
        
        guard let regex = try? NSRegularExpression(pattern: predicateStr, options: NSRegularExpression.Options(rawValue:0)), currObject != nil else {
            
            return false
        }
        
        let res = regex.matches(in: currObject, options: NSRegularExpression.MatchingOptions(rawValue:0), range: NSMakeRange(0, currObject.characters.count))
        
        return res.count > 0 ? true : false
    }
}

extension String {
    
    //MARK: -转16进制
    public func j_toHex() -> String? {
        
        guard var tmpid = Int(self) else {
            
            return nil
        }
        
        var nLetterValue = "" , str = ""
        
        var ttmpig: Int = 0
        
        for _ in 0 ..< 9 {
            
            ttmpig = tmpid % 16
            
            tmpid = tmpid / 16
            
            switch ttmpig {
            case 10:
                nLetterValue = "A"
            case 11:
                nLetterValue = "B"
            case 12:
                nLetterValue = "C"
            case 13:
                nLetterValue = "D"
            case 14:
                nLetterValue = "E"
            case 15:
                nLetterValue = "F"
            default:
                nLetterValue = "\(ttmpig)"
            }
            
            str = nLetterValue + str
        }
        
        return str
    }
    
    //MARK: -判断
    
    /// 邮箱判断
    ///
    /// - Returns: true/false
    public func j_isEmail() -> Bool { return Validate.email(self).isRight }
    
    /// 手机号判断
    ///
    /// - Returns: true/false
    public func j_isMobile() -> Bool { return Validate.phoneNum(self).isRight }
    
    /// 钱规则判断
    ///
    /// - Returns: true/false
    public func j_isMoney() -> Bool { return Validate.money(self).isRight }
    
    /// 数字判断
    ///
    /// - Returns: true/false
    public func j_isNumber() -> Bool { return Validate.number(self).isRight }
    
    /// 身份证号判断
    ///
    /// - Returns: true/false
    public func j_isIdentityCard() -> Bool { return Validate.identityCard(self).isRight }
    
    /// 用户名判断 无特殊字符 6-18 位
    ///
    /// - Returns: true/false
    public func j_isUserName() -> Bool { return Validate.username(self).isRight }
    
    /// 密码判断 无特殊字符 6-18 位
    ///
    /// - Returns: true/false
    public func j_isPassword() -> Bool { return Validate.password(self).isRight }
    
    /// 昵称判断 中文 4-8 位
    ///
    /// - Returns: true/false
    public func j_isNickname() -> Bool { return Validate.nickname(self).isRight }
    
    ///  URL 判断
    ///
    /// - Returns: true/false
    public func j_isURL() -> Bool { return Validate.URL(self).isRight }
    
    ///  IP 判断
    ///
    /// - Returns: true/false
    public func j_isIP() -> Bool { return Validate.IP(self).isRight }
    
    /// 中文判断
    ///
    /// - Returns: true/false
    public func j_isChinese() -> Bool { return Validate.chinese(self).isRight }
    
    //MARK: -计算文字的 size
    
    /// 获取文字宽高
    ///
    /// - Parameters:
    ///   - font:  文字大小
    ///   - constrainedSize: 最大范围
    /// - Returns: text.size
    public func j_size( font: UIFont, constrainedSize: CGSize) -> CGSize {
        
        var resultSize = CGSize()
        
        guard !self.isEmpty else {
            
            return resultSize
        }
        
        let dic = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        
        resultSize = self.boundingRect(with: constrainedSize, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedStringKey : Any], context:nil).size
        
        return resultSize
    }
    
    /// 获取文字宽
    ///
    /// - Parameters:
    ///   - font:  文字大小
    ///   - constrainedSize: 最大范围
    /// - Returns: text.size.width
    public func j_width( font: UIFont, constrainedSize: CGSize) -> CGFloat {
        
        return j_size(font: font, constrainedSize: constrainedSize).width
    }
    
    /// 获取文字高
    ///
    /// - Parameters:
    ///   - font:  文字大小
    ///   - constrainedSize: 最大范围
    /// - Returns: text.size.height
    public func j_height( font: UIFont, constrainedSize: CGSize) -> CGFloat {
        
        return j_size(font: font, constrainedSize: constrainedSize).height
    }
    
    /// json -> 数组
    ///
    /// - Returns: Array<Any>?
    func j_toArray() -> [Any]? {
        
        let jsonObject = try? JSONSerialization.jsonObject(with: self.data(using: String.Encoding.utf8)!, options: JSONSerialization.ReadingOptions.allowFragments)
        
        return jsonObject as? [Any]
    }
    
    /// json -> 字典
    ///
    /// - Returns: [String: Any]?
    func j_toDictionary() -> [String: Any]? {
        
        let jsonObject = try? JSONSerialization.jsonObject(with: self.data(using: String.Encoding.utf8)!, options: JSONSerialization.ReadingOptions.allowFragments)
        
        return jsonObject as? [String: Any]
    }
    
    /// 返回沙盒文件路径
    ///
    /// - Returns: 路径
    public func j_documentsFile() -> String {
        
        return NSSearchPathForDirectoriesInDomains(.documentationDirectory, .userDomainMask, true)[0].appending(self)
    }
    
    /// 删除沙盒中的文件
    ///
    /// - Returns: 成功/失败
    @discardableResult public func j_removeDocumentsFile() -> Bool {
        
        do {
            try FileManager.default.removeItem(atPath: NSSearchPathForDirectoriesInDomains(.documentationDirectory, .userDomainMask, true)[0].appending(self))
            
            return true
            
        } catch {
            
            return false
        }
    }
    
    /// 写入系统偏好
    ///
    /// - Parameter key: key
    /// - Returns:  成功/失败
    @discardableResult public func j_saveUserDefaults( toKey key: String ) -> Bool {
        
        UserDefaults.standard.set(self, forKey: key)
        
        return UserDefaults.standard.synchronize()
    }
    
    /// 获取系统偏好
    ///
    /// - Returns: value
    public func j_getUserDefaults() -> Any? {
        
        return UserDefaults.standard.value(forKey: self)
    }
    
}
