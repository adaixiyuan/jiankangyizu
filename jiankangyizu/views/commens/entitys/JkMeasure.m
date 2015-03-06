//
//  JkMeasure.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkMeasure.h"
@implementation JkMeasureDAO
+(Class)getBindingModelClass
{
    return [JkMeasure class];
}
const static NSString* tablename = @"JkMeasure";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation JkMeasure
@synthesize identity ;
@synthesize addUser ;
@synthesize catDate ;//测量时间
@synthesize catAddress;//测量地点
@synthesize	userId ;//TODO 测量用户
@synthesize pcp ;//TODO 高压
@synthesize pdp ;//TODO 低压
@synthesize heartRate;//心率
@synthesize glu ;//TODO 血糖
@synthesize ear ;//TODO 耳温
@synthesize hb;//血氧
@synthesize pi;//血液灌注指数
@synthesize result;//心电测量结果
@synthesize data;//心电详细数据
@synthesize  maiRate;
@synthesize longitude ;//经度
@synthesize latitude;//纬度
@synthesize catResult;//测量结果
@synthesize type;//测量类型
@end
