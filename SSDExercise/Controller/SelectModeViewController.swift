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
    var selectModeLabels: [UILabel]!
    

    let modeDict = ["sequence", "wrong", "collection", "random", "exam"]
    let modeInt = ["sequence": 0, "wrong": 1, "collection": 2, "random": 3, "exam": 4]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectModeButtons = [button1, button2, button3, button4, button5]
        self.selectModeLabels = [label1, label2, label3, label4, label5]
        
        var index: Int = modeInt[NSUserDefaults.standardUserDefaults().objectForKey("Mode") as! String]!
        tintWhiteColor()
        tintThemeColor(selectModeButtons[index])
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        MobClick.beginLogPageView("做题模式")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        MobClick.endLogPageView("做题模式")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        var index: Int = modeInt[NSUserDefaults.standardUserDefaults().objectForKey("Mode") as! String]!
        tintWhiteColor()
        tintThemeColor(selectModeButtons[index])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SelectModeButtonsOnClick(sender: UIButton) {
        tintWhiteColor()
        tintThemeColor(sender)
        let mode: String = self.modeDict[sender.tag]
        NSUserDefaults.standardUserDefaults().setObject(mode, forKey: "Mode")
        MobClick.event("ChangeExerciseMode", attributes: ["Mode": mode])
    }
    
    
    func tintWhiteColor() {
        //button都设置成白色
        for button in selectModeButtons {
            button.setImage(UIImage(named: "icon_bg"), forState: UIControlState.Normal)
        }
        //label都设置为黑色
        for label in selectModeLabels {
            label.textColor = UIColor.blackColor()
        }
    }
    
    func tintThemeColor(button: UIButton) {
        button.setImage(UIImage(named: "icon_pre"), forState: UIControlState.Normal)
        var labelSelect: UILabel = selectModeLabels[button.tag]
        labelSelect.textColor = themeColor
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