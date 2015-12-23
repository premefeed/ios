//
//  FirstViewController.swift
//  PremeFeed-iOS
//
//  Created by Cryptoc1 on 12/20/15.
//  Copyright © 2015 Cryptoc1. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var FeedSubview: UIView!
    @IBOutlet weak var SupremeCollectionView: UICollectionView!
    
    var supremeItems = [SupremeItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Nav-bar so that it doesn't look like shit.
        self.navigationController!.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Lobster1.4", size: 32.0)!]
        
        let api: PremeFeedAPI = PremeFeedAPI()
        api.getAllItems({ (items) -> Void in
            // Fucking async bullshit
            
            
            /*
             *
             *  Add progress spinner while this shit loads
             *
             *  progress.startAnimation()
             *
             */
            
            // Store the Array<SupremeItem>s in the controller for use later
            self.supremeItems = items
            // Force reload the CollectionView now that data exists
            self.SupremeCollectionView.reloadData()
            
            
            // let cellSize = (self.SupremeCollectionView.bounds.width / 2) - 30
            // (self.SupremeCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = CGSizeMake(cellSize, cellSize)
        })
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.supremeItems.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: SupremeItemCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("SupremeItemCell", forIndexPath: indexPath) as! SupremeItemCollectionViewCell
        let img: UIImage = UIImage(data: NSData(contentsOfURL: NSURL(string: self.supremeItems[indexPath.row].image!)!)!)!
        cell.CellButton.setBackgroundImage(img, forState: UIControlState.Normal)
        cell.CellButton.addTarget(self, action: "supremeItemPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.CellButton.supremeItem = self.supremeItems[indexPath.row]
        cell.bounds.size.width = collectionView.bounds.width/2
        return cell
    }
    
    // This doesn't actually do anything since we have buttons in the cells
    // Maybe we could use this the trigger the segue to the ProductViewController, storing the product info in the cell (since we already have a custom class
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Cell \(indexPath.row) selected")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Store the product information stored in the button into the ProductViewController
        (segue.destinationViewController as! ProductViewController).Product = (sender as! SupremeItemButton).supremeItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func supremeItemPressed(sender: SupremeItemButton!) {
        // Go to the Product page
        self.performSegueWithIdentifier("segueToProductView", sender: sender)
    }

}