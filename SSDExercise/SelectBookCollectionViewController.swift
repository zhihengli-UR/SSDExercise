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
    
}

let reuseIdentifier = "Cell"

class SelectBookCollectionViewController: UICollectionViewController, UICollectionViewDelegate, UICollectionViewDataSource, BookNumberTransmitDelegate, UITextViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var bookNumberArray : [String]!
    var bookNameArray : [String]!
    var bookRatioArray : [Int]!
    var latestBookNumber: [Int]!
    
    var selectedBookNumber: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //展示LaunchImage
        NSThread.sleepForTimeInterval(1.0)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.registerClass(SSDBookCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        var bookDictionaryFromPlist = NSDictionary(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("BookName", ofType: "plist")!)!)
        self.bookNumberArray = bookDictionaryFromPlist?.objectForKey("BookNumber" as NSString) as! [String]
        self.bookNameArray = bookDictionaryFromPlist?.objectForKey("BookName" as NSString) as! [String]
        self.bookRatioArray = bookDictionaryFromPlist?.objectForKey("ExercisesCount" as NSString) as! [Int]
        
        //用于启动时
        self.latestBookNumber = LatestExerciseNumberManager.sharedLatestNumberManager.requireLatestIdentifier()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        //self.latestBookNumber = NSUserDefaults.standardUserDefaults().objectForKey("LastestNumber") as! [Int]
        
        //用于从做题界面返回刷新时
        self.latestBookNumber = LatestExerciseNumberManager.sharedLatestNumberManager.requireLatestIdentifier()
        collectionView?.reloadData()
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
        
        let indexInArray: Int = indexPath.section * 3 + indexPath.item
        
        cell.backgroundColor = themeColor
        cell.BookNumber.text = self.bookNumberArray[indexInArray]
        cell.BookName.text = self.bookNameArray[indexInArray]
        cell.BookRatio.text = "\(self.latestBookNumber[indexInArray])/\(self.bookRatioArray[indexInArray])"
        
        cell.BookName.delegate = self
        
        return cell
    }
    
    private let sectionInsets = UIEdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 20.0)
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var width = self.view.frame.width
        var cellWidth = CGFloat(Int((width - 80)/3))
        return CGSize(width: cellWidth, height: cellWidth * 1.3)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5
    }
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
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