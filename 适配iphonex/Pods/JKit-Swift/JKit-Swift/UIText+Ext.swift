//
//  UIText+Ext.swift
//  JKit-SwiftDemo
//
//  Created by Zebra on 2017/7/25.
//  Copyright © 2017年 Zebra. All rights reserved.
//

import UIKit

extension UITextField {
    
    /// 限制输入长度
    ///
    /// - Parameter length: 长度
    public func j_limitLength( _ length: Int ) {
        
        NotificationCenter.default.addObserver(forName: .UITextFieldTextDidChange, object: nil, queue: OperationQueue.main) { (note) in
            
            if (self.text?.characters.count)! > length && self.markedTextRange == nil {
                
                if let text = self.text {
                    
                    let index = text.index(text.startIndex, offsetBy: length)
                    self.text = text.substring(to: index)
                }
            }
        }
    }
}


var JPlaceholderLabelPointer: UInt8 = 0

var JPlaceholderText: UInt8 = 0

var JPlaceholderTextFont: UInt8 = 0

var JPlaceholderTextColor: UInt8 = 0

extension UITextView {
    
    /// 限制输入长度
    ///
    /// - Parameter length: 长度
    public func j_limitLength( _ length: Int ) {
        
        NotificationCenter.default.addObserver(forName: .UITextViewTextDidChange, object: nil, queue: OperationQueue.main) { (note) in
            
            if (self.text?.characters.count)! > length && self.markedTextRange == nil {
                
                if let text = self.text {
                    
                    let index = text.index(text.startIndex, offsetBy: length)
                    self.text = text.substring(to: index)
                }
            }
        }
    }
    
    //MARK: -扩展TextView的placeHolder
    var placeHolderTextView: UITextView? {
        
        get{
            
            return objc_getAssociatedObject(self, &JPlaceholderLabelPointer
                ) as? UITextView
        }
        
        set{
            
            objc_setAssociatedObject(self, &JPlaceholderLabelPointer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
    }
    
    /// TextView的placeHolder
    public var j_placeHolder: String? {
        
        get {
            
            return objc_getAssociatedObject(self, &JPlaceholderText) as? String
        }
        
        set {
            
            objc_setAssociatedObject(self, &JPlaceholderText, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            if placeHolderTextView == nil {
                
                placeHolderTextView = UITextView(frame:self.bounds)
                
                placeHolderTextView?.isUserInteractionEnabled = false
                
                placeHolderTextView?.text = newValue
                
                placeHolderTextView?.textColor = UIColor.gray
                
                self.insertSubview(placeHolderTextView!, at:0)
            }
        }
    }
    
    /// TextView的placeHolder的Font
    public var j_placeHolderFont: UIFont? {
        
        get {
            
            return objc_getAssociatedObject(self, &JPlaceholderTextFont) as? UIFont
        }
        
        set {
            
            objc_setAssociatedObject(self, &JPlaceholderTextFont, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            if placeHolderTextView != nil {
                
                placeHolderTextView?.font = newValue
            }
        }
    }
    
    /// TextView的placeHolder的Color
    public var j_placeHolderTextColor: UIColor? {
        
        get {
            
            return objc_getAssociatedObject(self, &JPlaceholderTextColor) as? UIColor
        }
        
        set {
            
            objc_setAssociatedObject(self, &JPlaceholderTextColor, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            if placeHolderTextView != nil {
                
                placeHolderTextView?.textColor = newValue
            }
        }
    }
    
    open override func willMove( toSuperview newSuperview: UIView? ) {
        
        NotificationCenter.default.addObserver(forName: .UITextViewTextDidChange, object: nil, queue: OperationQueue.main) { (note) in
            
            guard self.placeHolderTextView != nil else{
                
                return
            }
            
            if note.object as! UITextView === self {
                
                if self.text.lengthOfBytes(using: .utf8) > 0 {
                    
                    self.placeHolderTextView!.isHidden = true
                    
                } else {
                    
                    self.placeHolderTextView!.isHidden=false
                }
            }
        }
    }
    
}
