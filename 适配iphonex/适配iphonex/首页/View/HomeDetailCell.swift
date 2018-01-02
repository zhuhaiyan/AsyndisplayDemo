//
//  HomeDetailCell.swift
//  适配iphonex
//
//  Created by 朱海燕 on 2017/12/26.
//  Copyright © 2017年 朱海燕. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class HomeDetailCell: ASCellNode {

    var userImage: ASNetworkImageNode! // 用户头像
    var userName: ASTextNode! // 用户名
    var userLoction: ASTextNode! // 用户位置
    var floorNum: ASTextNode! // 楼层号
    var content: ASTextNode! // 内容
    var reply: HomeDetailReplyNode! // 子回复
    
    override init() {
        super.init()
    }
    
    override func layout() {
        super.layout()
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    func cellWith(model:CommentModel ) -> Void {
        
        let image: ASNetworkImageNode = AsynComment.nodeImageAddNode(node: self, defaultImg: "luisX", url: model.userImageUrl)
        userImage = image
        
        let name: ASTextNode = AsynComment.nodeTextNodeAddNode(node: self)
        name.attributedText = NSAttributedString.init(string: model.userName, attributes: [NSAttributedStringKey.foregroundColor : kColor_999999, NSAttributedStringKey.font: kFont_14])
        name.maximumNumberOfLines = 1
        userName = name
        
        let location: ASTextNode = AsynComment.nodeTextNodeAddNode(node: self)
        location.attributedText = NSAttributedString.init(string: model.userLocation, attributes: [NSAttributedStringKey.foregroundColor : kColor_999999, NSAttributedStringKey.font: kFont_12])
        location.maximumNumberOfLines = 1
        userLoction = location
        
        let floor: ASTextNode = AsynComment.nodeTextNodeAddNode(node: self)
        floor.attributedText = NSAttributedString.init(string: model.floor, attributes: [NSAttributedStringKey.foregroundColor : kColor_999999, NSAttributedStringKey.font: kFont_12])
        floor.maximumNumberOfLines = 1
        floorNum = floor
        
        let contentNode: ASTextNode = AsynComment.nodeTextNodeAddNode(node: self)
        contentNode.attributedText = NSAttributedString.init(string: model.content, attributes: [NSAttributedStringKey.foregroundColor : kColor_666666, NSAttributedStringKey.font: kFont_14])
        content = contentNode
        
        let arr = [model,model,model]
        let replyNode: HomeDetailReplyNode = HomeDetailReplyNode.init()
        replyNode.addReplayNode(items: arr)
        self.addSubnode(replyNode)
        reply = replyNode
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
       
        userImage.style.preferredSize = CGSize.init(width: 40, height: 40)
        
        let locationVer = ASStackLayoutSpec.init(direction: ASStackLayoutDirection.vertical, spacing: 10, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.start, children: [userName,userLoction])

//        let floorHor = ASStackLayoutSpec.init(direction: ASStackLayoutDirection.horizontal, spacing: 0, justifyContent: .spaceBetween, alignItems: ASStackLayoutAlignItems.start, children: [locationVer, floorNum])
//
//        let replyVer = ASStackLayoutSpec.init(direction: .vertical, spacing: 10, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.stretch, children: [floorHor,reply,content])
//
//
//        let imageHor = ASStackLayoutSpec.init(direction: ASStackLayoutDirection.horizontal, spacing: 10, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.stretch, children: [userImage, replyVer])

     
//        let contentVer = ASStackLayoutSpec.init(direction: .vertical, spacing: 10, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.stretch, children: [imageHor,content])

      
         let imageHor = ASStackLayoutSpec.init(direction: ASStackLayoutDirection.horizontal, spacing: 10, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.stretch, children: [userImage, locationVer])
        
        let nameHor = ASStackLayoutSpec.init(direction: ASStackLayoutDirection.horizontal, spacing: 10, justifyContent: .spaceBetween, alignItems: ASStackLayoutAlignItems.start, children: [imageHor, floorNum])
        
        let replyVer = ASStackLayoutSpec.init(direction: .vertical, spacing: 10, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.stretch, children: [nameHor,reply])
        
        let contentVer = ASStackLayoutSpec.init(direction: .vertical, spacing: 10, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.stretch, children: [replyVer,content])

     
        let inset = ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10), child: contentVer)
        
        return inset
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("首页详情tableview 触摸事件")
    }
    
    
}
