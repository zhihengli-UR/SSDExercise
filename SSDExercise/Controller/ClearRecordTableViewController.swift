//
//  ClearRecordTableViewController.swift
//
//
//  Created by 李 智恒 on 15/11/20.
//
//

import UIKit

class ClearRecordTableViewController: UITableViewController {
    
    var HUD: JGProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        HUD = prototypeHUD()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        MobClick.beginLogPageView("清除答题记录")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        MobClick.endLogPageView("清除答题记录")
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        HUD = JGProgressHUD(style: JGProgressHUDStyle.Dark)
        HUD.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
        HUD.textLabel.text = "清除中"
        HUD.showInView(UIApplication.sharedApplication().delegate?.window!)
        
        let clearUserDataQueue = dispatch_queue_create("cn.net.ziqiang.clear_user_record", nil)
        
        if indexPath.section == 0 {
            dispatch_async(clearUserDataQueue, { () -> Void in
                SSDPlistManager.sharedManager.clearUserData({ (writeResult) -> Void in
                    if writeResult {
                        self.showSuccessHUD()
                        NSUserDefaults.standardUserDefaults().setObject("sequence", forKey: "Mode")
                        LatestExerciseNumberManager.sharedLatestNumberManager.resetAll()
                        MobClick.event("ClearExercisesRecordSuccess", attributes: ["BookNumber": "All"])
                    } else {
                        self.showErrorHUD()
                        MobClick.event("ClearExercisesRecordFailed")
                    }
                })
            })
        } else if indexPath.section == 1 {
            dispatch_async(clearUserDataQueue, { () -> Void in
                SSDPlistManager.sharedManager.clearUserData(indexPath.row + 1, completionHandler: { (writeResult) -> Void in
                    if writeResult {
                        self.showSuccessHUD()
                        LatestExerciseNumberManager.sharedLatestNumberManager.resetForBook(bookNumber: indexPath.row + 1)
                        MobClick.event("ClearExercisesRecordSuccess", attributes: ["BookNumber": "SSD\(indexPath.row + 1)"])
                    } else {
                        self.showErrorHUD()
                        MobClick.event("ClearExercisesRecordFailed")
                    }
                })
            })
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
