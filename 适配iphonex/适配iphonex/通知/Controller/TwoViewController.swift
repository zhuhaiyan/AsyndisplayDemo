//
//  TwoViewController.swift
//  适配iphonex
//
//  Created by 朱海燕 on 2017/12/22.
//  Copyright © 2017年 朱海燕. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class TwoViewController: BaseViewController {

    lazy var mainTableNode: ASTableNode = {
        
        let mainTable = ASTableNode.init(style: UITableViewStyle.plain)
        
        mainTable.delegate = self
        
        mainTable.dataSource = self
        
        mainTable.frame = CGRect.init(x: 0, y: 0, width: KWidth, height: KHight - kNavBarHeight - kTabBarHeight)
        
        mainTable.view.separatorStyle = UITableViewCellSeparatorStyle.none
        
        return mainTable
        
    }()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.addSubnode(mainTableNode)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension TwoViewController : ASTableDelegate,ASTableDataSource{
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    

    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        let cellNodeBlock: ASCellNodeBlock = {
            
            let cellNode: TwoTableCellNode = TwoTableCellNode.init()
            cellNode.selectionStyle = .none
            return cellNode
        }
        
        return cellNodeBlock
    }
    
    
}
