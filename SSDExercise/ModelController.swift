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
UserDefaults说明：
做题模式——Key: Mode (String)
字体大小——Key: fontSize (Float)

*/

protocol ModelControllerDelegate: class {
    func arrayIsEmpty()
}

enum ExerciseMode: String {
    case Sequence = "sequence"
    case Wrong = "wrong"
    case Collection = "collection"
    case random = "random"
    case exam = "exam"
}

class ModelController: NSObject, UIPageViewControllerDataSource {
    
    var pageData: [SSDExercise]!
    var bookNumber: Int!
    weak var delegate: ModelControllerDelegate?
    
    init(delegate: ModelControllerDelegate) {
        self.delegate = delegate
    }
    
    func loadPageData(){
        let mode = ExerciseMode(rawValue: (NSUserDefaults.standardUserDefaults().objectForKey("Mode")) as! String)!
        pageData = self.generatePageData(mode)
        
//        if pageData == nil {
//            self.delegate!.arrayIsEmpty()
//            var emptyDictItem = ["answer": "a", "done": "0", "identifier": "1", "mark": "0", "optionA": "", "optionB": "", "optionC": "", "optionD": "", "question": "", "wrong": "0"]
//            var emptySSDExerciseItem = SSDExercise(exerciseDict: emptyDictItem)
//            pageData?.append(emptySSDExerciseItem)
//        }
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
        if let dataObject: SSDExercise = viewController.dataObject {
            let index = (self.pageData! as NSArray).indexOfObject(dataObject)
            return index
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
    
    func indexShouldShowFirst()->Int{

        //除了顺序做题外，其他模式默认首个要显示的题目为第一个
        var index = 0
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("Mode") as! String) != "sequence" {
            return 0
        }
        
//        for var i = 0; i < self.pageData?.count; i++ {
//            if pageData![i].done == false {
//                index = i
//                break
//            }
//        }
        index = LatestExerciseNumberManager.sharedLatestNumberManager.requireLatestIndex(bookNumber: bookNumber)
        
        //防止数组越界
        if (index - 1) == pageData.count {
            index--
        }
        

        return index
    }
    
    private func generateExercisesArray(dictArray: [[String: String]])-> [SSDExercise] {
        var exercisesArray: [SSDExercise] = []
        
        for dictItem in dictArray {
            let item = SSDExercise(exerciseDict: dictItem)
            exercisesArray.append(item)
        }
        return exercisesArray
    }
    
    
    private func generatePageData(mode: ExerciseMode)->[SSDExercise]? {
        
        var arrayToReturn: [SSDExercise] = []
        
        var dictArrayWithRecord: [[String: String]]? = SSDPlistManager.sharedManager.loadArray(self.bookNumber!, location: StorageLocation.sandbox)
        
        if dictArrayWithRecord == nil {
            //确保不为空，但会丢失用户数据
            SSDPlistManager.sharedManager.movePlistsToSandbox()
            dictArrayWithRecord = SSDPlistManager.sharedManager.loadArray(self.bookNumber!, location: StorageLocation.bundle)
        }
        
        var arrayWithRecord = generateExercisesArray(dictArrayWithRecord!)
        
        
        
        var arrayWithoutRecord: [SSDExercise]?
        
        if mode != ExerciseMode.Sequence {
            let dictArrayWithoutRecord = SSDPlistManager.sharedManager.loadArray(self.bookNumber!, location: StorageLocation.bundle)
            arrayWithoutRecord = generateExercisesArray(dictArrayWithoutRecord!)
            
        }
        
        
        switch mode {
        case .Sequence:
            arrayToReturn = arrayWithRecord
            
        case .Wrong:
            
            for var i = 0; i < arrayWithRecord.count; i++ {
                if arrayWithRecord[i].wrong {
                    let item: SSDExercise = arrayWithoutRecord![i]
                    arrayToReturn.append(item)
                }
            }
            
            
        case .Collection:
            for var i = 0; i < arrayWithRecord.count; i++ {
                if arrayWithRecord[i].mark {
                    let item: SSDExercise = arrayWithoutRecord![i]
                    arrayToReturn.append(item)
                }
            }
            
        case .random, .exam:
            let originalLength = arrayWithoutRecord!.count
            for var i = 0; i < originalLength; i++ {
                let random: Int = Int(arc4random()) % arrayWithoutRecord!.count  //生成一个随机数，范围是 0 到 “数组长度-1”
                arrayToReturn.append(arrayWithoutRecord![random])
                arrayWithoutRecord![random] = arrayWithoutRecord!.last!
                arrayWithoutRecord!.removeLast()
            }
            
        }

        if arrayToReturn.isEmpty {
            let emptyDictItem = ["answer": "a", "done": "0", "identifier": "1", "mark": "0", "optionA": "                   ", "optionB": "                 ", "optionC": "                 ", "optionD": "                 ", "question": "                    ", "wrong": "0"]
            let emptySSDExerciseItem = SSDExercise(exerciseDict: emptyDictItem)
            arrayToReturn.append(emptySSDExerciseItem)
            self.delegate!.arrayIsEmpty()
        }
        
        return arrayToReturn
    }
    
}

