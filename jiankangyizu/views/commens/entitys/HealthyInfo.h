//
//  HealthyInfo.h
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface HealthyInfoDAO: ZUOYLDAOBase

@end
@interface HealthyInfo : ZUOYLModelBase
@property(nonatomic,strong)NSString *	meaage ;//健康状况描述
@property(nonatomic,assign)NSString *listBtnId ;//主页面列表页显示的小圆
@property(nonatomic,assign)NSString *listBigBtnId;//主页面列表页显示的大图
@property(nonatomic,strong)UIColor *colorId;//文字显示颜色
@property(nonatomic,assign)int point;//分数
@end
