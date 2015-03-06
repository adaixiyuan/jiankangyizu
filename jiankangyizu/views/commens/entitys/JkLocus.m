//
//  JkLocus.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkLocus.h"
@implementation JkLocusDAO
+(Class)getBindingModelClass
{
    return [JkLocus class];
}
const static NSString* tablename = @"JkLocus";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation JkLocus
@synthesize	identity ;
@synthesize	addUser ;
@synthesize	addDate ;
@synthesize	addIp ;
@synthesize	uuid ;
@synthesize	posDate ;//轨迹时间
@synthesize posAddress;//轨迹地址
@synthesize 	longitude ;//经度
@synthesize 	latitude ;//纬度
@synthesize userId;//用户Id
@end
