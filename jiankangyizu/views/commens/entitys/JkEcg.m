//
//  JkEcg.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkEcg.h"
@implementation JkEcgDao
+(Class)getBindingModelClass
{
    return [JkEcg class];
}
const static NSString* tablename = @"JkEcg";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation JkEcg
@synthesize identity;
@synthesize addUser;
@synthesize addDate; 	//添加日期
@synthesize catDate; 	//测量日期
@synthesize userId;		//用户id
@synthesize path;      		//文件路径
@synthesize filename;    		// 文件名称
@synthesize startDate; 	//开始日期
@synthesize endDate; 	//结束日期
@synthesize catAddress;
@synthesize longitude ;//经度
@synthesize latitude;//纬度
@synthesize result;//测量结果代号
@synthesize catResult;//测量结果
@synthesize data;//心电图数据
@end
