//
//  TwoCollectionNode.swift
//  适配iphonex
//
//  Created by 海燕 on 2017/12/24.
//  Copyright © 2017年 朱海燕. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class TwoCollectionCellNode: ASCellNode {

    var  imageCell: ASNetworkImageNode! // 图片
    
    override init() {
        
        super.init()
        self.updateInfo()
    }
    func updateInfo() -> Void {
        
        /// 商品图
        let bgImageNode = AsynComment.nodeImageAddNode(node: self, defaultImg: "luisX", url: "")
        bgImageNode.style.layoutPosition = CGPoint.init(x: 0, y: 0)
        imageCell = bgImageNode
    }
    
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        imageCell.style.preferredSize = CGSize.init(width: constrainedSize.max.width - 10 , height: 100)
        
        let imageHor = ASStackLayoutSpec.init(direction: .horizontal, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.start, children: [imageCell])
        
        let imageVer = ASStackLayoutSpec.init(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.stretch, children: [imageHor])
        
        return ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0), child: imageVer)
        
    }
    
    override func layout() {
        
        super.layout()
    }
    
    override func didLoad() {
        
        super.didLoad()
    }
}
