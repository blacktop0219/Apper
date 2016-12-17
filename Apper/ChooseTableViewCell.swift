//
//  ChooseTableViewCell.swift
//  Apper
//
//  Created by jian on 9/2/15.
//  Copyright © 2015 jinhu. All rights reserved.
//

import UIKit

protocol ChooseTableViewCellDelegate {
    func cellButtonTapped(cell: ChooseTableViewCell, index: Int)
}

class ChooseTableViewCell: UITableViewCell {

    @IBOutlet weak var viewBackBg: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    //Lists.
    @IBOutlet weak var viewLists: UIView!
    @IBOutlet weak var viewListCircle1: UIView!
    @IBOutlet weak var viewListLine1: UIView!
    @IBOutlet weak var viewListCircle2: UIView!
    @IBOutlet weak var viewListLine2: UIView!
    @IBOutlet weak var viewListCircle3: UIView!
    @IBOutlet weak var viewListLine3: UIView!
    @IBOutlet weak var viewListCircle4: UIView!
    @IBOutlet weak var viewListLine4: UIView!
    @IBOutlet weak var viewListCircle5: UIView!
    @IBOutlet weak var viewListLine5: UIView!
    
    var transformListCircle1: CGAffineTransform!
    var rectListLine1: CGRect!
    var transformListCircle2: CGAffineTransform!
    var rectListLine2: CGRect!
    var transformListCircle3: CGAffineTransform!
    var rectListLine3: CGRect!
    var transformListCircle4: CGAffineTransform!
    var rectListLine4: CGRect!
    var transformListCircle5: CGAffineTransform!
    var rectListLine5: CGRect!
    
    //Feeds
    @IBOutlet weak var viewFeeds: UIView!
    @IBOutlet weak var viewFeedsRect1: UIView!
    @IBOutlet weak var viewFeedsLine1: UIView!
    @IBOutlet weak var viewFeedsLine2: UIView!
    @IBOutlet weak var viewFeedsRect2: UIView!
    @IBOutlet weak var viewFeedsLine3: UIView!
    @IBOutlet weak var viewFeedsLine4: UIView!
    @IBOutlet weak var viewFeedsRect3: UIView!
    @IBOutlet weak var viewFeedsLine5: UIView!
    @IBOutlet weak var viewFeedsLine6: UIView!
    
    var transformFeedsRect1: CGAffineTransform!
    var transformFeedsRect2: CGAffineTransform!
    var transformFeedsRect3: CGAffineTransform!
    var rectFeedsLine1: CGRect!
    var rectFeedsLine2: CGRect!
    var rectFeedsLine3: CGRect!
    var rectFeedsLine4: CGRect!
    var rectFeedsLine5: CGRect!
    var rectFeedsLine6: CGRect!
    
    //Maps
    @IBOutlet weak var viewMaps: UIView!
    @IBOutlet weak var viewMapLineContainer1: UIView!
    @IBOutlet weak var viewMapLine1: UIView!
    @IBOutlet weak var viewMapLineContainer2: UIView!
    @IBOutlet weak var viewMapLine2: UIView!
    @IBOutlet weak var viewMapLineContainer3: UIView!
    @IBOutlet weak var viewMapLine3: UIView!
    @IBOutlet weak var imgPinView1: UIImageView!
    @IBOutlet weak var imgPinView2: UIImageView!
    @IBOutlet weak var imgPinView3: UIImageView!
    @IBOutlet weak var viewMapContainer: UIView!
    @IBOutlet weak var imgMapView: UIImageView!
    
    var rectMapLineContainer1: CGRect!
    var rectMapLineContainer2: CGRect!
    var rectMapLineContainer3: CGRect!
    var rectMapContainer: CGRect!
    var ptMapPinCenter1: CGPoint!
    var ptMapPinCenter2: CGPoint!
    var ptMapPinCenter3: CGPoint!
    
    //Images.
    @IBOutlet weak var viewImages: UIView!
    @IBOutlet weak var imgImagesView: UIView!
    @IBOutlet weak var viewImagesRect1: UIView!
    @IBOutlet weak var viewImagesRect2: UIView!
    
    var rectImagesRect1: CGRect!
    var rectImagesRect2: CGRect!
    
    //Media
    @IBOutlet weak var viewMedia: UIView!
    @IBOutlet weak var viewMediaSliderThumb: UIView!
    @IBOutlet weak var viewMediaSliderBar: UIView!
    @IBOutlet weak var viewMediaTop: UIView!
    @IBOutlet weak var imgMediaIcon: UIView!
    
    var transformMediaIcon: CGAffineTransform!
    var transformMediaTop: CGAffineTransform!
    var rectMediaThumb: CGRect!
    
    //Actions
    @IBOutlet weak var viewActions: UIView!
    @IBOutlet weak var imgActionKeyboard: UIImageView!
    @IBOutlet weak var imgActionInput: UIImageView!
    @IBOutlet weak var viewActionBar: UIView!
    
    var rectActionKeyboard: CGRect!
    var rectActionInput: CGRect!
    
    //Promo
    @IBOutlet weak var viewPromo: UIView!
    @IBOutlet weak var viewPromoRect: UIView!
    @IBOutlet weak var viewPromoCircle: UIView!
    
    var transformPromoCircle: CGAffineTransform!
    var rectPromoRect: CGRect!
    
    var delegate: ChooseTableViewCellDelegate?
    var currentIndex: Int!
    var transformTitle: CGAffineTransform!
    var rectDescription: CGRect!
    var ptCenterTitle: CGPoint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let color = AppDelegate().getDelegate().currentApper.mainColor
        self.layer.masksToBounds = true
        
        transformTitle = lblTitle.transform
        rectDescription = lblDescription.frame
        
        lblDescription.frame = CGRectMake(self.bounds.width, rectDescription.origin.y, rectDescription.width, rectDescription.height)
        ptCenterTitle = lblTitle.center
        
        //List
        viewLists.alpha = 0
        viewLists.frame = CGRectMake(viewLists.frame.origin.x, 21, viewLists.frame.width, viewLists.frame.height)
        viewLists.layer.masksToBounds = true
        viewLists.layer.cornerRadius = CGFloat(CHOOSE_CORNER_RADIUS)
//        viewLists.layer.borderColor = UIColor.whiteColor().CGColor
//        viewLists.layer.borderWidth = CGFloat(CHOOSE_BORDER_WIDTH)

        viewListCircle1.layer.cornerRadius = viewListCircle1.frame.width/2.0
        viewListLine1.layer.cornerRadius = viewListLine1.frame.height/2.0
        viewListCircle2.layer.cornerRadius = viewListCircle2.frame.width/2.0
        viewListLine2.layer.cornerRadius = viewListLine2.frame.height/2.0
        viewListCircle3.layer.cornerRadius = viewListCircle3.frame.width/2.0
        viewListLine3.layer.cornerRadius = viewListLine3.frame.height/2.0
        viewListCircle4.layer.cornerRadius = viewListCircle4.frame.width/2.0
        viewListLine4.layer.cornerRadius = viewListLine4.frame.height/2.0
        viewListCircle5.layer.cornerRadius = viewListCircle5.frame.width/2.0
        viewListLine5.layer.cornerRadius = viewListLine5.frame.height/2.0
        
        transformListCircle1 = viewListCircle1.transform
        rectListLine1 = viewListLine1.frame
        transformListCircle2 = viewListCircle2.transform
        rectListLine2 = viewListLine2.frame
        transformListCircle3 = viewListCircle3.transform
        rectListLine3 = viewListLine3.frame
        transformListCircle4 = viewListCircle4.transform
        rectListLine4 = viewListLine4.frame
        transformListCircle5 = viewListCircle5.transform
        rectListLine5 = viewListLine5.frame
        
        //Feeds.
        viewFeeds.alpha = 0
        viewFeeds.frame = CGRectMake(viewFeeds.frame.origin.x, 21, viewFeeds.frame.width, viewFeeds.frame.height)
        viewFeeds.layer.masksToBounds = true
        viewFeeds.layer.cornerRadius = CGFloat(CHOOSE_CORNER_RADIUS)
//        viewFeeds.layer.borderColor = UIColor.whiteColor().CGColor
//        viewFeeds.layer.borderWidth = CGFloat(CHOOSE_BORDER_WIDTH)
        
        viewFeedsRect1.layer.cornerRadius = 5.0
        viewFeedsLine1.layer.cornerRadius = viewFeedsLine1.frame.height/2.0
        viewFeedsLine2.layer.cornerRadius = viewFeedsLine2.frame.height/2.0
        viewFeedsRect2.layer.cornerRadius = 5.0
        viewFeedsLine3.layer.cornerRadius = viewFeedsLine3.frame.height/2.0
        viewFeedsLine4.layer.cornerRadius = viewFeedsLine4.frame.height/2.0
        viewFeedsRect3.layer.cornerRadius = 5.0
        viewFeedsLine5.layer.cornerRadius = viewFeedsLine5.frame.height/2.0
        viewFeedsLine6.layer.cornerRadius = viewFeedsLine6.frame.height/2.0
        
        transformFeedsRect1 = viewFeedsRect1.transform
        transformFeedsRect2 = viewFeedsRect2.transform
        transformFeedsRect3 = viewFeedsRect3.transform
        
        rectFeedsLine1 = viewFeedsLine1.frame
        rectFeedsLine2 = viewFeedsLine2.frame
        rectFeedsLine3 = viewFeedsLine3.frame
        rectFeedsLine4 = viewFeedsLine4.frame
        rectFeedsLine5 = viewFeedsLine5.frame
        rectFeedsLine6 = viewFeedsLine6.frame
        
        //Maps.
        viewMaps.alpha = 0
        viewMaps.frame = CGRectMake(viewMaps.frame.origin.x, 21, viewMaps.frame.width, viewMaps.frame.height)
        viewMaps.layer.masksToBounds = true
        viewMaps.layer.cornerRadius = CGFloat(CHOOSE_CORNER_RADIUS)
//        viewMaps.layer.borderColor = UIColor.whiteColor().CGColor
//        viewMaps.layer.borderWidth = CGFloat(CHOOSE_BORDER_WIDTH)
        
        viewMapLine1.transform = CGAffineTransformRotate(viewMapLine1.transform, 0.93)
        viewMapLine2.transform = CGAffineTransformRotate(viewMapLine2.transform, -0.62)
        viewMapLine3.transform = CGAffineTransformRotate(viewMapLine3.transform, -0.62)
        
        rectMapLineContainer1 = viewMapLineContainer1.frame
        rectMapLineContainer2 = viewMapLineContainer2.frame
        rectMapLineContainer3 = viewMapLineContainer3.frame
        rectMapContainer = viewMapContainer.frame
        
        ptMapPinCenter1 = imgPinView1.center
        ptMapPinCenter2 = imgPinView2.center
        ptMapPinCenter3 = imgPinView3.center
        
        viewMapLineContainer1.layer.masksToBounds = true
        viewMapLineContainer2.layer.masksToBounds = true
        viewMapLineContainer3.layer.masksToBounds = true
        viewMapContainer.layer.masksToBounds = true
        
        //Images
        viewImages.alpha = 0
        viewImages.frame = CGRectMake(viewImages.frame.origin.x, 21, viewImages.frame.width, viewImages.frame.height)
        viewImages.layer.masksToBounds = true
        viewImages.layer.cornerRadius = CGFloat(CHOOSE_CORNER_RADIUS)
//        viewImages.layer.borderColor = UIColor.whiteColor().CGColor
//        viewImages.layer.borderWidth = CGFloat(CHOOSE_BORDER_WIDTH)
        
        rectImagesRect1 = viewImagesRect1.frame
        rectImagesRect2 = viewImagesRect2.frame
        
        //Media.
        viewMedia.alpha = 0
        viewMedia.frame = CGRectMake(viewMedia.frame.origin.x, 21, viewMedia.frame.width, viewMedia.frame.height)
        viewMedia.layer.masksToBounds = true
        viewMedia.layer.cornerRadius = CGFloat(CHOOSE_CORNER_RADIUS)
//        viewMedia.layer.borderColor = UIColor.whiteColor().CGColor
//        viewMedia.layer.borderWidth = CGFloat(CHOOSE_BORDER_WIDTH)
        
        viewMediaSliderThumb.layer.cornerRadius = viewMediaSliderThumb.frame.width/2.0
        viewMediaSliderThumb.backgroundColor = color
        
        viewMediaSliderBar.layer.cornerRadius = viewMediaSliderBar.frame.height/2.0
        viewMediaSliderBar.backgroundColor = color
        viewMediaSliderBar.alpha = 0.5
        
        rectMediaThumb = viewMediaSliderThumb.frame
        transformMediaTop = viewMediaTop.transform
        transformMediaIcon = imgMediaIcon.transform
        
        //Actions.
        viewActions.alpha = 0
        viewActions.frame = CGRectMake(viewActions.frame.origin.x, 21, viewActions.frame.width, viewActions.frame.height)
        viewActions.layer.masksToBounds = true
        viewActions.layer.cornerRadius = CGFloat(CHOOSE_CORNER_RADIUS)
//        viewActions.layer.borderColor = UIColor.whiteColor().CGColor
//        viewActions.layer.borderWidth = CGFloat(CHOOSE_BORDER_WIDTH)

        rectActionKeyboard = imgActionKeyboard.frame
        rectActionInput = imgActionInput.frame
        
        //Promo.
        viewPromo.alpha = 0
        viewPromo.frame = CGRectMake(viewPromo.frame.origin.x, 21, viewPromo.frame.width, viewPromo.frame.height)
        viewPromo.layer.masksToBounds = true
        viewPromo.layer.cornerRadius = CGFloat(CHOOSE_CORNER_RADIUS)
//        viewPromo.layer.borderColor = UIColor.whiteColor().CGColor
//        viewPromo.layer.borderWidth = CGFloat(CHOOSE_BORDER_WIDTH)
        
        viewPromoCircle.layer.cornerRadius = viewPromoCircle.frame.width/2.0
        viewPromoRect.layer.cornerRadius = CGFloat(CHOOSE_CORNER_RADIUS + 3.0)
        viewPromoRect.layer.borderColor = UIColor.whiteColor().CGColor
        viewPromoRect.layer.borderWidth = CGFloat(CHOOSE_BORDER_WIDTH)
        
        transformPromoCircle = viewPromoCircle.transform
        rectPromoRect = viewPromoRect.frame
        
        let gesture = UITapGestureRecognizer(target: self, action: Selector("tapCell"))
        gesture.numberOfTouchesRequired = 1
        self.addGestureRecognizer(gesture)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(index: Int!)
    {
        currentIndex = index
        self.backgroundColor = AppDelegate().getDelegate().currentApper.mainColor
        
        if(index == 0)
        {
            lblTitle.text = "Lists"
            lblDescription.text = "Display a set of records like products, contacts, events, items, etc. and link them to other screens or actions..."
            viewBackBg.alpha = 0
        }
        else if(index == 1)
        {
            lblTitle.text = "Feeds"
            lblDescription.text = "Connect to your social networks, blogs and online articles easily to get dynamic content..."
            viewBackBg.alpha = 0.1
        }
        else if(index == 2)
        {
            lblTitle.text = "Maps"
            lblDescription.text = "Set pins to show people your locations, places of interest, a route or your office..."
            viewBackBg.alpha = 0.2
        }
        else if(index == 3)
        {
            lblTitle.text = "Images"
            lblDescription.text = "Add a gallery of images, an image slider, zoomable images, full screen images and more..."
            viewBackBg.alpha = 0.3
        }
        else if(index == 4)
        {
            lblTitle.text = "Media"
            lblDescription.text = "Play videos and music from your online content like Youtube and Video..."
            viewBackBg.alpha = 0.4
        }
        else if(index == 5)
        {
            lblTitle.text = "Actions"
            lblDescription.text = "Set actions to make your users call you, text you, send an email, pay you, open a web address, among others..."
            viewBackBg.alpha = 0.5
        }
        else if(index == 6)
        {
            lblTitle.text = "Promo"
            lblDescription.text = "Create promotional offers with a QR Code, Bar Code, details about your product or biography and many more..."
            viewBackBg.alpha = 0.6
        }
        
        lblDescription.frame = CGRectMake(lblDescription.frame.origin.x, lblDescription.frame.origin.y, rectDescription.width, rectDescription.height)
        lblDescription.sizeToFit()
    }
    
    //MARK: Animate.
    func animateCell()
    {
        var offsetX = 0.0
        let offsetY = 8.0
        
        //Lists.
        if(currentIndex == 0)
        {
            offsetX = 16.0
            viewLists.alpha = 1
            self.setDefaultListValue()
        }
            
        //Feeds.
        else if(currentIndex == 1)
        {
            offsetX = 23.0
            viewFeeds.alpha = 1
            self.setDefaultFeedsValue()
        }
            
        //Maps.
        else if(currentIndex == 2)
        {
            offsetX = 20.0
            self.viewMaps.alpha = 1
            self.setDefaultMapsValue()
        }
            
        //Images.
        else if(currentIndex == 3)
        {
            offsetX = 28.0
            self.viewImages.alpha = 1
            self.setDefaultImagesValue()
        }
        
        //Media.
        else if(currentIndex == 4)
        {
            offsetX = 22.0
            self.viewMedia.alpha = 1
            self.setDefaultMediaValue()
        }
        
        //Actions.
        else if(currentIndex == 5)
        {
            offsetX = 30.0
            self.viewActions.alpha = 1
            self.setDefaultActionsValue()
        }
        
        //Promo.
        else if(currentIndex == 6)
        {
            offsetX = 26.0
            self.viewPromo.alpha = 1
            self.setDefaultPromoValue()
        }

        UIView.animateWithDuration(0.2,
            delay: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.lblTitle.transform = CGAffineTransformScale(self.transformTitle, 1.2, 1.2)
                self.lblTitle.center = CGPointMake(self.ptCenterTitle.x + CGFloat(offsetX), self.ptCenterTitle.y + CGFloat(offsetY))
                
            }) { (Bool) -> Void in
                
                UIView.animateWithDuration(0.4,
                    delay: 0,
                    options: [.CurveEaseInOut, .AllowUserInteraction],
                    animations: { () -> Void in
                        
                        if(self.currentIndex == 0)
                        {
                            self.animateListCell()
                        }
                        else if(self.currentIndex == 1)
                        {
                            self.animateFeedsCell()
                        }
                        else if(self.currentIndex == 2)
                        {
                            self.animateMapsCell()
                        }
                        else if(self.currentIndex == 3)
                        {
                            self.animateImagesCell()
                        }
                        else if(self.currentIndex == 4)
                        {
                            self.animateMediaCell()
                        }
                        else if(self.currentIndex == 5)
                        {
                            self.animateActionsCell()
                        }
                        else if(self.currentIndex == 6)
                        {
                            self.animatePromoCell()
                        }
                        
                        self.lblDescription.frame = CGRectMake(self.rectDescription.origin.x,
                            self.rectDescription.origin.y,
                            self.lblDescription.frame.width,
                            self.lblDescription.frame.height)
                        
                    }) { (Bool) -> Void in
                }
        }
    }
    
    func moveToNormalState(index: Int, completion: ((Bool) -> Void)?)
    {
        UIView.animateWithDuration(0.3,
            delay: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.lblTitle.transform = self.transformTitle
                
            }) { (flag: Bool) -> Void in
                
                UIView.animateWithDuration(0.1,
                    delay: 0,
                    options: [.CurveEaseInOut, .AllowUserInteraction],
                    animations: { () -> Void in
                        
                        self.lblTitle.center = self.ptCenterTitle
                        
                    }) { (flag: Bool) -> Void in
                        
                }
        }
        
        UIView.animateWithDuration(0.1,
            delay: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.lblDescription.frame = CGRectMake(self.bounds.width,
                    self.rectDescription.origin.y,
                    self.lblDescription.frame.width,
                    self.lblDescription.frame.height)
                
            }) { (flag: Bool) -> Void in
                
                completion!(flag)
        }

        
        let fy = CGFloat(index - self.currentIndex)
        var offset = CGFloat(0.0)
        offset = CGFloat(CGFloat(CHOOSE_FRAME_OFFSET) + fy * 64.0)
        
        if(index > self.currentIndex)
        {
            UIView.animateWithDuration(CHOOSE_FRAME_ANIM_TIME,
                delay: 0,
                options: [.CurveEaseInOut, .AllowUserInteraction],
                animations: { () -> Void in
                    
                    
                    if(self.currentIndex == 0)
                    {
                        self.viewLists.alpha = 0
                        self.viewLists.frame = CGRectMake(self.viewLists.frame.origin.x, offset, self.viewLists.frame.width, self.viewLists.frame.height)
                    }
                    else if(self.currentIndex == 1)
                    {
                        self.viewFeeds.alpha = 0
                        self.viewFeeds.frame = CGRectMake(self.viewFeeds.frame.origin.x, offset, self.viewFeeds.frame.width, self.viewFeeds.frame.height)
                    }
                    else if(self.currentIndex == 2)
                    {
                        self.viewMaps.alpha = 0
                        self.viewMaps.frame = CGRectMake(self.viewMaps.frame.origin.x, offset, self.viewMaps.frame.width, self.viewMaps.frame.height)
                    }
                    else if(self.currentIndex == 3)
                    {
                        self.viewImages.alpha = 0
                        self.viewImages.frame = CGRectMake(self.viewImages.frame.origin.x, offset, self.viewImages.frame.width, self.viewImages.frame.height)
                    }
                    else if(self.currentIndex == 4)
                    {
                        self.viewMedia.alpha = 0
                        self.viewMedia.frame = CGRectMake(self.viewMedia.frame.origin.x, offset, self.viewMedia.frame.width, self.viewMedia.frame.height)
                    }
                    else if(self.currentIndex == 5)
                    {
                        self.viewActions.alpha = 0
                        self.viewActions.frame = CGRectMake(self.viewActions.frame.origin.x, offset, self.viewActions.frame.width, self.viewActions.frame.height)
                    }
                    else if(self.currentIndex == 6)
                    {
                        self.viewPromo.alpha = 0
                        self.viewPromo.frame = CGRectMake(self.viewPromo.frame.origin.x, offset, self.viewPromo.frame.width, self.viewPromo.frame.height)
                    }
                    
                }) { (flag: Bool) -> Void in
            }

        }
        else
        {
            UIView.animateWithDuration(CHOOSE_FRAME_ANIM_TIME,
                delay: 0,
                options: [.CurveEaseInOut, .AllowUserInteraction],
                animations: { () -> Void in
                    
                    
                    if(self.currentIndex == 0)
                    {
                        self.viewLists.frame = CGRectMake(self.viewLists.frame.origin.x, offset, self.viewLists.frame.width, self.viewLists.frame.height)
                    }
                    else if(self.currentIndex == 1)
                    {
                        self.viewFeeds.frame = CGRectMake(self.viewFeeds.frame.origin.x, offset, self.viewFeeds.frame.width, self.viewFeeds.frame.height)
                    }
                    else if(self.currentIndex == 2)
                    {
                        self.viewMaps.frame = CGRectMake(self.viewMaps.frame.origin.x, offset, self.viewMaps.frame.width, self.viewMaps.frame.height)
                    }
                    else if(self.currentIndex == 3)
                    {
                        self.viewImages.frame = CGRectMake(self.viewImages.frame.origin.x, offset, self.viewImages.frame.width, self.viewImages.frame.height)
                    }
                    else if(self.currentIndex == 4)
                    {
                        self.viewMedia.frame = CGRectMake(self.viewMedia.frame.origin.x, offset, self.viewMedia.frame.width, self.viewMedia.frame.height)
                    }
                    else if(self.currentIndex == 5)
                    {
                        self.viewActions.frame = CGRectMake(self.viewActions.frame.origin.x, offset, self.viewActions.frame.width, self.viewActions.frame.height)
                    }
                    else if(self.currentIndex == 6)
                    {
                        self.viewPromo.frame = CGRectMake(self.viewPromo.frame.origin.x, offset, self.viewPromo.frame.width, self.viewPromo.frame.height)
                    }
                    
                }) { (flag: Bool) -> Void in
                    
            }
            
            UIView.animateWithDuration(CHOOSE_FRAME_ANIM_TIME / 3.0,
                delay: 0,
                options: [.CurveEaseInOut, .AllowUserInteraction],
                animations: { () -> Void in
                    
                    
                    if(self.currentIndex == 0)
                    {
                        self.viewLists.alpha = 0
                    }
                    else if(self.currentIndex == 1)
                    {
                        self.viewFeeds.alpha = 0
                    }
                    else if(self.currentIndex == 2)
                    {
                        self.viewMaps.alpha = 0
                    }
                    else if(self.currentIndex == 3)
                    {
                        self.viewImages.alpha = 0
                    }
                    else if(self.currentIndex == 4)
                    {
                        self.viewMedia.alpha = 0
                    }
                    else if(self.currentIndex == 5)
                    {
                        self.viewActions.alpha = 0
                    }
                    else if(self.currentIndex == 6)
                    {
                        self.viewPromo.alpha = 0
                    }
                    
                }) { (flag: Bool) -> Void in
            }

        }
    }
    
    func tapCell()
    {
        delegate?.cellButtonTapped(self, index: currentIndex)
    }
    
    
    //MARK: List
    func setDefaultListValue()
    {
        viewLists.frame = CGRectMake(viewLists.frame.origin.x, CGFloat(CHOOSE_FRAME_OFFSET), viewLists.frame.width, viewLists.frame.height)
        
        viewListCircle1.transform = CGAffineTransformScale(transformListCircle1, 0.001, 0.001)
        viewListLine1.frame = CGRectMake(viewListLine1.frame.origin.x, viewListLine1.frame.origin.y, 0, viewListLine1.frame.height)
        
        viewListCircle2.transform = CGAffineTransformScale(transformListCircle2, 0.001, 0.001)
        viewListLine2.frame = CGRectMake(viewListLine2.frame.origin.x, viewListLine2.frame.origin.y, 0, viewListLine2.frame.height)
        
        viewListCircle3.transform = CGAffineTransformScale(transformListCircle3, 0.001, 0.001)
        viewListLine3.frame = CGRectMake(viewListLine3.frame.origin.x, viewListLine3.frame.origin.y, 0, viewListLine3.frame.height)
        
        viewListCircle4.transform = CGAffineTransformScale(transformListCircle4, 0.001, 0.001)
        viewListLine4.frame = CGRectMake(viewListLine4.frame.origin.x, viewListLine4.frame.origin.y, 0, viewListLine4.frame.height)
        
        viewListCircle5.transform = CGAffineTransformScale(transformListCircle5, 0.001, 0.001)
        viewListLine5.frame = CGRectMake(viewListLine5.frame.origin.x, viewListLine5.frame.origin.y, 0, viewListLine5.frame.height)
        
    }
    
    func animateListCell()
    {
        let animTime = 0.03
        let zoomValue = CGFloat(1.5)
        let lineAnimTime = animTime * 4
        let originAnimTime = animTime / 3.0
        var delay = 0.0
        let delayDelta = animTime * 4
        
        UIView.animateWithDuration(animTime,
            delay: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewListCircle1.transform = CGAffineTransformScale(self.transformListCircle1, zoomValue, zoomValue)
                
            }) { (flag: Bool) -> Void in
                
                if(flag == true)
                {
                    UIView.animateWithDuration(originAnimTime,
                        delay: 0,
                        options: [.CurveEaseInOut, .AllowUserInteraction],
                        animations: { () -> Void in
                            
                            self.viewListCircle1.transform = CGAffineTransformScale(self.transformListCircle1, 1.0, 1.0)
                            
                        }) { (flag: Bool) -> Void in
                            if(flag == true)
                            {
                                
                            }
                    }
                }
        }
        
        //Show Line.
        UIView.animateWithDuration(lineAnimTime,
            delay: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewListLine1.frame = self.rectListLine1
                
            }) { (flag: Bool) -> Void in
                
        }

        
        //2
        delay += delayDelta
        UIView.animateWithDuration(animTime,
            delay: delay,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewListCircle2.transform = CGAffineTransformScale(self.transformListCircle2, zoomValue, zoomValue)
                
            }) { (flag: Bool) -> Void in
                
                if(flag == true)
                {
                    UIView.animateWithDuration(originAnimTime,
                        delay: 0,
                        options: [.CurveEaseInOut, .AllowUserInteraction],
                        animations: { () -> Void in
                            
                            self.viewListCircle2.transform = CGAffineTransformScale(self.transformListCircle2, 1.0, 1.0)
                            
                        }) { (flag: Bool) -> Void in
                            if(flag == true)
                            {
                                
                            }
                    }
                }
        }
        
        //Show Line.
        UIView.animateWithDuration(lineAnimTime,
            delay: delay,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewListLine2.frame = self.rectListLine2
                
            }) { (flag: Bool) -> Void in
                
        }
        
        //3
        delay += delayDelta
        UIView.animateWithDuration(animTime,
            delay: delay,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewListCircle3.transform = CGAffineTransformScale(self.transformListCircle3, zoomValue, zoomValue)
                
            }) { (flag: Bool) -> Void in
                
                if(flag == true)
                {
                    UIView.animateWithDuration(originAnimTime,
                        delay: 0,
                        options: [.CurveEaseInOut, .AllowUserInteraction],
                        animations: { () -> Void in
                            
                            self.viewListCircle3.transform = CGAffineTransformScale(self.transformListCircle3, 1.0, 1.0)
                            
                        }) { (flag: Bool) -> Void in
                            if(flag == true)
                            {
                                
                            }
                    }
                }
        }
        
        UIView.animateWithDuration(lineAnimTime,
            delay: delay,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewListLine3.frame = self.rectListLine3
                
            }) { (flag: Bool) -> Void in
                
        }
        
        delay += delayDelta
        UIView.animateWithDuration(animTime,
            delay: delay,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewListCircle4.transform = CGAffineTransformScale(self.transformListCircle4, zoomValue, zoomValue)
                
            }) { (flag: Bool) -> Void in
                
                if(flag == true)
                {
                    UIView.animateWithDuration(originAnimTime,
                        delay: 0,
                        options: [.CurveEaseInOut, .AllowUserInteraction],
                        animations: { () -> Void in
                            
                            self.viewListCircle4.transform = CGAffineTransformScale(self.transformListCircle4, 1.0, 1.0)
                            
                        }) { (flag: Bool) -> Void in
                            if(flag == true)
                            {
                                
                            }
                    }
                }
        }
        
        UIView.animateWithDuration(lineAnimTime,
            delay: delay,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewListLine4.frame = self.rectListLine4
                
            }) { (flag: Bool) -> Void in
                
        }
        
        delay += delayDelta
        UIView.animateWithDuration(animTime,
            delay: delay,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewListCircle5.transform = CGAffineTransformScale(self.transformListCircle5, zoomValue, zoomValue)
                
            }) { (flag: Bool) -> Void in
                
                if(flag == true)
                {
                    UIView.animateWithDuration(originAnimTime,
                        delay: 0,
                        options: [.CurveEaseInOut, .AllowUserInteraction],
                        animations: { () -> Void in
                            
                            self.viewListCircle5.transform = CGAffineTransformScale(self.transformListCircle5, 1.0, 1.0)
                            
                        }) { (flag: Bool) -> Void in
                            if(flag == true)
                            {
                            }
                    }
                }
        }
        
        UIView.animateWithDuration(lineAnimTime,
            delay: delay,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewListLine5.frame = self.rectListLine5
                
            }) { (flag: Bool) -> Void in
                
        }
    }
    
    //MARK: Feeds.
    func setDefaultFeedsValue()
    {
        viewFeeds.frame = CGRectMake(viewFeeds.frame.origin.x, CGFloat(CHOOSE_FRAME_OFFSET), viewFeeds.frame.width, viewFeeds.frame.height)
        
        viewFeedsRect1.transform = CGAffineTransformScale(transformFeedsRect1, 0.001, 0.001)
        viewFeedsRect2.transform = CGAffineTransformScale(transformFeedsRect2, 0.001, 0.001)
        viewFeedsRect3.transform = CGAffineTransformScale(transformFeedsRect3, 0.001, 0.001)
        
        viewFeedsLine1.frame = CGRectMake(viewFeedsLine1.frame.origin.x, viewFeedsLine1.frame.origin.y, 0, viewFeedsLine1.frame.height)
        viewFeedsLine2.frame = CGRectMake(viewFeedsLine2.frame.origin.x, viewFeedsLine2.frame.origin.y, 0, viewFeedsLine2.frame.height)
        viewFeedsLine3.frame = CGRectMake(viewFeedsLine3.frame.origin.x, viewFeedsLine3.frame.origin.y, 0, viewFeedsLine3.frame.height)
        viewFeedsLine4.frame = CGRectMake(viewFeedsLine4.frame.origin.x, viewFeedsLine4.frame.origin.y, 0, viewFeedsLine4.frame.height)
        viewFeedsLine5.frame = CGRectMake(viewFeedsLine5.frame.origin.x, viewFeedsLine5.frame.origin.y, 0, viewFeedsLine5.frame.height)
        viewFeedsLine6.frame = CGRectMake(viewFeedsLine6.frame.origin.x, viewFeedsLine6.frame.origin.y, 0, viewFeedsLine6.frame.height)
    }
    
    func animateFeedsCell()
    {
        let animTime = 0.03
        let zoomValue = CGFloat(1.2)
        let lineAnimTime = animTime * 4
        let originAnimTime = animTime / 3.0
        var delay = 0.0
        let delayDelta = animTime * 4
        
        UIView.animateWithDuration(animTime,
            delay: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewFeedsRect1.transform = CGAffineTransformScale(self.transformFeedsRect1, zoomValue, zoomValue)
                
            }) { (flag: Bool) -> Void in
                
                if(flag == true)
                {
                    UIView.animateWithDuration(originAnimTime,
                        delay: 0,
                        options: [.CurveEaseInOut, .AllowUserInteraction],
                        animations: { () -> Void in
                            
                            self.viewFeedsRect1.transform = CGAffineTransformScale(self.transformFeedsRect1, 1.0, 1.0)
                            
                        }) { (flag: Bool) -> Void in
                            if(flag == true)
                            {
                                
                            }
                    }
                }
        }
        
        //Show Line.
        UIView.animateWithDuration(lineAnimTime,
            delay: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewFeedsLine1.frame = self.rectFeedsLine1
                self.viewFeedsLine2.frame = self.rectFeedsLine2
                
            }) { (flag: Bool) -> Void in
                
        }
        
        
        //2
        delay += delayDelta
        UIView.animateWithDuration(animTime,
            delay: delay,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewFeedsRect2.transform = CGAffineTransformScale(self.transformFeedsRect2, zoomValue, zoomValue)
                
            }) { (flag: Bool) -> Void in
                
                if(flag == true)
                {
                    UIView.animateWithDuration(originAnimTime,
                        delay: 0,
                        options: [.CurveEaseInOut, .AllowUserInteraction],
                        animations: { () -> Void in
                            
                            self.viewFeedsRect2.transform = CGAffineTransformScale(self.transformFeedsRect2, 1.0, 1.0)
                            
                        }) { (flag: Bool) -> Void in
                            if(flag == true)
                            {
                                
                            }
                    }
                }
        }
        
        //Show Line.
        UIView.animateWithDuration(lineAnimTime,
            delay: delay,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewFeedsLine3.frame = self.rectFeedsLine3
                self.viewFeedsLine4.frame = self.rectFeedsLine4
                
            }) { (flag: Bool) -> Void in
                
        }

        //3
        delay += delayDelta
        UIView.animateWithDuration(animTime,
            delay: delay,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewFeedsRect3.transform = CGAffineTransformScale(self.transformFeedsRect3, zoomValue, zoomValue)
                
            }) { (flag: Bool) -> Void in
                
                if(flag == true)
                {
                    UIView.animateWithDuration(originAnimTime,
                        delay: 0,
                        options: [.CurveEaseInOut, .AllowUserInteraction],
                        animations: { () -> Void in
                            
                            self.viewFeedsRect3.transform = CGAffineTransformScale(self.transformFeedsRect3, 1.0, 1.0)
                            
                        }) { (flag: Bool) -> Void in
                            if(flag == true)
                            {
                                
                            }
                    }
                }
        }
        
        //Show Line.
        UIView.animateWithDuration(lineAnimTime,
            delay: delay,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewFeedsLine5.frame = self.rectFeedsLine5
                self.viewFeedsLine6.frame = self.rectFeedsLine6
                
            }) { (flag: Bool) -> Void in
                
        }
    }
    
    //MARK: Maps.
    func setDefaultMapsValue()
    {
        viewMaps.frame = CGRectMake(viewMaps.frame.origin.x, CGFloat(CHOOSE_FRAME_OFFSET), viewMaps.frame.width, viewMaps.frame.height)
        
        viewMapLineContainer1.frame = CGRectMake(viewMapLineContainer1.frame.origin.x, viewMapLineContainer1.frame.origin.y, viewMapLineContainer1.frame.width, 0)
        viewMapLineContainer2.frame = CGRectMake(viewMapLineContainer2.frame.origin.x, viewMapLineContainer2.frame.origin.y, viewMapLineContainer2.frame.width, 0)
        viewMapLineContainer3.frame = CGRectMake(viewMapLineContainer3.frame.origin.x, viewMapLineContainer3.frame.origin.y, viewMapLineContainer3.frame.width, 0)
        viewMapContainer.frame = CGRectMake(viewMapContainer.frame.origin.x, viewMapContainer.frame.origin.y, viewMapContainer.frame.width, 0)
        
        let offset = CGFloat(40.0)
        imgPinView1.alpha = 0
        imgPinView1.center = CGPointMake(ptMapPinCenter1.x, ptMapPinCenter1.y - offset)
        
        imgPinView2.alpha = 0
        imgPinView2.center = CGPointMake(ptMapPinCenter2.x, ptMapPinCenter2.y - offset)
        
        imgPinView3.alpha = 0
        imgPinView3.center = CGPointMake(ptMapPinCenter3.x, ptMapPinCenter3.y - offset)
    }
    
    func animateMapsCell()
    {
        let animTime = 0.08

        UIView.animateWithDuration(animTime / 2.0,
            delay: 0.1,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewMapContainer.frame = self.rectMapContainer
                
            }) { (flag: Bool) -> Void in
                
                if(flag == true)
                {
                    UIView.animateWithDuration(animTime,
                        delay: 0,
                        options: [.CurveEaseInOut, .AllowUserInteraction],
                        animations: { () -> Void in
                            
                            self.viewMapLineContainer2.frame = self.rectMapLineContainer2
                            self.viewMapLineContainer3.frame = self.rectMapLineContainer3
                            
                        }) { (flag: Bool) -> Void in
                            
                            if(flag == true)
                            {
                                        if(flag == true)
                                        {
                                            UIView.animateWithDuration(animTime * 2,
                                                delay: 0,
                                                options: [.CurveEaseInOut, .AllowUserInteraction],
                                                animations: { () -> Void in
                                                    
                                                    self.viewMapLineContainer1.frame = self.rectMapLineContainer1
                                                    
                                                }) { (flag: Bool) -> Void in
                                                    
                                                    if(flag == true)
                                                    {
                                                        
                                            }
                                        }
                                }
                            }
                    }
                }
        }
        
        //Show Pins.
        UIView.animateWithDuration(animTime * 3,
            delay: 0.4,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.imgPinView3.alpha = 1
                self.imgPinView3.center = self.ptMapPinCenter3

                
            }) { (flag: Bool) -> Void in
                
                if(flag == true)
                {
                    UIView.animateWithDuration(animTime * 2,
                        delay: 0,
                        options: [.CurveEaseInOut, .AllowUserInteraction],
                        animations: { () -> Void in
                            
                            self.imgPinView1.alpha = 1
                            self.imgPinView1.center = self.ptMapPinCenter1
                            
                            self.imgPinView2.alpha = 1
                            self.imgPinView2.center = self.ptMapPinCenter2
                            
                        }) { (flag: Bool) -> Void in
                            
                            if(flag == true)
                            {
                                
                            }
                    }
                }
        }
    }
    
    //MARK: Images.
    func setDefaultImagesValue()
    {
        viewImages.frame = CGRectMake(viewImages.frame.origin.x, CGFloat(CHOOSE_FRAME_OFFSET), viewImages.frame.width, viewImages.frame.height)
        viewImagesRect2.frame = CGRectMake(rectImagesRect2.origin.x, rectImagesRect2.origin.y, rectImagesRect2.width, 0)
        
        viewImagesRect1.layer.anchorPoint = CGPointMake(0.5, 1.0)
        viewImagesRect1.frame = CGRectMake(rectImagesRect1.origin.x, rectImagesRect1.origin.y + rectImagesRect1.height, rectImagesRect1.width, 0)
        
        imgImagesView.alpha = 0
    }
    
    func animateImagesCell()
    {
        UIView.animateWithDuration(0.05,
            delay: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.imgImagesView.alpha = 1
                
            }) { (flag: Bool) -> Void in
                
                if(flag == true)
                {
                    UIView.animateWithDuration(0.1,
                        delay: 0,
                        options: [.CurveEaseInOut, .AllowUserInteraction],
                        animations: { () -> Void in
                            
                            self.viewImagesRect1.frame = self.rectImagesRect1
                            self.viewImagesRect2.frame = self.rectImagesRect2
                            
                        }) { (flag: Bool) -> Void in
                            
                            if(flag == true)
                            {
                                
                            }
                    }
                }
        }
    }
    
    //MARK: Media.
    func setDefaultMediaValue()
    {
        viewMedia.frame = CGRectMake(viewMedia.frame.origin.x, CGFloat(CHOOSE_FRAME_OFFSET), viewMedia.frame.width, viewMedia.frame.height)
        
        viewMediaTop.transform = CGAffineTransformScale(transformMediaTop, 0.001, 0.001)
        imgMediaIcon.transform = CGAffineTransformScale(transformMediaIcon, 0.001, 0.001)
        viewMediaSliderThumb.frame = rectMediaThumb
    }
    
    func animateMediaCell()
    {
        UIView.animateWithDuration(0.05,
            delay: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.imgMediaIcon.transform = CGAffineTransformScale(self.transformMediaIcon, 1.2, 1.2)
                
            }) { (flag: Bool) -> Void in
                
                if(flag == true)
                {
                    UIView.animateWithDuration(0.05,
                        delay: 0,
                        options: [.CurveEaseInOut, .AllowUserInteraction],
                        animations: { () -> Void in
                            
                            self.imgMediaIcon.transform = CGAffineTransformScale(self.transformMediaIcon, 1.0, 1.0)
                            
                        }) { (flag: Bool) -> Void in
                            
                            if(flag == true)
                            {
                                UIView.animateWithDuration(0.05,
                                    delay: 0,
                                    options: [.CurveEaseInOut, .AllowUserInteraction],
                                    animations: { () -> Void in
                                        
                                        self.viewMediaTop.transform = CGAffineTransformScale(self.transformMediaTop, 1.0, 1.0)
                                        
                                    }) { (flag: Bool) -> Void in
                                        
                                        if(flag == true)
                                        {
                                            UIView.animateWithDuration(0.3,
                                                delay: 0,
                                                options: [.CurveEaseInOut, .AllowUserInteraction],
                                                animations: { () -> Void in
                                                    
                                                    self.viewMediaSliderThumb.frame = CGRectMake(self.rectMediaThumb.origin.x + self.viewMediaSliderBar.frame.width - 10.0, self.rectMediaThumb.origin.y, self.rectMediaThumb.width, self.rectMediaThumb.height)
                                                    
                                                }) { (flag: Bool) -> Void in
                                                    
                                                    if(flag == true)
                                                    {
                                                    }
                                            }
                                        }
                                }
                            }
                    }
                }
        }

    }
    
    //MARK: Actions.
    func setDefaultActionsValue()
    {
        viewActions.frame = CGRectMake(viewActions.frame.origin.x, CGFloat(CHOOSE_FRAME_OFFSET), viewActions.frame.width, viewActions.frame.height)
        
        imgActionInput.alpha = 0
        imgActionKeyboard.alpha = 0
        viewActionBar.alpha = 0
        
        imgActionKeyboard.frame = CGRectMake(rectActionKeyboard.origin.x, rectActionKeyboard.origin.y - rectActionKeyboard.height, rectActionKeyboard.width, rectActionKeyboard.height)
        imgActionInput.frame = CGRectMake(rectActionInput.origin.x, rectActionInput.origin.y + rectActionInput.height, rectActionInput.width, rectActionInput.height)
    }
    
    func animateActionsCell()
    {
        UIView.animateWithDuration(0.1,
            delay: 0.1,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.imgActionKeyboard.frame = self.rectActionKeyboard
                self.imgActionKeyboard.alpha = 1
                
            }) { (flag: Bool) -> Void in
                
                if(flag == true)
                {
                    UIView.animateWithDuration(0.2,
                        delay: 0,
                        options: [.CurveEaseInOut, .AllowUserInteraction],
                        animations: { () -> Void in
                            
                            self.imgActionInput.frame = self.rectActionInput
                            self.imgActionInput.alpha = 1
                            self.viewActionBar.alpha = 1
                            
                        }) { (flag: Bool) -> Void in
                            
                            if(flag == true)
                            {
                            }
                    }
                }
        }
    }
    
    //MARK: Promo.
    func setDefaultPromoValue()
    {
        viewPromo.frame = CGRectMake(viewPromo.frame.origin.x, CGFloat(CHOOSE_FRAME_OFFSET), viewPromo.frame.width, viewPromo.frame.height)
        
        viewPromoRect.alpha = 0
        viewPromoRect.frame = CGRectMake(rectPromoRect.origin.x, rectPromoRect.origin.y - rectPromoRect.height, rectPromoRect.width, rectPromoRect.height)
        viewPromoCircle.transform = CGAffineTransformScale(transformPromoCircle, 0.001, 0.001)
    }
    
    func animatePromoCell()
    {
        UIView.animateWithDuration(0.1,
            delay: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewPromoRect.alpha = 1
                self.viewPromoRect.frame = self.rectPromoRect
                self.viewPromoCircle.transform = CGAffineTransformScale(self.transformPromoCircle, 1.2, 1.2)
                
            }) { (flag: Bool) -> Void in
                
                if(flag == true)
                {
                    UIView.animateWithDuration(0.1,
                        delay: 0,
                        options: [.CurveEaseInOut, .AllowUserInteraction],
                        animations: { () -> Void in
                            
                            self.viewPromoCircle.transform = CGAffineTransformScale(self.transformPromoCircle, 1.0, 1.0)
                            
                        }) { (flag: Bool) -> Void in
                            
                            if(flag == true)
                            {
                            }
                    }
                }
        }
    }
}
