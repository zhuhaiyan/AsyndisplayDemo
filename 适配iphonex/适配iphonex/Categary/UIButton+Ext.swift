//
//  UIButton+Ext.swift
//  适配iphonex
//
//  Created by 朱海燕 on 2017/12/28.
//  Copyright © 2017年 朱海燕. All rights reserved.
//

import UIKit
var ClickKey: UInt8 = 0
typealias ClickBlock = () -> Void
//Category中的属性，只会生成setter和getter方法，不会生成成员变量
extension UIButton{

    var click: ClickBlock?  {
        
        get{
            return objc_getAssociatedObject(self, &ClickKey) as? ClickBlock
        }
        set{
            
            objc_setAssociatedObject(self, &ClickKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            self.removeTarget(self, action: #selector(buttonClick), for: .touchUpInside)
            
            if (click != nil){
                
                self.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
            }
        }
    }
    
    @objc func buttonClick() -> Void {
        
        self.click!()
    }
}
