//
//  SelectBookCollectionViewController.swift
//  SSDExercise
//
//  Created by 李 智恒 on 15/3/10.
//  Copyright (c) 2015年 李 智恒. All rights reserved.
//

import UIKit

protocol BookNumberTransmitDelegate: class {
    func requireBookNumber() -> Int
}

class SSDBookCell : UICollectionViewCell {
    let BookNumber: UILabel!
    let BookName: UITextView!
    let BookRatio: UILabel!
    override init(frame: CGRect) {
//        super.init(frame: frame)
        BookNumber = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height/5))
        BookNumber.textAlignment = .Center
        BookNumber.textColor = UIColor.whiteColor()
        BookName = UITextView(frame: CGRect(x: 0, y: BookNumber.frame.size.height, width: frame.size.width, height: frame.size.height*3/5))
        BookName.textAlignment = .Center
        BookName.textColor = UIColor.whiteColor()
        BookName.backgroundColor = themeColor
        BookName.font = UIFont(name: "Arial", size: 15)
        BookName.userInteractionEnabled = false
        BookRatio = UILabel(frame: CGRect(x: 0, y: BookNumber.frame.size.height + BookName.frame.size.height, width: frame.size.width, height: frame.size.height/5))
        BookRatio.textAlignment = .Center
        BookRatio.textColor = UIColor.whiteColor()
        
        
        super.init(frame: frame)
        contentView.addSubview(BookNumber)
        contentView.addSubview(BookName)
        contentView.addSubview(BookRatio)
        
        //设置圆角矩形
        self.layer.cornerRadius = 10

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    
}

class SSDCollectionViewLayout: UICollectionViewFlowLayout {
    override func collectionViewContentSize() -> CGSize {
        var width = UIScreen.mainScreen().applicationFrame.width;
        var height = UIScreen.mainScreen().applicationFrame.height;
        return CGSizeMake(width-10, height-20)
    }
}

let reuseIdentifier = "Cell"

class SelectBookCollectionViewController: UICollectionViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextViewDelegate, BookNumberTransmitDelegate {
    
    var bookNumberArray : [String]!
    var bookNameArray : [String]!
    var bookRatioArray : [Int]!
    
    var userDefaults = NSUserDefaults()
    var shouldStayInRootViewController = true
    
    var selectedBookNumber: Int = 0
    var ssdCollectionViewlayout = SSDCollectionViewLayout()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        
//        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]

        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = themeColor
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.collectionView!.registerClass(SSDBookCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        var bookDictionaryFromPlist = NSDictionary(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("BookName", ofType: "plist")!)!)
        self.bookNumberArray = bookDictionaryFromPlist?.objectForKey("BookNumber" as NSString) as! [String]
        self.bookNameArray = bookDictionaryFromPlist?.objectForKey("BookName" as NSString) as! [String]
        self.bookRatioArray = bookDictionaryFromPlist?.objectForKey("ExercisesCount" as NSString) as! [Int]
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 3
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return 3
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SSDBookCell
        cell.backgroundColor = themeColor
        cell.BookNumber.text = self.bookNumberArray[indexPath.section * 3 + indexPath.item]
        cell.BookName.text = self.bookNameArray[indexPath.section * 3 + indexPath.item]
        cell.BookRatio.text = "\(self.bookRatioArray[indexPath.section * 3 + indexPath.item])"
        
        cell.BookName.delegate = self
        
        return cell
    }
    
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
//        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
//        NSNotificationCenter.defaultCenter().postNotificationName("didSelectBookInCollectionView", object: nil, userInfo: ["selectedBook": "SSD\(indexPath.item+1)"])
//            
//        }
        
        self.selectedBookNumber = indexPath.section * 3 + indexPath.item + 1
        
        var takeExerciseViewController: RootViewController = UIStoryboard(name: "TakeExercise", bundle: nil).instantiateViewControllerWithIdentifier("RootViewController") as! RootViewController
        
        takeExerciseViewController.dataTransmitDelegate = self
        
        
        self.navigationController?.pushViewController(takeExerciseViewController, animated: true)

        
    }
    
    func requireBookNumber() -> Int {
        return self.selectedBookNumber
    }
    
    
    
    
    // MARK: UICollectionViewDelegate
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    */
    
    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    */
    
    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
}