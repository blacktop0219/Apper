//
//  ViewController.swift
//  Apper
//
//  Created by jian on 8/3/15.
//  Copyright © 2015 jinhu. All rights reserved.
//

import UIKit
//import IntroStep1ViewController

class ViewController: BaseViewController {

    @IBOutlet weak var imgColor: UIImageView!
    @IBOutlet weak var viewIcon: UIView!
    @IBOutlet weak var viewIcon1: UIView!
    @IBOutlet weak var viewIcon2: UIView!
    @IBOutlet weak var viewIcon3: UIView!
    
    var rotation_counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if AppDelegate().getDelegate().DEBUG == false {
            self.normalStart()
        }
        else{
            // Debug Shartcuts
            self.gotoPostViewController() //Shortcut to list of categories
            //        self.gotoDashboardViewController() //Shortcut to dashboard view
            //        self.gotoNextView() //Skip splash animation and goto intro screen directly
            
        }
        
//        self.getSelectedLanguage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func rotateColorIcon()
    {
        UIView.animateWithDuration(1.0,
            delay: 0,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: { () -> Void in
                self.imgColor.transform = CGAffineTransformRotate(self.imgColor.transform, CGFloat(M_PI))
            }) {(Bool) -> Void in
                
                UIView.animateWithDuration(1.0,
                    delay: 0,
                    options: UIViewAnimationOptions.CurveEaseOut,
                    animations: { () -> Void in
                        self.imgColor.transform = CGAffineTransformRotate(self.imgColor.transform, CGFloat(M_PI))
                    }) {(Bool) -> Void in
                        self.hideColorIcon()
                }
        }
    }
    
    
    func hideColorIcon()
    {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.imgColor.alpha = 0
            }) { (Bool) -> Void in
                self.zoomMainIcon();
        }
    }
    
    func zoomMainIcon()
    {
        UIView.animateWithDuration(0.2,
            delay: 0,
            options: UIViewAnimationOptions.CurveLinear,
            animations: { () -> Void in
                self.viewIcon.transform = CGAffineTransformScale(self.viewIcon.transform, 0.8, 0.8)
            }) {(Bool) -> Void in
                UIView.animateWithDuration(0.15,
                    delay: 1.0,
                    options: UIViewAnimationOptions.CurveLinear,
                    animations: { () -> Void in
                        self.viewIcon.transform = CGAffineTransformScale(self.viewIcon.transform, 32, 32)
                    }) {(Bool) -> Void in
                        self.gotoNextView()
                }
        }
    }
    
    func gotoNextView()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("IntroStep1ViewController") as! IntroStep1ViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func normalStart(){
        viewIcon1.layer.masksToBounds = true
        viewIcon1.layer.cornerRadius = viewIcon1.frame.width/2.0
        
        viewIcon2.layer.masksToBounds = true
        viewIcon2.layer.cornerRadius = viewIcon2.frame.width/2.0
        
        viewIcon3.layer.masksToBounds = true
        viewIcon3.layer.cornerRadius = viewIcon3.frame.width/2.0
        
        self.rotateColorIcon()
    }
    
    // Shortcut methods
    
    func gotoPostViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("PostViewController") as! PostViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func gotoDashboardViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dashboard = storyboard.instantiateViewControllerWithIdentifier("DashboardViewController") as! DashboardViewController
        let menu = storyboard.instantiateViewControllerWithIdentifier("MenuViewController") as! MenuViewController
        let container = MFSideMenuContainerViewController.containerWithCenterViewController(dashboard, leftMenuViewController: menu, rightMenuViewController: nil)
        AppDelegate().getDelegate().dashboardContainer = container
        self.navigationController?.pushViewController(container, animated: false)
    }
    
    // It can be placed somewhere else after that
    func getSelectedLanguage(){
        let pre = NSLocale.preferredLanguages()[0]
        //        var preferredLanguages : NSLocale!
        //        let pre = preferredLanguages.displayNameForKey(NSLocaleIdentifier, value: preferredLanguages)
        //  ^^^ ... and so you send something to nil, which returns nil
        print(pre)
    }
    
}

