//
//  JkEar.h
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface JkEarDAO: ZUOYLDAOBase

@end
@interface JkEar : ZUOYLModelBase
@property(nonatomic,assign)int	identity ;
@property(nonatomic,strong)NSString *	addUser ;
@property(nonatomic,strong)NSString *	addDate ;
@property(nonatomic,strong)NSString *	addIp ;
@property(nonatomic,strong)NSString *	uuid ;
@property(nonatomic,strong)NSString *	catDate ;//测量时间
@property(nonatomic,strong)NSString * catAddress;//测量地点
@property(nonatomic,assign)int	userId ;//TODO 测量用户
@property(nonatomic,strong)NSString *	ear ;//TODO 耳温
@property(nonatomic,strong)NSString *	longitude ;//经度
@property(nonatomic,strong)NSString * latitude;//纬度
@property(nonatomic,strong)NSString * catResult;//测量结果
@end
