//
//  AppDelegate.swift
//  适配iphonex
//
//  Created by 朱海燕 on 2017/12/22.
//  Copyright © 2017年 朱海燕. All rights reserved.
//

import UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window?.rootViewController = BaseTabBarViewController()
        self.AddPush(launch: launchOptions)
        
        return true
    }

    /// 添加推送
    func AddPush(launch: [UIApplicationLaunchOptionsKey : Any]?) -> Void {
        
        if let version = Double.init(UIDevice.current.systemVersion) {
          
            if version >= 10.0{
                
                let push: JPUSHRegisterEntity = JPUSHRegisterEntity.init()
                push.types = Int(UInt8(UNAuthorizationOptions.alert.rawValue) | UInt8(UNAuthorizationOptions.badge.rawValue) | UInt8(UNAuthorizationOptions.sound.rawValue))
                
                JPUSHService.register(forRemoteNotificationConfig: push, delegate: self)
            }else{
                
                JPUSHService.register(forRemoteNotificationTypes: UInt(UInt8(UNAuthorizationOptions.alert.rawValue) | UInt8(UNAuthorizationOptions.badge.rawValue) | UInt8(UNAuthorizationOptions.sound.rawValue)), categories: nil)
            }
        }
        
        let push: JPUSHRegisterEntity = JPUSHRegisterEntity.init()
        push.types = Int(UInt8(UNAuthorizationOptions.alert.rawValue) | UInt8(UNAuthorizationOptions.badge.rawValue) | UInt8(UNAuthorizationOptions.sound.rawValue))
        
        JPUSHService.register(forRemoteNotificationConfig: push, delegate: self)
        
        /// 注册极光推送
        JPUSHService.setup(withOption: launch, appKey: "1452c81e164ec1c132ff7aeb", channel: "", apsForProduction: true, advertisingIdentifier: nil)
        
        /// 添加自定义消息推送
        
//        NotificationCenter.default.addObserver(self, selector: #selector(networkDidReceiveMessage), name: Notification.init(name: kJPFNetworkDidReceiveMessageNotification), object: nil)
    
    }
    
    @objc func networkDidReceiveMessage(noti: Notification) -> Void {
        
        let userInfo = noti.userInfo
        
        print(userInfo as Any)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {
       
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
       
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
      
    }

    func applicationWillTerminate(_ application: UIApplication) {
      
    }

}
extension AppDelegate : JPUSHRegisterDelegate {
   
    /// 注册APNs成功并上报DeviceToken
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        JPUSHService.registerDeviceToken(deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    
    /// iOS 10 需要
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
       
        let userInfo: [AnyHashable: Any] = notification.request.content.userInfo
        
        if (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.classForCoder()))!{
            JPUSHService.handleRemoteNotification(userInfo)
        }
        // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
        completionHandler(Int(UNAuthorizationOptions.alert.rawValue))
        
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        
        let userInfo: [AnyHashable: Any] = response.notification.request.content.userInfo
        if (response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.classForCoder()))!{
            JPUSHService.handleRemoteNotification(userInfo)
        }
        // 系统要求执行这个方法
        completionHandler()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        JPUSHService.handleRemoteNotification(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
}
