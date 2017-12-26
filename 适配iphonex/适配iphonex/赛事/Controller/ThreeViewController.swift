//
//  ThreeViewController.swift
//  适配iphonex
//
//  Created by 朱海燕 on 2017/12/22.
//  Copyright © 2017年 朱海燕. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ThreeViewController: BaseViewController {

    lazy var collection: ASCollectionNode = {
       
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        let collection: ASCollectionNode = ASCollectionNode.init(frame: CGRect.init(x: 0, y: 0, width: KWidth, height: KHight - kNavBarHeight - kTabBarHeight), collectionViewLayout:layout )
        collection.delegate = self
        collection.dataSource = self
        /// 我居然不注册到处想为啥不显示，结果注册完还是不显示。
//        collection.view.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        
        return collection
    }()
    
    var sectionArray: [String] = ["1","2","3"]
    var dataArray: [EventModel] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.addSubnode(collection)
        collection.view.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "UICollectionElementKindSectionHeader")
        self.getData()
    }
    
    func getData() -> Void {
        
        let model: EventModel = EventModel()
        model.title = "陈芳语"
        model.imageUrl = "http://img2.cache.netease.com/game/app/choice/icon/new_wnl_1.png"
        dataArray.append(model)
        dataArray.append(model)
        dataArray.append(model)
        dataArray.append(model)
        dataArray.append(model)
        
        collection.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
extension ThreeViewController: ASCollectionDelegate, ASCollectionDataSource{
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return sectionArray.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    //// collectioncell
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        let cellNodeBlock: ASCellNodeBlock = {
            
            let cellNode: EventsCollectionCell = EventsCollectionCell.init()
            cellNode.cellWith(model: self.dataArray[indexPath.row])
            return cellNode
        }
        
        return cellNodeBlock
    }

    /// collcetionView 段头段尾
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> ASCellNode {
        
        let cellNode: ASCellNode = ASCellNode.init()

        /// 如果是section header
        if kind == UICollectionElementKindSectionHeader{
           
            let cellNode1: ASCellNode = ASCellNode.init()
            cellNode1.backgroundColor = UIColor.init(red: 241.0/255.0, green: 241.0/255.0, blue: 241.0/255.0, alpha: 1.0)
            cellNode1.style.preferredSize = CGSize.init(width: KWidth, height: 20)
            return cellNode1
        }
        return cellNode
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize.init(width: KWidth, height: 20)
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        
        print("点击了某个item")
    }
    
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        
        return ASSizeRange.init(min: CGSize.init(width: (KWidth - 20) / 3, height: 120), max: CGSize.init(width: (KWidth - 20) / 3, height: 120))
    }
    
}
