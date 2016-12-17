

//
//  MakerViewController.swift
//  Apper
//
//  Created by jian on 8/19/15.
//  Copyright © 2015 jinhu. All rights reserved.
//

import UIKit

class MakerViewController: BaseViewController, RAReorderableLayoutDelegate, RAReorderableLayoutDataSource, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, ItemCollectionViewCellDelegate, ListItemTableViewCellDelegate, TabItemCellViewlDelegate, SubMenuItemTableViewCellDelegate, PublishViewDelegate
{
    @IBOutlet weak var viewOrangeMask: UIView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var imgMaskView: UIImageView!
    @IBOutlet weak var viewWhiteOverlay: UIView!
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var viewFloating: UIView!
    @IBOutlet weak var sliderColor: UISlider!
    @IBOutlet weak var imgSliderBar: UIImageView!
    @IBOutlet weak var viewOverlayMask: UIView!
    @IBOutlet weak var tblFont: UITableView!
    
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var viewIconBar: UIView!
    @IBOutlet weak var viewImages: UIView!
    @IBOutlet weak var viewMenu: UIView!
    @IBOutlet weak var viewInfo: UIView!
    @IBOutlet weak var viewPreview: UIView!
    @IBOutlet weak var viewPublish: UIView!
    
    //Menu Style.
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tblList: UITableView!
    
    //Tab
    @IBOutlet weak var viewTab: UIView!
    @IBOutlet weak var viewTabBg: UIView!
    @IBOutlet weak var scrollTab: UIScrollView!
    
    //Side.
    @IBOutlet weak var viewSideBar: UIView!
    @IBOutlet weak var viewSideLeft: UIView!
    @IBOutlet weak var viewSideRight: UIView!
    @IBOutlet weak var imgSideRigtView: UIImageView!
    @IBOutlet weak var tblSideView: UITableView!
    
    var arrItems : NSMutableArray!
    var arrFonts: NSArray!
    var arrTabCells: NSMutableArray!
    
    var imgMain: UIImage!
    
    var rectTop: CGRect!
    var rectFloating: CGRect!
    var openTopBar: Bool!
    var colorMode: Int!
    var titleString: String!
    var titleTransform: CGAffineTransform!
    var openFloatingIcons: Bool!
    var ptTitleCenter: CGPoint!
    
    //Publish.
    var viewBlurBg: SVBlurView!
    var viewPublishDialog: PublishView!
    
    //Moving.
    var snapshot: UIView!                   ///< A snapshot of the row user is moving.
    var sourceIndexPath: NSIndexPath!        ///< Initial index path, where gesture begins.
    var tabMovingCell: UIView!
    
    var deleteMode: Bool!
    
    //MARK: Init.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deleteMode = false
        openFloatingIcons = false
        openTopBar = false
        titleString = txtTitle.text
        titleTransform = txtTitle.transform
        
        let category = AppDelegate().getDelegate().currentApper.category as Int!
        let arrIcons = AppDelegate().getDelegate().currentApper.arrIcons as NSArray!
        
        arrItems = NSMutableArray()
        arrItems.addObjectsFromArray(arrIcons.objectAtIndex(category) as! [AnyObject])
        
        // only one "Add" icon is allowed
        let icon = AppIcon()
        arrItems.addObject(icon)
        
        /*
        if(arrItems.count < Int(MAX_ICON_COUNT))
        {
            let offset = (Int(MAX_ICON_COUNT) - arrItems.count)
            
            for var i = 0; i < offset; i++
            {
                let icon = AppIcon()
                arrItems.addObject(icon)
            }
        }
        */
        
        arrTabCells = NSMutableArray()
        
        self.checkMenuStyle()
        
        
        /*
        let actualHeightOfNavBar = viewTop.bounds.height
        var newHeight = viewTop.bounds.height
        
        
        // To get adoptive height effect for iph6/6s
        newHeight = 57
        
        // To get adoptive height effect for iph6+/6s+
//        newHeight = 50
        
        let scalingFactorForNavBarHeight = newHeight/actualHeightOfNavBar
        
        let yFactor = (actualHeightOfNavBar - newHeight)/2
        print("yFactor", yFactor)
        
        // update nav bar according to new calculated height
        viewTop.bounds = CGRectMake(viewTop.bounds.origin.x, -10, viewTop.bounds.width, viewTop.bounds.height * newHeight/actualHeightOfNavBar)
        txtTitle.bounds = CGRectMake(txtTitle.bounds.origin.x, txtTitle.bounds.origin.y*scalingFactorForNavBarHeight, txtTitle.bounds.width, txtTitle.bounds.height)
        btnMore.bounds = CGRectMake(btnMore.bounds.origin.x, btnMore.bounds.origin.y*scalingFactorForNavBarHeight, btnMore.bounds.width, btnMore.bounds.height)
        btnBack.bounds = CGRectMake(btnBack.bounds.origin.x, btnBack.bounds.origin.y*scalingFactorForNavBarHeight, btnBack.bounds.width, btnBack.bounds.height)
//
        */
        
        //Add Tap Gestures.
        let gestureNavBar = UITapGestureRecognizer(target: self, action: Selector("actionTopBar"))
        gestureNavBar.numberOfTouchesRequired = 1
        viewTop.addGestureRecognizer(gestureNavBar)
        
        let gestureMain = UITapGestureRecognizer(target: self, action: Selector("hideFloatingBar:"))
        gestureMain.numberOfTouchesRequired = 1
        viewOverlayMask.addGestureRecognizer(gestureMain)
        
        let gestureTable = UITapGestureRecognizer(target: self, action: Selector("actionTableview"))
        gestureTable.numberOfTouchesRequired = 1
        tblFont.addGestureRecognizer(gestureTable)
        
        //Init UI.
        viewOverlayMask.hidden = true
        viewFloating.hidden = true
        rectFloating = viewFloating.frame
        rectTop = viewTop.frame
        
        viewFloating.frame = CGRectMake(0, 0, rectFloating.width, rectFloating.height)
        
        btnBack.alpha = 0.4
        tblFont.alpha = 0
        tblFont.hidden = true
        tblFont.backgroundColor = UIColor.clearColor()
        tblFont.separatorStyle = .None
        
        //Content.
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.contentInset = UIEdgeInsetsMake(20.0, 20.0, 20.0, 20.0)

        //List.
        tblList.registerNib(UINib(nibName: "ListItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ListItemTableViewCell")
        tblList.backgroundColor = UIColor.clearColor()
        let longPressList = UILongPressGestureRecognizer(target: self, action: Selector("longPressGestureRecognized:"))
        tblList.addGestureRecognizer(longPressList)
        
        //Side.
        tblSideView.registerNib(UINib(nibName: "SubMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "SubMenuTableViewCell")
        tblSideView.backgroundColor = UIColor.clearColor()
        tblSideView.separatorStyle = UITableViewCellSeparatorStyle.None
        let longPressSideView = UILongPressGestureRecognizer(target: self, action: Selector("longPressGestureForSide:"))
        imgSideRigtView.image = imgMain
        viewSideLeft.backgroundColor = AppDelegate().getDelegate().currentApper.mainColor
        tblSideView.addGestureRecognizer(longPressSideView)

        //Tab.
        let longPressTab = UILongPressGestureRecognizer(target: self, action: Selector("longPressGestureForTab:"))
        scrollTab.addGestureRecognizer(longPressTab)
        self.setTabBarItems()
        
        //Cancel Delete.
        let tapGestureCollect = UITapGestureRecognizer(target: self, action: "tapGestureCancelDeleteMode")
        collectionView.backgroundView = UIView(frame:collectionView.bounds)
        collectionView.backgroundView!.addGestureRecognizer(tapGestureCollect)
        
        let tapGestureList = UITapGestureRecognizer(target: self, action: "tapGestureCancelDeleteMode")
        tblList.backgroundView = UIView(frame:tblList.bounds)
        tblList.backgroundView!.addGestureRecognizer(tapGestureList)
        
        let tapGestureSide = UITapGestureRecognizer(target: self, action: "tapGestureCancelDeleteMode")
        tblSideView.backgroundView = UIView(frame:tblSideView.bounds)
        tblSideView.backgroundView!.addGestureRecognizer(tapGestureSide)
        
        let tapGestureSideRight = UITapGestureRecognizer(target: self, action: "tapGestureCancelDeleteMode")
        viewSideRight!.addGestureRecognizer(tapGestureSideRight)

        let tapGestureTab = UITapGestureRecognizer(target: self, action: "tapGestureCancelDeleteMode")
        viewTabBg!.addGestureRecognizer(tapGestureTab)

        let tapGestureBG = UITapGestureRecognizer(target: self, action: "tapGestureCancelDeleteMode")
        viewTab!.addGestureRecognizer(tapGestureBG)
        
        arrFonts = NSArray(objects: "Arvo", "OpenSans", "Bebas", "CaviarDreams", "CrimsonText-Roman", "DroidSans", "Lato-Regular", "OpenSans-CondensedBold", "Quicksand-Regular", "Raleway-Regular", "RobotoSlab-Regular", "Sansation-Regular", "Ubuntu-Bold", "WalkwayBlack")
        
        /*
        for family: String in UIFont.familyNames()
        {
            print("\(family)")
            for names: String in UIFont.fontNamesForFamilyName(family)
            {
                print("== \(names)")
            }
        }
        */
        
        //Title Init.
        self.adjustTitleSize()
        
        
        sliderColor.addTarget(self, action: Selector("changeColor"), forControlEvents: UIControlEvents.ValueChanged)

        imgMaskView.image = imgMain
        viewMain.alpha = 0
        viewWhiteOverlay.alpha = 0
        UIView.animateWithDuration(0.8,
            delay: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewWhiteOverlay.alpha = 0.8
                self.viewMain.alpha = 1
                
            }) {(Bool) -> Void in
                
                self.initPublishDialog()
                
        }
        
        /*
        // DEBUG shortcut
        if AppDelegate().getDelegate().DEBUG {
            self.gotoInfoViewController()
        }
        */
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        txtTitle.text = AppDelegate().getDelegate().currentApper.appTitle
        self.checkMenuStyle()
    }
    
    func checkMenuStyle()
    {
        collectionView.hidden = true
        viewTab.hidden = true
        tblList.hidden = true
        viewSideBar.hidden = true
        
        let type = AppDelegate().getDelegate().currentApper.menuStyle
        if(type == .Collect)
        {
            collectionView.hidden = false
            viewContent.bringSubviewToFront(collectionView)
        }
        else if(type == .TabBar)
        {
            viewTab.hidden = false
            viewContent.bringSubviewToFront(viewTab)
        }
        else if(type == .List)
        {
            tblList.hidden = false
            viewContent.bringSubviewToFront(tblList)
        }
        else if(type == .SideBar)
        {
            viewSideBar.hidden = false
            viewContent.bringSubviewToFront(viewSideBar)
        }
    }
    
    func openMainView()
    {
        viewOrangeMask.backgroundColor = AppDelegate().getDelegate().currentApper.mainColor
        viewOrangeMask.hidden = false
        viewOrangeMask.alpha = 1
        UIView.animateWithDuration(0.2,
            delay: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewOrangeMask.alpha = 0
                
            }) { (Bool) -> Void in
                
        }
    }
    
    func getCurrentBarColorValue() -> Float
    {
        let color = viewTop.backgroundColor as UIColor!
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return Float(hue)
    }
    
    func getCurrentTitleColorValue() -> Float
    {
        let color = txtTitle.textColor as UIColor!
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return Float(hue)
    }
    
    func reloadContent ()
    {
        self.collectionView.reloadData()
        self.tblList.reloadData()
        self.tblSideView.reloadData()
        self.setTabBarItems()
    }
    
    func reloadCurrentContent()
    {
        let type = AppDelegate().getDelegate().currentApper.menuStyle
        if(type == .Collect)
        {
            self.collectionView.reloadData()
        }
        else if(type == .TabBar)
        {
            self.setTabBarItems()
        }
        else if(type == .List)
        {
            self.tblList.reloadData()
        }
        else if(type == .SideBar)
        {
            self.tblSideView.reloadData()
        }
    }
    
    //MARK: Tap Gestures.
    func actionTableview()
    {
        txtTitle.resignFirstResponder()
        self.hideFloatingBar(TYPE_NONE)
    }
    
    func actionTopBar()
    {
        self.tapGestureCancelDeleteMode()
        if(openTopBar == true) { return }
        
        colorMode = 1
        sliderColor.hidden = false
        imgSliderBar.hidden = false
        viewIconBar.hidden = true
        sliderColor.value = self.getCurrentBarColorValue()
        viewFloating.hidden = false
        viewOverlayMask.hidden = false
        viewOverlayMask.alpha = 0

        self.showFloatingBar(MODE_COLOR)
    }
    
    func actionTitle()
    {
        self.tapGestureCancelDeleteMode()
        if(openTopBar == true) { return }
        
        colorMode = 2
        sliderColor.hidden = false
        imgSliderBar.hidden = false
        viewIconBar.hidden = true
        
        let color = txtTitle.textColor as UIColor!
        if(color.isEqual(UIColor.whiteColor()))
        {
            sliderColor.value = 1
        }
        else
        {
            sliderColor.value = self.getCurrentTitleColorValue()
        }

        viewFloating.hidden = false
        viewOverlayMask.hidden = false
        viewOverlayMask.alpha = 0
        tblFont.hidden = false
        tblFont.alpha = 0
        
        self.showFloatingBar(MODE_FONT)
    }
    
    func showFloatingBar(mode: TOP_NAV_MOVING_MODE)
    {
        viewFloating.frame = CGRectMake(0, 0, self.rectFloating.width, 0)
        UIView.animateWithDuration(0.3,
            delay: 0,
            options: .CurveEaseIn,
            animations: { () -> Void in
                
                self.viewFloating.frame = CGRectMake(0, 0, self.rectFloating.width, self.rectFloating.origin.y + self.rectFloating.height + CGFloat(FLOATING_BAR_OFFSET))
                self.viewOverlayMask.alpha = 0.8
                
                if(mode == MODE_FONT)
                {
                    self.txtTitle.transform = CGAffineTransformScale(self.titleTransform, 1.2, 1.2)
                    self.tblFont.alpha = 1
                }
                else
                {
                    self.txtTitle.transform = CGAffineTransformScale(self.titleTransform, 0.8, 0.8)
                }

                
            }) { (Bool) -> Void in
                
                UIView.animateWithDuration(0.1,
                    delay: 0,
                    options: [.CurveEaseIn, .BeginFromCurrentState],
                    animations: { () -> Void in
                        
                        self.viewFloating.frame = CGRectMake(0, 0, self.rectFloating.width, self.rectFloating.origin.y + self.rectFloating.height)
                        
                    }) { (Bool) -> Void in
                        
                        self.openTopBar = true
                        
                        if(mode == MODE_FONT)
                        {
                            self.txtTitle.becomeFirstResponder()
                        }

                }
        }
    }
    
    func hideFloatingBar(moveViewIndex: TOP_NAV_TYPE)
    {
//        btnMore.imageView!.layer.removeAllAnimations()
        
        if(openFloatingIcons == true)
        {
            /*
            var arrImages: [UIImage] = []
            for var position = 7; position > 0; position--
            {
                let image  = UIImage(named: String(format: "more_anim%02i.png", position))
                arrImages += [image!]
            }
            
            let animation = CAKeyframeAnimation(keyPath: "contents")
            animation.calculationMode = kCAAnimationDiscrete
            animation.duration = 0.3
            animation.values = arrImages.map {$0.CGImage as! AnyObject}
            animation.repeatCount = 1
            animation.removedOnCompletion = false
            animation.fillMode = kCAFillModeForwards
            btnMore.imageView!.layer.addAnimation(animation, forKey: "contents")
            */
            
            UIView.animateWithDuration(0.1,
                delay: 0,
                options: [.CurveLinear, .BeginFromCurrentState],
                animations: { () -> Void in
                    
                    self.btnMore.alpha = 1.0
                    self.btnBack.alpha = 0.4
                    
                }) { (flag) -> Void in
                    
            }
            
        }

        openFloatingIcons = false
        let rectFloating = self.viewFloating.frame
        UIView.animateWithDuration(0.1,
            animations: { () -> Void in
                
                self.viewFloating.frame = CGRectMake(rectFloating.origin.x, rectFloating.origin.y, rectFloating.width, rectFloating.height + CGFloat(FLOATING_BAR_OFFSET))
                
            }) { (flag: Bool) -> Void in
                
//                if(flag == true)
//                {
                    UIView.animateWithDuration(0.3,
                        animations: { () -> Void in
                            
                            self.viewFloating.frame = CGRectMake(self.viewFloating.frame.origin.x, -self.viewFloating.frame.height, self.viewFloating.frame.width, self.viewFloating.frame.height)
                            self.viewOverlayMask.alpha = 0
                            self.tblFont.alpha = 0
                            self.txtTitle.transform = self.titleTransform

                            
                        }) { (flag: Bool) -> Void in
                            
                            if((moveViewIndex == TYPE_IMAGES) || (moveViewIndex == TYPE_PREVIEW))
                            {
                                UIView.animateWithDuration(0.1,
                                    animations: { () -> Void in
                                        
                                        self.viewTop.frame = CGRectMake(self.viewTop.frame.origin.x, -self.viewTop.frame.height, self.viewTop.frame.width, self.viewTop.frame.height)
                                        self.viewFloating.frame = CGRectMake(self.viewFloating.frame.origin.x, -self.viewFloating.frame.height, self.viewFloating.frame.width, self.viewFloating.frame.height)
                                        self.viewContent.alpha = 0
                                        
                                    }) { (flag: Bool) -> Void in
                                        
                                        if(flag == true)
                                        {
                                            self.moveNextPage(moveViewIndex)
                                        }
                                }
                            }
                            else
                            {
                                self.moveNextPage(moveViewIndex)
                            }
//                    }
                }
        }
    }
    
    func moveNextPage(moveViewIndex: TOP_NAV_TYPE)
    {
        self.viewFloating.hidden = true
        self.viewOverlayMask.hidden = true
        
        self.openTopBar = false
        self.tblFont.hidden = true
        self.txtTitle.resignFirstResponder()
        
        if(moveViewIndex == TYPE_IMAGES)
        {
            self.performSelector(Selector("moveToImagesView"), withObject: self, afterDelay: 0.2)
        }
        else if(moveViewIndex == TYPE_MENU)
        {
            self.performSelector(Selector("moveToMenu"), withObject: self, afterDelay: 0.2)
        }
        else if(moveViewIndex == TYPE_PREVIEW)
        {
            self.performSelector(Selector("moveToPreview"), withObject: self, afterDelay: 0.2)
        }
        else if(moveViewIndex == TYPE_PUBLISH)
        {
//            self.performSelector(Selector("moveToPublish"), withObject: self, afterDelay: 0.2)
        }
    }
    
    func moveToImagesView()
    {
        let imageMain = AppEngine.imageWithView(self.view)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextView = storyboard.instantiateViewControllerWithIdentifier("ImagesViewController") as! ImagesViewController
        nextView.parentView = self
        nextView.imageMain = imageMain
        self.navigationController?.pushViewController(nextView, animated: false)
        
        viewTop.frame = rectTop
        viewFloating.frame = rectFloating
        viewContent.alpha = 1
    }
    
    func moveToMenu()
    {
        let imageMain = AppEngine.imageWithView(self.view)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextView = storyboard.instantiateViewControllerWithIdentifier("MenuMakerViewController") as! MenuMakerViewController
        nextView.parentView = self
        nextView.imageMain = imageMain
        self.navigationController?.pushViewController(nextView, animated: false)
    }
    
    func moveToPreview()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextView = storyboard.instantiateViewControllerWithIdentifier("PreviewViewController") as! PreviewViewController
        nextView.parentView = self
        self.navigationController?.pushViewController(nextView, animated: false)
        
        viewTop.frame = rectTop
        viewFloating.frame = rectFloating
        viewContent.alpha = 1
    }
    
    func moveToPublish()
    {
        viewBlurBg.updateBlur()
        viewBlurBg.alpha = 0
        viewBlurBg.hidden = false
        viewPublishDialog.hidden = false
        
        UIView.animateWithDuration(0.2,
            animations: { () -> Void in
                
                self.viewBlurBg.alpha = 1.0
                
            }) { (Bool) -> Void in
                
                self.viewPublishDialog.showDialog()
        }
    }
    
    
    func gotoDashboardViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dashboard = storyboard.instantiateViewControllerWithIdentifier("DashboardViewController") as! DashboardViewController
        let menu = storyboard.instantiateViewControllerWithIdentifier("MenuViewController") as! MenuViewController
        let container = MFSideMenuContainerViewController.containerWithCenterViewController(dashboard, leftMenuViewController: menu, rightMenuViewController: nil)
        AppDelegate().getDelegate().dashboardContainer = container
        self.navigationController?.pushViewController(container, animated: false)
    }
    
    func changeColor()
    {
        let value = sliderColor.value
        
        if(colorMode == 1)
        {
            let color = viewTop.backgroundColor as UIColor!
            
            var hue: CGFloat = 0
            var saturation: CGFloat = 0
            var brightness: CGFloat = 0
            var alpha: CGFloat = 0
            
            let success = color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
            if(success)
            {
                viewTop.backgroundColor = UIColor(hue: CGFloat(value), saturation: 0.75, brightness: 0.5, alpha: alpha)
                viewFloating.backgroundColor = viewTop.backgroundColor
                AppDelegate().getDelegate().currentApper.mainColor = viewTop.backgroundColor
                viewSideLeft.backgroundColor = AppDelegate().getDelegate().currentApper.mainColor
                self.reloadCurrentContent()
            }
        }
        else if(colorMode == 2)
        {
            if(value == 1.0)
            {
                txtTitle.textColor = UIColor.whiteColor()
            }
            else
            {
                let color = txtTitle.textColor as UIColor!
                
                var hue: CGFloat = 0
                var saturation: CGFloat = 0
                var brightness: CGFloat = 0
                var alpha: CGFloat = 0
                
                let success = color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
                if(success)
                {
                    txtTitle.textColor = UIColor(hue: CGFloat(value), saturation: 0.25, brightness: 1.0, alpha: alpha)
                }
            }
        }
    }
    
    //MARK: UICollectionView.
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrItems.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("itemCell", forIndexPath: indexPath) as! ItemCollectionViewCell
        
        let appIcon = arrItems.objectAtIndex(indexPath.row) as! AppIcon
        let color = AppDelegate().getDelegate().currentApper.mainColor
        
        cell.delegate = self
        cell.tag = indexPath.row
        cell.updateIcon(appIcon, deleteMode: deleteMode, color: color)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        if(deleteMode == true){ return }
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("itemCell", forIndexPath: indexPath) as! ItemCollectionViewCell
        let rect = CGRectMake(
            collectionView.frame.origin.x + cell.frame.origin.x - cell.frame.width/4.0,
            viewContent.frame.origin.y + collectionView.frame.origin.y + cell.frame.origin.y - cell.frame.height/4.0,
            cell.frame.width,
            cell.frame.height)
        
        self.moveToChooseView(rect)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSizeMake(90, 90)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 3.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 3.0
    }

    func scrollTrigerPaddingInCollectionView(collectionView: UICollectionView) -> UIEdgeInsets {
        return UIEdgeInsetsMake(self.collectionView.contentInset.top, 0, self.collectionView.contentInset.bottom, 0)
    }

    
    func collectionView(collectionView: UICollectionView, allowMoveAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    
    func collectionView(collectionView: UICollectionView, reorderingItemAlphaInSection section: Int) -> CGFloat
    {
        return 0.3
    }

    
    func collectionView(collectionView: UICollectionView, atIndexPath: NSIndexPath, didMoveToIndexPath toIndexPath: NSIndexPath) {
        
        var icon: AppIcon
        icon = arrItems.objectAtIndex(atIndexPath.item) as! AppIcon
        arrItems.removeObjectAtIndex(atIndexPath.item)
        arrItems.insertObject(icon, atIndex: toIndexPath.item)
        
        self.reloadContent()
    }
    
    func collectionView(collectionView: UICollectionView, collectionViewLayout layout: RAReorderableLayout, willBeginDraggingItemAtIndexPath indexPath: NSIndexPath)
    {
        if(!deleteMode)
        {
            deleteMode = true
            for view in collectionView.visibleCells()
            {
                let cell = view as! ItemCollectionViewCell
                
                if(cell.iconData.isEmpty == false)
                {
                    cell.btnDelete.hidden = false
                    cell.shakeIcon()
                }
            }
        }
    }
    
    func tapGestureCancelDeleteMode()
    {
        scrollTab.pagingEnabled = true
        deleteMode = false
        self.reloadContent()
    }
    
    func deleteIcon(index: Int)
    {
        let iconData = arrItems.objectAtIndex(index) as! AppIcon
        iconData.removeContent()
        arrItems.removeObjectAtIndex(index)
        self.reloadContent()
    }
    
    func removeIconFromList(index: Int)
    {
        let selectedIndexPath = NSIndexPath(forItem: index, inSection: 0)
        self.arrItems.removeObjectAtIndex(selectedIndexPath.row)
        self.reloadContent()
    }
    
    // MARK: TableView.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(tableView == tblFont)
        {
            return arrFonts.count + 10
        }else
        {
            return arrItems.count
        }
            
        /*
        else if(tableView == tblList)
        {
            return Int(LIST_COUNT)
        }
        else
        {
            var drawerCount = numberOfFilledIcons + 1
            if drawerCount>Int(DRAWER_COUNT) { // it should not be greater than DRAWER_COUNT
                drawerCount = Int(DRAWER_COUNT)
            }
            return drawerCount
        }
    */
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if(tableView == tblFont)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("FontCell", forIndexPath: indexPath) as UITableViewCell!
            cell.textLabel!.text = ""
            
            if(indexPath.row < arrFonts.count)
            {
                cell.textLabel!.text = titleString
                cell.textLabel!.textAlignment = NSTextAlignment.Center
                let fontName = arrFonts[indexPath.row] as! String
                cell.textLabel!.font = UIFont(name: fontName, size: 17.0)
                cell.backgroundColor = UIColor.clearColor()
                cell.textLabel!.textColor = UIColor.whiteColor()
            }
            return cell
        }
        else if(tableView == tblList)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("ListItemTableViewCell", forIndexPath: indexPath) as! ListItemTableViewCell
            
            if(indexPath.row < arrItems.count)
            {
                cell.tag = indexPath.row
                cell.delegate = self
                let iconData = arrItems.objectAtIndex(indexPath.row) as! AppIcon
                let color = AppDelegate().getDelegate().currentApper.mainColor
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator                
                cell.updateIcon(iconData, color: color, deleteMode: deleteMode)
            }
            
            return cell

        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("SubMenuTableViewCell", forIndexPath: indexPath) as! SubMenuTableViewCell
            
            if(indexPath.row < arrItems.count)
            {
                cell.tag = indexPath.row
                cell.delegate = self
                let iconData = arrItems.objectAtIndex(indexPath.row) as! AppIcon
                let color = AppDelegate().getDelegate().currentApper.mainColor
                
                cell.updateIcon(iconData, color: color, deleteMode: deleteMode)
            }
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if(tableView == tblList)
        {
            return 55.0;
        }
        else
        {
            return 44.0;
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0.001
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        if(openTopBar == true)
        {
            for cell in tblFont.visibleCells
            {
                let fy = cell.frame.origin.y - scrollView.contentOffset.y
                if(fy >= 0 && fy <= 44)
                {
                    let selectedPos = tblFont.indexPathForCell(cell) as NSIndexPath!
                    
                    if(selectedPos.row < arrFonts.count)
                    {
                        let fontName = arrFonts[selectedPos.row] as! String
                        txtTitle.font = UIFont(name: fontName, size: 17.0)
                    }
                }
            }
        }
    }
    
    func selectedListIcon(index: Int, cell: ListItemTableViewCell)
    {
        if(deleteMode == true)
        {
            self.tapGestureCancelDeleteMode()
        }
        else
        {
            let rect = CGRectMake(
                cell.lblIcon.frame.origin.x - cell.lblIcon.frame.width/2.0,
                viewContent.frame.origin.y + cell.frame.origin.y + cell.lblIcon.frame.origin.y - cell.lblIcon.frame.height/2.0,
                cell.lblIcon.frame.width,
                cell.lblIcon.frame.height)
            
            self.moveToChooseView(rect)
        }
    }
    
    func selectedSubMenuIcon(index: Int, cell: SubMenuTableViewCell)
    {
        if(deleteMode == true)
        {
            self.tapGestureCancelDeleteMode()
        }
        else
        {
            let rect = CGRectMake(
                cell.lblIcon.frame.origin.x - cell.lblIcon.frame.width/2.0,
                viewContent.frame.origin.y + cell.frame.origin.y + cell.lblIcon.frame.origin.y - cell.lblIcon.frame.height/2.0,
                cell.lblIcon.frame.width,
                cell.lblIcon.frame.height)
            
            self.moveToChooseView(rect)
        }
    }
    
    func longPressGestureForSide(sender: UILongPressGestureRecognizer)
    {
        let state = sender.state
        let location = sender.locationInView(tblSideView)
        let indexPath = tblSideView.indexPathForRowAtPoint(location)
        
        if(state == UIGestureRecognizerState.Began)
        {
            if(deleteMode == false)
            {
                deleteMode = true
                for view in tblSideView.visibleCells
                {
                    let cell = view as! SubMenuTableViewCell
                    
                    if(cell.iconData.isEmpty == false)
                    {
                        cell.btnDelete.hidden = false
                        cell.shakeIcon()
                    }
                }
            }

            if(indexPath != nil)
            {
                let sourceCell = tblSideView.cellForRowAtIndexPath(indexPath!) as! SubMenuTableViewCell
                if sourceCell.iconData.isEmpty == false {
                    sourceIndexPath = indexPath
                    snapshot = self.customSnapshoFromView(sourceCell)
                
                    var center = sourceCell.center
                    snapshot.center = center
                    snapshot.alpha = 0.0;
                    tblSideView.addSubview(snapshot)
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                    
                        center.y = location.y
                        self.snapshot.center = center
                        self.snapshot.transform = CGAffineTransformMakeScale(1.02, 1.02)
                        self.snapshot.alpha = 0.98
                        sourceCell.alpha = 0.0
                    
                        }, completion: { (Bool) -> Void in
                            sourceCell.hidden = true
                    })
                }
            }
        }
        else if(state == UIGestureRecognizerState.Changed && snapshot != nil)
        {
            var center = snapshot.center;
            center.y = location.y;
            snapshot.center = center;
            
            // Is destination valid and is it different from source?
            if ((indexPath != nil) && (indexPath?.isEqual(sourceIndexPath)) == false) {
                
                let sourceCell = tblSideView.cellForRowAtIndexPath(indexPath!) as! SubMenuTableViewCell
                
                if sourceCell.iconData.isEmpty == false {
                    // ... update data source.
                    arrItems.exchangeObjectAtIndex(indexPath!.row, withObjectAtIndex: sourceIndexPath.row)
                
                    // ... move the rows.
                    tblSideView.moveRowAtIndexPath(sourceIndexPath, toIndexPath: indexPath!)
                
                    // ... and update source so it is in sync with UI changes.
                    sourceIndexPath = indexPath;
                }
            }
        }
        else
        {
            self.reloadContent()
            
            // Clean up.
            if(sourceIndexPath != nil)
            {
                let cell = tblSideView.cellForRowAtIndexPath(sourceIndexPath)
                cell!.hidden = false
                cell!.alpha = 0.0
                
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    
                    self.snapshot.center = cell!.center
                    self.snapshot.transform = CGAffineTransformIdentity
                    self.snapshot.alpha = 0.0
                    cell!.alpha = 1.0
                    
                    }, completion: { (Bool) -> Void in
                        
                        self.sourceIndexPath = nil
                        self.snapshot.removeFromSuperview()
                        self.snapshot = nil
                        
                })
            }
        }
    }
    
    func longPressGestureRecognized(sender: UILongPressGestureRecognizer)
    {
        let state = sender.state
        let location = sender.locationInView(tblList)
        let indexPath = tblList.indexPathForRowAtPoint(location)
        
        if(state == UIGestureRecognizerState.Began)
        {
            if(deleteMode == false)
            {
                deleteMode = true
                for view in tblList.visibleCells
                {
                    let cell = view as! ListItemTableViewCell
                    
                    if(cell.iconData.isEmpty == false)
                    {
                        cell.btnDelete.hidden = false
                        cell.shakeIcon()
                    }
                }
            }

            if(indexPath != nil)
            {
                let sourceCell = tblList.cellForRowAtIndexPath(indexPath!) as! ListItemTableViewCell
                if sourceCell.iconData.isEmpty == false {
                    sourceIndexPath = indexPath
                    snapshot = self.customSnapshoFromView(sourceCell)
                
                    var center = sourceCell.center
                    snapshot.center = center
                    snapshot.alpha = 0.0;
                    tblList.addSubview(snapshot)
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                    
                        center.y = location.y
                        self.snapshot.center = center
                        self.snapshot.transform = CGAffineTransformMakeScale(1.02, 1.02)
                        self.snapshot.alpha = 0.98
                        sourceCell.alpha = 0.0
                    
                        }, completion: { (Bool) -> Void in
                            sourceCell.hidden = true
                    })
                }
            }
        }
        else if(state == UIGestureRecognizerState.Changed)
        {
            if(snapshot != nil)
            {
                var center = snapshot.center;
                center.y = location.y;
                snapshot.center = center;
                
                // Is destination valid and is it different from source?
                if ((indexPath != nil) && (indexPath?.isEqual(sourceIndexPath)) == false) {
                    let sourceCell = tblList.cellForRowAtIndexPath(indexPath!) as! ListItemTableViewCell
                    if sourceCell.iconData.isEmpty == false {
                        // ... update data source.
                        arrItems.exchangeObjectAtIndex(indexPath!.row, withObjectAtIndex: sourceIndexPath.row)
                    
                        // ... move the rows.
                        tblList .moveRowAtIndexPath(sourceIndexPath, toIndexPath: indexPath!)
                    
                        // ... and update source so it is in sync with UI changes.
                        sourceIndexPath = indexPath;
                    }
                }
            }
        }
        else
        {
            self.reloadContent()
            
            // Clean up.
            if sourceIndexPath != nil {
                let cell = tblList.cellForRowAtIndexPath(sourceIndexPath)
                cell!.hidden = false
                cell!.alpha = 0.0
                
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    
                    self.snapshot.center = cell!.center
                    self.snapshot.transform = CGAffineTransformIdentity
                    self.snapshot.alpha = 0.0
                    cell!.alpha = 1.0
                    
                    }, completion: { (Bool) -> Void in
                        
                        self.sourceIndexPath = nil
                        self.snapshot.removeFromSuperview()
                        self.snapshot = nil

                })
            }
        }
    }
    
    //MARK: Tab
    func setTabBarItems ()
    {
        arrTabCells.removeAllObjects()
        for view in scrollTab.subviews
        {
            view.removeFromSuperview()
        }
        
        var fx = 0.0
        let fy = 0.0
        let fw = 64.0
        let fh = 48.0
        
        let color = AppDelegate().getDelegate().currentApper.mainColor
        var index = 0
        
        for icon in arrItems
        {
            let appIcon = icon as! AppIcon
            let cell = TabItemCellView(frame: CGRect(x: fx, y: fy, width: fw, height: fh))
            cell.updateIcon(appIcon, color: color, deleteMode: deleteMode)
            cell.tag = index
            cell.delegate = self
            scrollTab.addSubview(cell)
            arrTabCells.addObject(cell)
            
            fx += fw
            index += 1
        }
        
        scrollTab.contentSize = CGSizeMake(CGFloat(fx), CGFloat(fh))
    }
    
    // It only returns the cell which are not empty
    func getCurrentTabByLocation (location: CGPoint) -> UIView?
    {
        for item in arrTabCells
        {
            let cell = item as! TabItemCellView
            if(CGRectContainsPoint(cell.frame, location) && cell.iconData.isEmpty == false)
            {
                return cell
            }
        }
        
        return nil
    }
    
    func longPressGestureForTab(sender: UILongPressGestureRecognizer)
    {
        let state = sender.state
        let location = sender.locationInView(scrollTab)
        
        if(state == UIGestureRecognizerState.Began)
        {
            scrollTab.pagingEnabled = false
            if(deleteMode == false)
            {
                deleteMode = true
                for item in self.arrTabCells
                {
                    let cell = item as! TabItemCellView
                    
                    if(cell.iconData.isEmpty == false)
                    {
                        cell.btnTabDelete.hidden = false
                        cell.shakeTabIcon()
                    }
                }
            }
            
            tabMovingCell = self.getCurrentTabByLocation(location)
            if(tabMovingCell == nil)
            {
                return;
            }
            
            snapshot = self.customSnapshoFromView(tabMovingCell)
            
            var center = tabMovingCell.center
            snapshot.center = center
            snapshot.alpha = 0.0;
            scrollTab.addSubview(snapshot)
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                
                center.y = location.y
                self.snapshot.center = center
                self.snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05)
                self.snapshot.alpha = 0.98
                self.tabMovingCell.alpha = 0.0
                
                }, completion: { (Bool) -> Void in
                    self.tabMovingCell.hidden = true
            })
        }
        else if(state == UIGestureRecognizerState.Changed && snapshot != nil)
        {
            var center = snapshot.center;
            center.x = location.x
            snapshot.center = center;
            
            let currentTarget = self.getCurrentTabByLocation(center)
            if((currentTarget != nil) && (currentTarget!.tag != tabMovingCell.tag))
            {
                let targetCell = currentTarget as! TabItemCellView
                if(currentTarget!.tag < arrItems.count && targetCell.iconData.isEmpty == false)
                {
                    arrItems.exchangeObjectAtIndex(currentTarget!.tag, withObjectAtIndex: tabMovingCell.tag)
                    
                    //Change Tag.
                    let tag = currentTarget!.tag
                    currentTarget!.tag = self.tabMovingCell.tag
                    self.tabMovingCell.tag = tag
                    
                    //Change View.
                    let rectOriginal = tabMovingCell.frame
                    let rectTarget = currentTarget!.frame
                    
                    UIView.animateWithDuration(0.1, animations: { () -> Void in
                        
                        currentTarget!.frame = rectOriginal
                        self.tabMovingCell.frame = rectTarget
                        
                        }, completion: { (Bool) -> Void in
                            
                    })
                }
            }
        }
        else if (tabMovingCell != nil)
        {
            // Clean up.
            tabMovingCell.hidden = false
            tabMovingCell.alpha = 0.0
            
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                
                self.snapshot.center = self.tabMovingCell.center
                self.snapshot.transform = CGAffineTransformIdentity
                self.snapshot.alpha = 0.0
                self.tabMovingCell.alpha = 1.0
                
                }, completion: { (Bool) -> Void in
                    
                    self.snapshot.removeFromSuperview()
                    self.snapshot = nil
                    
                    for item in self.arrTabCells
                    {
                        let cell = item as! TabItemCellView
                        cell.resetCell()
                    }
                    
                    self.reloadContent()
                    self.scrollTab.pagingEnabled = true
            })
            
        }
    }

    func customSnapshoFromView(inputView: UIView)-> UIView{
        // Make an image from the input view.
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, UIScreen.mainScreen().scale * 2)
        inputView.drawViewHierarchyInRect(inputView.bounds, afterScreenUpdates: true)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Create an image view.
        let snapshot = UIImageView(image: image)
        snapshot.layer.masksToBounds = false
        snapshot.layer.cornerRadius = 0.0
        snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0)
        snapshot.layer.shadowRadius = 5.0
        snapshot.layer.shadowOpacity = 0.4
        
        return snapshot;
    }
    
    func selectedTabIcon(index: Int, cell: TabItemCellView) {
        
        if(deleteMode == true)
        {
            self.tapGestureCancelDeleteMode()
        }
        else
        {
            let fx = cell.frame.origin.x as CGFloat!
            let fy  = cell.superview?.frame.origin.y as CGFloat!

            let rect = CGRectMake(viewContent.frame.origin.x + viewTab.frame.origin.x + fx - scrollTab.contentOffset.x - cell.bounds.width/4.0, // it should be /2.0 but half gives wronge position
                viewContent.frame.origin.y + viewTab.frame.origin.y + fy - cell.frame.height/2.0,
                cell.frame.height,
                cell.frame.height)

            
            self.moveToChooseView(rect)
        }
    }
    
    //MARK: Home
    @IBAction func actionBack(){
        print("back button pressed")
//        self.navigationController?.popToViewController(AppDelegate().getDelegate().dashboardContainer, animated: true)
    }
    
    @IBAction func actionMore()
    {
        self.tapGestureCancelDeleteMode()
        if(!openFloatingIcons)
        {
            if(openTopBar == true) { return }

            openFloatingIcons = true
            viewIconBar.hidden = false
            
            /*
            var arrImages: [UIImage] = []
            for position in 1...7
            {
                let image  = UIImage(named: String(format: "more_anim%02i.png", position))
                arrImages += [image!]
            }
            
            let animation = CAKeyframeAnimation(keyPath: "contents")
            animation.calculationMode = kCAAnimationDiscrete
            animation.duration = 0.3
            animation.values = arrImages.map {$0.CGImage as! AnyObject}
            animation.repeatCount = 1
            animation.removedOnCompletion = false
            animation.fillMode = kCAFillModeForwards
            btnMore.imageView!.layer.addAnimation(animation, forKey: "contents")
            */
            
            UIView.animateWithDuration(0.1,
                delay: 0,
                options: [.CurveLinear, .BeginFromCurrentState],
                animations: { () -> Void in
                    
                    self.btnMore.alpha = 0.4
                    self.btnBack.alpha = 1.0
                    
                }) { (Bool) -> Void in
                    
                    
            }
            
            sliderColor.hidden = true
            imgSliderBar.hidden = true
            viewFloating.hidden = false
            viewOverlayMask.hidden = false
            viewOverlayMask.alpha = 0
            
            viewImages.hidden = true
            viewMenu.hidden = true
            viewInfo.hidden = true
            viewPreview.hidden = true
            viewPublish.hidden = true
            
            self.showFloatingBar(MODE_BAR)
            
            //Show Icons
            let time = 0.1
            var delay = 0.2
            
            self.viewImages.hidden = false
            let transformImage = self.viewImages.transform
            self.viewImages.transform = CGAffineTransformScale(transformImage, 0.001, 0.001)
            UIView.animateWithDuration(time,
                delay: delay,
                options: [.CurveEaseInOut, .AllowUserInteraction],
                animations: { () -> Void in
                    self.viewImages.transform = CGAffineTransformScale(transformImage, 1.1, 1.1)
                },
                completion: { (Bool) -> Void in
                    UIView.animateWithDuration(time / 5,
                        animations: { () -> Void in
                            
                            self.viewImages.transform = transformImage
                            
                        }, completion: { (Bool) -> Void in
                    })
            })
            
            //Menu
            delay += time
            
            self.viewMenu.hidden = false
            let transformMenu = self.viewMenu.transform
            self.viewMenu.transform = CGAffineTransformScale(transformMenu, 0.001, 0.001)
            UIView.animateWithDuration(time,
                delay: delay,
                options: [.CurveEaseInOut, .AllowUserInteraction],
                animations: { () -> Void in
                    self.viewMenu.transform = CGAffineTransformScale(transformMenu, 1.1, 1.1)
                },
                completion: { (Bool) -> Void in
                    UIView.animateWithDuration(time / 5,
                        animations: { () -> Void in
                            
                            self.viewMenu.transform = transformMenu
                            
                        }, completion: { (Bool) -> Void in
                    })
            })
            
            //Info
            delay += time
            self.viewInfo.hidden = false
            let transformInfo = self.viewInfo.transform
            self.viewInfo.transform = CGAffineTransformScale(transformInfo, 0.001, 0.001)
            UIView.animateWithDuration(time,
                delay: delay,
                options: [.CurveEaseInOut, .AllowUserInteraction],
                animations: { () -> Void in
                    self.viewInfo.transform = CGAffineTransformScale(transformInfo, 1.1, 1.1)
                },
                completion: { (Bool) -> Void in
                    UIView.animateWithDuration(time / 5,
                        animations: { () -> Void in
                            
                            self.viewInfo.transform = transformMenu
                            
                        }, completion: { (Bool) -> Void in
                    })
            })
            
            //Preview
            delay += time
            self.viewPreview.hidden = false
            let transformPreview = self.viewPreview.transform
            self.viewPreview.transform = CGAffineTransformScale(transformPreview, 0.001, 0.001)
            UIView.animateWithDuration(time,
                delay: delay,
                options: [.CurveEaseInOut, .AllowUserInteraction],
                animations: { () -> Void in
                    self.viewPreview.transform = CGAffineTransformScale(transformPreview, 1.1, 1.1)
                },
                completion: { (Bool) -> Void in
                    UIView.animateWithDuration(time / 5,
                        animations: { () -> Void in
                            
                            self.viewPreview.transform = transformMenu
                            
                        }, completion: { (Bool) -> Void in
                    })
            })
            
            //Publish
            delay += time
            self.viewPublish.hidden = false
            let transformPublish = self.viewPublish.transform
            self.viewPublish.transform = CGAffineTransformScale(transformPublish, 0.001, 0.001)
            UIView.animateWithDuration(time,
                delay: delay,
                options: [.CurveEaseInOut, .AllowUserInteraction],
                animations: { () -> Void in
                    self.viewPublish.transform = CGAffineTransformScale(transformPreview, 1.1, 1.1)
                },
                completion: { (Bool) -> Void in
                    UIView.animateWithDuration(time / 5,
                        animations: { () -> Void in
                            
                            self.viewPublish.transform = transformMenu
                            
                        }, completion: { (Bool) -> Void in
                    })
            })

        }
        else
        {
            self.hideFloatingBar(TYPE_NONE)
        }
    }
    
    @IBAction func actionImages()
    {
        self.hideFloatingBar(TYPE_IMAGES)
    }
    
    @IBAction func actionMenu()
    {
        self.hideFloatingBar(TYPE_MENU)
    }
    
    @IBAction func actionInfo()
    {
        let viewMask = UIView(frame: CGRectMake(viewIconBar.frame.origin.x + viewInfo.frame.origin.x,
                                viewIconBar.frame.origin.y + viewInfo.frame.origin.y, viewInfo.frame.width, viewInfo.frame.height))
        
        viewMask.backgroundColor = UIColor.whiteColor()
        viewMask.layer.cornerRadius = 10//viewMask.frame.width/2.0
        self.view.addSubview(viewMask)
        
        UIView.animateWithDuration(0.2,
            delay: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                viewMask.transform = CGAffineTransformScale(viewMask.transform, 20, 20)
                
            }) { (Bool) -> Void in
                
                viewMask.removeFromSuperview()
                self.hideFloatingBar(TYPE_INFO)
                self.gotoInfoViewController()
        }
    }
    
    func gotoInfoViewController()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextView = storyboard.instantiateViewControllerWithIdentifier("InfoViewController") as! InfoViewController
        nextView.parentView = self
        let menu = storyboard.instantiateViewControllerWithIdentifier("InfoMenuViewController") as! InfoMenuViewController
        let container = MFSideMenuContainerViewController.containerWithCenterViewController(nextView, leftMenuViewController: nil, rightMenuViewController: menu)
        container.setRightMenuWidth((self.view.frame.width/3)*2, animated: false)
        self.navigationController?.pushViewController(container, animated: false)
    }
    
    @IBAction func actionPreview()
    {
        self.hideFloatingBar(TYPE_PREVIEW)
    }
    
    @IBAction func actionPublish()
    {
        self.moveToPublish()
//        self.performSelector(Selector("moveToPublish"), withObject: self, afterDelay: 0.2)
    }
    
    func openMainViewFromPreview()
    {
        let rectTop = viewTop.frame
        
        self.checkMenuStyle()
        
        viewTop.frame = CGRectMake(rectTop.origin.x, -rectTop.height, rectTop.width, rectTop.height)
        viewContent.alpha = 0
        UIView.animateWithDuration(0.2,
            delay: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewTop.frame = rectTop
                self.viewContent.alpha = 1
                
            }) { (Bool) -> Void in
                
        }
    }
    
    func captureCollectScreenshot() -> UIImage
    {
        collectionView.hidden = false
        tblList.hidden = true
        viewTab.hidden = true
        viewSideBar.hidden = true
        
        let imageCapture = AppEngine.imageWithView(self.view)
        return imageCapture
    }
    
    func captureListScreenshot () -> UIImage
    {
        tblList.hidden = false
        collectionView.hidden = true
        viewTab.hidden = true
        viewSideBar.hidden = true
        
        let imageCapture = AppEngine.imageWithView(self.view)
        return imageCapture
    }
    
    func captureTabScreenshot() -> UIImage
    {
        viewTab.hidden = false
        tblList.hidden = true
        collectionView.hidden = true
        viewSideBar.hidden = true
        viewSideBar.hidden = true
        
        let imageCapture = AppEngine.imageWithView(self.view)
        return imageCapture
    }
    
    func captureSideScreenshot() -> UIImage
    {
        collectionView.hidden = true
        tblList.hidden = true
        viewTab.hidden = true
        viewSideBar.hidden = false
        
        let imageCapture = AppEngine.imageWithView(self.view)
        return imageCapture
    }
    

    //MARK: UITextField Delegate.
    func textFieldDidBeginEditing(textField: UITextField)
    {
        self.actionTitle()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        if(string == "")
        {
            
            let text = textField.text! as String
            if(text.characters.count > 0)
            {
                let lastIndex = (text.characters.count - 1)
                titleString = text.substringToIndex(text.startIndex.advancedBy(lastIndex))
            }
            else
            {
                titleString = ""
            }
        }
        else
        {
            titleString = String(format: "%@%@", textField.text!, string)
        }
        
        
        let newLength = (textField.text!.utf16).count + (string.utf16).count - range.length
        if(newLength <= Int(MAX_APP_TITLE_LENGTH))
        {
            tblFont.reloadData()
            return true
        }
        
        return false
    }
    
    func textFieldDidEndEditing(textField: UITextField)
    {
        AppDelegate().getDelegate().currentApper.appTitle = txtTitle.text
        self.adjustTitleSize()
    }
    
    func adjustTitleSize()
    {
        ptTitleCenter = txtTitle.center
        txtTitle.sizeToFit()
        txtTitle.center = ptTitleCenter
    }
    
    //MARK: CHOOSE.
    func moveToChooseView (rect: CGRect!)
    {
        let viewMask = UIView(frame: rect)
        viewMask.frame = CGRectMake(rect.origin.x + viewMask.frame.width/2.0, rect.origin.y + viewMask.frame.height/2.0, rect.width, rect.height)
        
        viewMask.backgroundColor = AppDelegate().getDelegate().currentApper.mainColor
        viewMask.layer.cornerRadius = viewMask.frame.width/2.0
        self.view.addSubview(viewMask)
        UIView.animateWithDuration(NEXT_PAGE_MOVING_ZOOM1_TIME,
            delay: 0,
            options: [.CurveEaseIn, .AllowUserInteraction],
            animations: { () -> Void in
                
                viewMask.transform = CGAffineTransformScale(viewMask.transform,
                    CGFloat(NEXT_PAGE_MOVING_ZOOM1_VALUE),
                    CGFloat(NEXT_PAGE_MOVING_ZOOM1_VALUE))
                
            }) {(flag: Bool) -> Void in
                
                if(flag == true)
                {
                    UIView.animateWithDuration(NEXT_PAGE_MOVING_ZOOM2_TIME,
                        delay: 0,
                        options: [.CurveEaseIn, .AllowUserInteraction],
                        animations: { () -> Void in
                            
                            viewMask.transform = CGAffineTransformScale(viewMask.transform,
                                CGFloat(NEXT_PAGE_MOVING_ZOOM2_VALUE),
                                CGFloat(NEXT_PAGE_MOVING_ZOOM2_VALUE))
                            
                        }) {(Bool) -> Void in
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let nextView = storyboard.instantiateViewControllerWithIdentifier("ChooseViewController") as! ChooseViewController
                            self.navigationController?.pushViewController(nextView, animated: false)
                            
                            viewMask.removeFromSuperview()
                            
                    }
                }
        }
    }
    
    //Publish.
    func initPublishDialog()
    {
        viewBlurBg = SVBlurView(frame: self.view.bounds)
        viewBlurBg.blurRadius = 4.0
        viewBlurBg.saturationDelta = 1.0
        viewBlurBg.hidden = true
        self.view.addSubview(viewBlurBg)
        
        viewPublishDialog = PublishView(frame: self.view.bounds)
        viewPublishDialog.hidden = true
        viewPublishDialog.delegate = self
        self.view.addSubview(viewPublishDialog)
    }
    
    func hidePublishView()
    {
        UIView.animateWithDuration(0.1,
            delay: 0,
            options: [.CurveEaseIn, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewBlurBg.alpha = 0.0
                
            }) {(Bool) -> Void in
                
                self.viewBlurBg.hidden = true
                self.viewPublishDialog.hidden = true
                
                self.hideFloatingBar(TYPE_PUBLISH)
        }
    }

}
