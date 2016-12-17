//
//  NotifyViewController.swift
//  Apper
//
//  Created by jian on 9/4/15.
//  Copyright © 2015 jinhu. All rights reserved.
//

import UIKit

class NotifyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapGesuture = UITapGestureRecognizer(target: self, action: Selector("backToParent"))
        tapGesuture.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(tapGesuture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backToParent()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
