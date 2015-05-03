//
//  TakeExerciseViewController.swift
//  SSDExercise
//
//  Created by 李 智恒 on 15/3/22.
//  Copyright (c) 2015年 李 智恒. All rights reserved.
//

import UIKit

class TakeExerciseViewController: UITableViewController, SSDExerciseDataSource {
    
    var collectionButtonshouldBeHighlighted = 0
    var exercise: SSDExercise?
    var dataTransmitDelegate: BookNumberTransmitDelegate!
    var selectedBookNumberFromRootViewController: Int = 0
    
    @IBOutlet weak var questionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.exercise = SSDExercise(delegate: self)
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        self.selectedBookNumberFromRootViewController = self.dataTransmitDelegate.requireBookNumber()
        self.navigationItem.title = "SSD\(self.selectedBookNumberFromRootViewController)"

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        
    }

    @IBAction func collectionButton(sender: AnyObject) {
        self.collectionButtonshouldBeHighlighted = self.collectionButtonshouldBeHighlighted == 0 ? 1:0
        if collectionButtonshouldBeHighlighted == 1 {
            (sender as! UIBarButtonItem).tintColor = UIColor(red: 245/255, green: 234/255, blue: 80/255, alpha: 1)
        }else {
            (sender as! UIBarButtonItem).tintColor = UIColor.whiteColor()
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
    
    func loadExeciseData(exercise: String, options: [String : String], answer: String) {
        
    }
    

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
