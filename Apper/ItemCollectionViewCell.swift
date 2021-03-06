//
//  ItemCollectionViewCell.swift
//  Apper
//
//  Created by jian on 8/19/15.
//  Copyright © 2015 jinhu. All rights reserved.
//

import UIKit

@objc protocol ItemCollectionViewCellDelegate
{
    optional func deleteIcon(index: Int)
}

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblIcon: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnDelete: TBAnimationButton!
    @IBOutlet weak var imgDeleteAnimView: UIImageView!
    @IBOutlet weak var imgEmpty: UIImageView!
    
    var transformIcon: CGAffineTransform!
    var delegate: ItemCollectionViewCellDelegate!
    var iconData: AppIcon!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lblIcon.font = UIFont(name: "iGenApps", size: 40)
        
        btnDelete.currentState = TBAnimationButtonState.Cross
        btnDelete.lineColor = UIColor(white: 1.0, alpha: 1.0)
        btnDelete.backgroundColor = UIColor(white: 0, alpha: 0.5)
        btnDelete.lineHeight = CGFloat(DELETE_LINE_HEGITH)        
        btnDelete.layer.masksToBounds = true
        btnDelete.layer.cornerRadius = btnDelete.frame.width/2.0
        btnDelete.updateAppearance()
        btnDelete.hidden = true
        imgDeleteAnimView.hidden = true
        
        transformIcon = self.transform
        imgEmpty.image = UIImage(named: "empty.png")
    }

    func updateIcon(appIcon: AppIcon, deleteMode: Bool, color: UIColor)
    {
        iconData = appIcon
        
        lblIcon.textColor = color
        lblTitle.textColor = color
        
        self.imgEmpty.layer.removeAllAnimations()
        if(appIcon.isEmpty == true)
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
            
            lblIcon.alpha = 1
            lblTitle.alpha = 1
            lblIcon.text = appIcon.iconCode
            lblIcon.hidden = false
            
            lblTitle.text = appIcon.title
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
        lblTitle.hidden = false
        lblTitle.text = "Add"
        lblTitle.alpha = CGFloat(EMPTY_ICON_ALPHA)
    }
    
    func shakeIcon ()
    {
        let offsetRadius = 0.02 as CGFloat
        
        UIView.animateWithDuration(0.1,
            delay: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.transform = CGAffineTransformRotate(self.transformIcon, offsetRadius)

            },
            completion: { (Bool) -> Void in
                
        })
        
        UIView.animateWithDuration(0.1,
            delay: 0.1,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.transform = CGAffineTransformRotate(self.transformIcon, -offsetRadius)

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
        self.layer.removeAllAnimations()
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
}
