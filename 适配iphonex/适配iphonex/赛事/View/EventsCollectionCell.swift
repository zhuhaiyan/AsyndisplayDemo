//
//  EventsCollectionCell.swift
//  适配iphonex
//
//  Created by 朱海燕 on 2017/12/26.
//  Copyright © 2017年 朱海燕. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class EventsCollectionCell: ASCellNode {
 
    var image: ASNetworkImageNode! // 图片
    var title: ASTextNode! // title
    var underLine: ASDisplayNode! /// 下划线
    var infoModel: EventModel = EventModel() /// 数据模型
    
    override init(){
        super.init()
    }
    
    override func layout() {
        super.layout()
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    func cellWith(model: EventModel) -> Void {
        
        infoModel = model
        let imageNode = AsynComment.nodeImageAddNode(node: self, defaultImg: "luisX", url: model.imageUrl)
        imageNode.clipsToBounds = true
        image = imageNode
        
        let text = AsynComment.nodeTextNodeAddNode(node: self)
        text.maximumNumberOfLines = 1 /// 保证是单行
        text.isLayerBacked = true // 暂时不知道
        text.attributedText = NSAttributedString.init(string: model.title, attributes: [NSAttributedStringKey.foregroundColor : kColor_333333, NSAttributedStringKey.font: kFont_14])
        title = text
        
        let underLineNode = AsynComment.addUnderLine(node: self)
        underLine = underLineNode
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        image.style.preferredSize = CGSize.init(width: 80, height: 80)
        title.style.flexShrink = 1000
        
        let imageVerStack = ASStackLayoutSpec.init(direction: ASStackLayoutDirection.vertical, spacing: 8, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [image,title])
        imageVerStack.style.flexShrink = 1000
        
        let inset = ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 10, left: 0, bottom: 0, right: 0), child: imageVerStack)
        
        return inset
    }
    
    
}
