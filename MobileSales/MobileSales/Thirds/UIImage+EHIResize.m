//
//  UIImage+EHIResize.m
//  MobileSales
//
//  Created by dengwx on 17/2/23.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "UIImage+EHIResize.h"

@implementation UIImage (EHIResize)

+ (UIImage *)resizeImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat imageW = image.size.width *0.5;
    CGFloat imageH = image.size.height *0.5;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW) resizingMode:UIImageResizingModeTile];
}


@end
