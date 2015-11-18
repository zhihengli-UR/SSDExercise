//
//  SSDPlistManager.swift
//  SSDExercise
//
//  Created by 李 智恒 on 15/7/27.
//  Copyright (c) 2015年 李 智恒. All rights reserved.
//

enum StorageLocation {
    case sandbox
    case bundle
}


class SSDPlistManager: NSObject {
    //单例
    static let sharedManager = SSDPlistManager()
    var exercisesArray: [[String: String]]?
    
    private let basePathInSandbox = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentationDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
    
    //写入成功返回true，否则返回false
    func saveToSandBox(_array: NSArray, bookNumber: Int)->Bool {
        var array = _array as NSArray
        var pathInSandbox = basePathInSandbox.stringByAppendingString("ku_ssd\(bookNumber).plist")
        return array.writeToFile(pathInSandbox, atomically: true)
        
    }
    
    
    //将题库中的plist文件导入沙盒中的Documents目录下
    func movePlistsToSandbox()->Bool {
        var flag = true
        for i in 1...9 {
            flag = flag && movePlistsToSandbox(i)
        }
        
        return flag
    }
    
    func movePlistsToSandbox(bookNumber: Int)->Bool {
        let pathInBundle = generatePathInBundle(bookNumber)
        
        let array = NSArray(contentsOfFile: pathInBundle)
        return saveToSandBox(array!, bookNumber: bookNumber)
        
    }
    
    func loadArray(bookNumber: Int, location: StorageLocation)->[[String: String]]? {
        
        switch location {
            
            //返回未修改过的Array
        case .bundle:
            var pathInBundle = generatePathInBundle(bookNumber)
            self.exercisesArray = NSArray(contentsOfFile: pathInBundle) as? [[String: String]]
            //            return self.exercisesArray
            
            //返回存有答题记录的Array
        case .sandbox:
            var pathInSandbox = basePathInSandbox.stringByAppendingString("ku_ssd\(bookNumber).plist")
            self.exercisesArray = NSArray(contentsOfFile: pathInSandbox) as? [[String: String]]
            //            return self.exercisesArray
        }
        
        return self.exercisesArray
    }
    
    //status为"done"、"mark"或者是abcd
    //写入成功返回true，否则返回false
    func saveStatus(exercise: [String: String], bookNumber: Int, arrayIndex: Int)->Bool {
        self.exercisesArray![arrayIndex] = exercise
        return saveToSandBox(self.exercisesArray! as NSArray, bookNumber: bookNumber)
    }
    
    
    //清除用户数据
    func clearUserData(completionHandler: (writeResult: Bool)->Void) {
        
        //var result = true
        
        //        for i in 1...9 {
        //            var pathInSandbox = path.stringByAppendingString("ku_ssd\(i).plist")
        //            var array = NSArray(contentsOfFile: pathInSandbox) as! [[String : String]]
        //
        //            for var i = 0; i < array.count; i++ {
        //                array[i]["done"] = "0"
        //                array[i]["mark"] = "0"
        //                array[i]["wrong"] = "0"
        //            }
        //
        //            var arrayToWrite = NSArray(array: array)
        //
        //            var everyResult = arrayToWrite.writeToFile(pathInSandbox, atomically: true)
        //            result = result && everyResult
        //        }
        
        //        for i in 1...9 {
        //            let pathInSandbox = basePathInSandbox.stringByAppendingString("ku_ssd\(i).plist")
        //            let pathInBundle = generatePathInBundle(i)
        //
        //
        //        }
        
        let writeResult = movePlistsToSandbox()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            completionHandler(writeResult: writeResult)
        })
        
    }
    
    func migrateDatabase() {
        
    }
    
    private func generatePathInBundle(bookNumber: Int)->String {
        let path = NSBundle.mainBundle().pathForResource("ku_ssd\(bookNumber)", ofType: "plist")!
        return path
    }
    
}
