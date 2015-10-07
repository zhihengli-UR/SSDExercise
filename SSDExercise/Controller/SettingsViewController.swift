//
//  SettingsViewController.swift
//  SSDExercise
//
//  Created by 李 智恒 on 15/3/21.
//  Copyright (c) 2015年 李 智恒. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    @IBOutlet weak var clearUserRecordIndicator: UIActivityIndicatorView!
    var HUD: JGProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.HUD = self.prototypeHUD()
        clearUserRecordIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 1 {
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                
                tableView.deselectRowAtIndexPath(indexPath, animated: false)
                self.HUD = JGProgressHUD(style: JGProgressHUDStyle.Dark)
                self.HUD.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
                self.HUD.textLabel.text = "清除中"
                self.HUD.showInView(UIApplication.sharedApplication().delegate?.window!)
            })
            
            let clearUserDataQueue = dispatch_queue_create("cn.net.ziqiang.clearUserData", nil)
            
            dispatch_async(clearUserDataQueue, { () -> Void in
                SSDPlistManager.sharedManager.clearUserData({ (writeResult) -> Void in
                    writeResult ? self.showSuccessHUD() : self.showErrorHUD()
                })
            })
            
            
            NSUserDefaults.standardUserDefaults().setObject("sequence", forKey: "Mode")
            //globalMode = "sequence"
            
            //最新做题数目
//            var defaultLatestNumber = [1, 1, 1, 1, 1, 1, 1, 1, 1]
//            NSUserDefaults.standardUserDefaults().setObject(defaultLatestNumber, forKey: "LastestNumber")
            LatestExerciseNumberManager.sharedLatestNumberManager.resetAll()
        }
    }
    
    func showSuccessHUD() {
        HUD.textLabel.text = "清除成功"
        HUD.indicatorView = JGProgressHUDSuccessIndicatorView()
        
        HUD.showInView(UIApplication.sharedApplication().delegate?.window!)
        HUD.dismissAfterDelay(2.0)
    }
    
    func showErrorHUD() {
        HUD.textLabel.text = "清除失败"
        HUD.indicatorView = JGProgressHUDErrorIndicatorView()
        
        HUD.showInView(UIApplication.sharedApplication().delegate?.window!)
        HUD.dismissAfterDelay(2.0)
    }
    
    func prototypeHUD()->JGProgressHUD {
        var HUD = JGProgressHUD(style: JGProgressHUDStyle.Dark)
        HUD.interactionType = JGProgressHUDInteractionType.BlockNoTouches
        HUD.square = true
        HUD.backgroundColor = UIColor(white: 0, alpha: 0.4)
        return HUD
    }
}
