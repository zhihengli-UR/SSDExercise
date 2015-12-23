//
//  AppDelegate.swift
//  SSDExercise
//
//  Created by 李 智恒 on 15/3/10.
//  Copyright (c) 2015年 李 智恒. All rights reserved.
//

import UIKit

//var globalMode = "sequence"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        window?.tintColor = themeColor
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        
        window?.backgroundColor = UIColor.whiteColor()
        
        //第一次打开，设置缺省UserDefaults
        if (NSUserDefaults.standardUserDefaults().objectForKey("everLaunched") == nil) {
            //做题模式
            NSUserDefaults.standardUserDefaults().setObject(ExerciseMode.Sequence.rawValue, forKey: "Mode")
            //字号
            NSUserDefaults.standardUserDefaults().setFloat(17.0, forKey: "fontSize")
            //最新题目数
//            var defaultLatestNumber = [1, 1, 1, 1, 1, 1, 1, 1, 1]
//            NSUserDefaults.standardUserDefaults().setObject(defaultLatestNumber, forKey: "LastestNumber")
            //将题库中的plist文件导入沙盒中的Documents目录下
            SSDPlistManager.sharedManager.movePlistsToSandbox()
            
            
            NSUserDefaults.standardUserDefaults().setObject("everLaunched", forKey: "everLaunched")
        }
        
        MobClick.startWithAppkey("564cb17e67e58e9465001aa8", reportPolicy: BATCH, channelId: nil);
        let version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as! String
        MobClick.setAppVersion(version)
        MobClick.setEncryptEnabled(true)
        
        
        UMFeedback.setAppkey("564cb17e67e58e9465001aa8")
        
        SSDPlistManager.sharedManager.fixNo68ExerciseInSSD2()
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

