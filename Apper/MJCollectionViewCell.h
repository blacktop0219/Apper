//
//  MJCollectionViewCell.h
//  RCCPeakableImageSample
//
//  Created by Mayur on 4/1/14.
//  Copyright (c) 2014 RCCBox. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IMAGE_HEIGHT 568
#define IMAGE_OFFSET_SPEED 568

@interface MJCollectionViewCell : UICollectionViewCell

/*
 
 image used in the cell which will be having the parallax effect
 
 */
@property (nonatomic, strong, readwrite) UIImage *image;
@property (nonatomic, strong, readwrite) UILabel *lblTitle;

/*
 Image will always animate according to the imageOffset provided. Higher the value means higher offset for the image
 */
@property (nonatomic, assign, readwrite) CGPoint imageOffset;

@end
