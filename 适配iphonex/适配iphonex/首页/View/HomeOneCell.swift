//
//  HomeOneCell.swift
//  适配iphonex
//
//  Created by 朱海燕 on 2017/12/25.
//  Copyright © 2017年 朱海燕. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class HomeOneCell: ASCellNode {
   
    var title: ASTextNode! //  标题
    var repleyNum: ASTextNode! // 回复数
    var bgImage: ASNetworkImageNode! // 图片
    var infoModel: HomeModel = HomeModel() // 内容model
    var replyImage: ASImageNode! /// 回复图片
    var underLineNode: ASDisplayNode! //// 下划线
    
    override init() {
        
        super.init()
        
    }
    func cellWith(model: HomeModel) -> Void {
        
        infoModel = model
        self.addImage()
        self.addTitle()
        self.addReplyNum()
        self.addReplyImage()
        self.addUnderLine()
    }

    override func didLoad() {
        super.didLoad()
    }
    
    override func layout() {
        super.layout()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        underLineNode.style.preferredSize = CGSize.init(width: constrainedSize.max.width, height: 0.5)

        let repleImageNumHor = ASStackLayoutSpec.init(direction: ASStackLayoutDirection.horizontal, spacing: 5, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [replyImage,repleyNum])
        
        let titleStackVer = ASStackLayoutSpec.init(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.spaceBetween, alignItems: ASStackLayoutAlignItems.stretch, children: [title,repleImageNumHor])
        titleStackVer.flexShrink = 1000
        
        let bgImageHor = ASStackLayoutSpec.init(direction: ASStackLayoutDirection.horizontal, spacing: 10, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.stretch, children: [bgImage, titleStackVer])
        
        let insetLayout = ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10), child: bgImageHor)
        
        let lineStackVer = ASStackLayoutSpec.init(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: .start, children: [insetLayout,underLineNode])
        
        return lineStackVer
    }
    
    func addUnderLine() -> Void {
        
        let underLine =  AsynComment.addUnderLine(node: self)
        underLineNode = underLine
    }
    
    func addReplyImage() -> Void {
        
        let image = AsynComment.addImage(node: self, defaultImg: "common_chat_new")
        replyImage = image
        replyImage.style.preferredSize = CGSize.init(width: 11, height: 11)
    }
    
    func addImage() -> Void {
        
        let image = AsynComment.nodeImageAddNode(node: self, defaultImg: "luisX", url: "")
        bgImage = image
        bgImage.style.preferredSize = CGSize.init(width: 84, height: 62)
    }
    
    func addReplyNum() -> Void {
        
        let titleNode: ASTextNode = AsynComment.nodeTextNodeAddNode(node: self)
        titleNode.maximumNumberOfLines = 2
        titleNode.isLayerBacked = true
        titleNode.attributedText = NSAttributedString.init(string: infoModel.repleyNum, attributes: [NSAttributedStringKey.foregroundColor : kColor_666666, NSAttributedStringKey.font: kFont_12])
        repleyNum = titleNode
    }
    
    func addTitle() -> Void {
       
        let titleNode: ASTextNode = AsynComment.nodeTextNodeAddNode(node: self)
        titleNode.maximumNumberOfLines = 2
        titleNode.isLayerBacked = true
        titleNode.attributedText = NSAttributedString.init(string: infoModel.title, attributes: [NSAttributedStringKey.foregroundColor : kColor_666666, NSAttributedStringKey.font: kFont_14])
        title = titleNode
    }
}
