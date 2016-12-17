//
//  ChooseViewController.swift
//  Apper
//
//  Created by jian on 9/2/15.
//  Copyright © 2015 jinhu. All rights reserved.
//

import UIKit

class ChooseViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, ChooseTableViewCellDelegate
{
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewFrame: UIView!
    @IBOutlet weak var btnBack: TBAnimationButton!
    @IBOutlet weak var viewBack: UIView!
    
    var currentIndex: Int!
    var rectFrame: CGRect!
    var rectBack: CGRect!
    var transformBack: CGAffineTransform!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentIndex = 0
        rectFrame = viewFrame.frame
        
        // Do any additional setup after loading the view.
        UIApplication.sharedApplication().statusBarHidden = true
        
        btnBack.lineHeight = 1.0
        btnBack.lineWidth = btnBack.frame.width / 3.0
        btnBack.currentState = TBAnimationButtonState.Cross
        btnBack.layer.masksToBounds = true
        btnBack.layer.cornerRadius = btnBack.frame.width/2.0
        btnBack.lineColor = AppDelegate().getDelegate().currentApper.mainColor
        btnBack.backgroundColor = UIColor.clearColor()
        btnBack.updateAppearance()
        
        transformBack = btnBack.transform
        btnBack.transform = CGAffineTransformScale(transformBack, 0.0001, 0.0001)
        
        viewBack.layer.masksToBounds = true
        viewBack.layer.cornerRadius = viewBack.frame.width/2.0
        rectBack = viewBack.frame
        viewBack.frame = CGRectMake(rectBack.origin.x + rectBack.width, rectBack.origin.y - rectBack.height, rectBack.width, rectBack.height)
        
        viewFrame.layer.borderColor = UIColor.whiteColor().CGColor
        viewFrame.layer.borderWidth = CGFloat(CHOOSE_BORDER_WIDTH)
        viewFrame.layer.cornerRadius = CGFloat(CHOOSE_CORNER_RADIUS)
        viewFrame.userInteractionEnabled = false
        
        tblView.registerNib(UINib(nibName: "ChooseTableViewCell", bundle: nil), forCellReuseIdentifier: "ChooseTableViewCell")
        tblView.separatorStyle = UITableViewCellSeparatorStyle.None
        tblView.reloadData()
        
        let indexPathPrev = NSIndexPath(forRow: 0, inSection: 0)
        let firstCell = tblView.cellForRowAtIndexPath(indexPathPrev) as! ChooseTableViewCell
        firstCell.animateCell()
        
        //Show Back Button
        let time = 0.2
        UIView.animateWithDuration(time,
            delay: 0.7,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                self.viewBack.frame = CGRectMake(self.rectBack.origin.x - 2.0, self.rectBack.origin.y + 2.0, self.rectBack.width, self.rectBack.height)
            },
            completion: { (Bool) -> Void in
                
                //Zoom Button.
                UIView.animateWithDuration(time / 4.0,
                    delay: 0,
                    options: [.CurveEaseInOut, .AllowUserInteraction],
                    animations: { () -> Void in
                        
                        self.viewBack.frame = self.rectBack
                    },
                    completion: { (Bool) -> Void in
                        
                        //Zoom Button.
                        UIView.animateWithDuration(time,
                            delay: 0,
                            options: [.CurveEaseInOut, .AllowUserInteraction],
                            animations: { () -> Void in
                                
                                self.btnBack.transform = self.transformBack
                            },
                            completion: { (Bool) -> Void in
                                
                                
                        })

                })
        })
        
//        UIView.animateWithDuration(time,
//            delay: 0.7,
//            usingSpringWithDamping: 0.75,
//            initialSpringVelocity: 0,
//            options: [.CurveEaseInOut, .AllowUserInteraction],
//            animations: { () -> Void in
//                
//                self.viewBack.frame = self.rectBack
//                
//            }) { (Bool) -> Void in
//                
//                //Zoom Button.
//                UIView.animateWithDuration(time,
//                    delay: 0,
//                    options: [.CurveEaseInOut, .AllowUserInteraction],
//                    animations: { () -> Void in
//                        
//                        self.btnBack.transform = self.transformBack
//                    },
//                    completion: { (Bool) -> Void in
//                        
//                        
//                })
//        }

    }
    
    override func viewWillDisappear(animated: Bool)
    {
        UIApplication.sharedApplication().statusBarHidden = false
    }
    
    @IBAction func actionBack()
    {
        let rect = viewBack.frame
        let viewMask = UIView(frame: rect)
        viewMask.frame = CGRectMake(rect.origin.x + viewMask.frame.width/2.0, rect.origin.y + viewMask.frame.height/2.0, rect.width, rect.height)
        
        viewMask.backgroundColor = viewBack.backgroundColor
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
                            
                            self.navigationController?.popViewControllerAnimated(false)
                            viewMask.removeFromSuperview()
                            
                    }
                }
        }
    }

    // MARK: TableView.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 7
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChooseTableViewCell", forIndexPath: indexPath) as! ChooseTableViewCell
        cell.updateCell(indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if(currentIndex == indexPath.row)
        {
            return 184.0
        }
        
        return 64.0
    }
    
    func cellButtonTapped(cell: ChooseTableViewCell, index: Int)
    {
        if(currentIndex != index)
        {
            let indexPathPrev = NSIndexPath(forRow: currentIndex, inSection: 0)
            let prevCell = tblView.cellForRowAtIndexPath(indexPathPrev) as! ChooseTableViewCell
            prevCell.moveToNormalState(index, completion: { (Bool) -> Void in
                
                self.currentIndex = index
                
                let indexPath = NSIndexPath(forRow: index, inSection: 0)
                let cell = self.tblView.cellForRowAtIndexPath(indexPath) as! ChooseTableViewCell
                cell.animateCell()
                
                self.tblView.beginUpdates()
                self.tblView.endUpdates()
                
            })
            
            UIView.animateWithDuration(CHOOSE_FRAME_ANIM_TIME,
                delay: 0,
                options: [.CurveEaseInOut, .AllowUserInteraction],
                animations: { () -> Void in
                    
                    self.viewFrame.frame = CGRectMake(self.rectFrame.origin.x, (self.rectFrame.origin.y + CGFloat(64 * index)), self.rectFrame.width, self.rectFrame.height)
                    
                }) { (flag: Bool) -> Void in

            }
        }
        else
        {
            let rect = CGRectMake(cell.frame.origin.x + cell.viewLists.frame.origin.x,
                cell.frame.origin.y + cell.viewLists.frame.origin.y,
                cell.viewLists.frame.width,
                cell.viewLists.frame.height)
            
            /*
            let viewContainer = UIView(frame: rect)
            viewContainer.backgroundColor = cell.backgroundColor
            self.view.addSubview(viewContainer)
            
            let viewMask = UIView(frame: CGRectMake(0, 0, cell.frame.width, cell.frame.height))
            viewMask.backgroundColor = UIColor.blackColor()
            viewMask.alpha = cell.viewBackBg.alpha
            viewMask.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            viewContainer.addSubview(viewMask)
            
            UIView.animateWithDuration(0.3,
                delay: 0,
                options: [.CurveEaseIn, .AllowUserInteraction],
                animations: { () -> Void in
                    
                    viewContainer.frame = self.view.bounds
                    
                }) {(flag: Bool) -> Void in
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let nextView = storyboard.instantiateViewControllerWithIdentifier("StyleViewController") as! StyleViewController
                    if(self.currentIndex == 0)
                    {
                        nextView.chooseType = CHOOSE_LISTS
                    }
                    else if(self.currentIndex == 1)
                    {
                        nextView.chooseType = CHOOSE_FEEDS
                    }
                    else if(self.currentIndex == 2)
                    {
                        nextView.chooseType = CHOOSE_MAPS
                    }
                    else if(self.currentIndex == 3)
                    {
                        nextView.chooseType = CHOOSE_IMAGES
                    }
                    else if(self.currentIndex == 4)
                    {
                        nextView.chooseType = CHOOSE_MEDIA
                    }
                    else if(self.currentIndex == 5)
                    {
                        nextView.chooseType = CHOOSE_ACTIONS
                    }
                    else if(self.currentIndex == 6)
                    {
                        nextView.chooseType = CHOOSE_PROMO
                    }
                    
                    self.navigationController?.pushViewController(nextView, animated: false)
                    viewContainer.removeFromSuperview()
            }
            */
            
            let viewMask = UIView(frame: rect)
            viewMask.backgroundColor = AppDelegate().getDelegate().currentApper.mainColor
            viewMask.layer.borderColor = AppDelegate().getDelegate().currentApper.mainColor.CGColor
            viewMask.layer.borderWidth = CGFloat(CHOOSE_BORDER_WIDTH)
            viewMask.layer.cornerRadius = CGFloat(CHOOSE_CORNER_RADIUS)
            
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
                        //

                        UIView.animateWithDuration(NEXT_PAGE_MOVING_ZOOM2_TIME,
                            delay: 0,
                            options: [.CurveEaseIn, .AllowUserInteraction],
                            animations: { () -> Void in
                                
                                viewMask.transform = CGAffineTransformScale(viewMask.transform,
                                    CGFloat(NEXT_PAGE_MOVING_ZOOM2_VALUE),
                                    CGFloat(NEXT_PAGE_MOVING_ZOOM2_VALUE))
                                
                            }) {(Bool) -> Void in
                                
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let nextView = storyboard.instantiateViewControllerWithIdentifier("StyleViewController") as! StyleViewController
                                if(self.currentIndex == 0)
                                {
                                    nextView.chooseType = CHOOSE_LISTS
                                }
                                else if(self.currentIndex == 1)
                                {
                                    nextView.chooseType = CHOOSE_FEEDS
                                }
                                else if(self.currentIndex == 2)
                                {
                                    nextView.chooseType = CHOOSE_MAPS
                                }
                                else if(self.currentIndex == 3)
                                {
                                    nextView.chooseType = CHOOSE_IMAGES
                                }
                                else if(self.currentIndex == 4)
                                {
                                    nextView.chooseType = CHOOSE_MEDIA
                                }
                                else if(self.currentIndex == 5)
                                {
                                    nextView.chooseType = CHOOSE_ACTIONS
                                }
                                else if(self.currentIndex == 6)
                                {
                                    nextView.chooseType = CHOOSE_PROMO
                                }
                                
                                self.navigationController?.pushViewController(nextView, animated: false)
                                viewMask.removeFromSuperview()
                        }
                    }
            }

        }
    }
}
