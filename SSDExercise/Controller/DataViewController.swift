//
//  TakeExerciseViewController.swift
//  SSDExercise
//
//  Created by 李 智恒 on 15/3/22.
//  Copyright (c) 2015年 李 智恒. All rights reserved.
//

import UIKit


class DataViewController: UITableViewController, UpdateTakeExerciseUI {
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var optionALabel: UILabel!
    @IBOutlet weak var optionBLabel: UILabel!
    @IBOutlet weak var optionCLabel: UILabel!
    @IBOutlet weak var optionDLabel: UILabel!
    @IBOutlet weak var optionAImage: UIImageView!
    @IBOutlet weak var optionBImage: UIImageView!
    @IBOutlet weak var optionCImage: UIImageView!
    @IBOutlet weak var optionDImage: UIImageView!
    
    weak var markButton: UIBarButtonItem?

    var dataObject: SSDExercise?
    
    private let answerToInt = ["a": 0, "b": 1, "c": 2, "d": 3]
    
    var bookNumber: Int?
    var collectionButtonHighlight = false
    
    
    var optionImageViews: [UIImageView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            
            if globalMode == "sequence" {
                //添加收藏按钮至rootViewController的NavigationBar中
                var rootViewController = ((self.parentViewController as! UIPageViewController).delegate) as! RootViewController
                rootViewController.navigationItem.rightBarButtonItem?.target = self
                rootViewController.navigationItem.rightBarButtonItem?.action = "collectionButton:"
                self.markButton = rootViewController.navigationItem.rightBarButtonItem
            }
            //加载字号
            self.loadFontSize()
            if let obj: SSDExercise = self.dataObject {
                self.questionTextView.text = obj.question
                self.optionALabel.text = obj.optionA
                self.optionBLabel.text = obj.optionB
                self.optionCLabel.text = obj.optionC
                self.optionDLabel.text = obj.optionD
                
            } else {
                self.questionTextView.text = ""
                self.optionALabel.text = ""
                self.optionBLabel.text = ""
                self.optionCLabel.text = ""
                self.optionDLabel.text = ""
            }
            
            self.optionImageViews = [self.optionAImage, self.optionBImage, self.optionCImage, self.optionDImage]
            
            self.bookNumber = (((self.parentViewController as! UIPageViewController).delegate) as! RootViewController).selectedBookNumberFromRootViewController
            var arrayIndex = ((self.parentViewController as! UIPageViewController).dataSource as! ModelController).indexOfViewController(self)
            //加载题目状态
            self.dataObject?.setBookNumberArrayIndexAndDelegate(self.bookNumber!, index: arrayIndex, delegate: self)
            
            self.upDateUI()
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 1 {
            dataObject?.userDidSelect(indexPath.row)
        }
        
        //撤销选中
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    
    func collectionButton(sender: AnyObject) {
        
        collectionButtonHighlight = !collectionButtonHighlight
        collectionButtonHighlight ? highlightMarkButton() : whitenMarkButton()
        var rootViewController = ((self.parentViewController as! UIPageViewController).delegate) as! RootViewController
        self.dataObject!.userDidMark(collectionButtonHighlight)
    }
    
    private func highlightMarkButton() {
        markButton?.tintColor = UIColor(red: 245/255, green: 234/255, blue: 80/255, alpha: 1)
    }
    
    private func whitenMarkButton() {
        markButton?.tintColor = UIColor.whiteColor()
    }
    
    private func loadFontSize() {
        var fontSize: Float = NSUserDefaults.standardUserDefaults().floatForKey("fontSize")
        var userFont: UIFont = UIFont.systemFontOfSize(CGFloat(fontSize))
        questionTextView.font = userFont
        optionALabel.font = userFont
        optionBLabel.font = userFont
        optionCLabel.font = userFont
        optionDLabel.font = userFont
    }
    
    func upDateUI() {
        
        if dataObject!.done {
            //显示正确答案：深蓝色
            optionImageViews[answerToInt[dataObject!.answer]!].image = UIImage(named: "option\(dataObject!.answer.uppercaseString)_pre_right")
            
            if dataObject!.wrong {
                //显示错误选项：红色
                optionImageViews[answerToInt[dataObject!.wrongChoice]!].image = UIImage(named: "option\(dataObject!.wrongChoice.uppercaseString)_pre_wrong")
            }
        }
        
        if dataObject!.mark {
            //点亮收藏按钮
            collectionButtonHighlight = true
            highlightMarkButton()
        }else {
            //变白收藏按钮
            collectionButtonHighlight = false
            whitenMarkButton()
        }
        
    }
    
    func showToast(correction: Bool, rightAnswer: String) {
        var options: NSDictionary = ToastManager.sharedManager().generateOptionsWithCorrection(correction, andRightAnswer: rightAnswer)
        CRToastManager.showNotificationWithOptions(options as [NSObject : AnyObject], completionBlock: nil)
    }
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
