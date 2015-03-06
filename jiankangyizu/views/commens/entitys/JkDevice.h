//
//  JkDevice.h
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface JkDeviceDAO: ZUOYLDAOBase

@end
@interface JkDevice : ZUOYLModelBase
@property(nonatomic,assign)int identity;
@property (nonatomic,strong)NSString *device;
@end
