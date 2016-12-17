//
//  ImagesViewController.swift
//  Apper
//
//  Created by jian on 8/25/15.
//  Copyright © 2015 jinhu. All rights reserved.
//

import UIKit

class ImagesViewController: BaseViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ImageCropViewControllerDelegate
{
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var viewSplash: UIView!
    @IBOutlet weak var viewSplashPhone: UIView!
    @IBOutlet weak var lblSplashTitle: UILabel!
    @IBOutlet weak var btnSplashTakePhoto: UIButton!
    @IBOutlet weak var btnSplashChoosePhoto: UIButton!
    @IBOutlet weak var btnSplashSearchOnlinePhoto: UIButton!
    @IBOutlet weak var btnSplashUseDefaultPhoto: UIButton!
    @IBOutlet weak var imgSplashView: UIImageView!
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var viewBackgroundPhone: UIView!
    @IBOutlet weak var lblBackgroundTitle: UILabel!
    @IBOutlet weak var btnBackgroundTakePhoto: UIButton!
    @IBOutlet weak var btnBackgroundChoosePhoto: UIButton!
    @IBOutlet weak var btnBackgroundSearchOnlinePhoto: UIButton!
    @IBOutlet weak var btnBackgroundUseDefaultPhoto: UIButton!
    @IBOutlet weak var imgBackgroundView: UIImageView!
    
    @IBOutlet weak var viewPreview: UIView!
    @IBOutlet weak var imgPreviewView: UIImageView!
    
    var parentView: MakerViewController!
    var rectBack: CGRect!
    var rectDone: CGRect!
    var rectSplashPhone: CGRect!
    var currentIndex: Int!
    var imageMain: UIImage!
    var transformPreview: CGAffineTransform!
    var ptPreviewCenter: CGPoint!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Init Variables.
        let color = AppDelegate().getDelegate().currentApper.mainColor
        
        transformPreview = viewPreview.transform
        rectBack = btnBack.frame
        rectDone = btnDone.frame
        rectSplashPhone = viewSplashPhone.frame
        imagePicker.delegate = self
        
        // Init UI.
        scrollView.contentSize = CGSizeMake(scrollView.frame.width * 2, scrollView.frame.height)
        
        let borderColor = UIColor(red: 212.0/255.0, green: 212.0/255.0, blue: 212.0/255.0, alpha: 1.0).CGColor
        let borderWidth = 1.0 as CGFloat
        
        //Splash.
        imgSplashView.layer.masksToBounds = true
        imgSplashView.contentMode = UIViewContentMode.ScaleAspectFill
        
        let imgSplash = AppDelegate().getDelegate().currentApper.imgSplash
        if(imgSplash != nil)
        {
            imgSplashView.image = imgSplash
        }
        
        btnSplashTakePhoto.layer.masksToBounds = true
        btnSplashTakePhoto.layer.cornerRadius = 5.0
        btnSplashTakePhoto.layer.borderColor = borderColor
        btnSplashTakePhoto.layer.borderWidth = borderWidth
        
        btnSplashChoosePhoto.layer.masksToBounds = true
        btnSplashChoosePhoto.layer.cornerRadius = 5.0
        btnSplashChoosePhoto.layer.borderColor = borderColor
        btnSplashChoosePhoto.layer.borderWidth = borderWidth
        
        btnSplashSearchOnlinePhoto.layer.masksToBounds = true
        btnSplashSearchOnlinePhoto.layer.cornerRadius = 5.0
        btnSplashSearchOnlinePhoto.layer.borderColor = borderColor
        btnSplashSearchOnlinePhoto.layer.borderWidth = borderWidth
        
        btnSplashUseDefaultPhoto.layer.masksToBounds = true
        btnSplashUseDefaultPhoto.layer.cornerRadius = 5.0
        btnSplashUseDefaultPhoto.layer.borderColor = borderColor
        btnSplashUseDefaultPhoto.layer.borderWidth = borderWidth
        
        //Background.
        imgBackgroundView.layer.masksToBounds = true
        imgBackgroundView.contentMode = UIViewContentMode.ScaleAspectFill
        
        var imgBackground = AppDelegate().getDelegate().currentApper.imgBackground
        if(imgBackground != nil)
        {
            imgBackgroundView.image = imgBackground
        }
        else
        {
            let category = AppDelegate().getDelegate().currentApper.category
            let name = AppDelegate().getDelegate().currentApper.arrCategories.objectAtIndex(category) as! String
            imgBackground = UIImage(named: String(format: "%@.jpg", name))
            imgBackgroundView.image = imgBackground
            
        }
        
        btnBackgroundTakePhoto.layer.masksToBounds = true
        btnBackgroundTakePhoto.layer.cornerRadius = 5.0
        btnBackgroundTakePhoto.layer.borderColor = borderColor
        btnBackgroundTakePhoto.layer.borderWidth = borderWidth
        
        btnBackgroundChoosePhoto.layer.masksToBounds = true
        btnBackgroundChoosePhoto.layer.cornerRadius = 5.0
        btnBackgroundChoosePhoto.layer.borderColor = borderColor
        btnBackgroundChoosePhoto.layer.borderWidth = borderWidth
        
        btnBackgroundSearchOnlinePhoto.layer.masksToBounds = true
        btnBackgroundSearchOnlinePhoto.layer.cornerRadius = 5.0
        btnBackgroundSearchOnlinePhoto.layer.borderColor = borderColor
        btnBackgroundSearchOnlinePhoto.layer.borderWidth = borderWidth
        
        btnBackgroundUseDefaultPhoto.layer.masksToBounds = true
        btnBackgroundUseDefaultPhoto.layer.cornerRadius = 5.0
        btnBackgroundUseDefaultPhoto.layer.borderColor = borderColor
        btnBackgroundUseDefaultPhoto.layer.borderWidth = borderWidth

        btnBack.frame = CGRectMake(rectBack.origin.x - 50.0, rectBack.origin.y, rectBack.size.width, rectBack.size.height)
        btnBack.setTitleColor(color, forState: UIControlState.Normal)
        
        btnDone.frame = CGRectMake(rectDone.origin.x + 50.0, rectDone.origin.y, rectDone.size.width, rectDone.size.height)
        btnDone.setTitleColor(color, forState: UIControlState.Normal)

        self.moveBackgroundPage()
        
        self.lblSplashTitle.alpha = 0
        self.lblBackgroundTitle.alpha = 0
        self.viewSplashPhone.alpha = 0
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        self.startAnimate()
    }
    
    func startAnimate()
    {
        imgPreviewView.image = imageMain
        ptPreviewCenter = viewPreview.center
        UIView.animateWithDuration(0.3, delay: 0, options: [.CurveEaseInOut, .AllowUserInteraction], animations: { () -> Void in
        
        self.viewPreview.transform = CGAffineTransformMakeScale(0.73, 0.73)
        self.viewPreview.center = CGPointMake(self.ptPreviewCenter.x, self.ptPreviewCenter.y + 84.0)
        
        }) { (Bool) -> Void in
        
            self.viewSplashPhone.alpha = 1
            
            //Start Show Animation.
            UIView.animateWithDuration(0.2, delay: 0, options: [.CurveEaseInOut, .AllowUserInteraction], animations: { () -> Void in
        
                self.btnBack.frame = self.rectBack
                self.btnDone.frame = self.rectDone
                self.lblBackgroundTitle.alpha = 1
                self.lblSplashTitle.alpha = 1
                self.viewPreview.alpha = 0
        
                }) { (Bool) -> Void in
            }
        }
    }
    
    func moveBackgroundPage()
    {
        scrollView.setContentOffset(CGPointMake(scrollView.frame.width, 0), animated: true)
    }
    
    //MARK: ScrollView Delegate.
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        let pageNumber = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width));
        pageControl.currentPage = pageNumber
        
        //Page 0 ~ 1
        if(scrollView.contentOffset.x >= 0 && scrollView.contentOffset.x <= scrollView.frame.width)
        {
            let progress = scrollView.contentOffset.x / scrollView.frame.width
            if(progress < 0.5)
            {
                lblSplashTitle.alpha = 1 - progress * 2
                lblBackgroundTitle.alpha = 0
            }
            else
            {
                lblSplashTitle.alpha = 0
                lblBackgroundTitle.alpha = progress
            }
        }
    }
    
    //MARK: Actions.
    @IBAction func actionDone(sender: AnyObject)
    {
        self.moveToBack()
    }
    
    @IBAction func actionBack(sender: AnyObject)
    {
        self.moveToBack()
    }
    
    func moveToBack()
    {
        UIView.animateWithDuration(0.2, delay: 0, options: [.CurveEaseInOut, .AllowUserInteraction], animations: { () -> Void in
            
            self.viewPreview.alpha = 1
            }) { (Bool) -> Void in
                
                UIView.animateWithDuration(0.3, delay: 0, options: [.CurveEaseInOut, .AllowUserInteraction], animations: { () -> Void in
                    
                    self.viewPreview.transform = self.transformPreview
                    self.viewPreview.center = self.ptPreviewCenter
                    
                    }) { (Bool) -> Void in
                        
                        self.navigationController?.popViewControllerAnimated(false)
                }
        }
    }
    
    @IBAction func actionSplashTakePhoto()
    {
        self.actionCamera(Int(SPLASH_IMAGE))
    }
    
    @IBAction func actionSplashChoosePhoto()
    {
        self.actionChoosePhoto(Int(SPLASH_IMAGE))
    }
    
    @IBAction func actionSplashSearchOnline()
    {
        
    }
    
    @IBAction func actionSplashUseDefault()
    {
        imgSplashView.image = AppDelegate().getDelegate().currentApper.imgDefault
    }
    
    @IBAction func actionBackgroundTakePhoto()
    {
        self.actionCamera(Int(BACKGROUND_IMAGE))
    }
    
    @IBAction func actionBackgroundChoosePhoto()
    {
        self.actionChoosePhoto(Int(BACKGROUND_IMAGE))
    }
    
    @IBAction func actionBackgroundSearchOnline()
    {
        
    }
    
    @IBAction func actionBackgroundUseDefault()
    {
        imgBackgroundView.image = AppDelegate().getDelegate().currentApper.imgDefault
    }
    
    func actionCamera(index: Int)
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
        {
            currentIndex = index
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func actionChoosePhoto(index: Int)
    {
        currentIndex = index
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone
        {
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?)
    {
        picker.dismissViewControllerAnimated(true, completion: nil)
        gotoImageCropViewController(image)
    }
    
    func gotoImageCropViewController(image: UIImage!)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cropView = storyboard.instantiateViewControllerWithIdentifier("ImageCropViewController") as! ImageCropViewController
        cropView.image = image
        cropView.delegate = self
        self.presentViewController(cropView, animated: true, completion: nil)
    }
    
    // implementation of the protocol of splash ratio view controller to get cropped image
    func imageCropViewControllerDidFinish(viewController: ImageCropViewController, image: UIImage, isIcon: Bool) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
        if(currentIndex == Int(SPLASH_IMAGE))
        {
            imgSplashView.image = image
        }
        else
        {
            imgBackgroundView.image = image
        }
    }
}
