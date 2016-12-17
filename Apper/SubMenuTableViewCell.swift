//
//  SubMenuTableViewCell.swift
//  Apper
//
//  Created by jian on 9/16/15.
//  Copyright © 2015 jinhu. All rights reserved.
//

import UIKit

@objc protocol SubMenuItemTableViewCellDelegate
{
    optional func deleteIcon(index: Int)
    optional func selectedSubMenuIcon(index: Int, cell: SubMenuTableViewCell)
}

class SubMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblIcon: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnDelete: TBAnimationButton!
    @IBOutlet weak var imgDeleteAnimView: UIImageView!
    @IBOutlet weak var imgEmpty: UIImageView!
    
    var transformIcon: CGAffineTransform!
    var delegate: SubMenuItemTableViewCellDelegate!
    var iconData: AppIcon!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        btnDelete.currentState = TBAnimationButtonState.Cross
        btnDelete.lineColor = UIColor(white: 1.0, alpha: 1.0)
        btnDelete.lineHeight = CGFloat(DELETE_LINE_HEGITH)
        btnDelete.backgroundColor = UIColor(white: 0, alpha: 0.5)
        btnDelete.layer.masksToBounds = true
        btnDelete.layer.cornerRadius = btnDelete.frame.width/2.0
        btnDelete.updateAppearance()
        btnDelete.hidden = true
        imgDeleteAnimView.hidden = true
        
        transformIcon = lblIcon.transform
        
        let tapSelect = UITapGestureRecognizer(target: self, action: Selector("actionSelect"))
        tapSelect.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapSelect)
        
        imgEmpty.image = UIImage(named: "empty.png")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateIcon (icon: AppIcon, color: UIColor, deleteMode: Bool)
    {
        self.iconData = icon
//        lblIcon.textColor = color
//        lblTitle.textColor = color
        backgroundColor = UIColor.clearColor()
        self.imgEmpty.layer.removeAllAnimations()
        
        if(iconData.isEmpty == true)
        {
            self.emptyUI()
            imgEmpty.image = imgEmpty.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            imgEmpty.tintColor = UIColor.whiteColor()
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
            lblIcon.alpha = 1
            lblTitle.alpha = 1
            
            lblIcon.text = icon.iconCode
            lblIcon.hidden = false
            lblTitle.text = icon.title
            lblTitle.hidden = false
            
            if(deleteMode == true)
            {
                btnDelete.hidden = false
                self.shakeIcon()
            }
            else
            {
                btnDelete.hidden = true
                self.stopShake()
            }
        }
    }
    
    func emptyUI()
    {
        btnDelete.hidden = true
        imgDeleteAnimView.hidden = true
        lblIcon.hidden = true
        
        imgEmpty.hidden = false
        imgEmpty.alpha = CGFloat(EMPTY_ICON_ALPHA)
        lblTitle.text = "Add"
        lblTitle.alpha = CGFloat(EMPTY_ICON_ALPHA)
        lblTitle.hidden = false
    }
    
    func shakeIcon ()
    {
        let offsetRadius = 0.05 as CGFloat
        
        UIView.animateWithDuration(0.1,
            delay: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.lblIcon.transform = CGAffineTransformRotate(self.transformIcon, offsetRadius)
                
            },
            completion: { (Bool) -> Void in
                
        })
        
        UIView.animateWithDuration(0.1,
            delay: 0.1,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.lblIcon.transform = CGAffineTransformRotate(self.transformIcon, -offsetRadius)
                
            },
            completion: { (flag: Bool) -> Void in
                
                if(flag == true)
                {
                    self.shakeIcon()
                }
                
        })
    }
    
    func stopShake()
    {
        lblIcon.layer.removeAllAnimations()
        lblIcon.transform = transformIcon
    }
    
    @IBAction func actionDelete()
    {
        imgDeleteAnimView.hidden = false
        lblTitle.hidden = true
        lblIcon.hidden = true
        btnDelete.hidden = true
        
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
        imgDeleteAnimView.layer.addAnimation(animation, forKey: "contents")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool)
    {
        delegate?.deleteIcon!(self.tag)
        self.emptyUI()
    }
    
    func actionSelect()
    {
        delegate?.selectedSubMenuIcon!(self.tag, cell: self)
    }
}
