//
//  CreateImage.m
//  ViewDeckExample
//
//  Created by apple on 13-2-27.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import "CreateImage.h"

@implementation CreateImage

+ (UIImage*)newImageForSize:(CGSize)targetSize with:(UIImage *)_image
{
    UIImage *newImage = nil;      
    CGSize imageSize = _image.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor < heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
    }      
    
    CGSize newSize=CGSizeMake(scaledWidth, scaledHeight);
    
    UIGraphicsBeginImageContext(newSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [_image drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;    
     
}


@end
