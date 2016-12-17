//
//  MenuViewController.swift
//  Apper
//
//  Created by jian on 8/17/15.
//  Copyright © 2015 jinhu. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ImageCropViewControllerDelegate {

    @IBOutlet weak var swUsername: UISwitch!
    @IBOutlet weak var imgMedal1: UIImageView!
    @IBOutlet weak var imgMedal2: UIImageView!
    @IBOutlet weak var imgMedal3: UIImageView!
    @IBOutlet weak var imgMedal4: UIImageView!
    @IBOutlet weak var imgMedal5: UIImageView!
    @IBOutlet weak var imgMedal6: UIImageView!
    @IBOutlet weak var imgMedal7: UIImageView!
    @IBOutlet weak var imgMedal8: UIImageView!
    @IBOutlet weak var btnAvatar: UIButton!

    let imagePicker = UIImagePickerController()
    var existAvatar: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        swUsername.transform = CGAffineTransformScale(swUsername.transform, 0.8, 0.8)
        
        //Avatar.
        btnAvatar.layer.masksToBounds = true
        btnAvatar.layer.cornerRadius = btnAvatar.frame.width / 2.0
        imagePicker.delegate = self
        btnAvatar.layer.borderColor = UIColor.whiteColor().CGColor
        btnAvatar.layer.borderWidth = 5.0
        
        existAvatar = false
        let settings = NSUserDefaults.standardUserDefaults()
        if (settings.objectForKey("avatar") != nil) {
            let dataAvatar = settings.valueForKey("avatar") as! NSData
            btnAvatar.setImage(UIImage(data: dataAvatar), forState: UIControlState.Normal)
            existAvatar = true
        }
        
        //Medal.
        imgMedal1.userInteractionEnabled = true
        let gesture1 = UITapGestureRecognizer(target: self, action: Selector("selectedMedal1"))
        gesture1.numberOfTapsRequired = 1
        imgMedal1.addGestureRecognizer(gesture1)
        
        imgMedal2.userInteractionEnabled = true
        let gesture2 = UITapGestureRecognizer(target: self, action: Selector("selectedMedal2"))
        gesture2.numberOfTapsRequired = 1
        imgMedal2.addGestureRecognizer(gesture2)

        imgMedal3.userInteractionEnabled = true
        let gesture3 = UITapGestureRecognizer(target: self, action: Selector("selectedMedal3"))
        gesture3.numberOfTapsRequired = 1
        imgMedal3.addGestureRecognizer(gesture3)

        imgMedal4.userInteractionEnabled = true
        let gesture4 = UITapGestureRecognizer(target: self, action: Selector("selectedMedal4"))
        gesture4.numberOfTapsRequired = 1
        imgMedal4.addGestureRecognizer(gesture4)

        imgMedal5.userInteractionEnabled = true
        let gesture5 = UITapGestureRecognizer(target: self, action: Selector("selectedMedal5"))
        gesture5.numberOfTapsRequired = 1
        imgMedal5.addGestureRecognizer(gesture5)

        imgMedal6.userInteractionEnabled = true
        let gesture6 = UITapGestureRecognizer(target: self, action: Selector("selectedMedal6"))
        gesture6.numberOfTapsRequired = 1
        imgMedal6.addGestureRecognizer(gesture6)

        imgMedal7.userInteractionEnabled = true
        let gesture7 = UITapGestureRecognizer(target: self, action: Selector("selectedMedal7"))
        gesture7.numberOfTapsRequired = 1
        imgMedal7.addGestureRecognizer(gesture7)

        imgMedal8.userInteractionEnabled = true
        let gesture8 = UITapGestureRecognizer(target: self, action: Selector("selectedMedal8"))
        gesture8.numberOfTapsRequired = 1
        imgMedal8.addGestureRecognizer(gesture8)

    }
    
    func selectedMedal1()
    {
        imgMedal1.highlighted = !imgMedal1.highlighted
    }
    
    func selectedMedal2()
    {
        imgMedal2.highlighted = !imgMedal2.highlighted
    }
    
    func selectedMedal3()
    {
        imgMedal3.highlighted = !imgMedal3.highlighted
    }
    
    func selectedMedal4()
    {
        imgMedal4.highlighted = !imgMedal4.highlighted
    }
    
    func selectedMedal5()
    {
        imgMedal5.highlighted = !imgMedal5.highlighted
    }
    
    func selectedMedal6()
    {
        imgMedal6.highlighted = !imgMedal6.highlighted
    }
    
    func selectedMedal7()
    {
        imgMedal7.highlighted = !imgMedal7.highlighted
    }
    
    func selectedMedal8()
    {
        imgMedal8.highlighted = !imgMedal8.highlighted
    }
    
    @IBAction func actionAvatar()
    {
        let alert:UIAlertController=UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default)
            {
                UIAlertAction in
                self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.Default)
            {
                UIAlertAction in
                self.openGallary()
        }
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        
        if(existAvatar == true)
        {
            let removeAction = UIAlertAction(title: "Remove", style: UIAlertActionStyle.Destructive)
                {
                    UIAlertAction in
                    self.removePhoto()
            }
            alert.addAction(removeAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel)
            {
                UIAlertAction in
        }
        
        // Add the actions
        alert.addAction(cancelAction)
        
        // Present the actionsheet
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func removePhoto()
    {
        existAvatar = false
        let settings = NSUserDefaults.standardUserDefaults()
        settings.removeObjectForKey("avatar")
        settings.synchronize()
        
        btnAvatar.setImage(UIImage(named: "male user.png"), forState: UIControlState.Normal)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone
        {
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?)
    {
        picker .dismissViewControllerAnimated(true, completion: nil)
        
        gotoImageCropViewController(image)
    }
    
    func gotoImageCropViewController(image: UIImage!)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cropView = storyboard.instantiateViewControllerWithIdentifier("ImageCropViewController") as! ImageCropViewController
        cropView.image = image
        cropView.isIcon = true
        cropView.delegate = self
        self.presentViewController(cropView, animated: true, completion: nil)
    }
    
    func imageCropViewControllerDidFinish(viewController: ImageCropViewController, image: UIImage, isIcon: Bool) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
        btnAvatar.setImage(image, forState: UIControlState.Normal)
        existAvatar = true
        let settings = NSUserDefaults.standardUserDefaults()
        settings.setValue(UIImagePNGRepresentation(image), forKey: "avatar")
        settings.synchronize()
    }
}
