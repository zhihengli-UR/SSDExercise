//
//  DefaultNavigationController.swift
//  SSDExercise
//
//  Created by 李 智恒 on 15/7/29.
//  Copyright (c) 2015年 李 智恒. All rights reserved.
//

import UIKit

let themeColor = UIColor(red: 14/255.0, green: 96/255.0, blue: 152/255.0, alpha: 1)

class DefaultNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = themeColor
        navigationBar.translucent = false
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationBar.tintColor = UIColor.whiteColor()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    }
    

}
