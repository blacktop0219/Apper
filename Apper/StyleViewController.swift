//
//  StyleViewController.swift
//  Apper
//
//  Created by jian on 9/4/15.
//  Copyright © 2015 jinhu. All rights reserved.
//

import UIKit

class StyleViewController: BaseViewController, iCarouselDataSource, iCarouselDelegate
{
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var carousel: iCarousel!
    
    var chooseType: CHOOSE_TYPE!
    var arrImages: NSArray!
    var spacingValue: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        spacingValue = 1.0
        if(chooseType == CHOOSE_LISTS)
        {
            spacingValue = 1.3
            lblTitle.text = "Lists"
            arrImages = NSArray(objects: "Lists_Contacts1.png", "Lists_Contacts2.png", "Lists_Contacts3.png", "Lists_Contacts4.png", "Lists_Contacts5.png", "Lists_Contacts6.png", "Lists_Contacts7.png", "Lists_Contacts8.png", "Lists_Contacts9.png", "Lists_Contacts10.png", "Lists_Descrpition1.png", "Lists_Descrpition2.png", "Lists_Events1.png", "Lists_Events2.png", "Lists_Groups1.png", "Lists_Groups2.png", "Lists_Groups3.png", "Lists_Groups4.png", "Lists_Groups5.png", "Lists_Groups6.png", "Lists_Groups7.png", "Lists_Groups8.png", "Lists_Groups9.png", "Lists_Groups10.png", "Lists_Product1.png", "Lists_Product2.png", "Lists_Product3.png", "Lists_Product4.png", "Lists_Sections1.png", "Lists_Sections2.png", "Lists_Sections3.png", "Lists_Sections4.png", "Lists_Sections5.png", "Lists_Sections6.png", "Lists_Sections7.png", "Lists_Sections8.png", "Lists_Sections9.png", "Lists_Sections10.png", "Lists_Segement1.png", "Lists_Segement2.png", "Lists_Segement3.png", "Lists_Segement4.png", "Lists_Segement5.png", "Lists_Segement6.png", "Lists_Segement7.png", "Lists_Segement8.png", "Lists_Segement9.png", "Lists_Segement10.png", "Lists_Simple1.png", "Lists_Simple2.png", "Lists_Simple3.png", "Lists_Simple4.png", "Lists_Simple5.png", "Lists_Simple6.png", "Lists_Simple7.png", "Lists_Simple8.png", "Lists_Simple9.png", "Lists_Simple10.png", "Lists_Sorted1.png", "Lists_Sorted2.png", "Lists_Sorted3.png", "Lists_Sorted4.png", "Lists_Sorted5.png", "Lists_Sorted6.png", "Lists_Sorted7.png", "Lists_Sorted8.png", "Lists_Sorted9.png", "Lists_Sorted10.png")
        }
        else if(chooseType == CHOOSE_FEEDS)
        {
            spacingValue = 1.4
            lblTitle.text = "Feeds"
            arrImages = NSArray(objects: "Feeds_Blogger.png", "Feeds_Facebook.png", "Feeds_Flickr.png", "Feeds_Googleplus.png", "Feeds_Instagram.png", "Feeds_Picassa.png", "Feeds_Pinterest.png", "Feeds_RSS.png", "Feeds_Tumblr.png", "Feeds_Twitpic.png", "Feeds_Twitter.png", "Feeds_Vimeo.png", "Feeds_Wordpress.png", "Feeds_Youtube.png")
        }
        else if(chooseType == CHOOSE_MAPS)
        {
            spacingValue = 2
            lblTitle.text = "Maps"
            arrImages = NSArray(objects: "Maps_Location.png", "Maps_Multi-Location.png", "Maps_Route.png")
        }
        else if(chooseType == CHOOSE_IMAGES)
        {
            spacingValue = 1.3
            lblTitle.text = "Images"
            arrImages = NSArray(objects: "Images_Gallery1.png", "Images_Gallery2.png", "Images_Gallery3_Description.png", "Images_Gallery3.png", "Images_Single_Description.png", "Images_Single.png", "Images_Slideshow_Description.png", "Images_Slideshow.png", "Images_Zoomable_Description.png", "Images_Zoomable.png")
        }
        else if(chooseType == CHOOSE_MEDIA)
        {
            spacingValue = 3
            lblTitle.text = "Media"
            arrImages = NSArray(objects: "Media_VimeoPlayer.png", "Media_YouTubePlayer.png")
        }
        else if(chooseType == CHOOSE_ACTIONS)
        {
            spacingValue = 1.3
            lblTitle.text = "Actions"
            arrImages = NSArray(objects: "Actions_AppStore.png", "Actions_Dial.png", "Actions_Donation.png", "Actions_Email.png", "Actions_iTunes.png", "Actions_Map.png", "Actions_Payment.png", "Actions_PDF.png", "Actions_Route.png", "Actions_SMS.png", "Actions_Website.png", "Actions_Word.png")
        }
        else if(chooseType == CHOOSE_PROMO)
        {
            spacingValue = 1.3
            lblTitle.text = "Promo"
            arrImages = NSArray(objects: "Promo_Appointments.png", "Promo_BarCode_Promo1.png", "Promo_BarCode_Promo2.png", "Promo_BarCode_Promo3.png", "Promo_Bookshelf.png", "Promo_ContentBlock1.png", "Promo_ContentBlock2.png", "Promo_ContentBlock3.png", "Promo_ContentBlock4.png", "Promo_QRCode_Promo1.png", "Promo_QRCode_Promo2.png", "Promo_QRCode_Promo3.png")
        }
        
        self.view.backgroundColor = AppDelegate().getDelegate().currentApper.mainColor
        
        carousel.delegate = self
        carousel.dataSource = self
        carousel.pagingEnabled = true
        carousel.type = iCarouselType.Rotary
        carousel.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: iCarousl
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int
    {
        return arrImages.count
    }
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView
    {
        var itemView: UIView
        //create new view if no view is available for recycling
        if (view == nil)
        {
            let fw = 167.0 as CGFloat!
            let fh = 297.0 as CGFloat!
            
            let rect = CGRectMake((carousel.frame.width - fw)/2.0, 0, fw, fh)
            
            itemView = UIView(frame: rect)
            
            let imageName = arrImages.objectAtIndex(index) as! String
            let image = UIImage(named: imageName)
            
            let imageView = UIImageView(frame: itemView.bounds)
            imageView.image = image
            imageView.layer.masksToBounds = true
            imageView.contentMode = .ScaleAspectFit
            imageView.layer.borderColor = UIColor.lightGrayColor().CGColor
            imageView.layer.borderWidth = 0.5
            itemView.addSubview(imageView)
            
            if(index == 0)
            {
                imageView.backgroundColor = UIColor.redColor()
            }
            else if(index == 1)
            {
                imageView.backgroundColor = UIColor.greenColor()
            }
            else if(index == 2)
            {
                imageView.backgroundColor = UIColor.blueColor()
            }
        }
        else
        {
            //get a reference to the label in the recycled view
            itemView = view as UIView!
        }
        
        return itemView
    }
    
    func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat
    {
        switch(option)
        {
        case .Spacing:
            return value * spacingValue
            
        case .Wrap:
            return 1
            
        case .Arc:
            return 2 * 3.141592 * 0.5
            
        case .Radius:
            return value
            
            
        default:
            return value
        }
    }
    
    
    func carousel(carousel: iCarousel, didSelectItemAtIndex index: Int)
    {
        carousel.hidden = true
        self.navigationController?.popViewControllerAnimated(true)
    }


}
