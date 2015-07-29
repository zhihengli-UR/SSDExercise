//
//  TakeExerciseViewController.swift
//  SSDExercise
//
//  Created by 李 智恒 on 15/3/22.
//  Copyright (c) 2015年 李 智恒. All rights reserved.
//

import UIKit


class DataViewController: UITableViewController {
    

    //var collectionButtonColor = false
    

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var optionALabel: UILabel!
    @IBOutlet weak var optionBLabel: UILabel!
    @IBOutlet weak var optionCLabel: UILabel!
    @IBOutlet weak var optionDLabel: UILabel!
    @IBOutlet weak var optionAImage: UIImageView!
    @IBOutlet weak var optionBImage: UIImageView!
    @IBOutlet weak var optionCImage: UIImageView!
    @IBOutlet weak var optionDImage: UIImageView!
    
    
    
    var dataObject: [String: String]?
    
    //题目答案
    var answerToInt = ["a": 0, "b": 1, "c": 2, "d": 3]
    var answerToString = [0: "a", 1: "b", 2: "c", 3: "d"]
    var answerLetter: String?
    var answer: Int?
    var done: String?
    var wrong: String?
    var collection: String?
    var bookNumber: Int?
    var collectionButtonColor = false
    
    
    var optionImageViews: [UIImageView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        
        //添加收藏按钮至rootViewController的NavigationBar中
        var rootViewController = (((self.parentViewController as! UIPageViewController).delegate) as! RootViewController)
        rootViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_collect"), style: UIBarButtonItemStyle.Plain, target: self, action: "collectionButton:")
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let obj: AnyObject = dataObject {
            var dict = obj as! [String: String]
            answerLetter = dict["answer"]?.uppercaseString
            answer = answerToInt[dict["answer"]!]
            done = dict["done"]
            wrong = dict["wrong"]
            collection = dict["mark"]
            questionLabel.text = dict["question"]
            optionALabel.text = dict["optionA"]
            optionBLabel.text = dict["optionB"]
            optionCLabel.text = dict["optionC"]
            optionDLabel.text = dict["optionD"]
            
        } else {
            answer = 4
            questionLabel.text = ""
            optionALabel.text = ""
            optionBLabel.text = ""
            optionCLabel.text = ""
            optionDLabel.text = ""
        }
        optionImageViews = [optionAImage, optionBImage, optionCImage, optionDImage]
        self.bookNumber = (((self.parentViewController as! UIPageViewController).delegate) as! RootViewController).selectedBookNumberFromRootViewController

    }

//    @IBAction func collectionButton(sender: AnyObject) {
//        
//        collectionButtonColor = !collectionButtonColor
//        collectionButtonColor == true ? ((sender as! UIBarButtonItem).tintColor = UIColor(red: 245/255, green: 234/255, blue: 80/255, alpha: 1)) : ((sender as! UIBarButtonItem).tintColor = UIColor.whiteColor())
//
//    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            //无论对错，修改正选选项图片为深蓝色：
            optionImageViews[answer!].image = UIImage(named: "option\(answerLetter!)_pre_right")
            var options: NSDictionary! = ToastManager.sharedManager().generateOptionsWithCorrection(indexPath.row == answer, andRightAnswer: answerLetter)
            //选错时...
            if indexPath.row != answer {
                //plist操作：
                SSDPlistManager.sharedManager.saveStatus(dataObject!, bookNumber: bookNumber!, status: answerToString[indexPath.row]!)
                //修改错误选项图片为红色
                optionImageViews[indexPath.row].image = UIImage(named: "option\(answerToString[indexPath.row]!)_pre_wrong")
            }else {
                //选对时
                SSDPlistManager.sharedManager.saveStatus(dataObject!, bookNumber: bookNumber!, status: "done")
            }
            

            
            
            //撤销选中
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            //在statusBar中显示Toast
            CRToastManager.showNotificationWithOptions(options as! [NSObject: AnyObject], completionBlock: nil)
            
            
        }else {
            
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    private func updateUI() {
        if done! != "0" {
            optionImageViews[answer!].image = UIImage(named: "option\(answerLetter!)_pre_right")
            if wrong! != "0" {
                optionImageViews[answerToInt[wrong!]!].image = UIImage(named: "option\(wrong!.uppercaseString)_pre_wrong")
            }
        }
        
        if collection! != "0" {
            //右上角星星的tintColor变为黄色
        }
        
    }
    
    
    func collectionButton(sender: AnyObject) {
        
        collectionButtonColor = !collectionButtonColor
        collectionButtonColor == true ? ((sender as! UIBarButtonItem).tintColor = UIColor(red: 245/255, green: 234/255, blue: 80/255, alpha: 1)) : ((sender as! UIBarButtonItem).tintColor = UIColor.whiteColor())
    }
    
//    func selectBookCompeletion(notification: NSNotification) {
//        println("Notification has been received")
//        var notificationDictionary = notification.userInfo as! [String: String]
//        var selectedBook: Int = (notificationDictionary["selectedBook"]!).toInt()!
//        
//        println(selectedBook)
//        self.navigationController?.title = "\(selectedBook)"
//        
//        
//    }
    
    

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete method implementation.
//        // Return the number of rows in the section.
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
