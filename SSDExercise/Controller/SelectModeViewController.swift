//
//  SelectModeViewController.swift
//  SSDExercise
//
//  Created by 李 智恒 on 15/3/21.
//  Copyright (c) 2015年 李 智恒. All rights reserved.
//

import UIKit

class SelectModeViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    
    
    var selectModeButtons: [UIButton]!
    var selectMode = ["顺序做题", "错题集", "收藏集", "随机练习", "模拟考试"]
    var selectModeLabels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = themeColor
        
        self.selectModeButtons = [button1, button2, button3, button4, button5]
        self.selectModeLabels = [label1, label2, label3, label4, label5]
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SelectModeButtonsOnClick(sender: UIButton) {
        var userDefaults = NSUserDefaults()
        for button in selectModeButtons {
            button.setImage(UIImage(named: "icon_bg"), forState: UIControlState.Normal)
        }
        for label in selectModeLabels {
            label.textColor = UIColor.blackColor()
        }
        sender.setImage(UIImage(named: "icon_pre"), forState: UIControlState.Normal)
        var labelSelect: UILabel = selectModeLabels[sender.tag]
        labelSelect.textColor = themeColor
        userDefaults.setObject(self.selectMode[sender.tag], forKey: "SelectMode")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
}