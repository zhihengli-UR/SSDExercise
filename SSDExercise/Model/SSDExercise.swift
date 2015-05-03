//
//  SSDExercise.swift
//  SSDExercise
//
//  Created by 李 智恒 on 15/3/22.
//  Copyright (c) 2015年 李 智恒. All rights reserved.
//

import UIKit

protocol SSDExerciseDataSource {
    func loadExeciseData(exercise: String, options: [String: String], answer: String)
}

struct ExercisePattern {
    let Sequence = 0
    let Wrong = 1
    let Collection = 2
}

class SSDExercise: NSObject {
    var answer: String = ""
    var done: String = ""
    var id: String = ""
    var identifier: String = ""
    var mark: String = ""
    var optionA: String = ""
    var optionB: String = ""
    var optionC: String = ""
    var optionD: String = ""
    var question: String = ""
    var wrong: String = ""
    
    var delegate: SSDExerciseDataSource?
    
    init(delegate: SSDExerciseDataSource) {
        self.delegate = delegate
    }
    
    func requireExercisesList(#book: Int){
        var exerciseList = NSArray(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("ku_ssd\(book)", ofType: "plist")!)!)
        delegate?.loadExeciseData(self.question, options: ["A": self.optionA, "B": self.optionB, "C": self.optionC, "D": self.optionD], answer: self.answer)
        
    }
    
    
}
