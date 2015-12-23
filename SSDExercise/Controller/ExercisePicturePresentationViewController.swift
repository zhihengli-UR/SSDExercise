//
//  ExercisePicturePresentationViewController.swift
//  
//
//  Created by 李 智恒 on 15/11/3.
//
//

import UIKit

class ExercisePicturePresentationViewController: UIViewController {
    
    private let pictureFileNameDictionary = ["SSD3-13题": "ssd3_13", "SSD3-14题": "ssd3_14", "SSD3-16题": "ssd3_16", "SSD4-59题": "ssd4_59", "SSD4-83、85题": "ssd4_8485"]
    var exerciseNumber: String!
    
    @IBOutlet weak var exerciseImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = exerciseNumber
        exerciseImageView.image = UIImage(named: pictureFileNameDictionary[exerciseNumber]!)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        MobClick.beginLogPageView("查看题目图片")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        MobClick.endLogPageView("查看题目图片")
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
