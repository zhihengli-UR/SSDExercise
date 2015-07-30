//
//  SSDExercise.swift
//  SSDExercise
//
//  Created by 李 智恒 on 15/3/22.
//  Copyright (c) 2015年 李 智恒. All rights reserved.
//

import UIKit

//protocol SSDExerciseDataSource {
//    func loadExeciseData(#question: String, options: [String: String], answer: String)
//}

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
    
    let answer: String!
    let optionA: String!
    let optionB: String!
    let optionC: String!
    let optionD: String!
    let question: String!
    let wrongChoice: String!
    
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
        
        //写入存储status:
        var status: String!
        
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
        status = "done"
        
        //答错时
        if !correction {
            wrong = true
            self.exerciseDict!["wrong"] = answerToString[userChoice]
            status = answerToString[userChoice]
        }
        
        delegate?.upDateUI()
        delegate?.showToast(correction, rightAnswer: answer!)
        
        //写入存储
        SSDPlistManager.sharedManager.saveStatus(self.exerciseDict!, bookNumber: self.bookNumber!, status: status)
 
    }
    
    func setBookNumberArrayIndexAndDelegate(bookNumber: Int, index: Int, delegate: UpdateTakeExerciseUI) {
        self.bookNumber = bookNumber
        self.arrayIndex = index
        self.delegate = delegate
    }
    
    
    
    
    
    
    
}

