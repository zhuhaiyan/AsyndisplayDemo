//
//  OneDetailViewController.swift
//  适配iphonex
//
//  Created by 朱海燕 on 2017/12/26.
//  Copyright © 2017年 朱海燕. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class OneDetailViewController: BaseViewController {

    lazy var table: ASTableNode = {
        
        let table: ASTableNode = ASTableNode.init(style: .plain)
        table.delegate = self
        table.dataSource = self
        table.frame = CGRect.init(x: 0, y: -kNavBarHeight, width: KWidth, height: KHight + kNavBarHeight )
        table.view.tableHeaderView = tableHeadView
        return table
    }()
    
    lazy var tableHeadView: HomeDetailView = {
      
        let headView: HomeDetailView = Bundle.main.loadNibNamed("HomeDetailView", owner: nil, options: nil)?.last as! HomeDetailView
        
        return headView
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.addSubnode(table)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    self.navigationController?.navigationBar.j_setDefaultBackgroundColor(ThemeColor)
        self.navigationController?.navigationBar.j_setAlpha(0.0)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.j_reset(false)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension OneDetailViewController: ASTableDelegate, ASTableDataSource,UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        /// 导航栏透明度
        
        let minAlphaOffset: CGFloat = 0.0
        let maxAlphaOffset: CGFloat = kNavBarHeight * 2
        var offsexY = scrollView.contentOffset.y
        
        let apha: CGFloat = (offsexY - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset)
        self.navigationController?.navigationBar.j_setAlpha(apha)
        
        offsexY > 0 ? (self.title = "详情"): (self.title = "")
        
        if IOS11 {
           offsexY = offsexY + kNavBarHeight
        }
        
        if offsexY < 0{
           
            tableHeadView.bgImage.frame = CGRect.init(x: offsexY / 2, y: offsexY, width: KWidth - offsexY, height: 228 - offsexY)
        }else{
            
            tableHeadView.bgImage.frame = CGRect.init(x: 0, y: 0, width: KWidth, height: 228)
        }
    }
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 3
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        let cellNodeBlock: ASCellNodeBlock = {
            
            let cellNode: HomeDetailCell = HomeDetailCell.init()
            return cellNode
            
        }
        return cellNodeBlock
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        
        return ASSizeRange.init(min: CGSize.init(width: KWidth, height: 100), max: CGSize.init(width: KWidth, height: 100))
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view: HomeDetailSectionView = HomeDetailSectionView.initView()
        view.titleLab.text = "标题"
        return view
    }
    
    
    
}
