//
//  PublishView.swift
//  Apper
//
//  Created by jian on 9/17/15.
//  Copyright © 2015 jinhu. All rights reserved.
//

import UIKit

@objc protocol PublishViewDelegate
{
    optional func hidePublishView()
}


class PublishView: UIView
{
    @IBOutlet weak var viewDialog: UIView!
    @IBOutlet weak var btnView: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var viewFB: UIView!
    @IBOutlet weak var btnFB: UIButton!
    
    @IBOutlet weak var viewTwitter: UIView!
    @IBOutlet weak var btnTwitter: UIButton!
    
    @IBOutlet weak var viewWhatsapp: UIView!
    @IBOutlet weak var btnWhatsapp: UIButton!
    
    @IBOutlet weak var viewBusiness: UIView!
    @IBOutlet weak var btnBusiness: UIButton!
    
    var transformDialog: CGAffineTransform!
    var delegate: PublishViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        loadViewFromNib ()
    }
    
    func loadViewFromNib()
    {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "PublishView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(view);
        
        self.initMember()
    }
    
    
    func initMember()
    {
        viewDialog.layer.masksToBounds = true
        viewDialog.layer.cornerRadius = 10.0
        
        btnView.setBackgroundImage(self.imageWithColor(UIColor.whiteColor()), forState: UIControlState.Highlighted)
        btnSubmit.setBackgroundImage(self.imageWithColor(UIColor.whiteColor()), forState: UIControlState.Highlighted)
        
        btnFB.setBackgroundImage(self.imageWithColor(UIColor.whiteColor()), forState: UIControlState.Highlighted)
        btnTwitter.setBackgroundImage(self.imageWithColor(UIColor.whiteColor()), forState: UIControlState.Highlighted)
        btnWhatsapp.setBackgroundImage(self.imageWithColor(UIColor.whiteColor()), forState: UIControlState.Highlighted)
        btnBusiness.setBackgroundImage(self.imageWithColor(UIColor.whiteColor()), forState: UIControlState.Highlighted)
        
        let subRadius = CGFloat(5.0)
        viewFB.layer.masksToBounds = true
        viewFB.layer.cornerRadius = subRadius
        
        viewTwitter.layer.masksToBounds = true
        viewTwitter.layer.cornerRadius = subRadius

        viewWhatsapp.layer.masksToBounds = true
        viewWhatsapp.layer.cornerRadius = subRadius

        viewBusiness.layer.masksToBounds = true
        viewBusiness.layer.cornerRadius = subRadius

        viewDialog.layer.anchorPoint = CGPointMake(1.0, 0.0)
        viewDialog.frame = CGRectMake(viewDialog.frame.origin.x + viewDialog.frame.width/2.0, viewDialog.frame.origin.y - viewDialog.frame.height / 2, viewDialog.frame.width, viewDialog.frame.height)
        transformDialog = viewDialog.transform
        viewDialog.transform = CGAffineTransformScale(transform, 0.001, 0.001)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("hideDialog"))
        tapGesture.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapGesture)
    }
    
    func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRectMake(0.0, 0.0, 1.0, 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func showDialog()
    {
        UIView.animateWithDuration(0.1,
            animations: { () -> Void in
                
                self.viewDialog.transform = CGAffineTransformScale(self.transformDialog, 1.2, 1.2)
                
            }) { (Bool) -> Void in
                
                UIView.animateWithDuration(0.1,
                    animations: { () -> Void in
                        
                        self.viewDialog.transform = self.transformDialog
                        
                    }) { (Bool) -> Void in
                }
        }
    }
    
    func hideDialog()
    {
        UIView.animateWithDuration(0.1,
            animations: { () -> Void in
                
                self.viewDialog.transform = CGAffineTransformScale(self.transformDialog, 1.2, 1.2)
                
            }) { (Bool) -> Void in
                
                UIView.animateWithDuration(0.1,
                    animations: { () -> Void in
                        
                        self.viewDialog.transform = CGAffineTransformScale(self.transformDialog, 0.001, 0.001)
                        
                    }) { (Bool) -> Void in
                        
                        self.delegate?.hidePublishView!()
                }
        }
    }
    
    
    @IBAction func actionView()
    {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://mobile.igenapps.com")!)
    }
    
    @IBAction func actionSubmit()
    {

    }
    
    @IBAction func actionShare()
    {

    }
    
    @IBAction func actionFB()
    {
        
    }
    
    @IBAction func actionTwitter()
    {
        
    }
    
    @IBAction func actionWhatsapp()
    {
        let whatsappURL = NSURL(string: "Check out my App! http://mobile.igenapps.com I just did with @iGenApps") as NSURL!
        if(UIApplication.sharedApplication().canOpenURL(whatsappURL))
        {
            UIApplication.sharedApplication().openURL(whatsappURL)
        }
    }
    
    @IBAction func actionBusiness()
    {
        
    }
}
