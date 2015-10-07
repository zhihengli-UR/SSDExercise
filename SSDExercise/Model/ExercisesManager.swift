//
//  ExercisesManager.swift
//  SSDExercise
//
//  Created by 李 智恒 on 15/7/14.
//  Copyright (c) 2015年 李 智恒. All rights reserved.
//

import UIKit

/*
题目数组UserDefault结构：
根节点为Dictionary
0级：key:ExercisesArray
一级:key:SSD1-9(String) value:dictionary
二级:key:sequence, wrong, collection(String) value:array
三级:题目的identifier
*/

/*
最新题目UserDefault结构：
根节点为Dictionary
0级：key:LatestExercise
一级:key:SSD1-9(String) value:dictionary
二级:key:sequence, wrong, collection(String) value:identifier(String)
*/



class ExercisesManager {
    //单例
    
    private static let manager = ExercisesManager()
    
    static var sharedManager: ExercisesManager {
        return self.manager
    }
    
//    class var sharedManager: ExercisesManager {
//        struct Static {
//            static let manager: ExercisesManager = ExercisesManager()
//        }
//        return Static.manager
//    }
    
    private init() {
        
    }
    
    var rootArray: NSMutableArray!
    var exercise: SSDExercise?
    var nextExercise: SSDExercise?
    var beforeExercise: SSDExercise?
    
    func initializeExercises(#book: Int) {
        
        rootArray = NSMutableArray(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("ku_ssd\(book)", ofType: "plist")!)!)
        var mode: ExerciseMode = NSUserDefaults.standardUserDefaults().objectForKey("Mode") as! ExerciseMode
        var USDFExercisesArrayDict = NSUserDefaults.standardUserDefaults().dictionaryForKey("ExercisesArray") as! [String: AnyObject]
        var dict1 = USDFExercisesArrayDict["SSD\(book)"] as! [String: AnyObject]
        var identifiers = dict1[mode.rawValue] as! [String]
        var USDFLastestExerciseDict = NSUserDefaults.standardUserDefaults().dictionaryForKey("LatestExercise") as! [String: AnyObject]
        var dict2 = USDFLastestExerciseDict["SSD\(book)"] as! [String: String]
        var lastestIdentifier: String = dict2[mode.rawValue]!

        
        switch mode {
        case .Sequence:
            
//            if !identifiers.isEmpty {
//                
//                for var i = 0; i < rootArray.count; i++ {
//
//                    if (rootArray[i]["identifier"] as! String)
//                }
//                
//                for item in rootArray {
//                    if (item["identifier"] as! String) == lastestIdentifier {
//                        exercise = SSDExercise(exerciseDict: item as! [String : String])
//                    }else if (item["identifier"] as! String) == "\(lastestIdentifier.toInt()!+1)" {
//                        nextExercise = SSDExercise(exerciseDict: item as! [String: String])
//                    }else if (item["identifier"] as! String) == "\(lastestIdentifier.toInt()!-1)" {
//                        beforeExercise = SSDExercise(exerciseDict: item as! [String: String])
//                    }else {
//                        continue
//                    }
//                }
//            }

        case .Wrong, .Collection:
            
            var wrongOrCollectionArray: [AnyObject]!
            for identifier in identifiers {
                for item in rootArray {
                    if (item["identifier"] as! String) == identifier {
                        wrongOrCollectionArray.append(item)
                        break
                    }
                }
            }
            rootArray = NSMutableArray(array: wrongOrCollectionArray)
            for var i = 0; i < wrongOrCollectionArray.count; i++ {
                if rootArray[i]["identifier"] as! String == lastestIdentifier {
                    exercise = SSDExercise(exerciseDict: rootArray[i] as! [String: String])
                    beforeExercise = SSDExercise(exerciseDict: rootArray[i-1] as! [String: String])
                    nextExercise = SSDExercise(exerciseDict: rootArray[i+1] as! [String: String])
                }
            }
        case .random, .exam:
            //打乱rootArray的顺序
            var originalLength = rootArray.count
            var newArray: [AnyObject]!
            for var i = 0; i < originalLength; i++ {
                var random: Int = Int(arc4random()) % rootArray.count  //生成数组长度的一个随机数
                newArray.append(NSDictionary(dictionary: rootArray[random] as! [String: String], copyItems: true))
                rootArray[random] = NSDictionary(dictionary: rootArray.lastObject as! [String: String], copyItems: true)
                rootArray.removeLastObject()
            }
            
            rootArray = NSMutableArray(array: newArray)
            exercise = SSDExercise(exerciseDict: rootArray[0] as! [String: String])
            beforeExercise = nil
            nextExercise = SSDExercise(exerciseDict: rootArray[1] as! [String: String])
        default:
            rootArray = nil
            exercise = nil
            beforeExercise = nil
            nextExercise = nil
        }
        
    }
    
    func next(){
        var mode: ExerciseMode = NSUserDefaults.standardUserDefaults().objectForKey("Mode") as! ExerciseMode
        switch mode {
        case .Sequence:
            
        }
    }
    
    
}


