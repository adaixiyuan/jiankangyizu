//
//  JkRemind.h
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface JkRemindDAO: ZUOYLDAOBase

@end
@interface JkRemind : ZUOYLModelBase

    @property(nonatomic,assign)int	identity ;
    @property(nonatomic,strong)NSString *	addUser ;
    @property(nonatomic,strong)NSString * addDate ;
    @property(nonatomic,strong)NSString *	addIp ;
    @property(nonatomic,strong)NSString *	uuid ;
    @property(nonatomic,strong)NSString * name;//提醒名称
    @property(nonatomic,strong)NSString *	hour ;//小时
    @property(nonatomic,strong)NSString *	minute ;//分钟
    @property(nonatomic,strong)NSString *	rate ;//频率
    @property(nonatomic,strong)NSString * state;//是否开启
    @property(nonatomic,strong)NSString * userId;//用户Id
    @property(nonatomic,strong)NSString * alarmDate;

@end
