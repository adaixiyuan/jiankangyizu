//
//  JkBong.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkBong.h"
@implementation JkBongDAO
+(Class)getBindingModelClass
{
    return [JkBong class];
}
const static NSString* tablename = @"JkBong";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation JkBong

@synthesize	identity ;
@synthesize addUser ;
@synthesize addDate ;
@synthesize addIp ;
@synthesize uuid ;
@synthesize catDate ;//测量时间
@synthesize uid;//bong用户ID
@synthesize calories ;//热量
@synthesize	sleepNum ;//睡眠时间
@synthesize	dsNum;//深度睡眠时间
@synthesize	sleepTimes;//睡眠次数
@synthesize	complete;//该日数据是否完整。 0:不完整 1:完整
@synthesize	distance;//距离
@synthesize	steps;//步数
@synthesize	stillTime;//静坐时间
@end
