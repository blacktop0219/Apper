//
//  IconTableViewCell.swift
//  Apper
//
//  Created by jian on 8/14/15.
//  Copyright © 2015 jinhu. All rights reserved.
//

import UIKit
import QuartzCore

@objc protocol IconTableViewCellDelegate
{
    optional func selectedIcon()
    optional func longPressedIcon()
}

class IconTableViewCell: UITableViewCell
{
    var delegate: IconTableViewCellDelegate!
    
    @IBOutlet weak var viewIcon1: UIView!
    @IBOutlet weak var btnDelete1: TBAnimationButton!
    @IBOutlet weak var imgIcon1: UIImageView!
    
    @IBOutlet weak var viewIcon2: UIView!
    @IBOutlet weak var btnDelete2: TBAnimationButton!
    @IBOutlet weak var imgIcon2: UIImageView!
    
    @IBOutlet weak var viewIcon3: UIView!
    @IBOutlet weak var btnDelete3: TBAnimationButton!
    @IBOutlet weak var imgIcon3: UIImageView!
    
    @IBOutlet weak var viewIcon4: UIView!
    @IBOutlet weak var btnDelete4: TBAnimationButton!
    @IBOutlet weak var imgIcon4: UIImageView!
    
    var ptIcon1Center : CGPoint!
    var ptIcon2Center : CGPoint!
    var ptIcon3Center : CGPoint!
    var ptIcon4Center : CGPoint!
    
    var transform1: CGAffineTransform!
    var transform2: CGAffineTransform!
    var transform3: CGAffineTransform!
    var transform4: CGAffineTransform!
    
    var shaking: Bool!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.shaking = false
        let holdDuration = 2 as CFTimeInterval

        //Icon 1.
        btnDelete1.currentState = TBAnimationButtonState.Cross
        btnDelete1.lineColor = UIColor.whiteColor()
        btnDelete1.layer.masksToBounds = true
        btnDelete1.layer.cornerRadius = btnDelete1.frame.width/2.0
        btnDelete1.updateAppearance()
        btnDelete1.hidden = true
        
        imgIcon1.clipsToBounds = false
        imgIcon1.layer.cornerRadius = 12
        imgIcon1.layer.borderWidth = 0.5
        imgIcon1.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        let gesture1 = UITapGestureRecognizer(target: self, action: Selector("actionSelect:"))
        gesture1.numberOfTouchesRequired = 1
        viewIcon1.addGestureRecognizer(gesture1)
        
        let longPressGesture1 = UILongPressGestureRecognizer(target: self, action: Selector("actionLongPress:"))
        longPressGesture1.minimumPressDuration = holdDuration
        viewIcon1.addGestureRecognizer(longPressGesture1)
        
        //Icon 2.
        btnDelete2.currentState = TBAnimationButtonState.Cross
        btnDelete2.lineColor = UIColor.whiteColor()
        btnDelete2.layer.masksToBounds = true
        btnDelete2.layer.cornerRadius = btnDelete2.frame.width/2.0
        btnDelete2.updateAppearance()
        btnDelete2.hidden = true

        imgIcon2.clipsToBounds = false
        imgIcon2.layer.cornerRadius = 12
        imgIcon2.layer.borderWidth = 0.5
        imgIcon2.layer.borderColor = UIColor.lightGrayColor().CGColor

        let gesture2 = UITapGestureRecognizer(target: self, action: Selector("actionSelect:"))
        gesture2.numberOfTouchesRequired = 1
        viewIcon2.addGestureRecognizer(gesture2)
        
        let longPressGesture2 = UILongPressGestureRecognizer(target: self, action: Selector("actionLongPress:"))
        longPressGesture2.minimumPressDuration = holdDuration
        viewIcon2.addGestureRecognizer(longPressGesture2)
        
        //Icon 3.
        btnDelete3.currentState = TBAnimationButtonState.Cross
        btnDelete3.lineColor = UIColor.whiteColor()
        btnDelete3.layer.masksToBounds = true
        btnDelete3.layer.cornerRadius = btnDelete3.frame.width/2.0
        btnDelete3.updateAppearance()
        btnDelete3.hidden = true
        
        imgIcon3.clipsToBounds = false
        imgIcon3.layer.cornerRadius = 12
        imgIcon3.layer.borderWidth = 0.5
        imgIcon3.layer.borderColor = UIColor.lightGrayColor().CGColor

        let gesture3 = UITapGestureRecognizer(target: self, action: Selector("actionSelect:"))
        gesture3.numberOfTouchesRequired = 1
        viewIcon3.addGestureRecognizer(gesture3)

        let longPressGesture3 = UILongPressGestureRecognizer(target: self, action: Selector("actionLongPress:"))
        longPressGesture3.minimumPressDuration = holdDuration
        viewIcon3.addGestureRecognizer(longPressGesture3)
        
        //Icon 4.
        btnDelete4.currentState = TBAnimationButtonState.Cross
        btnDelete4.lineColor = UIColor.whiteColor()
        btnDelete4.layer.masksToBounds = true
        btnDelete4.layer.cornerRadius = btnDelete4.frame.width/2.0
        btnDelete4.updateAppearance()
        btnDelete4.hidden = true
        
        imgIcon4.clipsToBounds = false
        imgIcon4.layer.cornerRadius = 12
        imgIcon4.layer.borderWidth = 0.5
        imgIcon4.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        let gesture4 = UITapGestureRecognizer(target: self, action: Selector("actionSelect:"))
        gesture4.numberOfTouchesRequired = 1
        viewIcon4.addGestureRecognizer(gesture4)
        
        let longPressGesture4 = UILongPressGestureRecognizer(target: self, action: Selector("actionLongPress:"))
        longPressGesture4.minimumPressDuration = holdDuration
        viewIcon4.addGestureRecognizer(longPressGesture4)
        
        ptIcon1Center = viewIcon1.center
        ptIcon2Center = viewIcon2.center
        ptIcon3Center = viewIcon3.center
        ptIcon4Center = viewIcon4.center
        
        transform1 = viewIcon1.transform
        transform2 = viewIcon2.transform
        transform3 = viewIcon3.transform
        transform4 = viewIcon4.transform
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func zoomIcons(index: Int)
    {
        let zoomRate = 1.2 as CGFloat!
        let interval = 0.1
        var delay = Double(Double(index) * interval * 4)
        
        UIView.animateWithDuration(interval * 1.5,
            delay: delay,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewIcon1.transform = CGAffineTransformScale(self.transform1, zoomRate, zoomRate)
                
            }) {(flag: Bool) -> Void in
                
                if(flag == true)
                {
                    UIView.animateWithDuration(interval * 0.5,
                        delay: 0,
                        options: [.CurveEaseInOut, .AllowUserInteraction],
                        animations: { () -> Void in
                            
                            self.viewIcon1.transform = self.transform1
                            
                        }) {(Bool) -> Void in
                    }
                }
        }

        delay += interval
        UIView.animateWithDuration(interval * 1.5,
            delay: delay,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewIcon2.transform = CGAffineTransformScale(self.transform1, zoomRate, zoomRate)
                
            }) {(flag: Bool) -> Void in
                if(flag == true)
                {
                    UIView.animateWithDuration(interval * 0.5,
                        delay: 0,
                        options: [.CurveEaseInOut, .AllowUserInteraction],
                        animations: { () -> Void in
                            
                            self.viewIcon2.transform = self.transform2
                            
                        }) {(Bool) -> Void in
                    }
                }
        }

        delay += interval
        UIView.animateWithDuration(interval * 1.5,
            delay: delay,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewIcon3.transform = CGAffineTransformScale(self.transform3, zoomRate, zoomRate)
                
            }) {(flag: Bool) -> Void in
                if(flag == true)
                {
                    UIView.animateWithDuration(interval * 0.5,
                        delay: 0,
                        options: [.CurveEaseInOut, .AllowUserInteraction],
                        animations: { () -> Void in
                            
                            self.viewIcon3.transform = self.transform3
                            
                        }) {(Bool) -> Void in
                    }
                }
        }
        
        delay += interval
        UIView.animateWithDuration(interval * 1.5,
            delay: delay,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewIcon4.transform = CGAffineTransformScale(self.transform4, zoomRate, zoomRate)
                
            }) {(flag: Bool) -> Void in
                if(flag == true)
                {
                    UIView.animateWithDuration(interval * 0.5,
                        delay: 0,
                        options: [.CurveEaseInOut, .AllowUserInteraction],
                        animations: { () -> Void in
                            
                            self.viewIcon4.transform = self.transform4
                            
                        }) {(Bool) -> Void in
                    }
                }
        }
    }
    
    func updateAppIcon (deleteStatus: Bool, animateFlag: Bool)
    {
        if(animateFlag == false)
        {
            viewIcon1.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
            viewIcon2.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
            viewIcon3.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
            viewIcon4.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
        }
        
        //Shake.
        if(deleteStatus == true)
        {
            if(self.shaking == true) { return }
                
            self.shaking = true
            let offsetX = 1 as CGFloat
            let offsetRadius = 0.02 as CGFloat
            
            self.viewIcon1.center = CGPointMake(ptIcon1Center.x - offsetX, self.ptIcon1Center.y)
            self.viewIcon1.transform = CGAffineTransformRotate(self.viewIcon1.transform, -offsetRadius)
            self.btnDelete1.hidden = false
            
            self.viewIcon2.center = CGPointMake(ptIcon2Center.x - offsetX, ptIcon2Center.y)
            self.viewIcon2.transform = CGAffineTransformRotate(self.viewIcon2.transform, -offsetRadius)
            self.btnDelete2.hidden = false
            
            self.viewIcon3.center = CGPointMake(ptIcon3Center.x - offsetX, ptIcon3Center.y)
            self.viewIcon3.transform = CGAffineTransformRotate(self.viewIcon3.transform, -offsetRadius)
            self.btnDelete3.hidden = false
            
            self.viewIcon4.center = CGPointMake(ptIcon4Center.x - offsetX, ptIcon4Center.y)
            self.viewIcon4.transform = CGAffineTransformRotate(self.viewIcon4.transform, -offsetRadius)
            self.btnDelete4.hidden = false
            
            self.shakeIcon()
        }
        else
        {
            self.shaking = false
            
            self.viewIcon1.layer.removeAllAnimations()
            self.btnDelete1.hidden = true
            
            self.viewIcon2.layer.removeAllAnimations()
            self.btnDelete2.hidden = true

            self.viewIcon3.layer.removeAllAnimations()
            self.btnDelete3.hidden = true
            
            self.viewIcon4.layer.removeAllAnimations()
            self.btnDelete4.hidden = true
        }
    }
    
    func shakeIcon ()
    {
        if(self.shaking == false){ return }
        
        let offsetX = 1 as CGFloat
        let offsetRadius = 0.02 as CGFloat
        
        UIView.animateWithDuration(0.1,
            delay: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewIcon1.center = CGPointMake(self.ptIcon1Center.x + offsetX, self.ptIcon1Center.y)
                self.viewIcon1.transform = CGAffineTransformRotate(self.transform1, offsetRadius)
                
                self.viewIcon2.center = CGPointMake(self.ptIcon2Center.x + offsetX, self.ptIcon2Center.y)
                self.viewIcon2.transform = CGAffineTransformRotate(self.transform2, offsetRadius)
                
                self.viewIcon3.center = CGPointMake(self.ptIcon3Center.x + offsetX, self.ptIcon3Center.y)
                self.viewIcon3.transform = CGAffineTransformRotate(self.transform3, offsetRadius)
                
                self.viewIcon4.center = CGPointMake(self.ptIcon4Center.x + offsetX, self.ptIcon4Center.y)
                self.viewIcon4.transform = CGAffineTransformRotate(self.transform4, offsetRadius)
                
            },
            completion: { (Bool) -> Void in

        })
        
        UIView.animateWithDuration(0.1,
            delay: 0.1,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewIcon1.center = CGPointMake(self.ptIcon1Center.x - offsetX, self.ptIcon1Center.y)
                self.viewIcon1.transform = CGAffineTransformRotate(self.transform1, -offsetRadius)
                
                self.viewIcon2.center = CGPointMake(self.ptIcon2Center.x - offsetX, self.ptIcon2Center.y)
                self.viewIcon2.transform = CGAffineTransformRotate(self.transform2, -offsetRadius)
                
                self.viewIcon3.center = CGPointMake(self.ptIcon3Center.x - offsetX, self.ptIcon3Center.y)
                self.viewIcon3.transform = CGAffineTransformRotate(self.transform3, -offsetRadius)
                
                self.viewIcon4.center = CGPointMake(self.ptIcon4Center.x - offsetX, self.ptIcon4Center.y)
                self.viewIcon4.transform = CGAffineTransformRotate(self.transform4, -offsetRadius)
                
            },
            completion: { (Bool) -> Void in
                
                self.shakeIcon()
        })
    }
    
    
    func actionSelect(sender: AnyObject)
    {
        delegate?.selectedIcon!()
    }
    
    func actionLongPress(sender: AnyObject)
    {
        delegate?.longPressedIcon!()
    }
}
