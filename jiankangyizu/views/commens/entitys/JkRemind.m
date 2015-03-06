//
//  JkRemind.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkRemind.h"
@implementation JkRemindDAO
+(Class)getBindingModelClass
{
    return [JkRemind class];
}
const static NSString* tablename = @"JkRemind";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation JkRemind

@synthesize	identity ;
@synthesize	addUser ;
@synthesize addDate ;
@synthesize	addIp ;
@synthesize uuid ;
@synthesize name;//提醒名称
@synthesize	hour ;//小时
@synthesize	minute ;//分钟
@synthesize	rate ;//频率
@synthesize state;//是否开启
@synthesize userId;//用户Id
@synthesize alarmDate;
@end
