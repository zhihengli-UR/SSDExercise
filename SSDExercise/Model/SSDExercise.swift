//
//  SSDExercise.swift
//  SSDExercise
//
//  Created by 李 智恒 on 15/3/22.
//  Copyright (c) 2015年 李 智恒. All rights reserved.
//

import UIKit

protocol SSDExerciseDataSource {
    func loadExeciseData(#question: String, options: [String: String], answer: String)
}



class SSDExercise: NSObject {
    var answer: String = ""
    var done: String = ""
    var identifier: String = ""
    var mark: String = ""
    var optionA: String = ""
    var optionB: String = ""
    var optionC: String = ""
    var optionD: String = ""
    var question: String = ""
    var wrong: String = ""
    
    init(exerciseDict: [String: String]) {
        answer = exerciseDict["answer"]!
        done = exerciseDict["done"]!
        identifier = exerciseDict["identifier"]!
        mark = exerciseDict["mark"]!
        optionA = exerciseDict["optionA"]!
        optionB = exerciseDict["optionB"]!
        optionC = exerciseDict["optionC"]!
        optionD = exerciseDict["optionD"]!
        question = exerciseDict["question"]!
        wrong = exerciseDict["wrong"]!
    }
    
    
}

