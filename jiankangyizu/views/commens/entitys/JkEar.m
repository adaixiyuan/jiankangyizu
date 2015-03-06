//
//  JkEar.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkEar.h"
@implementation JkEarDAO
+(Class)getBindingModelClass
{
    return [JkEar class];
}
const static NSString* tablename = @"JkEar";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation JkEar
@synthesize	identity ;
@synthesize	addUser ;
@synthesize	addDate ;
@synthesize	addIp ;
@synthesize	uuid ;
@synthesize	catDate ;//测量时间
@synthesize catAddress;//测量地点
@synthesize	userId ;//TODO 测量用户
@synthesize	ear ;//TODO 耳温
@synthesize	longitude ;//经度
@synthesize latitude;//纬度
@synthesize catResult;//测量结果
@end
