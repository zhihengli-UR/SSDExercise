//
//  LatestExerciseNumberManager.swift
//  SSDExercise
//
//  Created by 李 智恒 on 15/9/3.
//  Copyright (c) 2015年 李 智恒. All rights reserved.
//

import UIKit

class LatestExerciseNumberManager {
    
    //单例模式
    static let sharedLatestNumberManager = LatestExerciseNumberManager()
    
    //最新题目的Identifier数组，9个元素，对应9本书的最新数
    private var latestIdentifierArray: [Int]!
    //最新题目的ArrayIndex数组
    private var latestIndexArray: [Int]!
    
    private let maximumIndexArray = [94, 302, 101, 100, 172, 255, 105, 173, 271]
    
    var bookNumber: Int!
    
    private init() {
        if let identifierArray = NSUserDefaults.standardUserDefaults().objectForKey("LastestIdentifer") as? [Int] {
            latestIdentifierArray = identifierArray
        } else {
            latestIdentifierArray = [1, 1, 1, 1, 1, 1, 1, 1, 2]
            NSUserDefaults.standardUserDefaults().setObject(latestIdentifierArray, forKey: "LastestIdentifer")
        }
        
        if let indexArray = NSUserDefaults.standardUserDefaults().objectForKey("LatestIndex") as? [Int] {
            latestIndexArray = indexArray
        } else {
            latestIndexArray = [-1, -1, -1, -1, -1, -1, -1, -1, -1]
            NSUserDefaults.standardUserDefaults().setObject(latestIndexArray, forKey: "LatestIndex")
        }
    }
    
    func requireLatestIdentifier()->[Int] {
        return latestIdentifierArray
    }
    
    func writeLatestIdentifier(bookNumber bookNumber: Int, identifier: Int) {
        if latestIdentifierArray[bookNumber - 1] >= identifier {
            return
        }
        latestIdentifierArray[bookNumber - 1] = identifier
        NSUserDefaults.standardUserDefaults().setObject(latestIdentifierArray, forKey: "LastestIdentifer")
    }
    
    func requireLatestIndex(bookNumber bookNumber: Int)->Int {
        //将要做下一题，所以 + 1
        if latestIndexArray[bookNumber - 1] == maximumIndexArray[bookNumber - 1] {
            return latestIndexArray[bookNumber - 1]
        }
        return latestIndexArray[bookNumber - 1] + 1
    }
    
    func writeLatestIndex(bookNumber bookNumber: Int, index: Int) {
        if latestIndexArray[bookNumber - 1] >= index {
            return
        }
        latestIndexArray[bookNumber - 1] = index
        NSUserDefaults.standardUserDefaults().setObject(latestIndexArray, forKey: "LatestIndex")
    }
    
    func resetAll() {
        latestIdentifierArray = [1, 1, 1, 1, 1, 1, 1, 1, 2]
        latestIndexArray = [-1, -1, -1, -1, -1, -1, -1, -1, -1]
        NSUserDefaults.standardUserDefaults().setObject(latestIdentifierArray, forKey: "LastestIdentifer")
        NSUserDefaults.standardUserDefaults().setObject(latestIndexArray, forKey: "LatestIndex")
    }
    
    func resetForBook(bookNumber bookNumber: Int) {
        if bookNumber == 9 {
            latestIdentifierArray[bookNumber-1] = 2
        } else {
            latestIdentifierArray[bookNumber-1] = 1
        }
        latestIndexArray[bookNumber-1] = -1
        NSUserDefaults.standardUserDefaults().setObject(latestIdentifierArray, forKey: "LastestIdentifer")
        NSUserDefaults.standardUserDefaults().setObject(latestIndexArray, forKey: "LatestIndex")
    }
    
    
    
    
    
    
}
