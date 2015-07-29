//
//  ModelController.swift
//  PageViewTest
//
//  Created by 李 智恒 on 15/7/16.
//  Copyright (c) 2015年 李 智恒. All rights reserved.
//

import UIKit

/*
A controller object that manages a simple model -- a collection of month names.

The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.

There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
*/

/*
UserDefault说明：
做题模式——Key:Mode
*/

enum ExerciseMode: String {
    case Sequence = "sequence"
    case Wrong = "wrong"
    case Collection = "collection"
    case random = "random"
    case exam = "exam"
}

class ModelController: NSObject, UIPageViewControllerDataSource {
    
    var pageData: [[String: String]]?
    var bookNumber: Int?
    
    func loadDataFromPlistToArray(){
        var array: [[String: String]]!
        
        var number = bookNumber ?? 1 //默认课本为SSD1
        
        //array = NSMutableArray(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("ku_ssd\(number)", ofType: "plist")!)!)!
        array = SSDPlistManager.sharedManager.loadArray(number)
        
        //确保不为空，但会丢失用户数据
        if array == nil {
            SSDPlistManager.sharedManager.movePlistsToSandbox()
            array = SSDPlistManager.sharedManager.loadArray(number)
            println("重新导入沙盒，丢失用户数据")
        }
        
        
        var _modeString: String? = NSUserDefaults.standardUserDefaults().objectForKey("Mode") as! String?
        var _mode = _modeString ?? "sequence"
        var mode = ExerciseMode(rawValue: _mode)!
        
        switch mode {
        case .Sequence:
            pageData = array
            
        case .Wrong, .Collection:
            for item in array {
                if (item)[mode.rawValue] != "0" {
//                    (pageData! as! NSMutableArray).addObject(NSDictionary(dictionary: item, copyItems: true))
                    pageData?.append(item)
                }
            }
        case .random, .exam:
            var originalLength = array.count
            for var i = 0; i < originalLength; i++ {
                var random: Int = Int(arc4random()) % array.count  //生成一个随机数，范围是 0 到 “数组长度-1”
//                pageData.addObject(NSDictionary(dictionary: array[random] as! [String: String], copyItems: true))
                pageData?.append(array[random])
//                array[random] = NSDictionary(dictionary: array.lastObject as! [String: String], copyItems: true)
                array[random] = array.last!
//                array.removeLastObject()
                array.removeLast()
            }
            
        }
    }
    
    func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> DataViewController? {
        // Return the data view controller for the given index.
        if (self.pageData!.count == 0) || (index >= self.pageData!.count) {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let dataViewController = storyboard.instantiateViewControllerWithIdentifier("DataViewController") as! DataViewController
        dataViewController.dataObject = self.pageData?[index]
        return dataViewController
    }
    
    func indexOfViewController(viewController: DataViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        if let dataObject: AnyObject = viewController.dataObject {
            return (self.pageData! as NSArray).indexOfObject(dataObject)
        } else {
            return NSNotFound
        }
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if index == NSNotFound {
            return nil
        }
        
        index++
        if index == self.pageData!.count {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    
}

