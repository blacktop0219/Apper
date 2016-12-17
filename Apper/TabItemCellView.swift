//
//  TabItemCellView.swift
//  Apper
//
//  Created by jian on 9/11/15.
//  Copyright © 2015 jinhu. All rights reserved.
//

import UIKit

@objc protocol TabItemCellViewlDelegate
{
    optional func deleteIcon(index: Int)
    optional func selectedTabIcon(index: Int, cell: TabItemCellView)
}

class TabItemCellView: UIView {

    var view:UIView!;
    @IBOutlet weak var lblTabIcon: UILabel!
    @IBOutlet weak var lblTabTitle: UILabel!
    @IBOutlet weak var btnTabDelete: TBAnimationButton!
    @IBOutlet weak var imgTabDelete: UIImageView!
    @IBOutlet weak var imgEmpty: UIImageView!
    
    var transformTabIcon: CGAffineTransform!
    var rectFirst: CGRect!
    var tagFirst: Int!
    var iconData: AppIcon!
    var delegate: TabItemCellViewlDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
    }
    
    func loadViewFromNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "TabItemCellView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(view);
    }

    func initMember()
    {
        transformTabIcon = lblTabIcon.transform
        btnTabDelete.currentState = TBAnimationButtonState.Cross
        btnTabDelete.lineColor = UIColor(white: 1.0, alpha: 1.0)
        btnTabDelete.backgroundColor = UIColor(white: 0, alpha: 0.5)
        btnTabDelete.layer.masksToBounds = true
        btnTabDelete.lineHeight = CGFloat(DELETE_LINE_HEGITH)
        btnTabDelete.layer.cornerRadius = btnTabDelete.frame.width/2.0
        btnTabDelete.updateAppearance()
        btnTabDelete.hidden = true
        imgTabDelete.hidden = true
        
        lblTabIcon.font = UIFont(name: "iGenApps", size: 20)
        imgEmpty.image = UIImage(named: "empty.png")        
    }
    
    func updateIcon (icon: AppIcon, color: UIColor, deleteMode: Bool)
    {
        self.initMember()
        iconData = icon
        
        lblTabIcon.textColor = color
        lblTabTitle.textColor = color
        
        rectFirst = self.frame
        tagFirst = self.tag
        
        if(icon.isEmpty == true)
        {
            self.emptyUI()
            imgEmpty.image = imgEmpty.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            imgEmpty.tintColor = color
            UIView.animateWithDuration(EMPTY_SPIN_SPEED,
                delay: 0,
                options: [.Repeat, .CurveLinear], animations: { () -> Void in
                    
                    self.imgEmpty.transform = CGAffineTransformRotate(self.imgEmpty.transform, CGFloat(M_PI))
                    
                }) { (Bool) -> Void in
            }
        }
        else
        {
            imgEmpty.hidden = true
            lblTabIcon.alpha = 1
            lblTabTitle.alpha = 1

            lblTabIcon.text = icon.iconCode
            lblTabTitle.text = icon.title
            
            if(deleteMode == true)
            {
                btnTabDelete.hidden = false
                self.shakeTabIcon()
            }
            else
            {
                btnTabDelete.hidden = true
                self.stopTabShake()
            }
        }
    }
    
    func emptyUI()
    {
        btnTabDelete.hidden = true
        imgTabDelete.hidden = true
        lblTabIcon.hidden = true
        
        lblTabTitle.hidden = false
        
        imgEmpty.alpha = CGFloat(EMPTY_ICON_ALPHA)
        lblTabTitle.text = "Add"
        lblTabTitle.alpha = CGFloat(EMPTY_ICON_ALPHA)
    }
    
    func resetCell()
    {
        self.frame = rectFirst
        self.tag = tagFirst
    }
    
    func shakeTabIcon ()
    {
        self.stopTabShake()
        let offsetRadius = 0.05 as CGFloat
        
        UIView.animateWithDuration(0.1,
            delay: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.lblTabIcon.transform = CGAffineTransformRotate(self.transformTabIcon, offsetRadius)
                
            },
            completion: { (Bool) -> Void in
                
        })
        
        UIView.animateWithDuration(0.1,
            delay: 0.1,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.lblTabIcon.transform = CGAffineTransformRotate(self.transformTabIcon, -offsetRadius)
                
            },
            completion: { (flag: Bool) -> Void in
                
                if(flag == true)
                {
                    self.shakeTabIcon()
                }
                
        })
    }
    
    func stopTabShake()
    {
        self.lblTabIcon.layer.removeAllAnimations()
    }
    
    @IBAction func actionDelete()
    {
        imgTabDelete.hidden = false
        lblTabTitle.hidden = true
        lblTabIcon.hidden = true
        btnTabDelete.hidden = true
        
        var arrImages: [UIImage] = []
        for position in 1...5
        {
            let image  = UIImage(named: String(format: "delete_anim%02i.png", position))
            arrImages += [image!]
        }
        
        let animation = CAKeyframeAnimation(keyPath: "contents")
        animation.calculationMode = kCAAnimationDiscrete
        animation.duration = 0.3
        animation.values = arrImages.map {$0.CGImage as! AnyObject}
        animation.repeatCount = 1
        animation.removedOnCompletion = true
        animation.fillMode = kCAFillModeForwards
        animation.delegate = self
        imgTabDelete.layer.addAnimation(animation, forKey: "contents")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool)
    {
        delegate?.deleteIcon!(self.tag)
        self.emptyUI()
    }
    
    @IBAction func actionSelect()
    {
        delegate?.selectedTabIcon!(self.tag, cell: self)
    }

}
