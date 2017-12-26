//
//  UIView+Ext.swift
//  JKit-SwiftDemo
//
//  Created by Zebra on 2017/7/25.
//  Copyright © 2017年 Zebra. All rights reserved.
//

import UIKit

//MARK: -Frame
extension UIView {
    
    var j_origin: CGPoint {
        
        get {
            
            return self.frame.origin
        }
        
        set {
            
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }
    
    var j_size: CGSize {
        
        get {
            
            return self.frame.size
        }
        
        set {
            
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    
    var j_width: CGFloat {
        
        get {
            
            return self.frame.size.width
        }
        
        set {
            
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    var j_height: CGFloat {
        
        get {
            
            return self.frame.size.height
        }
        
        set {
            
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    var j_top: CGFloat {
        
        get {
            
            return self.frame.origin.y
        }
        
        set {
            
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    var j_left: CGFloat {
        
        get {
            
            return self.frame.origin.x
        }
        
        set {
            
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    var j_bottom: CGFloat {
        
        get {
            
            return self.frame.origin.y + self.frame.size.height
        }
        
        set {
            
            var frame = self.frame
            frame.origin.y = newValue - self.frame.size.height
            self.frame = frame
        }
    }
    
    var j_right: CGFloat {
        
        get {
            
            return self.frame.origin.x + self.frame.size.width
        }
        
        set {
            
            var frame = self.frame
            frame.origin.x = newValue - self.frame.size.width
            self.frame = frame
        }
    }
    
    var j_centerX: CGFloat {
        
        get {
            
            return self.center.x
        }
        
        set {
            
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    var j_centerY: CGFloat {
        
        get {
            
            return self.center.y
        }
        
        set {
            
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
}

//MARK: -手势 闭包实现
var JTapGestureBlockKey: UInt8 = 0
var JLongPressGestureBlockKey: UInt8 = 0
var JPanGestureBlockKey: UInt8 = 0

extension UIView {
    
    public typealias JTapGestureBlock = (_ gestureRecognizer: UITapGestureRecognizer) -> ()
    public typealias JLongPressGestureBlock = (_ gestureRecognizer: UILongPressGestureRecognizer) -> ()
    public typealias JPanGestureBlock = (_ gestureRecognizer: UIPanGestureRecognizer) -> ()
    
    var tapGestureAction: JTapGestureBlock? {
        
        get{
            
            return objc_getAssociatedObject(self, &JTapGestureBlockKey
                ) as? JTapGestureBlock
        }
        
        set{
            
            objc_setAssociatedObject(self, &JTapGestureBlockKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var longPressGestureAction: JLongPressGestureBlock? {
        
        get{
            
            return objc_getAssociatedObject(self, &JLongPressGestureBlockKey
                ) as? JLongPressGestureBlock
        }
        
        set{
            
            objc_setAssociatedObject(self, &JLongPressGestureBlockKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var panGestureAction: JPanGestureBlock? {
        
        get{
            
            return objc_getAssociatedObject(self, &JPanGestureBlockKey
                ) as? JPanGestureBlock
        }
        
        set{
            
            objc_setAssociatedObject(self, &JPanGestureBlockKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 点击手势
    ///
    /// - Parameter tapAction: 回调 JTapGestureBlock
    /// - Returns: UITapGestureRecognizer
    @discardableResult public func j_addTapGesture( _ tapAction: @escaping JTapGestureBlock ) -> UITapGestureRecognizer? {
        
        self.tapGestureAction = tapAction
        
        guard self.gestureRecognizers == nil else {
            
            return nil
        }
        
        self.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        
        self.addGestureRecognizer(gesture)
        
        return gesture
    }
    
    @objc private func tapGesture(gestureRecognizer: UITapGestureRecognizer) {
        
        if let tapGestureAction = self.tapGestureAction {
            
            tapGestureAction(gestureRecognizer)
        }
    }
    
    /// 长按手势
    ///
    /// - Parameter longPressAction: 回调 JLongPressGestureBlock
    /// - Returns: UILongPressGestureRecognizer
    @discardableResult public func j_addLongPressGesture( _ longPressAction: @escaping JLongPressGestureBlock ) -> UILongPressGestureRecognizer? {
        
        self.longPressGestureAction = longPressAction
        
        guard self.gestureRecognizers == nil else {
            
            return nil
        }
        
        self.isUserInteractionEnabled = true
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressGesture))
        
        self.addGestureRecognizer(gesture)
        
        return gesture
    }
    
    @objc private func longPressGesture(gestureRecognizer: UILongPressGestureRecognizer) {
        
        if let longPressGestureAction = self.longPressGestureAction {
            
            longPressGestureAction(gestureRecognizer)
        }
    }
    
    /// 平移手势
    ///
    /// - Parameter panAction: 回调 JPanGestureBlock
    /// - Returns: UIPanGestureRecognizer
    @discardableResult public func j_addPanGesture( _ panAction: @escaping JPanGestureBlock ) -> UIPanGestureRecognizer? {
        
        self.panGestureAction = panAction
        
        guard self.gestureRecognizers == nil else {
            
            return nil
        }
        
        self.isUserInteractionEnabled = true
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
        
        self.addGestureRecognizer(gesture)
        
        return gesture
    }
    
    @objc private func panGesture(gestureRecognizer: UIPanGestureRecognizer) {
        
        if let panGestureAction = self.panGestureAction {
            
            panGestureAction(gestureRecognizer)
        }
    }
    
}


