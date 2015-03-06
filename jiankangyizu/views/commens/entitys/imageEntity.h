//
//  imageEntity.h
//  yuehandier
//
//  Created by apple on 14/12/19.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface imageEntity : NSObject
{
  NSString *img_center;
NSString *img_face;
NSString *img_small;
}
@property(nonatomic,strong) NSString *img_center;
@property(nonatomic,strong) NSString *img_face;
@property(nonatomic,strong) NSString *img_small;
@end
