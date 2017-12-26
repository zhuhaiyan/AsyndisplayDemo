//
//  AsynComment.swift
//  适配iphonex
//
//  Created by 朱海燕 on 2017/12/26.
//  Copyright © 2017年 朱海燕. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class AsynComment: NSObject {

    
    static  func nodeImageAddNode(node: ASDisplayNode, defaultImg: String, url : String) -> ASNetworkImageNode {
        
        let imageNetNode = ASNetworkImageNode.init()
        imageNetNode.defaultImage = UIImage.init(named: defaultImg)
        imageNetNode.clipsToBounds = true
        imageNetNode.contentMode = .scaleAspectFill
        imageNetNode.setURL(URL.init(string: url), resetToDefault: true)
        node.addSubnode(imageNetNode)
        return imageNetNode
    }
    
   static func nodeTextNodeAddNode(node: ASDisplayNode) -> ASTextNode {
        
        let textNode: ASTextNode = ASTextNode.init()
        node.addSubnode(textNode)
        return textNode
    }
    
  static  func addImage(node: ASDisplayNode, defaultImg: String) -> ASImageNode {
        
        let image = ASImageNode.init()
        image.image = UIImage.init(named: defaultImg)
        image.contentMode = .scaleAspectFill
        node.addSubnode(image)
        return image
    }
    
 static   func addUnderLine(node: ASDisplayNode) -> ASDisplayNode {
       
        let underLine = ASDisplayNode.init()
        underLine.isLayerBacked = true
        underLine.backgroundColor = kColor_line
        node.addSubnode(underLine)
        return underLine
    }
    
    
    
}
