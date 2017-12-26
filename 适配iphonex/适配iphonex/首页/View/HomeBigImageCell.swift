//
//  HomeBigImageCell.swift
//  适配iphonex
//
//  Created by 朱海燕 on 2017/12/25.
//  Copyright © 2017年 朱海燕. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class HomeBigImageCell: ASCellNode {
   
    var bgImage: ASNetworkImageNode! // 图片
    var title: ASTextNode! // title
    var infoModel: HomeModel! // 数据源
    var underLineNode: ASDisplayNode! /// 下面那根线
    
    override init() {
        super.init()
    }
    
    override func layout() {
        super.layout()
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        bgImage.style.preferredSize = CGSize.init(width: constrainedSize.max.width, height: 118)
        
        title.style.flexShrink = 100  /// 并不懂这个属性是干嘛的。目前这里写啥都一个样    
        
        let imageVer = ASStackLayoutSpec.init(direction: ASStackLayoutDirection.vertical, spacing: 5, justifyContent: ASStackLayoutJustifyContent.spaceBetween, alignItems: ASStackLayoutAlignItems.start, children: [title,bgImage])
        
        let insetLayout = ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10), child: imageVer)

        underLineNode.style.preferredSize = CGSize.init(width: constrainedSize.max.width, height: 0.5)
        let lineStackVer = ASStackLayoutSpec.init(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: .start, children: [insetLayout,underLineNode])
        
        return lineStackVer
    }
    
    func cellWith(model: HomeModel) -> Void {
        infoModel = model
        self.addPic()
        self.addTitle()
        self.addUnderLine()
    }
    
    ///  添加图片
    func addPic() -> Void {
        
        let image = AsynComment.nodeImageAddNode(node: self, defaultImg: "luisX", url: infoModel.imageUrl)
        bgImage = image
    }
    
    /// 添加标题
    func addTitle() -> Void {
        
        let titleNode: ASTextNode = AsynComment.nodeTextNodeAddNode(node: self)
        titleNode.maximumNumberOfLines = 1
        titleNode.isLayerBacked = true
        titleNode.attributedText = NSAttributedString.init(string: infoModel.title, attributes: [NSAttributedStringKey.foregroundColor : kColor_666666, NSAttributedStringKey.font: kFont_14])
        title = titleNode
    }
    
    func addUnderLine() -> Void {
        
        let underLine = AsynComment.addUnderLine(node: self)
        underLineNode = underLine
    }
    
    
}
