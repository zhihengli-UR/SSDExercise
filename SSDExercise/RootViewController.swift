//
//  RootViewController.swift
//  PageViewTest
//
//  Created by 李 智恒 on 15/7/16.
//  Copyright (c) 2015年 李 智恒. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UIPageViewControllerDelegate {

    var pageViewController: UIPageViewController?
    weak var dataTransmitDelegate: BookNumberTransmitDelegate!
    var selectedBookNumberFromRootViewController = 0
    
    var collectionButtonColor = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Configure the page view controller and add it as a child view controller.
        
        
        self.selectedBookNumberFromRootViewController = self.dataTransmitDelegate.requireBookNumber()
        self.modelController.bookNumber = self.selectedBookNumberFromRootViewController    //将书号传给model
        self.modelController.loadDataFromPlistToArray()
        self.navigationItem.title = "SSD\(self.selectedBookNumberFromRootViewController)"   //设置NavigationBar的Title
        
        if (self.navigationController?.respondsToSelector("interactivePopGestureRecognizer") != nil){
            self.navigationController?.interactivePopGestureRecognizer.enabled = false    //禁用滑动返回
        }
        
        self.pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        self.pageViewController!.delegate = self
        
        let startingViewController: DataViewController = self.modelController.viewControllerAtIndex(0, storyboard: self.storyboard!)!
        let viewControllers = [startingViewController]
        self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: nil)

        self.pageViewController!.dataSource = self.modelController

        self.addChildViewController(self.pageViewController!)
        self.view.addSubview(self.pageViewController!.view)

        // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
//        var originBounds = self.view.bounds
//        var originBoundsWidth = originBounds.width
//        var originBoundsHeight = originBounds.height
//        var navigationBarHeight = self.navigationController?.navigationBar.bounds.height
        var pageViewFrame: CGRect = self.view.bounds
//        if let height = navigationBarHeight {
//            pageViewFrame = CGRectMake(0, height+15, originBoundsWidth, originBoundsHeight - height) //减去NavigationBar的高度
//        }
        
        
        //newBounds.size.height -= self.navigationController?.navigationBar.bounds.size.height!
        
        
        //var pageViewRect = self.view.bounds
        //self.pageViewController!.view.frame = pageViewRect
        self.pageViewController!.view.frame = pageViewFrame

        self.pageViewController!.didMoveToParentViewController(self)

        // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
        self.view.gestureRecognizers = self.pageViewController!.gestureRecognizers
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var modelController: ModelController {
        // Return the model controller object, creating it if necessary.
        // In more complex implementations, the model controller may be passed to the view controller.
        if _modelController == nil {
            _modelController = ModelController()
        }
        return _modelController!
    }

    var _modelController: ModelController? = nil

    // MARK: - UIPageViewController delegate methods

    func pageViewController(pageViewController: UIPageViewController, spineLocationForInterfaceOrientation orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        // Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to true, so set it to false here.
        let currentViewController = self.pageViewController!.viewControllers[0] as! UIViewController
        let viewControllers = [currentViewController]
        self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: {done in })

        self.pageViewController!.doubleSided = false
        return .Min
    }



}

