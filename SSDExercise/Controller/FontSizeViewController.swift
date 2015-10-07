//
//  FontSizeViewController.swift
//  SSDExercise
//
//  Created by 李 智恒 on 15/7/29.
//  Copyright (c) 2015年 李 智恒. All rights reserved.
//

import UIKit

class FontSizeViewController: UITableViewController {

    @IBOutlet weak var demoLabel: UILabel!
    @IBOutlet weak var fontSlider: UISlider!
    
    private var fontNumbers: [Float] = [11.0, 13.0, 15.0, 17.0, 19.0, 20.0, 22.0]
    private var numberOfSteps: Float = 6.0
    private var fontSize:Float = 17.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        //初始化Slider的值
        var fontSize: Float = NSUserDefaults.standardUserDefaults().floatForKey("fontSize")
        var sliderValue = (fontSize - 11) / 2
        fontSlider.setValue(sliderValue, animated: false)
        

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        NSUserDefaults.standardUserDefaults().setFloat(self.fontSize, forKey: "fontSize")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func sliderValueChanged(sender: AnyObject) {
        var index: Int = Int(fontSlider.value + 0.5)
        fontSlider.setValue(Float(index), animated: false)
        var fontSize: Float = fontNumbers[index]
        demoLabel.font = UIFont.systemFontOfSize(CGFloat(fontSize))
        self.fontSize = fontSize
    }

}
