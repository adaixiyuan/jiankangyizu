//
//  HealthyInfo.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "HealthyInfo.h"
@implementation HealthyInfoDAO
+(Class)getBindingModelClass
{
    return [HealthyInfo class];
}
const static NSString* tablename = @"HealthyInfo";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation HealthyInfo
@synthesize	meaage ;//健康状况描述
@synthesize listBtnId ;//主页面列表页显示的小圆
@synthesize listBigBtnId;//主页面列表页显示的大图
@synthesize colorId;//文字显示颜色
@synthesize point;//分数
@end
