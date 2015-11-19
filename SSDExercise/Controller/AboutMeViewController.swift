//
//  AboutMeViewController.swift
//  SSDExercise
//
//  Created by 李 智恒 on 15/8/2.
//  Copyright (c) 2015年 李 智恒. All rights reserved.
//

import UIKit

class AboutMeViewController: UITableViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        var version = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        var build = NSBundle.mainBundle().infoDictionary!["CFBundleVersion"] as! String
        self.versionLabel.text = "v\(version)(\(build))"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 1 {
            self.presentViewController(UMFeedback.feedbackModalViewController(), animated: true, completion: nil)
            
        }
    }
    
}
