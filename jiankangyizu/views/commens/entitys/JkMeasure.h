//
//  JkMeasure.h
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface JkMeasureDAO : ZUOYLDAOBase

@end
@interface JkMeasure : ZUOYLModelBase
{
    int	identity ;
    NSString *addUser ;
    NSString *catDate ;//测量时间
    NSString *catAddress;//测量地点
    int	userId ;//TODO 测量用户
    NSString *pcp ;//TODO 高压
    NSString *pdp ;//TODO 低压
    NSString *heartRate;//心率
    NSString *glu ;//TODO 血糖
    NSString *ear ;//TODO 耳温
    NSString *hb;//血氧
    NSString *pi;//血液灌注指数
    int result;//心电测量结果
    NSString *data;//心电详细数据
    NSString * maiRate;
    double longitude ;//经度
    double latitude;//纬度
    NSString *catResult;//测量结果
    int type;//测量类型
}
@property(nonatomic,assign) int	identity ;
@property(nonatomic,strong)NSString *addUser ;
@property(nonatomic,strong)NSString *catDate ;//测量时间
@property(nonatomic,strong)NSString *catAddress;//测量地点
@property(nonatomic,assign)int	userId ;//TODO 测量用户
@property(nonatomic,strong)NSString *pcp ;//TODO 高压
@property(nonatomic,strong)NSString *pdp ;//TODO 低压
@property(nonatomic,strong)NSString *heartRate;//心率
@property(nonatomic,strong)NSString *glu ;//TODO 血糖
@property(nonatomic,strong)NSString *ear ;//TODO 耳温
@property(nonatomic,strong)NSString *hb;//血氧
@property(nonatomic,strong)NSString *pi;//血液灌注指数
@property(nonatomic,assign)int result;//心电测量结果
@property(nonatomic,strong)NSString *data;//心电详细数据
@property(nonatomic,strong)NSString * maiRate;
@property(nonatomic,assign)double longitude ;//经度
@property(nonatomic,assign)double latitude;//纬度
@property(nonatomic,strong)NSString *catResult;//测量结果
@property(nonatomic,assign)int type;//测量类型
@end
