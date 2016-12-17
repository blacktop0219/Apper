//
//  InfoViewController.swift
//  Apper
//
//  Created by jian on 8/25/15.
//  Copyright © 2015 jinhu. All rights reserved.
//

import UIKit

class InfoViewController: BaseViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, ImageCropViewControllerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewSplash: UIScrollView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnCategory: UIButton!
    @IBOutlet weak var lblStar1: UILabel!
    @IBOutlet weak var lblStar2: UILabel!
    @IBOutlet weak var lblStar3: UILabel!
    @IBOutlet weak var lblStar4: UILabel!
    @IBOutlet weak var lblStar5: UILabel!
    
    @IBOutlet weak var viewSplash: UIView!
    @IBOutlet weak var viewDescription: UIView!
    @IBOutlet weak var viewModalForPicker: UIView!
    
    @IBOutlet weak var lblInformation: UILabel!
    @IBOutlet weak var lblCreatorTitle: UILabel!
    @IBOutlet weak var lblCreatorName: UILabel!
    @IBOutlet weak var lblCategoryTitle: UILabel!
    @IBOutlet weak var lblUpdatedTitle: UILabel!
    @IBOutlet weak var lblUpdatedName: UILabel!
    @IBOutlet weak var lblVersionTitle: UILabel!
    @IBOutlet weak var lblVersionName: UILabel!
    @IBOutlet weak var lblLanguageTitle: UILabel!
    @IBOutlet weak var lblLanguageName: UILabel!
    
    @IBOutlet weak var imgIconView: UIImageView!
    @IBOutlet weak var imgIconRibben: UIImageView!
    @IBOutlet var imgSplashView: [UIImageView]!
    @IBOutlet weak var imgSplashRibben: UIImageView!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtCreatedBy: UITextField!
    @IBOutlet weak var txtCreator: UITextField!
    @IBOutlet weak var lblDescriptionTitle: UILabel!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var lblIconRibbenPurchase: UILabel!
    @IBOutlet weak var lblSplashRibbenPurchase: UILabel!
    @IBOutlet weak var viewMask: UIView!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var picker: UIPickerView!
    
    var isPickerShown = false
    var activeField: UITextField?
    
    var parentView: MakerViewController!
    var splashRatioController: ImageCropViewController!
    var rectTxtDesc: CGRect!
    let imagePicker = UIImagePickerController()
    var pickerArray: NSArray!
    var isSplashPicker = false
    var isLocked = true // it will get latest value later
    var isSplashLocked = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Init UI.
        let color = btnBack.currentTitleColor
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        self.setNeedsStatusBarAppearanceUpdate()
        
        
        let currentApper = AppDelegate().getDelegate().currentApper
        let imgIcon = currentApper.imgIcon
        let imgSplash = currentApper.imgSplash
        pickerArray = currentApper.appStoreCategories
        txtTitle.text = currentApper.appTitle
//        txtCategory.text = AppDelegate().getDelegate().currentApper.appCategory // not yet decided which text will be provided
//        txtDescription.text = AppDelegate().getDelegate().currentApper.appDescription
        self.checkDescription()
        
        //Star.
        lblStar1.font = UIFont(name: "iGenApps", size: 8)
        lblStar1.text = "\u{F13A}"
        lblStar2.font = UIFont(name: "iGenApps", size: 8)
        lblStar2.text = "\u{F13A}"
        lblStar3.font = UIFont(name: "iGenApps", size: 8)
        lblStar3.text = "\u{F13A}"
        lblStar4.font = UIFont(name: "iGenApps", size: 8)
        lblStar4.text = "\u{F13A}"
        lblStar5.font = UIFont(name: "iGenApps", size: 8)
        lblStar5.text = "\u{F13A}"
        btnDone.setTitleColor(color, forState: UIControlState.Normal)
        btnDone.layer.masksToBounds = true
        btnDone.layer.borderWidth = 1
        btnDone.layer.borderColor = color.CGColor
        btnDone.layer.cornerRadius = 3.0
        
        // by default splash view will be visible
        viewDescription.hidden = true
        
        // adjust the picker according to view
        viewModalForPicker.hidden = true
        picker.frame = CGRectMake(0, view.frame.height, picker.frame.width, picker.frame.height)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name:UIKeyboardWillHideNotification, object: nil)
        
//        btnDone.setTitleColor(color, forState: UIControlState.Normal)
//        btnBack.setTitleColor(color, forState: UIControlState.Normal)
        
//        [("4:5", 4/5), ("3:4", 3/4), ("2:3", splashDestRatio), ("10:16", 10/16), ("9:16", 9/16)]
        
        if(imgIcon != nil)
        {
            imgIconView.image = imgIcon
        }
        if(imgSplash != nil)
        {
            isLocked = false // unlock icon and splash
            addImageToSplashViews(imgSplash)
        }
        
        imagePicker.delegate = self
        imgIconView.layer.cornerRadius = 20
        imgIconView.layer.masksToBounds = true
        imgIconView.layer.borderWidth = 1
        imgIconView.layer.borderColor = UIColor.lightGrayColor().CGColor
        imgIconView.userInteractionEnabled = true
        
        let deg: CGFloat = 45
        let rad: CGFloat = CGFloat(M_PI)*deg/180.0
        lblIconRibbenPurchase.transform = CGAffineTransformRotate(lblIconRibbenPurchase.transform, rad)
        lblSplashRibbenPurchase.transform = CGAffineTransformRotate(lblSplashRibbenPurchase.transform, rad)
        
        if isLocked == false {
            unlockIconAndSplash()
        }
        
        scrollViewSplash.contentSize = CGSize(width: 951, height: scrollViewSplash.frame.height)
        
        let gestureIcon = UITapGestureRecognizer(target: self, action: Selector("actionIcon"))
        gestureIcon.numberOfTouchesRequired = 1
        imgIconView.addGestureRecognizer(gestureIcon)
        
        for view in imgSplashView {
            let gestureSplash = UITapGestureRecognizer(target: self, action: Selector("actionSplash"))
            gestureSplash.numberOfTouchesRequired = 1
            view.addGestureRecognizer(gestureSplash)
        }
        
        let gesture = UITapGestureRecognizer(target: self, action: Selector("hideKeyboard"))
        gesture.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(gesture)
        
//        rectTxtDesc = txtDescription.frame
        viewMask.hidden = false
        viewMask.alpha = 1
        viewMask.frame = CGRectMake(viewMask.frame.origin.x, 0, viewMask.frame.width, viewMask.frame.height)
        UIView.animateWithDuration(0.2, delay: 0.2, options: [.CurveEaseInOut, .AllowUserInteraction], animations: { () -> Void in
            
            self.viewMask.alpha = 0
            
            }) { (Bool) -> Void in
        }
        
        /*
        // DEBUG shortcut
        if AppDelegate().getDelegate().DEBUG {
            let image = UIImage(named: "intro_bg.jpg")
            self.gotoImageCropViewController(image)
        }
        */
    }

    //MARK: UITextField Delegate.
    func hideKeyboard()
    {
        txtTitle.resignFirstResponder()
        txtCreatedBy.resignFirstResponder()
        txtCreator.resignFirstResponder()
        txtDescription.resignFirstResponder()
    }
    
    func unlockIconAndSplash()
    {
        scrollViewSplash.scrollEnabled = true
        imgIconRibben.hidden = true
        lblIconRibbenPurchase.hidden = true
        imgSplashRibben.hidden = true
        lblSplashRibbenPurchase.hidden = true
    }
    
    func keyboardWillShow(notification:NSNotification){
        
        // its a description textview
        if activeField == nil {
            var userInfo = notification.userInfo!
            var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
            keyboardFrame = self.view.convertRect(keyboardFrame, fromView: nil)
            
            var contentInset:UIEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
            contentInset.top -= keyboardFrame.size.height
            print(contentInset)
            self.scrollView.contentInset = contentInset
            self.scrollView.scrollEnabled = true
        }
    }
    
    func keyboardWillHide(notification:NSNotification){
        
        let contentInset:UIEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        self.scrollView.contentInset = contentInset
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        activeField = textField
    }
    
    func textFieldDidEndEditing(textField: UITextField)
    {
        activeField = nil
        
        if(textField == txtTitle)
        {
            AppDelegate().getDelegate().currentApper.appTitle = txtTitle.text
        }
        else if(textField == txtCreatedBy)
        {
//            AppDelegate().getDelegate().currentApper.appCategory = txtCreatedBy.text
        }
    }
    
    //MARK: UITextView Delegate.
    func textViewDidChange(textView: UITextView)
    {
        self.checkDescription()
        AppDelegate().getDelegate().currentApper.appDescription = txtDescription.text
    }
    
    func checkDescription()
    {
//        var title = txtDescription.text as String!
        if(title == nil || title?.characters.count == 0)
        {
//            lblDescriptionTitle.hidden = true
//            lblDescriptionPlaceHolder.hidden = false
        }
        else
        {
//            lblDescriptionTitle.hidden = false
//            lblDescriptionPlaceHolder.hidden = true
        }
    }
    
    func textViewDidBeginEditing(textView: UITextView)
    {
        UIView.animateWithDuration(0.25, delay: 0, options: [.CurveEaseInOut, .AllowUserInteraction], animations: { () -> Void in
            
//            self.txtDescription.frame = CGRectMake(self.rectTxtDesc.origin.x, self.rectTxtDesc.origin.y, self.rectTxtDesc.width, self.rectTxtDesc.height - 240.0)
            
            }) { (Bool) -> Void in
                
        }
    }
    
    func textViewDidEndEditing(textView: UITextView)
    {
        UIView.animateWithDuration(0.25, delay: 0, options: [.CurveEaseInOut, .AllowUserInteraction], animations: { () -> Void in
            
//            self.txtDescription.frame = self.rectTxtDesc
            
            }) { (Bool) -> Void in
                
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    // Picker functions
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (pickerArray[row] as! String)
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        btnCategory.setTitle((pickerArray[row] as! String), forState: UIControlState.Normal)
        if isPickerShown {
            UIView.animateWithDuration(0.5, animations: {
                self.picker.frame = CGRectMake(0, self.view.frame.height, self.picker.frame.width, self.picker.frame.height)
                self.viewModalForPicker.hidden = true
                self.isPickerShown = false
            })
        }
    }
    
    //MARK: Actions.
    @IBAction func actionDone(sender: AnyObject)
    {
        viewMask.backgroundColor = UIColor(red: 253.0/255.0, green: 130/255.0, blue: 12.0/255.0, alpha: 1.0)
        viewMask.alpha = 1
        
        let radius = 8.0 as CGFloat
        viewMask.frame = CGRectMake(btnDone.frame.origin.x + (btnDone.frame.width - 8)/2.0,
            btnDone.frame.origin.y + (btnDone.frame.height - 8)/2.0,
            radius, radius)
        viewMask.layer.masksToBounds = true
        viewMask.layer.cornerRadius = 2 //radius / 2.0
        UIView.animateWithDuration(0.2, delay: 0, options: [.CurveEaseInOut, .AllowUserInteraction], animations: { () -> Void in
         
                self.viewMask.transform = CGAffineTransformScale(self.viewMask.transform, 200, 200)
            
            }) { (Bool) -> Void in
                
                self.parentView.openMainView()
                self.navigationController?.popViewControllerAnimated(false)
        }
    }
    
    @IBAction func actionBack(sender: AnyObject)
    {
        viewMask.backgroundColor = UIColor(red: 253.0/255.0, green: 130/255.0, blue: 12.0/255.0, alpha: 1.0)
        viewMask.alpha = 1
        
        let radius = 8.0 as CGFloat
        viewMask.frame = CGRectMake(btnBack.frame.origin.x + (btnBack.frame.width - 8)/2.0,
            btnBack.frame.origin.y + (btnBack.frame.height - 8)/2.0,
            radius, radius)
        viewMask.layer.masksToBounds = true
        viewMask.layer.cornerRadius = 2 //radius / 2.0
        UIView.animateWithDuration(0.2, delay: 0, options: [.CurveEaseInOut, .AllowUserInteraction], animations: { () -> Void in
            
            self.viewMask.transform = CGAffineTransformScale(self.viewMask.transform, 200, 200)
            
            }) { (Bool) -> Void in
                
                self.parentView.openMainView()
                self.navigationController?.popViewControllerAnimated(false)
        }
    }
    
    @IBAction func actionMenu(sender: AnyObject)
    {
        self.menuContainerViewController.toggleRightSideMenuCompletion{ () -> Void in
            
        }
    }
    
    @IBAction func actionCategory(sender: AnyObject) {
        txtTitle.resignFirstResponder()
        txtCreatedBy.resignFirstResponder()
        txtCreator.resignFirstResponder()
        txtDescription.resignFirstResponder()
        if isPickerShown == false {
            isPickerShown = true
            viewModalForPicker.hidden = false
            UIView.animateWithDuration(0.5, animations: {
                self.picker.frame = CGRectMake(0, self.view.frame.height - self.picker.frame.height, self.picker.frame.width, self.picker.frame.height)
            })
        }
        
    }
    
    
    @IBAction func actionToggleButton(sender: UISegmentedControl, forEvent event: UIEvent) {
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            viewDescription.hidden = true
            viewSplash.hidden = false
        case 1:
            viewDescription.hidden = false
            viewSplash.hidden = true
        default:
            break; 
        }
    }
    
    //MARK: Icon.
    func actionSplash()
    {
        isSplashPicker = true
        let imgSplash = AppDelegate().getDelegate().currentApper.imgSplash
        if isLocked == false {
            createAlert(imgSplash != nil)
        } else {
            purchaseAlert({ (result: Bool) in
                if result {
                    self.isLocked = false
                    self.unlockIconAndSplash()
                    self.createAlert(imgSplash != nil)
                }
            })
        }
    }
    
    func actionIcon()
    {
        isSplashPicker = false
        let imgIcon = AppDelegate().getDelegate().currentApper.imgIcon
        if isLocked == false {
            createAlert(imgIcon != nil)
        } else {
            purchaseAlert({ (result: Bool) in
                if result {
                    self.unlockIconAndSplash()
                    self.createAlert(imgIcon != nil)
                }
            })
        }
       
    }
    
    func purchaseAlert(onComplete: (result: Bool)->Void)
    {
        let alert:UIAlertController=UIAlertController(title: "Purchase!", message: "Do you want to purchase Icon and Splash for $0.99?", preferredStyle: UIAlertControllerStyle.Alert)
        let yes = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default)
            {
                UIAlertAction in
                onComplete(result: true)
        }
        let no = UIAlertAction(title: "No", style: UIAlertActionStyle.Default)
            {
                UIAlertAction in
                onComplete(result: false)
        }
        alert.addAction(yes)
        alert.addAction(no)
        
        // Present the actionsheet
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // It will be globally used function for all kind of image selection, It can be updated later
    func createAlert(enableRemoveButton: Bool)
    {
        let alert:UIAlertController=UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let gallaryAction = UIAlertAction(title: "Choose from Library", style: UIAlertActionStyle.Default)
            {
                UIAlertAction in
                self.openGallary()
        }
        let chooseFromWebAction = UIAlertAction(title: "Choose from Web", style: UIAlertActionStyle.Default)
            {
                UIAlertAction in
                // code to fatch web image
        }
        let cameraAction = UIAlertAction(title: "Take Photo", style: UIAlertActionStyle.Default)
            {
                UIAlertAction in
                self.openCamera()
        }
        alert.addAction(gallaryAction)
        alert.addAction(chooseFromWebAction)
        alert.addAction(cameraAction)
        
        if(enableRemoveButton)
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
        if isSplashPicker {
            AppDelegate().getDelegate().currentApper.imgSplash = nil
            addImageToSplashViews(nil)
        } else {
            AppDelegate().getDelegate().currentApper.imgIcon = nil
            imgIconView.image = UIImage(named: "app_icon.png")
        }
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
        cropView.isIcon = !isSplashPicker
        cropView.delegate = self
        self.presentViewController(cropView, animated: true, completion: nil)
    }
    
    // implementation of the protocol of splash ratio view controller to get cropped image
    func imageCropViewControllerDidFinish(viewController: ImageCropViewController, image: UIImage, isIcon: Bool) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
        if isIcon {
            imgIconView.image = image
            AppDelegate().getDelegate().currentApper.imgIcon = image
        } else {
            addImageToSplashViews(image)
            AppDelegate().getDelegate().currentApper.imgSplash = image
        }
    }
    
    func addImageToSplashViews(image: UIImage!)
    {
        for view in imgSplashView {
            view.image = image
        }
    }
}
