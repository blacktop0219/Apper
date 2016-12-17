//
//  PreviewViewController.swift
//  Apper
//
//  Created by jian on 8/25/15.
//  Copyright © 2015 jinhu. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var lblPreviewTitle: UILabel!
    @IBOutlet weak var viewShake: UIView!
    @IBOutlet weak var imgVibrationView: UIImageView!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var imgBackgroundView: UIImageView!
    
    var parentView: MakerViewController!
    var shakeTimer: NSTimer!
    var shakeCount: Int!
    var finishedLoading: Bool!
    var finishedShake: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let imgBack = AppDelegate().getDelegate().currentApper.imgBackground
        let color = AppDelegate().getDelegate().currentApper.mainColor
        
        imgBackgroundView.image = imgBack
        lblPreviewTitle.backgroundColor = color
        lblPreviewTitle.userInteractionEnabled = true
        let gestureTitle = UITapGestureRecognizer(target: self, action: Selector("actionTouchTitle"))
        gestureTitle.numberOfTouchesRequired = 1
        lblPreviewTitle.addGestureRecognizer(gestureTitle)
        
        finishedLoading = false
        finishedShake = false
        webView.delegate = self
        
        UIApplication.sharedApplication().statusBarHidden = true
        
        let request = NSURLRequest(URL: NSURL(string: PREVIEW_URL)!)
        webView.loadRequest(request)
        webView.hidden = true
        
        shakeCount = 0
        let transformImage = viewShake.transform
        viewShake.transform = CGAffineTransformScale(transformImage, 0.0001, 0.0001)
        imgVibrationView.layer.anchorPoint = CGPointMake(0.5, 1);
        
        //Show Phone.
        UIView.animateWithDuration(0.1, delay: 0, options: [.CurveEaseInOut, .AllowUserInteraction], animations: { () -> Void in
            
            self.viewShake.transform = CGAffineTransformScale(transformImage, 1.1, 1.1)
            
            }) { (Bool) -> Void in
                UIView.animateWithDuration(0.1, delay: 0, options: [.CurveEaseInOut, .AllowUserInteraction], animations: { () -> Void in
                    
                    self.viewShake.transform = CGAffineTransformScale(transformImage, 1.0, 1.0)
                    
                    }) { (Bool) -> Void in
                        
                        self.shakeTimer = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: Selector("shakePhone"), userInfo: nil, repeats: true)
                }
        }

    }
    
    override func viewWillDisappear(animated: Bool)
    {
        UIApplication.sharedApplication().statusBarHidden = false
    }
    
    func shakePhone()
    {
        shakeCount = shakeCount + 1
        if(shakeCount >= 2) {
            shakeTimer.invalidate()
            shakeTimer = nil
            
            self.finishedShake = true
            if(self.finishedLoading == true)
            {
                self.hidePhone()
            }
        }
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSNumber(float: -0.1)
        animation.toValue = NSNumber(float: 0.1)
        self.imgVibrationView.layer.addAnimation(animation, forKey: "transform.rotation.z")
    }
 
    func hidePhone()
    {
        //Hide Phone.
        UIView.animateWithDuration(0.1, delay: 1.0, options: [.CurveEaseInOut, .AllowUserInteraction], animations: { () -> Void in
            
            self.viewShake.transform = CGAffineTransformScale(self.viewShake.transform, 0.001, 0.001)
            
            }) { (Bool) -> Void in
                self.imgVibrationView.hidden = true
                self.webView.hidden = false
        }
    }
    
    func backToParent(rectStart: CGRect!)
    {
        UIView.animateWithDuration(0.2, delay: 0, options: [.CurveEaseInOut, .AllowUserInteraction], animations: { () -> Void in
            
            self.viewTop.frame = CGRectMake(self.viewTop.frame.origin.x, -self.viewTop.frame.height, self.viewTop.frame.width, self.viewTop.frame.height)
            self.viewShake.alpha = 0
            self.webView.alpha = 0
            
            }) { (Bool) -> Void in
                
                self.parentView.openMainViewFromPreview()
                self.navigationController?.popViewControllerAnimated(false)
        }
    }

    func actionTouchTitle()
    {
        self.backToParent(CGRectMake(0, 0, 50, 50))
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake
        {
            self.backToParent(CGRectMake(0, 0, 50, 50))
        }
    }
    
    //MARK: UIWebview Delegate.
    func webViewDidFinishLoad(webView: UIWebView)
    {
        finishedLoading = true
        if(finishedShake == true)
        {
            self.hidePhone()
        }
    }
}
