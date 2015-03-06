//
//  JkBong.h
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface JkBongDAO: ZUOYLDAOBase

@end
@interface JkBong : ZUOYLModelBase
@property(nonatomic,assign)int	identity ;
@property(nonatomic,strong)NSString *addUser ;
@property(nonatomic,strong)NSString *addDate ;
@property(nonatomic,strong)NSString *addIp ;
@property(nonatomic,strong)NSString *uuid ;
@property(nonatomic,strong)NSString *catDate ;//测量时间
@property(nonatomic,strong)NSString *uid;//bong用户ID
@property(nonatomic,strong)NSString *calories ;//热量
@property(nonatomic,assign)int	sleepNum ;//睡眠时间
@property(nonatomic,assign)int	dsNum;//深度睡眠时间
@property(nonatomic,assign)int	sleepTimes;//睡眠次数
@property(nonatomic,assign)int	complete;//该日数据是否完整。 0:不完整 1:完整
@property(nonatomic,assign)int	distance;//距离
@property(nonatomic,assign)int	steps;//步数
@property(nonatomic,assign)int	stillTime;//静坐时间
@end
