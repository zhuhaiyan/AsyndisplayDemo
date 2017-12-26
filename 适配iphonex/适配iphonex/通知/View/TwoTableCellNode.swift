//
//  TwoTableCellNode.swift
//  适配iphonex
//
//  Created by 朱海燕 on 2017/12/22.
//  Copyright © 2017年 朱海燕. All rights reserved.
//

import UIKit

import AsyncDisplayKit
import AsyncDisplayKit.AsyncDisplayKit

class TwoTableCellNode: ASCellNode {
    
    var bgImage: ASNetworkImageNode!  // 图片
    var titleText: ASTextNode! // 标题
    var detailText: ASTextNode! // 详情
    var timeText: ASTextNode! // 发布时间
    var picDetail: ASTextNode! // 图片详情
    var imageCell: ASCollectionNode! // 图片展示
    var bgView: ASTextNode! // 测试
    var underLine: ASDisplayNode! // 下划线
    
    override init() {
        
        super.init()
        
        self.updateInfo()
    }
    
    func updateInfo() -> Void {
        
        /// 商品图
        let bgImageNode = AsynComment.nodeImageAddNode(node: self, defaultImg: "luisX", url: "")
        bgImageNode.style.layoutPosition = CGPoint.init(x: 0, y: 0)
        bgImageNode.style.preferredSize = CGSize.init(width: 40, height: 40)
        bgImage = bgImageNode
        
        /// 标题
        let titleTextNode = AsynComment.nodeTextNodeAddNode(node: self)
        titleTextNode.attributedText = NSAttributedString.init(string: "我是🐷小白", attributes: [NSAttributedStringKey.foregroundColor : kColor_666666, NSAttributedStringKey.font: kFont_14])
        titleTextNode.style.flexShrink = 1
        titleTextNode.maximumNumberOfLines = 1
        titleText = titleTextNode
        
        /// 详情
        let newTextNode = AsynComment.nodeTextNodeAddNode(node: self)
        newTextNode.attributedText = NSAttributedString.init(string: "我是详情啊我是相亲我的打底裤大幅度的短发短发短发 短发发短发短发短发当时的短发短发短发时对方的短发短发短发时", attributes: [NSAttributedStringKey.foregroundColor : kColor_333333, NSAttributedStringKey.font: kFont_14])
        newTextNode.style.flexShrink = 3
        newTextNode.maximumNumberOfLines = 3
        detailText = newTextNode
        
        /// 发布时间
        let timeNode = AsynComment.nodeTextNodeAddNode(node: self)
        timeNode.attributedText = NSAttributedString.init(string: "2017-12-24", attributes: [NSAttributedStringKey.foregroundColor : kColor_666666, NSAttributedStringKey.font : kFont_14])
        timeNode.style.flexShrink = 1
        timeNode.maximumNumberOfLines = 1
        timeText = timeNode
        
        /// 图片详情
        let picDetialNode = AsynComment.nodeTextNodeAddNode(node: self)
        picDetialNode.attributedText = NSAttributedString.init(string: "我听见下雨的声音，爱像一阵风，吹完它就走。爱在过境。缘分不停，凄美的动听，而我听见下雨的声音，想起你用唇语说爱情。终于听见下雨的声音。发现你始终你靠近，默默的陪在我生命，态度坚定", attributes: [NSAttributedStringKey.foregroundColor : kColor_666666, NSAttributedStringKey.font : kFont_14])
        picDetialNode.style.flexShrink = 1
        picDetialNode.maximumNumberOfLines = 1000
        picDetail = picDetialNode
        
        ///图片collcetionview
        let picCollectionNode = self.addCollectionNode(node: self)
        imageCell = picCollectionNode
        self.addUnderLine()
        
    }
    func addUnderLine() -> Void {
        
        let underLineNode = AsynComment.addUnderLine(node: self)
        underLine = underLineNode
        
    }
    
    func addCollectionNode(node: ASDisplayNode) -> ASCollectionNode {
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: 50, height: 50)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collection = ASCollectionNode.init(collectionViewLayout: layout)
        collection.frame = CGRect.init(x: 0, y: 0, width: 100, height: 100)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = kColor_line
        node.addSubnode(collection)
        return collection
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        imageCell.style.preferredSize = CGSize.init(width: constrainedSize.max.width, height: 100)

        /// 对title的水平约束
        let titleStack = ASStackLayoutSpec.init(direction: .horizontal, spacing: 10, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.start, children: [titleText])
        
        let timeStack = ASStackLayoutSpec.init(direction: ASStackLayoutDirection.vertical, spacing: 10, justifyContent: ASStackLayoutJustifyContent.spaceBetween, alignItems: ASStackLayoutAlignItems.start, children: [titleStack,timeText])
        
        
        /// 图片绝对约束
        let bigTagAbsolute = ASAbsoluteLayoutSpec.init(sizing: ASAbsoluteLayoutSpecSizing.default, children: [bgImage])
        
        // 图片水平约束
        let imageContentStack = ASStackLayoutSpec.init(direction: ASStackLayoutDirection.horizontal, spacing: 10, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.stretch, children: [bigTagAbsolute,timeStack])
        
        /// 图片详情竖直约束
        let picDetialStack = ASStackLayoutSpec.init(direction: ASStackLayoutDirection.vertical, spacing: 10, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.start, children: [imageContentStack,picDetail])
        
        /// 图片collectionview 竖直约束
        let picStack = ASStackLayoutSpec.init(direction: .vertical, spacing: 10, justifyContent: ASStackLayoutJustifyContent.start, alignItems: .start, children: [picDetialStack,imageCell])
       
        //整体边框---(边框约束)
        let inset = ASInsetLayoutSpec.init(insets: UIEdgeInsetsMake(10, 10, 10, 10), child: picStack)
        
        /// 下划线约束
        underLine.style.preferredSize = CGSize.init(width: constrainedSize.max.width, height: 0.5)
         let lineStackVer = ASStackLayoutSpec.init(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: .start, children: [inset,underLine])
        
        return lineStackVer
    }
    
    override func layout() {
        
        super.layout()
    }
    
    override func didLoad() {
        
        super.didLoad()
    }
}
extension TwoTableCellNode: ASCollectionDelegate,ASCollectionDataSource {
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        let cellNodeBlock: ASCellNodeBlock = {
            
            let cellNode1: TwoCollectionCellNode = TwoCollectionCellNode.init()
            
            return cellNode1
        }
        
        return cellNodeBlock
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        
        return ASSizeRangeMake(CGSize.init(width: (KWidth - 20)/3, height: 100), CGSize.init(width: (KWidth - 20)/3, height: 100))
    }
}

