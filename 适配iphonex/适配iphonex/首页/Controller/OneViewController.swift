//
//  OneViewController.swift
//  适配iphonex
//
//  Created by 朱海燕 on 2017/12/22.
//  Copyright © 2017年 朱海燕. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class OneViewController: BaseViewController {

   lazy var table: ASTableNode = {
    
    let tableNode: ASTableNode = ASTableNode.init(style: .plain)
    tableNode.delegate = self
    tableNode.dataSource = self
    tableNode.frame = CGRect.init(x: 0, y: 0, width: KWidth, height: KHight - kNavBarHeight - kTabBarHeight)
    tableNode.view.separatorStyle = .none
    return tableNode
    
    }()
    
    var dataArray:[HomeModel] = []
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        self.title = "首页"
        self.setBarItem()
        self.view.addSubnode(table)
        self.getData()
        

        
    }
    
    func getData() -> Void {
     
        let model: HomeModel = HomeModel()
        model.title = "就这样爱你 爱你 爱你 随时都要一起 我喜欢 爱你 外套 味道 还有你的怀里"
        model.repleyNum = "22"
        model.imageUrl = ""
        model.type = "0"
       
        let model2: HomeModel = HomeModel()
        model2.title = "就这样爱你 爱你 爱你 随时都要一起 我喜欢 爱你 外套 味道 还有你的怀里"
        model2.repleyNum = "22"
        model2.imageUrl = ""
        model2.type = "1"
        
        
        dataArray.append(model)
        dataArray.append(model2)
        dataArray.append(model)
        dataArray.append(model2)
        dataArray.append(model)
        dataArray.append(model)
        dataArray.append(model2)
        table.reloadData()
    }
    
    @objc func rightItem() -> Void {
        
    }
    
    /// 设置导航栏item
    func setBarItem() -> Void {
        
        if  let version = Double(UIDevice.current.systemVersion){
            
            if version >= 11{
                
                let bgView: UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
                let button: UIButton = UIButton.init(frame: CGRect.init(x: 15, y: 0, width: 40, height: 40))
                button.setTitle("测试", for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                bgView.addSubview(button)
                self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: bgView)
                
            }else{
                
                let barButtonItem: UIBarButtonItem = UIBarButtonItem.init(title: "右边", style: UIBarButtonItemStyle.plain, target: self, action: #selector(rightItem))
                let space: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
                space.width = -15
                self.navigationItem.rightBarButtonItems = [space,barButtonItem]
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension OneViewController: ASTextNodeDelegate,ASTableDelegate,ASTableDataSource {
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        
//        let model: HomeModel = dataArray[indexPath.row]
        let oneDetail: OneDetailViewController = OneDetailViewController()
        self.navigationController?.pushViewController(oneDetail, animated: true)
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        let model: HomeModel = dataArray[indexPath.row]
        let cellNodeBlock: ASCellNodeBlock = {
            
            if model.type == "0"{
                let cellNode: HomeOneCell = HomeOneCell.init()
                cellNode.cellWith(model: self.dataArray[indexPath.row])
                cellNode.selectionStyle = .none
                return cellNode
            }else{
                let cellNode: HomeBigImageCell = HomeBigImageCell.init()
                cellNode.cellWith(model: self.dataArray[indexPath.row])
                cellNode.selectionStyle = .none
                return cellNode
            }
        }
        
        return cellNodeBlock
    }
}
