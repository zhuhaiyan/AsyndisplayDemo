//
//  UIBarButtonItem+Ext.swift
//  JKit-SwiftDemo
//
//  Created by Zebra on 2017/7/25.
//  Copyright © 2017年 Zebra. All rights reserved.
//

import UIKit

public typealias JBarButtonHandlder = ( _ barButtonItem: UIBarButtonItem ) -> ()

var JBarButtonHandlderKey: UInt8 = 0

extension UIBarButtonItem {
    
    var jBarButtonHandlder : JBarButtonHandlder? {
        
        get{
            
            return objc_getAssociatedObject(self, &JBarButtonHandlderKey
                ) as? JBarButtonHandlder
        }
        
        set{
            
            objc_setAssociatedObject(self, &JBarButtonHandlderKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public convenience init( title: String?, style: UIBarButtonItemStyle, barButtonHandlder: @escaping JBarButtonHandlder ) {
        
        self.init(title: title, style: style, target: nil, action: #selector(barButtonClicked))
        
        self.jBarButtonHandlder = barButtonHandlder
    }
    
    public convenience init( image: UIImage?, style: UIBarButtonItemStyle, barButtonHandlder: @escaping JBarButtonHandlder ) {
        
        self.init(image: image, style: style, target: nil, action: #selector(barButtonClicked))
        
        self.jBarButtonHandlder = barButtonHandlder
    }
    
    public convenience init( barButtonSystemItem systemItem: UIBarButtonSystemItem, barButtonHandlder: @escaping JBarButtonHandlder ) {
        
        self.init(barButtonSystemItem: systemItem, target: nil, action: #selector(barButtonClicked))
        
        self.jBarButtonHandlder = barButtonHandlder
    }
    
    @objc public func barButtonClicked( _ barButtonItem: UIBarButtonItem ) {
        
        self.jBarButtonHandlder?(barButtonItem)
    }
    
}
