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
        
        let table: ASTableNode = ASTableNode.init()
        table.delegate = self
        table.dataSource = self
//        table.view.separatorStyle = UITableViewCellSeparatorStyle.none
        table.frame = CGRect.init(x: 0, y: -kNavBarHeight, width: KWidth, height: KHight + kNavBarHeight )
        table.view.tableHeaderView = tableHeadView
        return table
    }()
    
    lazy var tableHeadView: HomeDetailView = {
      
        let headView: HomeDetailView = Bundle.main.loadNibNamed("HomeDetailView", owner: nil, options: nil)?.last as! HomeDetailView
        
        return headView
    }()
    
    var dataArray: [CommentModel] = []
    
    var hotArray: [CommentModel] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.addSubnode(table)
        self.getData()
    }
    
    func getData() -> Void {
       
        let model: CommentModel = CommentModel()
        model.userImageUrl = ""
        model.userName = "🐷小白"
        model.userLocation = "北京"
        model.floor = "1楼"
        model.content = "你 就是我的小星星 挂 在那天上放光明 我已经决定要爱你 就不会轻易放弃"
        
        let model2: CommentModel = CommentModel()
        model2.userImageUrl = ""
        model2.userName = "带你去旅行"
        model2.userLocation = "土耳其"
        model2.floor = "2楼"
        model2.content = "我想要带你去浪漫的土耳其 然后一起去东京和巴黎 其实我特别喜欢迈阿密和有黑人的洛杉矶 其实亲爱的你不必太过惊喜 一起去繁华的上海和北京 还有云南的大理保留着回忆 这样才有意义"
        
        let model3: CommentModel = CommentModel()
        model3.userImageUrl = ""
        model3.userName = "钟无艳"
        model3.userLocation = "广东"
        model3.floor = "3楼"
        model3.content = "其实我怕你总夸奖高估我坚忍 其实更怕你只懂得欣赏我品行 无人及我用字绝重拾了你信心 无人问我可甘心演这伟大 化身 其实我想间中崩溃脆弱如恋人 谁在你两臂中低得不需要身份 无奈被你识穿这个念头 得到好处的你 明示不想失去绝世好友 没有得你的允许 我都会爱下去 互相祝福心软之际或者准我吻下去 我痛恨成熟到 不要你望着我流泪 但漂亮笑下去 彷佛冬天饮雪水 被你一贯的赞许 却不配爱下去 在你悲伤一刻必须解慰找到我乐趣 我甘于当副车 也是快乐着唏嘘 彼此这么了解"
        
        
        dataArray.append(model)
        dataArray.append(model2)
        dataArray.append(model3)
        dataArray.append(model2)
        dataArray.append(model3)
        

        hotArray.append(model)
        hotArray.append(model2)
        hotArray.append(model3)
        
        table.reloadData()
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
        return 2
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return self.hotArray.count
        }
        return self.dataArray.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        let cellNodeBlock: ASCellNodeBlock = {
            
            let cellNode: HomeDetailCell = HomeDetailCell.init()
            if indexPath.section == 0 {
               
                cellNode.cellWith(model: self.hotArray[indexPath.row])
            }else{
              
                cellNode.cellWith(model: self.dataArray[indexPath.row])
            }
            cellNode.selectionStyle = .none
            cellNode.userName.addTarget(self, action: #selector(self.nameTag), forControlEvents: ASControlNodeEvent.touchUpInside)
            return cellNode
        }
        return cellNodeBlock
    }
    
    @objc func nameTag() -> Void {
        
        print("点击了名字")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view: HomeDetailSectionView = HomeDetailSectionView.initView()
        
        if section == 0 {
            view.titleLab.text = "热门跟帖"
        }else{
            view.titleLab.text = "最新跟帖"
        }
        return view
    }
    
    
    
}
