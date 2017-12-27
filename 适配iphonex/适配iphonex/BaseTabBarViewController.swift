//
//  BaseTabBarViewController.swift
//  适配iphonex
//
//  Created by 朱海燕 on 2017/12/22.
//  Copyright © 2017年 朱海燕. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let buttonItem: UIBarButtonItem = UIBarButtonItem.init()
        buttonItem.title = ""
        self.navigationItem.backBarButtonItem = buttonItem
        
        let tabBare = UITabBarItem.appearance()
        
        tabBare.setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
        
        tabBare.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        
        self.tabBar.isTranslucent = false /// 透明度
        
        self.tabBar.barTintColor = UIColor.init(red: 225.0 / 255.0, green: 225.0 / 255.0, blue: 225.0 / 255.0, alpha: 1.0)
        
        self.tabBar.backgroundImage = UIImage.init()
        
        self.tabBar.shadowImage = UIImage.init()
        
        createViewController(vcObj: OneViewController.init(), title: "首页", normalImg: "tabbar_home_normal", selectedImg: "tabbar_home_selected")
        createViewController(vcObj: TwoViewController.init(), title: "公告", normalImg: "tabbar_announcement_normal", selectedImg: "tabbar_announcement_selected")
        createViewController(vcObj: ThreeViewController.init(), title: "赛事", normalImg: "tabbar_action_normal", selectedImg: "tabbar_action_selected")
        createViewController(vcObj: FourViewController.init(), title: "新闻", normalImg: "tabbar_news_normal", selectedImg: "tabbar_news_selected")
    }

    private func createViewController(vcObj:UIViewController, title:String?, normalImg:String?, selectedImg:String?) {
        
        let viewController = vcObj
        
        let navigationController = BaseNavViewController.init(rootViewController: viewController)
        
        //标题
        if let title = title {
            
            viewController.title = title
            if title.contains("首页") {
                
                viewController.navigationItem.title = ""
                
            } else if title.contains("公告") {
                
                viewController.navigationItem.title = "通知公告"
                
            } else if title.contains("新闻") {
                
                viewController.navigationItem.title = "新闻中心"
            }
        }
        
        //CVA标题
        if normalImg == "tabbar_cva" {
            
            viewController.navigationItem.title = "CVA"
        }
        
        //图标
        if let normalImg = normalImg {
            
            navigationController.tabBarItem.image = UIImage.init(named: normalImg)?.withRenderingMode(.alwaysOriginal)
        }
        if let selectedImg = selectedImg {
            
            navigationController.tabBarItem.selectedImage = UIImage.init(named: selectedImg)?.withRenderingMode(.alwaysOriginal)
        }
        
        //导航栏颜色
        navigationController.navigationBar.barTintColor = ThemeColor
        //导航栏文字
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white]
    UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 18)], for: .normal)
        
        //修改导航栏按钮颜色
        navigationController.navigationBar.tintColor = UIColor.white
        //导航栏颜色不透明
        navigationController.navigationBar.isTranslucent = false
        
        addChildViewController(navigationController)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
