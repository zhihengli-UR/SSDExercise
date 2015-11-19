//
//  SSDExercise.swift
//  SSDExercise
//
//  Created by 李 智恒 on 15/3/22.
//  Copyright (c) 2015年 李 智恒. All rights reserved.
//

import UIKit


protocol UpdateTakeExerciseUI: class {
    func upDateUI()
    func showToast(correction: Bool, rightAnswer: String)
}


class SSDExercise: NSObject {
    
    private var exerciseDict: [String: String]?
    
    let identifier: Int!
    
    //外部赋值
    var arrayIndex: Int!
    var bookNumber: Int!
    //var arrayDict: NSArray?
    
    //内部赋值，外部修改
    var wrongChoice: String!
    
    let answer: String!
    let optionA: String!
    let optionB: String!
    let optionC: String!
    let optionD: String!
    let question: String!
    
    var mark: Bool = false
    var wrong: Bool = false
    var done: Bool = false
    
    //外部赋值
    weak var delegate: UpdateTakeExerciseUI?
    
    //Utilities
    private let answerToInt = ["a": 0, "b": 1, "c": 2, "d": 3]
    private let answerToString = [0: "a", 1: "b", 2: "c", 3: "d"]
    
    init(exerciseDict: [String: String]) {
        
        self.exerciseDict = exerciseDict
        
        identifier = (exerciseDict["identifier"]!).toInt()
        
        answer = exerciseDict["answer"]
        optionA = exerciseDict["optionA"]
        optionB = exerciseDict["optionB"]
        optionC = exerciseDict["optionC"]
        optionD = exerciseDict["optionD"]
        question = exerciseDict["question"]
        wrongChoice = exerciseDict["wrong"]
        
        mark = exerciseDict["mark"]! == "0" ? false : true
        wrong = exerciseDict["wrong"]! == "0" ? false : true
        done = exerciseDict["done"]! == "0" ? false : true
    }
    
    
    func userDidSelect(userChoice: Int) {
        
        //是否正确
        var correction: Bool = userChoice == answerToInt[answer!]
        
        //若已经做过
        if done {
            delegate?.showToast(correction, rightAnswer: answer!)
            return
        }
        
        //若没有做过
        done = true
        self.exerciseDict!["done"] = "1"
        
        /**
        *  顺序做题时写入最新做题数
        */
        if (NSUserDefaults.standardUserDefaults().objectForKey("Mode") as! String) == "sequence" {
//            var latestNumberArray = NSUserDefaults.standardUserDefaults().objectForKey("LastestNumber") as! [Int]
//            latestNumberArray[self.bookNumber - 1] = self.identifier
//            NSUserDefaults.standardUserDefaults().setObject(latestNumberArray, forKey: "LastestNumber")            
            let manager = LatestExerciseNumberManager.sharedLatestNumberManager
            manager.writeLatestIdentifier(bookNumber: bookNumber, identifier: identifier)
            manager.writeLatestIndex(bookNumber: bookNumber, index: arrayIndex)
        }
        
        //答错时
        if !correction {
            wrong = true
            wrongChoice = answerToString[userChoice]
            self.exerciseDict!["wrong"] = answerToString[userChoice]
        }
        
        delegate?.upDateUI()
        if (NSUserDefaults.standardUserDefaults().objectForKey("Mode") as! String) != "exam" {
            delegate?.showToast(correction, rightAnswer: answer!.uppercaseString)
        }
        
        //写入存储
        if (NSUserDefaults.standardUserDefaults().objectForKey("Mode") as! String) == "sequence" {
            SSDPlistManager.sharedManager.saveStatus(self.exerciseDict!, bookNumber: self.bookNumber, arrayIndex: self.arrayIndex)
            
        }
 
    }
    
    func userDidMark(mark: Bool){
        self.mark = mark
        self.exerciseDict!["mark"] = mark ? "1" : "0"
        SSDPlistManager.sharedManager.saveStatus(self.exerciseDict!, bookNumber: self.bookNumber, arrayIndex: self.arrayIndex)
    }
    
    func generateDict()->[String: String] {
        var dict: [String: String] = NSDictionary(dictionary: ["answer": self.answer, "identifier": "\(self.identifier)", "optionA": self.optionA, "optionB": self.optionB, "optionC": self.optionC, "optionD": self.optionD, "question": self.question, "wrong": self.wrongChoice, "mark": self.mark ? "1" : "0", "done": self.done ? "1" : "0"]) as! [String: String]
        
        
        return dict
    }
    
    
    func setBookNumberArrayIndexAndDelegate(bookNumber: Int, index: Int, delegate: UpdateTakeExerciseUI) {
        self.bookNumber = bookNumber
        self.arrayIndex = index
        self.delegate = delegate
    }
    
    
    
    
    
    
    
}

