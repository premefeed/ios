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
        
        /*
        
            Should some of this shit be moved to a different view override, like `viewWillAppear` or something? My intention is to speed up the processing.
            This also leads me to ask if we could cache images (if the system doesn't do that for you by default) 
            I honestly don't know shit about iOS, this is my first ever iOS app.
            dispatch_async
        
        */
        
        // Setup Nav-bar so that it doesn't look like shit.
        self.navigationController!.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Lobster1.4", size: 32.0)!]
        let starButton = UIBarButtonItem(image: UIImage(named: "star-outline")!, style: UIBarButtonItemStyle.Plain, target: self, action: Selector("itemStarred:"))
        self.navigationItem.rightBarButtonItem = starButton
        
        /*
            Try to figure out how the fuck page controllers work.
                I tried this: http://iosmadesimple.blogspot.com/2013/01/page-control-for-switching-between-views.html but it looked fucking stupid
                started to try this: http://swiftiostutorials.com/ios-tutorial-using-uipageviewcontroller-create-content-slider-objective-cswift/ but wasn't sure how to implement it within this app's circumstances
        */
        self.itemImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: self.supremeItem.images![0])!)!)!
        let itemTitle = UILabel(frame: CGRectMake(15, self.itemImage.bounds.height - (self.itemImage.frame.height / 7), self.view.frame.size.width - 15, CGFloat(20)))
        itemTitle.text = self.supremeItem.title!
        itemTitle.font = UIFont.boldSystemFontOfSize(20.0)
        itemTitle.textAlignment = NSTextAlignment.Center
        itemTitle.textColor = UIColor.grayColor()
        let itemDescription = UITextView(frame: CGRectMake(0, itemTitle.frame.origin.x, self.view.frame.size.width, CGFloat(40)))
        itemDescription.text = self.supremeItem.description!
        
        self.view.addSubview(itemTitle)
        self.view.addSubview(itemDescription)
    }
    
    func itemStarred(sender: AnyObject?) {
        (sender! as! UIBarButtonItem).image = UIImage(named: "star-filled")!
        // print("Item starred")
        
        // Add code to store self.supremeItem in starred block of CoreData, or some shit. I don't know.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}