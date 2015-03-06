//
//  JkOximeter.h
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface JkOximeterDAO : ZUOYLDAOBase

@end
@interface JkOximeter : ZUOYLModelBase
{
    int identity;
    NSString *addUser;
    NSString *addDate; 	//添加日期
    NSString *catDate; 	//测量日期
    NSString *userId;		//用户id
    int spo;      		//血氧浓度%
    int pr;    		// 脉率
    double pi;	  		//血流灌注指数
    NSString *catAddress;
    NSString *longitude ;//经度
    NSString *latitude;//纬度
    NSString *catResult;//测量结果
}
@property(nonatomic,assign)int identity;
@property(nonatomic,strong)NSString *addUser;
@property(nonatomic,strong)NSString *addDate; 	//添加日期
@property(nonatomic,strong)NSString *catDate; 	//测量日期
@property(nonatomic,strong)NSString *userId;		//用户id
@property(nonatomic,assign)int spo;      		//血氧浓度%
@property(nonatomic,assign)int pr;    		// 脉率
@property(nonatomic,assign)double pi;	  		//血流灌注指数
@property(nonatomic,strong)NSString *catAddress;
@property(nonatomic,strong)NSString *longitude ;//经度
@property(nonatomic,strong)NSString *latitude;//纬度
@property(nonatomic,strong)NSString *catResult;//测量结果
@end
