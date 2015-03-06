//
//  JkDevice.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkDevice.h"
@implementation JkDeviceDAO
+(Class)getBindingModelClass
{
    return [JkDevice class];
}
const static NSString* tablename = @"JkDevice";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation JkDevice
@synthesize identity;
@synthesize device;
@end
