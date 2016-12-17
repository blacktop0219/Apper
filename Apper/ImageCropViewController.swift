//
//  ImageCropViewController.swift
//  Apper
//
//  Created by Usman Mughal on 16/10/2015.
//  Copyright © 2015 jinhu. All rights reserved.
//

import UIKit

protocol ImageCropViewControllerDelegate {
    func imageCropViewControllerDidFinish(viewController: ImageCropViewController, image: UIImage, isIcon: Bool)
}

class ImageCropViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewRatioRect: UIImageView!
    @IBOutlet weak var viewButtonBar: UIView!
    
    var image: UIImage!
    var isIcon = false
    var availableHeight: CGFloat!
    var splashDimenssions: (width: CGFloat, height: CGFloat) = (width: 768, height: 1136)
    var overlays: (top: UIView, bottom: UIView, left: UIView, right: UIView) = (top: UIView(), bottom: UIView(), left: UIView(), right: UIView())
    
    var delegate: ImageCropViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // prepare image and add into scrollview
        imageView.image = image
        imageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size:image.size)
        scrollView.addSubview(imageView)
        scrollView.delegate = self
        scrollView.contentSize = image.size
        
        availableHeight = view.frame.size.height - viewButtonBar.frame.height
        
        scrollView.frame = view.frame
        viewButtonBar.frame.origin = CGPoint(x: 0, y: availableHeight)
        var newSize = viewRatioRect.frame.size
        let heightWithoutStatusBarHeight = availableHeight-20
        if heightWithoutStatusBarHeight < newSize.height {
            let scale = heightWithoutStatusBarHeight/newSize.height
            newSize.height = scale*newSize.height
            newSize.width = scale*newSize.width
        }
        
        if isIcon {
            newSize.height = newSize.width // we need a squere image for icon
            viewRatioRect.image = UIImage(named: "iconBox")
        }
        
        // 90% size of image
        newSize.width = newSize.width*0.9
        newSize.height = newSize.height*0.9
        
        viewRatioRect.frame.size = newSize
        viewRatioRect.frame.origin = CGPoint(x: (view.frame.width - newSize.width)/2, y: 20+(heightWithoutStatusBarHeight - newSize.height)/2)
        prepareOverlayViews()
        resetViewRatioRect(newSize.width, newH: newSize.height)
        
        let scaleHeight = viewRatioRect.frame.height/scrollView.contentSize.height
        let scaleWidth = viewRatioRect.frame.width/scrollView.contentSize.width
        let minScale = max(scaleHeight, scaleWidth)
        print( minScale, scaleHeight, scaleWidth )
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = minScale + 5
        scrollView.zoomScale = minScale
        
        // limit the scrollview paning area
        scrollView.contentInset = UIEdgeInsetsMake(viewRatioRect.frame.origin.y, viewRatioRect.frame.origin.x, scrollView.frame.height - (viewRatioRect.frame.origin.y + viewRatioRect.frame.height), scrollView.frame.width - (viewRatioRect.frame.origin.x + viewRatioRect.frame.width))

        // Do any additional setup after loading the view.
    }
    
    func prepareOverlayViews()
    {
        let mirror = Mirror(reflecting: overlays)
        for (_, value) in mirror.children {
            let lv = value as! UIView
            lv.backgroundColor = UIColor(white: 0, alpha: 0.63)
            self.view.addSubview(lv)
            lv.bringSubviewToFront(lv)
        }
    }
    
    func resetViewRatioRect(newW: CGFloat, newH: CGFloat)
    {
        let newX = (self.view.frame.width - newW)/2
        let newY:CGFloat = 20 + ((availableHeight - newH - 20)/2)
        let width = self.view.frame.width
        viewRatioRect.frame = CGRect(x: newX, y: newY, width: newW, height: newH)
        overlays.top.frame = CGRect(x: 0, y: 0, width: width, height: newY)
        overlays.left.frame = CGRect(x: 0, y: newY, width: newX, height: newH)
        overlays.right.frame = CGRect(x: newX+newW, y: newY, width: newX, height: newH)
        overlays.bottom.frame = CGRect(x: 0, y: newY+newH, width: width, height: availableHeight-newY-newH)
    }
    
    func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
        
        let pointInView = recognizer.locationInView(imageView)

        var newZoomScale = scrollView.zoomScale * 1.5
        newZoomScale = min(newZoomScale, scrollView.maximumZoomScale)
        
        let scrollViewSize = scrollView.bounds.size
        let w = scrollViewSize.width / newZoomScale
        let h = scrollViewSize.height / newZoomScale
        let x = pointInView.x - (w / 2.0)
        let y = pointInView.y - (h / 2.0)
        
        let rectToZoomTo = CGRectMake(x, y, w, h);
        
        scrollView.zoomToRect(rectToZoomTo, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func imageFromView(srcImage: UIImage, rect: CGRect) -> UIImage {
        let cr: CGImageRef = CGImageCreateWithImageInRect(srcImage.CGImage, rect)!
        let cropped: UIImage = UIImage(CGImage: cr)
        return cropped
        
    }
    
    func cropImage() -> UIImage {
        var visibleRect = CGRect()
        let scale: CGFloat = 1.0 / scrollView.zoomScale
        visibleRect.origin.x = (scrollView.contentOffset.x + viewRatioRect.frame.origin.x) * scale
        visibleRect.origin.y = (scrollView.contentOffset.y + viewRatioRect.frame.origin.y) * scale
        visibleRect.size.width = viewRatioRect.frame.width * scale
        visibleRect.size.height = viewRatioRect.frame.height * scale
        return imageFromView(imageView.image!, rect: visibleRect)
    }
    
    // MARK: - IBActions
    @IBAction func actionCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func actionChoose(sender: AnyObject) {
        
        delegate?.imageCropViewControllerDidFinish(self, image: cropImage(), isIcon: isIcon)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
