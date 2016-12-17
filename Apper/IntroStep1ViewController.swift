//
//  IntroStep1ViewController.swift
//  Apper
//
//  Created by jian on 8/3/15.
//  Copyright © 2015 jinhu. All rights reserved.
//

import UIKit
import QuartzCore

class IntroStep1ViewController: BaseViewController, UIScrollViewDelegate
{
    @IBOutlet weak var viewColor: UIView!
    @IBOutlet weak var viewRed: UIView!
    @IBOutlet weak var viewPurple: UIView!
    @IBOutlet weak var viewBlue: UIView!
    @IBOutlet weak var viewGreen: UIView!
    @IBOutlet weak var viewOrange: UIView!

    @IBOutlet weak var viewPhoneGrayHeader: UIView!
    var imgPhoneStatusBar: UIImageView!
    
    @IBOutlet weak var scrollMain: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var viewPhone: UIView!
    @IBOutlet weak var viewPhoneHeader: UIView!

    @IBOutlet weak var imgPhone1: UIImageView!
    @IBOutlet weak var imgIcon1: UIImageView!
    @IBOutlet weak var lblTitle1: UILabel!
    @IBOutlet weak var lblAppCustomize: UILabel!
    
    @IBOutlet weak var imgMap: UIImageView!
    @IBOutlet weak var imgMapOverlay: UIImageView!
    
    @IBOutlet weak var lblTopTitle2: UILabel!
    @IBOutlet weak var lblYourApp2: UILabel!
    
    @IBOutlet weak var viewBlueBG: UIView!
    @IBOutlet weak var imgBlurBG: UIImageView!
    @IBOutlet weak var lblGetStarted: UILabel!
    @IBOutlet weak var imgIntroBg: UIImageView!
    
    var pointNow : CGPoint!
    var rectPhone : CGRect!
    var rectIcon : CGRect!
    var rectIconInPhone: CGRect!
    
    var ptTitleCenter1 : CGPoint!
    
    var rectTopLabel2 : CGRect!
    var rectMap : CGRect!
    var currentMapX : CGFloat!
    var currentMapActualX : CGFloat!
    
    var rectPhoneBase4 : CGRect!
    var rectImageBG: CGRect!
    
    var setColorAnimate: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Step 1.
        rectPhone = viewPhone.frame
        rectIcon = imgIcon1.frame
        ptTitleCenter1 = lblTitle1.center
        viewPhone.frame = CGRectMake(rectPhone.origin.x, self.view.frame.height, rectPhone.width, rectPhone.height);

        imgPhoneStatusBar = UIImageView(frame: viewPhoneGrayHeader.frame)
        let imgHeader = UIImage(named: "mask_header.png")
        imgPhoneStatusBar.image = AppEngine.changeWhiteColorTransparent(imgHeader)
        viewPhone.addSubview(imgPhoneStatusBar)
        
        // tap gesture to icon at step1 which lead to wizard to step2
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("moveStep2"))
        tapGesture.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(tapGesture)
        
        //Step 2.
        lblYourApp2.alpha = 0
        rectTopLabel2 = lblTopTitle2.frame
        rectMap = imgMap.frame
        rectIconInPhone = CGRectMake(rectIcon.origin.x - 36,  self.rectIcon.origin.y + 285, self.rectIcon.width * 0.3, self.rectIcon.height * 0.3)
        currentMapActualX = self.rectMap.origin.x - self.view.frame.width - self.rectMap.size.width
        
        //Step 3.
        setColorAnimate = false
        
        //Step 4.
        viewPhoneHeader.alpha = 0
        rectImageBG = imgIntroBg.frame
        imgIntroBg.layer.masksToBounds = true
        imgIntroBg.contentMode = UIViewContentMode.ScaleAspectFill
        scrollMain.contentSize = CGSizeMake(scrollMain.frame.width * 4, 0);
        
        imgBlurBG.layer.masksToBounds = true
        imgBlurBG.contentMode = UIViewContentMode.ScaleAspectFill
        
        lblTitle1.hidden = true
        imgIcon1.alpha = 0
        imgIntroBg.alpha = 0
        viewBlueBG.alpha = 0
        lblGetStarted.alpha = 0
        
        //Add Icon Shadow
        imgIcon1.clipsToBounds = false
        imgIcon1.layer.shadowColor = UIColor.blackColor().CGColor
        imgIcon1.layer.shadowOffset = CGSizeMake(0, 0)
        imgIcon1.layer.shadowOpacity = 0.5
        
        self.initIntro()
        self.step1();
        
        // skipped whole scene for shortcut to login view controller
//        self.gotoNextView()
    }

    
    func initIntro()
    {
        self.initStep1()
        self.initStep2()
        self.initStep3()
        self.initStep4()
    }
    
/////////////////////////////////////////////////////////////////////////////////////
/// Step 1
/////////////////////////////////////////////////////////////////////////////////////
    
    func moveStep2()
    {
        if(scrollMain.contentOffset.x == 0)
        {
            scrollMain.setContentOffset(CGPointMake(scrollMain.frame.size.width, 0), animated: true)
            pageControl.currentPage = 1
            self.initStep2()
            self.step2()
        }
    }
    
    func initStep1()
    {
        NSLog("init step1")
        imgIcon1.transform = CGAffineTransformIdentity
        lblYourApp2.alpha = 0
    }
    
    func step1()
    {
        self.imgIcon1.frame = CGRectMake(self.rectIcon.origin.x, self.rectIcon.origin.y + 50, self.rectIcon.size.width, self.rectIcon.size.height)
        self.imgIcon1.alpha = 0
        
        self.lblTitle1.hidden = false;
        self.lblTitle1.alpha = 0

        //Show Phone.
        UIView.animateWithDuration(0.3,
            delay: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                self.viewPhone.frame = CGRectMake(self.viewPhone.frame.origin.x, self.rectPhone.origin.y - 50.0, self.viewPhone.frame.size.width, self.viewPhone.frame.size.height);
            }) {(Bool) -> Void in
                
                UIView.animateWithDuration(0.1,
                    delay: 0,
                    options: [.CurveEaseInOut, .AllowUserInteraction],
                    animations: { () -> Void in
                        self.viewPhone.frame = self.rectPhone
                    }) {(Bool) -> Void in
                        
                        //Show Icon
                        UIView.animateWithDuration(0.5,
                            delay: 0.2,
                            options: [.CurveEaseInOut, .AllowUserInteraction],
                            animations: { () -> Void in
                                self.imgIcon1.frame = self.rectIcon;
                                self.imgIcon1.alpha = 1.0
                            }) {(Bool) -> Void in
                        }
                        
                        //Show App Title.
                        UIView.animateWithDuration(0.5,
                            delay: 0.5,
                            options: [.CurveEaseInOut, .AllowUserInteraction],
                            animations: { () -> Void in
                                self.lblTitle1.alpha = 1.0
                            }) {(Bool) -> Void in
                        }
                }
        }
    }
    
/////////////////////////////////////////////////////////////////////////////////////
/// Step 2
/////////////////////////////////////////////////////////////////////////////////////
    
    // start moving map with default x position if x position is not provided
    func moveMap(){
        UIView.animateWithDuration(10.0,
            delay: 0,
            options: [.CurveLinear, .AllowUserInteraction, .Repeat, ],
            animations: { () -> Void in
                
                self.imgMap.frame = CGRectMake(self.currentMapActualX,
                    self.rectMap.origin.y,
                    self.rectMap.size.width,
                    self.rectMap.size.height)
                
            }) {(Bool) -> Void in
                
                self.imgMap.frame = self.rectMap
        }
    }
    
    func moveMapFromMid(){

        self.imgMap.hidden = false
        UIView.animateWithDuration(Double(6.5),
            delay: 0,
            options: [.CurveLinear, .AllowUserInteraction, ],
            animations: { () -> Void in
                
                self.imgMap.frame = CGRectMake(self.currentMapActualX,
                    self.rectMap.origin.y,
                    self.rectMap.size.width,
                    self.rectMap.size.height)
                
            }) {(Bool) -> Void in
                print("one completed, other is about to start")
                self.imgMap.frame = self.rectMap
                // in case of step2 repeat the loop of map
                if self.pageControl.currentPage == 1 {
                    self.moveMap()
                }
        }
    }
    
    func initStep2()
    {
        NSLog("init step2")
        lblTopTitle2.alpha = 0
        lblTitle1.layer.removeAllAnimations()
    }
    
    func step2()
    {
        //Show App Name.
        UIView.animateWithDuration(0.2,
            delay: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.lblYourApp2.alpha = 1
                
            }) {(Bool) -> Void in
                
        }
        
        //Move Map.
        moveMap()
    }

   
/////////////////////////////////////////////////////////////////////////////////////
/// Step 3
/////////////////////////////////////////////////////////////////////////////////////
    func initStep3()
    {
        NSLog("init step3")
        
        //Red.
        lblAppCustomize.alpha = 0
        
        viewRed.layer.removeAllAnimations()
        viewRed.alpha = 0
        viewRed.hidden = true
        
        //Purple.
        viewPurple.layer.removeAllAnimations()
        viewPurple.alpha = 0
        viewPurple.hidden = true
        
        //Blue
        viewBlue.layer.removeAllAnimations()
        viewBlue.alpha = 0
        viewBlue.hidden = true
        
        //Green.
        viewGreen.layer.removeAllAnimations()
        viewGreen.alpha = 0
        viewGreen.hidden = true
        
        //Orange.
        viewOrange.layer.removeAllAnimations()
        viewOrange.alpha = 0
        viewOrange.hidden = true
        
        viewPhoneGrayHeader.alpha = 1
        imgPhoneStatusBar.alpha = 1
    }
    
    func step3()
    {
//        self.resumeLayer(viewColor.layer)
        self.resumeLayer(viewRed.layer)
        self.resumeLayer(viewPurple.layer)
        self.resumeLayer(viewBlue.layer)
        self.resumeLayer(viewGreen.layer)
        self.resumeLayer(viewOrange.layer)
        
        viewColor.alpha = 1
        viewPhoneGrayHeader.alpha = 0
        
        //Red
        let animTime = 0.5
        self.viewRed.hidden = false
        UIView.animateWithDuration(animTime,
            delay: 0,
            options: [.CurveLinear, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewRed.alpha = 1
                
            }) {(flag: Bool) -> Void in
                
                if(flag)
                {
                    self.showPurpleColorBar(animTime)
                }
        }
    }
    
    func showPurpleColorBar(animTime: Double)
    {
        //Purple
        self.viewPurple.hidden = false
        UIView.animateWithDuration(animTime,
            delay: 0,
            options: [.CurveLinear, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewPurple.alpha = 1
                
            }) {(flag: Bool) -> Void in
                
                if(flag)
                {
                    self.showBlueColorBar(animTime)
                }
        }
    }
    
    func showBlueColorBar(animTime: Double)
    {
        //Blue
        self.viewBlue.hidden = false
        UIView.animateWithDuration(animTime,
            delay: 0,
            options: [.CurveLinear, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewBlue.alpha = 1
                
            }) {(flag: Bool) -> Void in
                if(flag)
                {
                    self.showGreenColorBar(animTime)
                }
        }
    }
    
    func showGreenColorBar(animTime: Double)
    {
        //Green
        self.viewGreen.hidden = false
        UIView.animateWithDuration(animTime,
            delay: 0,
            options: [.CurveLinear, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewGreen.alpha = 1
               
            }) {(flag: Bool) -> Void in
                if(flag)
                {
                    self.showOrangeColorBar(animTime)
                }
        }
    }
    
    func showOrangeColorBar(animTime: Double)
    {
        //Orange
        self.viewOrange.hidden = false
        UIView.animateWithDuration(animTime,
            delay: 0,
            options: [.CurveLinear, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewOrange.alpha = 1
                
            }) {(flag: Bool) -> Void in
        }
    }
    
/////////////////////////////////////////////////////////////////////////////////////
/// Step 4
/////////////////////////////////////////////////////////////////////////////////////
    func initStep4()
    {
        NSLog("init step4")
    }
    
    func step4()
    {
        
    }

/////////////////////////////////////////////////////////////////////////////////////
/// End Step
/////////////////////////////////////////////////////////////////////////////////////
    func endStep()
    {
        scrollMain.userInteractionEnabled = false
        
        //Hide Getting Started.
        UIView.animateWithDuration(0.2,
            delay: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.lblGetStarted.alpha = 0
                
            }) {(Bool) -> Void in
                
                self.pageControl.alpha = 0
                self.viewPhoneGrayHeader.alpha = 0
                self.imgPhoneStatusBar.alpha = 0
                let rectPhone = self.viewPhone.frame
                
                //Move Phone.
                UIView.animateWithDuration(0.4,
                    delay: 0,
                    options: [.CurveEaseInOut, .AllowUserInteraction],
                    animations: { () -> Void in
                        
                        self.viewPhone.frame = CGRectMake(rectPhone.origin.x, rectPhone.origin.y - 131.0, rectPhone.width, rectPhone.height)
                        self.viewPhone.transform = CGAffineTransformScale(self.viewPhone.transform, 1.32, 1.32)
                        
                    }) {(Bool) -> Void in
                        
                        self.imgPhone1.alpha = 0
                        
                        //Move Phone Header
                        UIView.animateWithDuration(0.2,
                            delay: 1.0,
                            options: [.CurveEaseInOut, .AllowUserInteraction],
                            animations: { () -> Void in
                                
                                self.viewPhoneHeader.alpha = 0
                                self.viewPhoneHeader.frame = CGRectMake(self.viewPhoneHeader.frame.origin.x,
                                    self.viewPhoneHeader.frame.origin.y - 52.0,
                                    self.viewPhoneHeader.frame.width,
                                    self.viewPhoneHeader.frame.height)
                                
                            }) {(Bool) -> Void in
                                
                                self.gotoNextView()
                        }
                }

        }
    }
    
    
/////////////////////////////////////////////////////////////////////////////////////
/// UIScrollView Delegate.
/////////////////////////////////////////////////////////////////////////////////////
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView)
    {
        pointNow = scrollView.contentOffset;
        
        if (pointNow.x == 0){
//            self.pauseLayer(imgMap.layer)
            let layer = imgMap.layer.presentationLayer() as! CALayer
            currentMapX = layer.frame.origin.x - self.view.frame.width
            
            imgMap.hidden = true
            imgMapOverlay.frame = layer.frame
            imgMapOverlay.hidden = false
        }
        else if(pointNow.x == scrollView.frame.width)
        {
            self.pauseLayer(imgMap.layer)
            let layer = imgMap.layer.presentationLayer() as! CALayer
            currentMapX = layer.frame.origin.x
            
            imgMap.hidden = true
            imgMapOverlay.frame = layer.frame
            imgMapOverlay.hidden = false
        }
        else if(pointNow.x == scrollView.frame.width * 2)
        {
//            self.pauseLayer(viewColor.layer)
            self.pauseLayer(viewRed.layer)
            self.pauseLayer(viewPurple.layer)
            self.pauseLayer(viewBlue.layer)
            self.pauseLayer(viewGreen.layer)
            self.pauseLayer(viewOrange.layer)
        }
        
        let delay = 0.05 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.checkScrollDirection()
        }
    }
    
    func checkScrollDirection()
    {
        NSLog("checkScrollDirection")
        var direction = 0
        if(pointNow.x > scrollMain.contentOffset.x)
        {
            direction = -1
        }
        else
        {
            direction = 1
        }
        
        if(scrollMain.contentOffset.x < 0)
        {
            self.initStep1()
        }
        if(scrollMain.contentOffset.x >= 0 && scrollMain.contentOffset.x < scrollMain.frame.width)
        {
            if(direction == 1)
            {
                self.initStep2()
            }
            else
            {
                self.initStep1()
            }
        }
        
        if(scrollMain.contentOffset.x >= scrollMain.frame.width && scrollMain.contentOffset.x < scrollMain.frame.width * 2)
        {
            if(direction == 1)
            {
                self.initStep3()
            }
            else
            {
                self.initStep2()
            }
        }
        
        if(scrollMain.contentOffset.x >= scrollMain.frame.width * 2 && scrollMain.contentOffset.x < scrollMain.frame.width * 3)
        {
            if(direction == 1)
            {
                self.initStep4()
            }
            else
            {
                self.initStep3()
            }
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) -> ()
    {
        let pageNumber = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width));
        
        print("scrollViewDidEndDecelerating", pageNumber)
        
        //Some init
        if(pageNumber == 0)
        {
            currentMapX = nil
            self.resumeLayer(imgMap.layer)
            imgMap.hidden = false
            imgMapOverlay.hidden = true
            imgMapOverlay.frame = rectMap
            imgMap.frame = rectMap
            imgMap.layer.removeAllAnimations()
        }
        else if(pageNumber == 1)
        {
//            let molayer = imgMapOverlay.layer.presentationLayer() as! CALayer
//            imgMap.frame = molayer.frame
            
            imgMap.hidden = false
            imgMapOverlay.hidden = true
            self.resumeLayer(imgMap.layer)
        }
        else if(pageNumber == 2)
        {
//            self.resumeLayer(viewColor.layer)
            self.resumeLayer(viewRed.layer)
            self.resumeLayer(viewPurple.layer)
            self.resumeLayer(viewBlue.layer)
            self.resumeLayer(viewGreen.layer)
            self.resumeLayer(viewOrange.layer)
            
            self.resumeLayer(imgMap.layer)
            currentMapX = nil
            imgMap.hidden = false
            imgMapOverlay.hidden = true
            imgMapOverlay.frame = rectMap
            imgMap.frame = rectMap
            imgMap.layer.removeAllAnimations()
        }
        else if(pageNumber == 3)
        {

        }
        
        
        //Animation.
        if(pageNumber != pageControl.currentPage)
        {
            if(pageNumber == 0)
            {
//                self.step1()
            }
            else if(pageNumber == 1)
            {
                // start moving the map where imgMapOverlay left
                let molayer = imgMapOverlay.layer.presentationLayer() as! CALayer
                imgMap.frame = molayer.frame
                moveMapFromMid()
            }
            else if(pageNumber == 2)
            {
                self.step3()
            }
            else if(pageNumber == 3)
            {
                scrollView.scrollEnabled = false
                
                self.step4()
                let delay = 0.5 * Double(NSEC_PER_SEC)
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                dispatch_after(time, dispatch_get_main_queue()) {
                    
                    self.endStep()
                }
            }
        }
        
        pageControl.currentPage = pageNumber
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        //Page 0 ~ 1
        if(scrollView.contentOffset.x >= 0 && scrollView.contentOffset.x <= scrollView.frame.width)
        {
            let progress = scrollView.contentOffset.x / scrollView.frame.width

            viewPhone.frame = CGRectMake(rectPhone.origin.x, rectPhone.origin.y - 100 * progress, rectPhone.width, rectPhone.height)
            var newAlpha = progress*5
            if newAlpha > 1 {
                newAlpha = 1
            }
            lblTitle1.alpha = 1 - progress * 5
            lblYourApp2.alpha = progress * 2
            
            self.imgIcon1.frame = CGRectMake(rectIcon.origin.x - 36 * progress,
                self.rectIcon.origin.y + 285 * progress,
                self.rectIcon.width * (1 - 0.7 * progress),
                self.rectIcon.height * (1 - 0.7 * progress))
            
            
            var scale = 1 - 0.5 * progress
            if(scale < 0)
            {
                scale = 0
            }
            else if(scale > 1)
            {
                scale = 1
            }
            
            self.lblTopTitle2.alpha = progress
            
            //Move Map.
            if(currentMapX != nil)
            {
                let length = self.view.frame.width - currentMapX
                let x = currentMapX + length * (1 - progress)
                
                imgMapOverlay.frame = CGRectMake(x,
                    imgMapOverlay.frame.origin.y,
                    imgMapOverlay.frame.size.width,
                    imgMapOverlay.frame.size.height)
            }
        }
            
        //Page 1 ~ 2
        else if(scrollView.contentOffset.x >= scrollView.frame.width && scrollView.contentOffset.x <= scrollView.frame.width * 2)
        {
            let progress = (scrollView.contentOffset.x - scrollView.frame.width) / scrollView.frame.width
            
            viewPhone.frame = CGRectMake(rectPhone.origin.x, rectPhone.origin.y - 100 - 100 * progress, rectPhone.width, rectPhone.height)
            self.imgIcon1.frame = CGRectMake(rectIconInPhone.origin.x,
                rectIconInPhone.origin.y - 100 * progress,
                rectIconInPhone.width,
                rectIconInPhone.height)

            if(progress > 0.5)
            {
                lblAppCustomize.alpha = (progress - 0.5) * 2
                lblTopTitle2.alpha = 0
            }
            else
            {
                lblAppCustomize.alpha = 0
                lblTopTitle2.alpha = 1 - progress * 2
            }
            
            if(progress < 0.7)
            {
                viewPhoneGrayHeader.alpha = 1
            }
            
            //Move Map.
            if(currentMapX != nil)
            {
                let length = imgMapOverlay.frame.width + currentMapX
                let x = currentMapX - length * progress
                
                imgMapOverlay.frame = CGRectMake(x,
                    imgMapOverlay.frame.origin.y,
                    imgMapOverlay.frame.size.width,
                    imgMapOverlay.frame.size.height)
            }
            
            //Change Background Color.
            viewColor.alpha = progress
        }
        
        //Page 2 ~ 3
        else if(scrollView.contentOffset.x >= scrollView.frame.width * 2 && scrollView.contentOffset.x <= scrollView.frame.width * 3)
        {
            let progress = (scrollView.contentOffset.x - scrollView.frame.width * 2) / scrollView.frame.width
            viewPhone.frame = CGRectMake(rectPhone.origin.x, rectPhone.origin.y - 200 - 100 * progress, rectPhone.width, rectPhone.height)
            self.imgIcon1.frame = CGRectMake(rectIconInPhone.origin.x - (rectIconInPhone.width / 4) * progress,
                rectIconInPhone.origin.y - 100 - 100 * progress - (rectIconInPhone.height / 4) * progress,
                rectIconInPhone.width + (rectIconInPhone.width / 2) * progress,
                rectIconInPhone.height + (rectIconInPhone.height / 2) * progress)
            
            if(progress > 0.5)
            {
                lblGetStarted.alpha = (progress - 0.5) * 2
                lblAppCustomize.alpha = 0
            }
            else
            {
                lblGetStarted.alpha = 0
                lblAppCustomize.alpha = 1 - progress * 2
            }
            
            viewColor.alpha = 1 - progress
            viewBlueBG.alpha = progress
            
            if(progress > 0.5)
            {
                imgIntroBg.alpha = (progress - 0.5) * 2
                viewPhoneHeader.alpha = (progress - 0.5) * 2
                
                imgIcon1.alpha = 0
                lblYourApp2.alpha = 0
            }
            else
            {
                imgIntroBg.alpha = 0
                viewPhoneHeader.alpha = 0
                
                imgIcon1.alpha = 1 - progress * 2
                lblYourApp2.alpha = 1 - progress * 2
            }
            
            if(progress > 0.3)
            {
                viewPhoneGrayHeader.alpha = 1
            }
            else
            {
                viewPhoneGrayHeader.alpha = 0
            }
        }
    }

    func gotoNextView()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("SignInViewController") as! SignInViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func pauseLayer(layer: CALayer)
    {
        let paused_time = layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
        layer.speed = 0
        layer.timeOffset = paused_time
    }
    
    func resumeLayer(layer: CALayer)
    {
        let paused_time = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let time_since_pause = layer.convertTime(CACurrentMediaTime(), fromLayer:  nil) - paused_time
        layer.beginTime = time_since_pause
    }
}

