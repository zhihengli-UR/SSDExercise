//
//  SSDPlistManager.swift
//  SSDExercise
//
//  Created by 李 智恒 on 15/7/27.
//  Copyright (c) 2015年 李 智恒. All rights reserved.
//

import UIKit

class SSDPlistManager: NSObject {
    //单例
    static let sharedManager = SSDPlistManager()
    var exercisesArray: NSMutableArray?
    
    
    //将题库中的plist文件导入沙盒中的Documents目录下
    func movePlistsToSandbox(){
        
        for i in 1...9 {
            movePlistsToSandbox(i)
        }
    }
    
    func movePlistsToSandbox(bookNumber: Int){
        var pathInBundle = NSBundle.mainBundle().pathForResource("ku_ssd\(bookNumber)", ofType: "plist")
        if let p = pathInBundle {
            var array = NSArray(contentsOfFile: p)
            var paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentationDirectory, NSSearchPathDomainMask.UserDomainMask, true)
            var path = paths[0] as! String
            var pathInSandbox = path.stringByAppendingString("ku_ssd\(bookNumber).plist")
            if array?.writeToFile(pathInSandbox, atomically: true) == true {
                println("SSD\(bookNumber)导入至沙盒成功")
            } else {
                println("SSD\(bookNumber)导入至沙盒失败")
            }
        }
    }
    
    
    func loadArray(bookNumber: Int)->NSMutableArray? {
        var paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentationDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = paths[0] as! String
        var pathInSandbox = path.stringByAppendingString("ku_ssd\(bookNumber).plist")
        self.exercisesArray = NSMutableArray(contentsOfFile: pathInSandbox)
        

        
        return self.exercisesArray
    }
    
    func saveMark(exercise: [String: String]) {

    }
    
    
    
    
    
    
}
