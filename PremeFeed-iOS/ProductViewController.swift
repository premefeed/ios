//
//  SettingsViewController.swift
//  PremeFeed-iOS
//
//  Created by Cryptoc1 on 12/20/15.
//  Copyright © 2015 Cryptoc1. All rights reserved.
//

import UIKit
import Foundation

class ProductViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var itemImage: UIImageView!
    
    var supremeItem: SupremeItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Nav-bar so that it doesn't look like shit.
        self.navigationController!.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Lobster1.4", size: 32.0)!]
        
        /*
            Try to figure out how the fuck page controllers work.
                I tried this: http://iosmadesimple.blogspot.com/2013/01/page-control-for-switching-between-views.html but it looked fucking stupid
                started to try this: http://swiftiostutorials.com/ios-tutorial-using-uipageviewcontroller-create-content-slider-objective-cswift/ but wasn't sure how to implement it within this app's circumstances
        */
        self.itemImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: self.supremeItem.images![0])!)!)!
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}