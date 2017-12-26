//
//  Array_Ext.swift
//  JKit-SwiftDemo
//
//  Created by Zebra on 2017/8/25.
//  Copyright © 2017年 Zebra. All rights reserved.
//

import UIKit

extension Array {
    
    /// 数组 -> json
    ///
    /// - Returns: json
    func toJson() -> String {
        
        let data = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        return String(data: data!, encoding: String.Encoding.utf8)!
    }
}
