//
//  HomeDetailSectionView.swift
//  适配iphonex
//
//  Created by 朱海燕 on 2017/12/26.
//  Copyright © 2017年 朱海燕. All rights reserved.
//

import UIKit

class HomeDetailSectionView: UIView {

    @IBOutlet var titleLab: UILabel!
    
  static  func initView() -> HomeDetailSectionView {
        
        let view: HomeDetailSectionView = Bundle.main.loadNibNamed("HomeDetailSectionView", owner: nil, options: nil)?.last as! HomeDetailSectionView
        
        return view
    }
}
