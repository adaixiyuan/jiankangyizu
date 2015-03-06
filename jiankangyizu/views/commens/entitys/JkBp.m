//
//  JkBp.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkBp.h"
@implementation JkBpDAO
+(Class)getBindingModelClass
{
    return [JkBp class];
}
const static NSString* tablename = @"JkBp";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation JkBp
@synthesize	identity ;
@synthesize	addUser ;
@synthesize	addDate ;
@synthesize	addIp ;
@synthesize	uuid ;
@synthesize	catDate ;//测量时间
@synthesize catAddress;//测量地点
@synthesize	userId ;//TODO 测量用户
@synthesize	pcp ;//TODO 高压
@synthesize	pdp ;//TODO 低压
@synthesize	heartRate ;//心率
@synthesize	longitude ;//经度
@synthesize latitude;//纬度
@synthesize catResult;//测量结果
@end
