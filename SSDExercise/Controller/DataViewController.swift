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
    
    
    
    var dataObject: AnyObject?
    
    //题目答案
    var answerToInt = ["a": 0, "b": 1, "c": 2, "d": 3]
    var answerLetter: String?
    var answer: Int?
    var done: String?
    var wrong: String?
    var collection: String?
    
    
    var optionImageViews: [UIImageView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let obj: AnyObject = dataObject {
            var dict = obj as! [String: String]
            self.answerLetter = dict["answer"]?.uppercaseString
            self.answer = answerToInt[dict["answer"]!]
            self.done = dict["done"]
            self.wrong = dict["wrong"]
            self.collection = dict["mark"]
            self.questionLabel.text = dict["question"]
            self.optionALabel.text = dict["optionA"]
            self.optionBLabel.text = dict["optionB"]
            self.optionCLabel.text = dict["optionC"]
            self.optionDLabel.text = dict["optionD"]
            
        } else {
            self.answer = 4
            self.questionLabel.text = ""
            self.optionALabel.text = ""
            self.optionBLabel.text = ""
            self.optionCLabel.text = ""
            self.optionDLabel.text = ""
        }
        self.optionImageViews = [optionAImage, optionBImage, optionCImage, optionDImage]

    }

//    @IBAction func collectionButton(sender: AnyObject) {
//        
//        collectionButtonColor = !collectionButtonColor
//        collectionButtonColor == true ? ((sender as! UIBarButtonItem).tintColor = UIColor(red: 245/255, green: 234/255, blue: 80/255, alpha: 1)) : ((sender as! UIBarButtonItem).tintColor = UIColor.whiteColor())
//
//    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            //无论对错：
            optionImageViews[answer!].image = UIImage(named: "option\(answerLetter!)_pre_right")
            var options: NSDictionary!
            //选错时...
            if indexPath.row != answer {
                //plist操作：
                options = ToastManager.generateOptionsWithCorrection(false, andRightAnswer: answerLetter)
                optionImageViews[indexPath.row].image = UIImage(named: "option\((answerToInt as NSDictionary).allKeysForObject(indexPath.row)[0].uppercaseString)_pre_wrong")
            }else {
                //选对时
                options = ToastManager.generateOptionsWithCorrection(true, andRightAnswer: answerLetter)
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
