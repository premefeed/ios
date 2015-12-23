//
//  SettingsViewController.swift
//  PremeFeed-iOS
//
//  Created by Cryptoc1 on 12/20/15.
//  Copyright © 2015 Cryptoc1. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup Nav-bar so that it doesn't look like shit.
        self.navigationController!.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Lobster1.4", size: 32.0)!]
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}