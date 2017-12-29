//
//  HomeDetailReplyNode.swift
//  适配iphonex
//
//  Created by 朱海燕 on 2017/12/29.
//  Copyright © 2017年 朱海燕. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class HomeDetailReplyNode: ASDisplayNode {

    var commentItems: [CommentModel] = []
    var replyNodes: [HomeDetailReplyItemNode] = []
    
    override init() {
        super.init()
        self.backgroundColor = UIColor.init(red: 248.0 / 255.0, green: 249.0 / 255.0, blue: 241.0 / 255.0, alpha: 1.0)
    }
    
    override func layout() {
        super.layout()
    }
    
    override func didLoad() {
        super.didLoad()
        self.layer.borderColor = UIColor.init(red: 218.0 / 255.0, green: 218.0 / 255.0, blue: 218.0 / 255.0, alpha: 1.0).cgColor
        self.layer.borderWidth = 0.5
    }
    
    func addReplayNode(items: [CommentModel]) -> Void {
        
        for item in items {
            
            let replayNode = HomeDetailReplyItemNode.init()
            replayNode.replyItem(model: item)
            self.addSubnode(replayNode)
            replyNodes.append(replayNode)
        }
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let vetStack = ASStackLayoutSpec.init(direction: ASStackLayoutDirection.vertical, spacing: 10, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.stretch, children: replyNodes)
        
        return vetStack
    }
    
}
