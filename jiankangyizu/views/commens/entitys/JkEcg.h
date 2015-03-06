//
//  JkEcg.h
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface JkEcgDao : ZUOYLDAOBase

@end
@interface JkEcg : ZUOYLModelBase{

    int identity;
    NSString *addUser;
    NSString *addDate; 	//添加日期
    NSString *catDate; 	//测量日期
    NSString *userId;		//用户id
    int path;      		//文件路径
    int filename;    		// 文件名称
    NSString *startDate; 	//开始日期
    NSString *endDate; 	//结束日期
    NSString *catAddress;
    NSString *longitude ;//经度
    NSString *latitude;//纬度
    int result;//测量结果代号
    NSString *catResult;//测量结果
    NSString *data;//心电图数据
}
@property(nonatomic,assign)int identity;
@property(nonatomic,strong)NSString *addUser;
@property(nonatomic,strong)NSString *addDate; 	//添加日期
@property(nonatomic,strong)NSString *catDate; 	//测量日期
@property(nonatomic,strong)NSString *userId;		//用户id
@property(nonatomic,assign)int path;      		//文件路径
@property(nonatomic,assign)int filename;    		// 文件名称
@property(nonatomic,strong)NSString *startDate; 	//开始日期
@property(nonatomic,strong)NSString *endDate; 	//结束日期
@property(nonatomic,strong)NSString *catAddress;
@property(nonatomic,strong)NSString *longitude ;//经度
@property(nonatomic,strong)NSString *latitude;//纬度
@property(nonatomic,assign)int result;//测量结果代号
@property(nonatomic,strong)NSString *catResult;//测量结果
@property(nonatomic,strong)NSString *data;//心电图数据
@end
