//
//  AppEngine.h
//  Apper
//
//  Created by jian on 8/17/15.
//  Copyright © 2015 jinhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppEngine : NSObject
{
    
}

+ (UIImage *)convertImageToGrayScale:(UIImage *)image;
+ (UIImage *)imageWithView:(UIView *)view;
+ (UIImage *)changeWhiteColorTransparent: (UIImage *)image;
@end
