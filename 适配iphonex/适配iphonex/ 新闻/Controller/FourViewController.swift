//
//  FourViewController.swift
//  适配iphonex
//
//  Created by 朱海燕 on 2017/12/22.
//  Copyright © 2017年 朱海燕. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class FourViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buton: UIButton = UIButton.init(type: .custom)
        buton.frame = CGRect.init(x: 50, y: 50, width: 50, height: 50)
        buton.backgroundColor = UIColor.red
        buton.click = {
           print("点击了button")
        }
        self.view.addSubview(buton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
