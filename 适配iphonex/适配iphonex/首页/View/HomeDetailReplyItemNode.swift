//
//  HomeDetailReplyItemNode.swift
//  适配iphonex
//
//  Created by 朱海燕 on 2017/12/29.
//  Copyright © 2017年 朱海燕. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class HomeDetailReplyItemNode: ASDisplayNode {

    var userName: ASTextNode! // 用户名
    var content: ASTextNode! // 内容
    
    override init() {
        super.init()
    }
    
    override func layout() {
        super.layout()
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    func replyItem(model: CommentModel ) -> Void {
        
        let userNameText = AsynComment.nodeTextNodeAddNode(node: self)
        userNameText.attributedText = NSAttributedString.init(string: model.userName, attributes: [NSAttributedStringKey.foregroundColor : kColor_666666, NSAttributedStringKey.font : kFont_12])
        userName = userNameText
        
        let contentNode = AsynComment.nodeTextNodeAddNode(node: self)
        contentNode.attributedText = NSAttributedString.init(string: model.content, attributes: [NSAttributedStringKey.foregroundColor : kColor_666666, NSAttributedStringKey.font : kFont_12])
        contentNode.maximumNumberOfLines = 0
        contentNode.isLayerBacked = true
        content = contentNode
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        content.style.flexShrink = 1000
        let contentVer = ASStackLayoutSpec.init(direction: ASStackLayoutDirection.vertical, spacing: 10, justifyContent: ASStackLayoutJustifyContent.start, alignItems: .stretch, children: [userName, content])
        
        let inset = ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10), child: contentVer)
        
        return inset
    }
    
    
}
