//
//  AppEngine.m
//  Apper
//
//  Created by jian on 8/17/15.
//  Copyright © 2015 jinhu. All rights reserved.
//

#import "AppEngine.h"

@implementation AppEngine

+ (UIImage *)convertImageToGrayScale:(UIImage *) image
{
    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    // Grayscale color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    // Create bitmap content with current image size and grayscale colorspace
    CGContextRef context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8, 0, colorSpace, kCGImageAlphaNone);
    
    // Draw image into current context, with specified rectangle
    // using previously defined context (with grayscale colorspace)
    CGContextDrawImage(context, imageRect, [image CGImage]);
    
    // Create bitmap image info from pixel data in current context
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    // Release colorspace, context and bitmap information
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    context = CGBitmapContextCreate(nil,image.size.width, image.size.height, 8, 0, nil, kCGImageAlphaOnly );
    CGContextDrawImage(context, imageRect, [image CGImage]);
    CGImageRef mask = CGBitmapContextCreateImage(context);
    
    // Create a new UIImage object
    UIImage *newImage = [UIImage imageWithCGImage:CGImageCreateWithMask(imageRef, mask)];
    CGImageRelease(imageRef);
    CGImageRelease(mask);
    
    // Return the new grayscale image
    return newImage;
}

+ (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, [[UIScreen mainScreen] scale]);
//    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    [view drawViewHierarchyInRect: view.bounds afterScreenUpdates: YES];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)changeWhiteColorTransparent: (UIImage *)orginalImage
{
    UIImage *entryImage  = orginalImage;
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIImage *image = [CIImage imageWithCGImage:[entryImage CGImage]];
    CIFilter *filter = [CIFilter filterWithName:@"CIMaskToAlpha"];
    [filter setDefaults];
    [filter setValue:image forKey:kCIInputImageKey];
    CIImage *result = [filter outputImage];
    
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    
    UIImage *newImage = [UIImage imageWithCGImage:cgImage scale:[entryImage scale] orientation:UIImageOrientationUp];
    return newImage;
}

@end
