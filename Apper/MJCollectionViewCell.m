//
//  MJCollectionViewCell.m
//  RCCPeakableImageSample
//
//  Created by Mayur on 4/1/14.
//  Copyright (c) 2014 RCCBox. All rights reserved.
//

#import "MJCollectionViewCell.h"

@interface MJCollectionViewCell()

@property (nonatomic, strong, readwrite) UIImageView *MJImageView;

@end

@implementation MJCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) [self setupImageView];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) [self setupImageView];
    return self;
}


#pragma mark - Setup Method
- (void)setupImageView
{
    // Clip subviews
    self.clipsToBounds = YES;
    
    // Add image subview
    self.MJImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, IMAGE_HEIGHT)];
    self.MJImageView.backgroundColor = [UIColor redColor];
    self.MJImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.MJImageView.clipsToBounds = NO;
    [self addSubview:self.MJImageView];

    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.bounds.size.width, self.bounds.origin.y + self.bounds.size.height)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite: 0 alpha: 0] CGColor], (id)[[UIColor colorWithWhite: 0 alpha: 1] CGColor], nil];
    [view.layer insertSublayer:gradient atIndex:0];
    view.alpha = 0.7f;
    [self addSubview: view];
    
    self.lblTitle = [[UILabel alloc] initWithFrame: CGRectMake(self.bounds.origin.x + 16,
                                                                   self.bounds.origin.y + self.bounds.size.height * 2   / 5,
                                                                   self.bounds.size.width,
                                                                   38)];
    self.lblTitle.font = [UIFont fontWithName:@"Helvetica-Condensed-Light" size:28];
    self.lblTitle.textColor = [UIColor whiteColor];
    self.lblTitle.shadowColor = [UIColor colorWithRed:50/255.0f green:50.0f/255.0f blue:50.0f/255.0f alpha: 0.5];
    self.lblTitle.shadowOffset = CGSizeMake(1, 1);
    
    [self addSubview: self.lblTitle];
}

# pragma mark - Setters

- (void)setImage:(UIImage *)image
{
    // Store image
    self.MJImageView.image = image;
    
    // Update padding
    [self setImageOffset:self.imageOffset];
}

- (void)setImageOffset:(CGPoint)imageOffset
{
    // Store padding value
    _imageOffset = imageOffset;
    
    // Grow image view
    CGRect frame = self.MJImageView.bounds;
    CGRect offsetFrame = CGRectOffset(frame, _imageOffset.x, _imageOffset.y);
    self.MJImageView.frame = offsetFrame;
}

@end
