//
//  LatestExerciseNumber.swift
//  SSDExercise
//
//  Created by 李 智恒 on 15/9/3.
//  Copyright (c) 2015年 李 智恒. All rights reserved.
//

import UIKit

class LatestExerciseNumber: NSObject {
    
    //单例模式
    static let sharedLatestNumber = LatestExerciseNumber()
    
    //最新题目数数组，9个元素，对应9本书的最新数
    private var latestNumberArray: [Int]?
    
    private let path = NSBundle.mainBundle().pathForResource("LatestNumber", ofType: "plist")
    
    func loadArrayFromPlist() {
        self.latestNumberArray = NSArray(contentsOfFile: path!) as? [Int]
    }
    
    func requireLatestNumber(#bookNumber: Int)->Int {
        if latestNumberArray == nil {
            loadArrayFromPlist()
        }
        return self.latestNumberArray![bookNumber - 1]
    }
    
    func setLatestNumberToArray(bookNumber: Int, latestNumber: Int) {
        if self.latestNumberArray == nil {
            loadArrayFromPlist()
        }
        self.latestNumberArray![bookNumber - 1] = latestNumber
    }
    
    
    
    
}
