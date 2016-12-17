//
//  DashboardViewController.swift
//  Apper
//
//  Created by jian on 8/5/15.
//  Copyright © 2015 jinhu. All rights reserved.
//

import UIKit

class DashboardViewController: BaseViewController, SSARefreshControlDelegate, UPStackMenuDelegate, IconTableViewCellDelegate
{
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var viewButtonMask: UIView!
    @IBOutlet weak var viewButton: UIView!
    @IBOutlet weak var viewMenuButton: UIView!
    @IBOutlet weak var viewMenuButton1: UIView!
    @IBOutlet weak var viewMenuButton2: UIView!
    @IBOutlet weak var viewMenuButton3: UIView!
    
    @IBOutlet weak var viewPlusButton: UIView!
    @IBOutlet weak var viewPlusButton1: UIView!
    @IBOutlet weak var viewPlusButton2: UIView!
    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var viewMask: UIView!
    
    @IBOutlet weak var viewMenu: UIView!
    @IBOutlet weak var viewMenuSub1: UIView!
    @IBOutlet weak var viewMenuSub2: UIView!
    @IBOutlet weak var viewMenuSub3: UIView!
    
//    var rectMain : CGRect!
    var rectMenuSub1: CGRect!
    var rectMenuSub2: CGRect!
    var rectMenuSub3: CGRect!
    var arrIcons : NSMutableArray!
    var refreshControl : SSARefreshControl!
    var stack : UPStackMenu!
    var deleteStatus: Bool!
    var animateFinished: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Init Data.
        arrIcons = NSMutableArray()
        deleteStatus = false
        viewMask.hidden = true
        animateFinished = false
        
        //Customize Buttons.
        viewButtonMask.layer.masksToBounds = true
        viewButtonMask.hidden = true
        
        btnAdd.layer.masksToBounds = true
        btnAdd.layer.cornerRadius = btnAdd.frame.width/2.0
        
        viewButton.layer.cornerRadius = viewButton.frame.width/2.0
        viewButton.layer.masksToBounds = true
        viewButton.transform = CGAffineTransformScale(viewButton.transform, 9, 9)
        
        //App Menu.
        viewMenuButton.alpha = 0
        viewMenuButton1.layer.cornerRadius = viewMenuButton1.frame.width/2.0
        viewMenuButton2.layer.cornerRadius = viewMenuButton2.frame.width/2.0
        viewMenuButton3.layer.cornerRadius = viewMenuButton3.frame.width/2.0
        
        //Plus.
        viewPlusButton.alpha = 0
        viewPlusButton1.layer.cornerRadius = viewPlusButton1.frame.height/2.0
        viewPlusButton2.layer.cornerRadius = viewPlusButton2.frame.width/2.0
        
        //Menu.
        rectMenuSub1 = viewMenuSub1.frame
        viewMenuSub1.frame = CGRectMake(-viewMenuSub1.frame.width, viewMenuSub1.frame.origin.y, viewMenuSub1.frame.width, viewMenuSub1.frame.height)
        rectMenuSub2 = viewMenuSub2.frame
        viewMenuSub2.frame = CGRectMake(-viewMenuSub2.frame.width * 4, viewMenuSub2.frame.origin.y, viewMenuSub2.frame.width, viewMenuSub2.frame.height)
        rectMenuSub3 = viewMenuSub3.frame
        viewMenuSub3.frame = CGRectMake(-viewMenuSub3.frame.width * 6, viewMenuSub3.frame.origin.y, viewMenuSub3.frame.width, viewMenuSub3.frame.height)
        
        btnAdd.hidden = true
        
//        rectMain = tblView.frame
//        tblView.frame = CGRectMake(rectMain.origin.x, self.view.frame.height, rectMain.width, rectMain.height)
        tblView.separatorStyle = UITableViewCellSeparatorStyle.None
        tblView.registerNib(UINib(nibName: "IconTableViewCell", bundle: nil), forCellReuseIdentifier: "IconTableViewCell")
        
        //Init Refresh.
        refreshControl = SSARefreshControl(scrollView: tblView, andRefreshViewLayerType: SSARefreshViewLayerType.OnScrollView)
        refreshControl.delegate = self
        
        //Tap Gesture.
        let gesture = UITapGestureRecognizer(target: self, action: Selector("tapTableView"))
        gesture.numberOfTouchesRequired = 1
        tblView.addGestureRecognizer(gesture)
        
        self.showAddButton()
    }
    
    func showAddButton()
    {
        UIView.animateWithDuration(0.3,
            delay: 0.5,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewButton.transform = CGAffineTransformIdentity
                
            }) {(Bool) -> Void in
                
                self.viewMenuButton.alpha = 1
                UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
                self.setNeedsStatusBarAppearanceUpdate()

                //Move Add Button
                UIView.animateWithDuration(0.5,
                    delay: 2,
                    options: [.CurveEaseInOut, .AllowUserInteraction],
                    animations: { () -> Void in
                        
                        self.viewMenuButton.transform = CGAffineTransformRotate(self.viewMenuButton.transform, 3.1415926/2.0)
                        self.viewButton.frame = CGRectMake(240, self.view.frame.height - 80, self.viewButton.frame.width, self.viewButton.frame.height)
                        self.viewButton.transform = CGAffineTransformScale(self.viewButton.transform, 0.7, 0.7)
                        
                        //Move Left Top Menu.
                        self.viewMenuSub1.frame = self.rectMenuSub1
                        self.viewMenuSub2.frame = self.rectMenuSub2
                        self.viewMenuSub3.frame = self.rectMenuSub3
                        
                        self.viewMenuButton1.frame = self.viewPlusButton1.frame
                        self.viewMenuButton2.frame = self.viewPlusButton2.frame
                        self.viewMenuButton3.alpha = 0

                        
                    }) {(Bool) -> Void in
                        
                        //Change Button.
                        UIView.animateWithDuration(0.2,
                            delay: 0,
                            options: [.CurveEaseInOut, .AllowUserInteraction],
                            animations: { () -> Void in
                                
                            }) {(Bool) -> Void in
                                
                                //Show Add Button.
                                self.btnAdd.frame = self.viewButton.frame
                                self.btnAdd.hidden = false
                                self.viewButtonMask.frame = self.viewButton.frame
                                self.viewButtonMask.layer.cornerRadius = self.viewButtonMask.frame.width/2.0
                                
                                //Add Stack Menu.
                                self.stack = UPStackMenu(contentView: self.viewButton)
                                self.stack.delegate = self
                                
                                let editItem = UPStackMenuItem(image: UIImage(named: "edit_icon.png"), highlightedImage: UIImage(named: "edit_icon.png"), title: "Edit")
                                let notifyItem = UPStackMenuItem(image: UIImage(named: "notification_icon.png"), highlightedImage: UIImage(named: "notification_icon.png"), title: "Notify")
                                let analyzeItem = UPStackMenuItem(image: UIImage(named: "anayls_icon.png"), highlightedImage: UIImage(named: "anayls_icon.png"), title: "Analyze")
                                let shareItem = UPStackMenuItem(image: UIImage(named: "share_icon.png"), highlightedImage: UIImage(named: "share_icon.png"), title: "Share")
                                let publishItem = UPStackMenuItem(image: UIImage(named: "publish_icon.png"), highlightedImage: UIImage(named: "publish_icon.png"), title: "Submit")
                                
                                let items = NSMutableArray(objects: editItem, notifyItem, analyzeItem, shareItem, publishItem)
                                self.stack.animationType = UPStackMenuAnimationType_progressive
                                self.stack.stackPosition = UPStackMenuStackPosition_up
                                self.stack.openAnimationDuration = 0.4
                                self.stack.closeAnimationDuration = 0.4
                                self.stack.hidden = false
                                self.stack.addItems(items as [AnyObject])
                                self.stack.clipsToBounds = false
                                self.view.addSubview(self.stack)
                                
                                self.view.bringSubviewToFront(self.btnAdd)
                                self.animateFinished = true
                                
                                var index = 0
                                for itemCell in self.tblView.visibleCells
                                {
                                    let cell = itemCell as! IconTableViewCell
                                    cell.zoomIcons(index)
                                    index = index + 1                                    
                                }
                        }
                }
        }
    }

    func beganRefreshing()
    {
        self.loadDataSource()
    }
    
    func loadDataSource()
    {
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            sleep(2)
            dispatch_async(dispatch_get_main_queue()) {
                // update some UI
                
                self.tblView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }

/////////////////////////////////////////////////////////////////////////////////////
/// TableView.
/////////////////////////////////////////////////////////////////////////////////////
    // MARK: TableView.
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("IconTableViewCell", forIndexPath: indexPath) as! IconTableViewCell
        cell.delegate = self
        cell.updateAppIcon(self.deleteStatus, animateFlag: animateFinished)
        return cell
    }
    
    func selectedIcon()
    {
        self.stack.openStack()
    }
    
    func longPressedIcon()
    {
        self.deleteStatus = true
        self.tblView.reloadData()
    }
    
    func tapTableView()
    {
        self.deleteStatus = false
        self.tblView.reloadData()
    }
    
/////////////////////////////////////////////////////////////////////////////////////
/// UPStack Delegate.
/////////////////////////////////////////////////////////////////////////////////////
    // MARK: UPStack Delegate.
    func setStackIconClosed(close: Bool)
    {
        self.stack.hidden = !close
        let angle = close ? -(CGFloat(M_PI) * (135) / 180.0) : (CGFloat(M_PI) * (135) / 180.0)
        let color = close ? UIColor(red: 67.0/255.0, green: 111.0/255.0, blue: 182.0/255.0, alpha: 1.0) : UIColor.whiteColor()
        let arrowColor = close ? UIColor(red: 223.0/255.0, green: 223.0/255.0, blue: 223.0/255.0, alpha: 1.0) : UIColor.blackColor()
        let maskAlpha = close ? 0 : 0.75
        
        if(!close)
        {
            self.viewMask.hidden = false
        }
        
        UIView.animateWithDuration(0.4,
            delay: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewButton.transform = CGAffineTransformRotate(self.viewButton.transform, angle)
                self.viewButton.backgroundColor = color
                self.viewMask.alpha = CGFloat(maskAlpha)
                
                self.viewMenuButton1.backgroundColor = arrowColor
                self.viewMenuButton2.backgroundColor = arrowColor
                
            }) { (Bool) -> Void in
                
                self.viewMask.hidden = close
        };
    }

    func stackMenuWillOpen(menu: UPStackMenu!)
    {
        self.setStackIconClosed(false)
        self.btnAdd.hidden = true
    }
    
    func stackMenuWillClose(menu: UPStackMenu!)
    {
        self.setStackIconClosed(true)
        self.btnAdd.hidden = false
    }
    
    func stackMenu(menu: UPStackMenu!, didTouchItem item: UPStackMenuItem!, atIndex index: UInt)
    {
        let viewMask = UIView(frame: CGRectMake(menu.frame.origin.x + item.frame.origin.x,
            menu.frame.origin.y + item.frame.origin.y, item.frame.width, item.frame.height))
        
        viewMask.backgroundColor = UIColor(red: 67.0/255.0, green: 111.0/255.0, blue: 182.0/255.0, alpha: 1.0)
        viewMask.layer.cornerRadius = item.frame.width/2.0
        self.view.addSubview(viewMask)

        UIView.animateWithDuration(NEXT_PAGE_MOVING_SMALL_ZOOM_TIME,
            delay: 0,
            options: [.CurveEaseIn, .AllowUserInteraction],
            animations: { () -> Void in
                
                viewMask.transform = CGAffineTransformScale(viewMask.transform,
                    CGFloat(NEXT_PAGE_MOVING_SMALL_ZOOM_VALUE),
                    CGFloat(NEXT_PAGE_MOVING_SMALL_ZOOM_VALUE))
                
            }) {(flag: Bool) -> Void in
                
                if(flag == true)
                {
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
                                        let nextView = storyboard.instantiateViewControllerWithIdentifier("NotifyViewController") as! NotifyViewController
                                        self.navigationController?.pushViewController(nextView, animated: false)
                                        
                                        viewMask.removeFromSuperview()
                                        self.stack.closeStack()

                                }
                            }
                    }
                }
        }
    }

    
/////////////////////////////////////////////////////////////////////////////////////
/// Side Menu.
/////////////////////////////////////////////////////////////////////////////////////
    // MARK: Menu.
    @IBAction func actionMenu()
    {
        self.menuContainerViewController.toggleLeftSideMenuCompletion { () -> Void in
            
        }
    }    
    
/////////////////////////////////////////////////////////////////////////////////////
/// Actions.
/////////////////////////////////////////////////////////////////////////////////////
    
    // MARK: Actions.
    @IBAction func actionPost()
    {
        stack.hidden = true
        viewButton.hidden = true
        viewButtonMask.hidden = false

        let transform = self.viewButtonMask.transform
        UIView.animateWithDuration(NEXT_PAGE_MOVING_SMALL_ZOOM_TIME,
            delay: 0,
            options: [.CurveEaseIn, .AllowUserInteraction],
            animations: { () -> Void in

                self.viewButtonMask.transform = CGAffineTransformScale(self.viewButtonMask.transform,
                    CGFloat(NEXT_PAGE_MOVING_SMALL_ZOOM_VALUE),
                    CGFloat(NEXT_PAGE_MOVING_SMALL_ZOOM_VALUE))
                
            }) {(flag: Bool) -> Void in
                
                if(flag == true)
                {
                    UIView.animateWithDuration(NEXT_PAGE_MOVING_ZOOM1_TIME,
                        delay: 0,
                        options: [.CurveEaseIn, .AllowUserInteraction],
                        animations: { () -> Void in
                            
                            self.viewButtonMask.transform = CGAffineTransformScale(self.viewButtonMask.transform,
                                CGFloat(NEXT_PAGE_MOVING_ZOOM1_VALUE),
                                CGFloat(NEXT_PAGE_MOVING_ZOOM1_VALUE))
                            
                        }) {(flag: Bool) -> Void in
                            
                            if(flag == true)
                            {
                                UIView.animateWithDuration(NEXT_PAGE_MOVING_ZOOM2_TIME,
                                    delay: 0,
                                    options: [.CurveEaseIn, .AllowUserInteraction],
                                    animations: { () -> Void in
                                        
                                        self.viewButtonMask.transform = CGAffineTransformScale(self.viewButtonMask.transform,
                                            CGFloat(NEXT_PAGE_MOVING_ZOOM2_VALUE),
                                            CGFloat(NEXT_PAGE_MOVING_ZOOM2_VALUE))
                                        
                                    }) {(Bool) -> Void in
                                        
                                        //Go to Post View.
                                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                        let vc = storyboard.instantiateViewControllerWithIdentifier("PostViewController") as! PostViewController
                                        self.navigationController?.pushViewController(vc, animated: false)
                                        
                                        self.stack.hidden = false
                                        self.viewButton.hidden = false
                                        self.viewButtonMask.hidden = true
                                        self.viewButtonMask.transform = transform
                                }
                            }
                    }
                }
        }
    }

}

