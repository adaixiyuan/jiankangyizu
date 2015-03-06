//
//  CreateImage.h
//  ViewDeckExample
//
//  Created by apple on 13-2-27.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreateImage:NSObject

+ (UIImage*)newImageForSize:(CGSize)targetSize with:(UIImage *)_image;

@end
