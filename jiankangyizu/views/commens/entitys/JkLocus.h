//
//  JkLocus.h
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface JkLocusDAO: ZUOYLDAOBase

@end
@interface JkLocus : ZUOYLModelBase
@property(nonatomic,assign)int	identity ;
@property(nonatomic,strong)NSString *	addUser ;
@property(nonatomic,strong)NSString *	addDate ;
@property(nonatomic,strong)NSString *	addIp ;
@property(nonatomic,strong)NSString *	uuid ;
@property(nonatomic,strong)NSString *	posDate ;//轨迹时间
@property(nonatomic,strong)NSString * posAddress;//轨迹地址
@property(nonatomic,strong)NSString * 	longitude ;//经度
@property(nonatomic,strong)NSString * 	latitude ;//纬度
@property(nonatomic,strong)NSString * userId;//用户Id
@end
