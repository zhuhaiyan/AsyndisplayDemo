//
//  NavBarBackButton+Ext.swift
//  JKit-SwiftDemo
//
//  Created by Zebra on 2017/7/25.
//  Copyright © 2017年 Zebra. All rights reserved.
//

import UIKit

@objc protocol JBackButtonHandlderProtocol {
    
    /// 系统返回事件监听
    ///
    /// - Returns: 返回/不返回
    @objc optional func j_navigationShouldPopOnBackButton() -> Bool
}

var JBackButtonHandlderProtocolKey: UInt8 = 0

extension UIViewController: JBackButtonHandlderProtocol {
    
    var delegate : JBackButtonHandlderProtocol? {
        
        get{
            
            return objc_getAssociatedObject(self, &JBackButtonHandlderProtocolKey
                ) as? JBackButtonHandlderProtocol
        }
        
        set{
            
            objc_setAssociatedObject(self, &JBackButtonHandlderProtocolKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension UINavigationController: UINavigationBarDelegate {
    
    //MARK: -监听系统返回事件实现方法
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        
        if let items = navigationBar.items,
            viewControllers.count < items.count  {
            
            return true
        }
        
        var shouldPop = true
        
        if let viewController = self.topViewController,
            viewController.responds(to: #selector(JBackButtonHandlderProtocol.j_navigationShouldPopOnBackButton))        {
            
            viewController.delegate = viewController
            
            shouldPop = viewController.delegate!.j_navigationShouldPopOnBackButton!()
            
            viewController.delegate = nil
        }
        
        if shouldPop {
            
            DispatchQueue.main.async {
                
                self.popViewController(animated: true)
            }
        } else {
            
            for subView in navigationBar.subviews {
                
                if subView.alpha < 1.0 {
                    
                    UIView.animate(withDuration: 0.25, animations: {
                        
                        subView.alpha = 1.0
                    })
                }
            }
        }
        
        return false
    }
}

