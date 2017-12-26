//
//  UIViewController+Ext.swift
//  JKit-SwiftDemo
//
//  Created by Zebra on 2017/7/25.
//  Copyright © 2017年 Zebra. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// 点击空白处隐藏键盘
    public func j_tapDismissKeyboard() {
        
        let noteCenter = NotificationCenter.default
        
        let viewDismissKeyboardTapGR = UITapGestureRecognizer(target: self, action: #selector(tapAnywhereToDismissKeyboard(_:)))
//        let navBarDismissKeyboardTapGR = UITapGestureRecognizer(target: self, action: #selector(tapAnywhereToDismissKeyboard(_:)))
        
        noteCenter.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: OperationQueue.main) { (note) in
            
            self.view.addGestureRecognizer(viewDismissKeyboardTapGR)
//            self.navigationController?.navigationBar.addGestureRecognizer(navBarDismissKeyboardTapGR)
        }
        
        noteCenter.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: OperationQueue.main) { (note) in
            
            self.view.removeGestureRecognizer(viewDismissKeyboardTapGR)
//            self.navigationController?.navigationBar.removeGestureRecognizer(navBarDismissKeyboardTapGR)
        }
    }
    
    @objc private func tapAnywhereToDismissKeyboard( _ gestureRecognizer: UIGestureRecognizer ) {
        
        self.view.endEditing(true)
    }
    
}
