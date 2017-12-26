//
//  UINavigationBar+Ext.swift
//  SuperVolleyBall
//
//  Created by Zebra on 2017/9/19.
//  Copyright © 2017年 HuaYutime. All rights reserved.
//

import UIKit
import JKit
import JKit.UIColor_J

var UIViewControllerOverlayKey: UInt8 = 0

extension UINavigationBar {
    
    var overlay: UIView? {
        get{
            return objc_getAssociatedObject(self, &UIViewControllerOverlayKey
                ) as? UIView
        }
        set{
            objc_setAssociatedObject(self, &UIViewControllerOverlayKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func j_setDefaultBackgroundColor( _ backgroundColor: UIColor ) {
        
        self.j_reset()
        
        if self.overlay == nil {
            
            self.barTintColor = ThemeColor.j_changeFromTranslucent()
            
            self.isTranslucent = true
            
            self.setBackgroundImage(UIImage(), for: .default)
            
            self.shadowImage = UIImage()
            
            self.overlay = UIView(frame: CGRect(x: 0, y: 0, width: KWidth, height: kNavBarHeight))
            
            self.subviews.first?.insertSubview(self.overlay!, at: 0)
        }
        
        self.overlay?.backgroundColor = backgroundColor
        
        self.j_setAlpha(0)
    }
    
    func  j_setAlpha( _ alpha: CGFloat ) {
        
        self.overlay?.alpha = alpha
    }
    
    func j_reset( _ isTranslucent: Bool = false ) {
        
        if !isTranslucent {
            
            self.isTranslucent = false
            
            self.setBackgroundImage(UIImage.j_image(with: ThemeColor), for: .default)
        }
        
        self.barTintColor = ThemeColor
        
        self.overlay?.removeFromSuperview()
        
        self.overlay = nil
    }
}
