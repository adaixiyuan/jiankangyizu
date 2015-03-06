//
//  JkOximeter.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkOximeter.h"
@implementation JkOximeterDAO
+(Class)getBindingModelClass
{
    return [JkOximeter class];
}
const static NSString* tablename = @"JkOximeter";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation JkOximeter
@synthesize identity;
@synthesize addUser;
@synthesize addDate; 	//添加日期
@synthesize catDate; 	//测量日期
@synthesize userId;		//用户id
@synthesize spo;      		//血氧浓度%
@synthesize pr;    		// 脉率
@synthesize pi;	  		//血流灌注指数
@synthesize catAddress;
@synthesize longitude ;//经度
@synthesize latitude;//纬度
@synthesize catResult;//测量结果
@end
