//
//  PostViewController.swift
//  Apper
//
//  Created by jian on 8/14/15.
//  Copyright © 2015 jinhu. All rights reserved.
//

import UIKit

class PostViewController: BaseViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource
{
    @IBOutlet weak var viewMask: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var arrItems: NSArray!
    
    var contentsHalfSize: CGFloat!
    var contentsSize: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        AppDelegate().getDelegate().currentApper = Apper()
        
        //Init Data.
        let arrCategories = AppDelegate().getDelegate().currentApper.arrCategories
        arrItems = arrCategories
        arrItems = arrItems.arrayByAddingObjectsFromArray(arrCategories as [AnyObject]) // duplicate the arrCategories
        
        contentsHalfSize = CGFloat((arrItems.count/2)*80)
        contentsSize = CGFloat(arrItems.count*80)
        
        
        self.collectionView.backgroundColor = UIColor.whiteColor()
        
        // Show Mask.
        self.view.bringSubviewToFront(self.viewMask)
        UIView.animateWithDuration(0.2,
            delay: 0.2,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewMask.alpha = 0
                
            }) {(Bool) -> Void in
        }
        
        print(self.collectionView.contentOffset.y)
//        self.collectionView.contentOffset.y += contentsHalfSize + 20
        
        if AppDelegate().getDelegate().DEBUG {
            gotoMakerView(1) // skip everything
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: CollectView Delegate.
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        return CGSizeMake(1, -20)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
    {
        return CGSizeMake(1, 0)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(arrItems.count)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let name = arrItems[indexPath.row] as! String
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MJCell", forIndexPath: indexPath) as! MJCollectionViewCell
        cell.image = UIImage(named: String(format: "%@.jpg", name))
        let yOffset = ((self.collectionView.contentOffset.y - cell.frame.origin.y) / CGFloat(IMAGE_HEIGHT)) * CGFloat(IMAGE_OFFSET_SPEED);

        cell.imageOffset = CGPointMake(0.0, yOffset);
        cell.lblTitle.text = name;
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        
        for view in self.collectionView.visibleCells()
        {
            let cell = view as! MJCollectionViewCell
            let yOffset = ((self.collectionView.contentOffset.y - view.frame.origin.y) / CGFloat(IMAGE_HEIGHT)) * CGFloat(IMAGE_OFFSET_SPEED)
            cell.imageOffset = CGPointMake(0.0, yOffset);
        }
        
        // trigger the looping feather of collections view
        if(self.collectionView.contentOffset.y <= -20)
        {
            self.collectionView.contentOffset.y += contentsHalfSize+20+4
        }
        else if(self.collectionView.contentOffset.y >= contentsSize - self.collectionView.frame.size.height)
        {
            self.collectionView.contentOffset.y -= contentsHalfSize+20+4
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! MJCollectionViewCell
        cell.lblTitle?.hidden = true
        
        let currentIndex = indexPath.row%(abs(arrItems.count/2))
        
        let name = arrItems[currentIndex] as! String
        let imgMain = UIImage(named: String(format: "%@.jpg", name))
        
        let viewOverlay = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        viewOverlay.image = imgMain
        self.view.addSubview(viewOverlay)
        
        let viewMask1 = UIView(frame: CGRectMake(0, 0, self.view.frame.width, cell.frame.origin.y - collectionView.contentOffset.y))
        viewMask1.backgroundColor = UIColor.blackColor()
        self.view.addSubview(viewMask1)

        let fy = cell.frame.origin.y - collectionView.contentOffset.y + cell.frame.size.height * 2 / 3 - 3
        let viewMask2 = UIView(frame: CGRectMake(0, fy,
            self.view.frame.width, self.view.frame.height -  fy))
        viewMask2.backgroundColor = UIColor.blackColor()
        self.view.addSubview(viewMask2)

        UIView.animateWithDuration(0.2,
            delay: 0.0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                viewMask1.frame = CGRectMake(viewMask1.frame.origin.x,
                    viewMask1.frame.origin.y,
                    viewMask1.frame.width,
                    0)
                
                viewMask2.frame = CGRectMake(viewMask2.frame.origin.x,
                    self.view.frame.height,
                    viewMask1.frame.width,
                    0)
                
            }) {(Bool) -> Void in
                
                self.gotoMakerView(currentIndex)
        }

    }
    
    func gotoMakerView(index: Int){
        
        let name = arrItems.objectAtIndex(index) as! String
        let imgMain = UIImage(named: String(format: "%@.jpg", name))
        
        AppDelegate().getDelegate().currentApper.category = index
        AppDelegate().getDelegate().currentApper.appCategory = name
        AppDelegate().getDelegate().currentApper.imgBackground = imgMain
        AppDelegate().getDelegate().currentApper.imgDefault = imgMain
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextView = storyboard.instantiateViewControllerWithIdentifier("MakerViewController") as! MakerViewController
        nextView.imgMain = imgMain
        self.navigationController?.pushViewController(nextView, animated: false)
    }
}
