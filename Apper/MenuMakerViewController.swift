//
//  MenuMakerViewController.swift
//  Apper
//
//  Created by jian on 8/25/15.
//  Copyright © 2015 jinhu. All rights reserved.
//

import UIKit

class MenuMakerViewController: BaseViewController, iCarouselDataSource, iCarouselDelegate
{
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var carousel: iCarousel!
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewPreview: UIView!
    @IBOutlet weak var imgPreviewView: UIImageView!

    var rectTop: CGRect!
    var parentView: MakerViewController!
    var rectBack: CGRect!
    var rectDone: CGRect!
    
    var imageMain: UIImage!

    var imageCollect: UIImage!
    var imageList: UIImage!
    var imageTap: UIImage!
    var imageSide: UIImage!
    
    var transformPreview: CGAffineTransform!
    var ptPreviewCenter: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
        let color = AppDelegate().getDelegate().currentApper.mainColor
        let currentMenuType = AppDelegate().getDelegate().currentApper.menuStyle
        
        rectBack = btnBack.frame
        rectDone = btnDone.frame
        
        btnBack.setTitleColor(color, forState: UIControlState.Normal)
        btnDone.setTitleColor(color, forState: UIControlState.Normal)
        
        carousel.delegate = self
        carousel.dataSource = self
        carousel.pagingEnabled = true
        carousel.type = iCarouselType.Rotary
        
        transformPreview = viewPreview.transform
        ptPreviewCenter = viewPreview.center
        carousel.alpha = 0
        imgPreviewView.image = imageMain

        btnBack.frame = CGRectMake(rectBack.origin.x - 50.0, rectBack.origin.y, rectBack.size.width, rectBack.size.height)
        btnBack.setTitleColor(color, forState: UIControlState.Normal)
        
        btnDone.frame = CGRectMake(rectDone.origin.x + 50.0, rectDone.origin.y, rectDone.size.width, rectDone.size.height)
        btnDone.setTitleColor(color, forState: UIControlState.Normal)
        
        UIView.animateWithDuration(0.3, delay: 0, options: [.CurveEaseInOut, .AllowUserInteraction], animations: { () -> Void in
            
            self.viewPreview.transform = CGAffineTransformMakeScale(0.522, 0.522)
            self.viewPreview.center = CGPointMake(self.ptPreviewCenter.x, self.ptPreviewCenter.y + 15.0)
            
            }) { (flag: Bool) -> Void in
                
                if(flag == true)
                {
                    var selectIndex = 0
                    if(currentMenuType == MenuStyle.Collect)
                    {
                        self.imageCollect = self.imageMain
                        self.imageList = self.parentView.captureListScreenshot()
                        self.imageTap = self.parentView.captureTabScreenshot()
                        self.imageSide = self.parentView.captureSideScreenshot()
                        selectIndex = 0
                    }
                    else if(currentMenuType == MenuStyle.List)
                    {
                        self.imageCollect = self.parentView.captureCollectScreenshot()
                        self.imageList = self.imageMain
                        self.imageTap = self.parentView.captureTabScreenshot()
                        self.imageSide = self.parentView.captureSideScreenshot()
                        selectIndex = 1
                    }
                    else if(currentMenuType == MenuStyle.TabBar)
                    {
                        self.imageCollect = self.parentView.captureCollectScreenshot()
                        self.imageList = self.parentView.captureListScreenshot()
                        self.imageTap = self.imageMain
                        self.imageSide = self.parentView.captureSideScreenshot()
                        selectIndex = 2
                    }
                    else if(currentMenuType == MenuStyle.SideBar)
                    {
                        self.imageCollect = self.parentView.captureCollectScreenshot()
                        self.imageList = self.parentView.captureListScreenshot()
                        self.imageTap = self.parentView.captureTabScreenshot()
                        self.imageSide = self.imageMain
                        selectIndex = 3
                    }
                    
                    self.parentView.checkMenuStyle()
                    
                    self.carousel.reloadData()
                    self.carousel.scrollToItemAtIndex(selectIndex, animated: false)
                
                    self.viewPreview.alpha = 0
                    self.carousel.alpha = 1
                
                    //Start Show Animation.
                    UIView.animateWithDuration(0.2, delay: 0, options: [.CurveEaseInOut, .AllowUserInteraction], animations: { () -> Void in
                    
                        self.btnBack.frame = self.rectBack
                        self.btnDone.frame = self.rectDone
                    
                        }) { (Bool) -> Void in
                        
                    }
                }
        }

    }
    
    @IBAction func actionBack(sender: AnyObject)
    {
        self.backToParent()
    }
    
    @IBAction func actionChoose()
    {
        self.backToParent()
    }
    
    func backToParent()
    {
        let index = carousel.currentItemIndex
        if(index == 0)
        {
            AppDelegate().getDelegate().currentApper.menuStyle = MenuStyle.Collect
        }
        else if(index == 1)
        {
            AppDelegate().getDelegate().currentApper.menuStyle = MenuStyle.List
        }
        else if(index == 2)
        {
            AppDelegate().getDelegate().currentApper.menuStyle = MenuStyle.TabBar
        }
        else if(index == 3)
        {
            AppDelegate().getDelegate().currentApper.menuStyle = MenuStyle.SideBar
        }
        
        let style = AppDelegate().getDelegate().currentApper.menuStyle
        if(style == MenuStyle.Collect)
        {
            self.imgPreviewView.image = self.imageCollect
        }
        else if(style == MenuStyle.List)
        {
            self.imgPreviewView.image = self.imageList
        }
        else if(style == MenuStyle.TabBar)
        {
            self.imgPreviewView.image = self.imageTap
        }
        else if(style == MenuStyle.SideBar)
        {
            self.imgPreviewView.image = self.imageSide
        }
        
        carousel.alpha = 0
        viewPreview.alpha = 1
        viewTop.alpha = 0
        
        UIView.animateWithDuration(0.4, delay: 0, options: [.CurveEaseIn, .AllowUserInteraction], animations: { () -> Void in
            
            self.viewPreview.transform = CGAffineTransformScale(self.transformPreview, 0.67, 0.67)
            
            }) { (flag: Bool) -> Void in
                
                if(flag == true)
                {
                    UIView.animateWithDuration(0.1, delay: 0, options: [.CurveEaseIn, .AllowUserInteraction], animations: { () -> Void in
                        
                        self.viewPreview.transform = self.transformPreview
                        self.viewPreview.center = self.ptPreviewCenter
                        
                        }) { (Bool) -> Void in
                            
                            self.parentView.reloadContent()
                            self.navigationController?.popViewControllerAnimated(false)
                    }
                }
        }
    }
    
    //MARK: iCarousl
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int
    {
        return 4
    }
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView
    {
        var itemView: UIView
        //create new view if no view is available for recycling
        if (view == nil)
        {
            let fw = 167.0 as CGFloat!
            let fh = 297.0 as CGFloat!
            
            let rect = CGRectMake((carousel.frame.width - fw)/2.0, 0, fw, fh)
            
            itemView = UIView(frame: rect)
            
            let imageView = UIImageView(frame: itemView.bounds)
            imageView.layer.masksToBounds = true
            imageView.contentMode = .ScaleAspectFit
            imageView.layer.borderColor = UIColor.lightGrayColor().CGColor
            imageView.layer.borderWidth = 0.5
            itemView.addSubview(imageView)
            
            if(index == 0)
            {
                imageView.image = imageCollect
            }
            else if(index == 1)
            {
                imageView.image = imageList
            }
            else if(index == 2)
            {
                imageView.image = imageTap
            }
            else if(index == 3)
            {
                imageView.image = imageSide
            }
        }
        else
        {
            //get a reference to the label in the recycled view
            itemView = view as UIView!
        }
        
        return itemView
    }
    
    func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat
    {
        switch(option)
        {
            case .Spacing:
                return value * 1.7
            
            case .Wrap:
                return 1
            
            case .Arc:
                return 2 * 3.141592 * 0.5
            
            case .Radius:
                return value
            
            
            default:
                return value
        }
    }
    
    
    func carousel(carousel: iCarousel, didSelectItemAtIndex index: Int)
    {
        if(index == 0)
        {
            AppDelegate().getDelegate().currentApper.menuStyle = MenuStyle.Collect
        }
        else if(index == 1)
        {
            AppDelegate().getDelegate().currentApper.menuStyle = MenuStyle.List
        }
        else if(index == 2)
        {
            AppDelegate().getDelegate().currentApper.menuStyle = MenuStyle.TabBar
        }
        else if(index == 3)
        {
            AppDelegate().getDelegate().currentApper.menuStyle = MenuStyle.SideBar
        }
        self.backToParent()
    }
    
}
