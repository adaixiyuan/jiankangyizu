//
//  CommonUser.h
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface CommonUserDAO: ZUOYLDAOBase

@end
@interface CommonUser : ZUOYLModelBase<NSCoding>
@property(nonatomic,assign)int	identity ;
@property(nonatomic,strong)NSString *	uuid ;
@property(nonatomic,assign)int companyId;
@property(nonatomic,strong)NSString *	headImg ;//TODO 大头像
@property(nonatomic,strong)NSString *	usern ;//TODO 用户名
@property(nonatomic,strong)NSString *	password ;//TODO 密码
@property(nonatomic,strong)NSString *	email ;//TODO 邮箱
@property(nonatomic,strong)NSString *	name ;//TODO 真实姓名
@property(nonatomic,assign)int	sex ;//TODO 性别
@property(nonatomic,strong)NSString *	tel ;//TODO 联系电话
@property(nonatomic,strong)NSString *	homeTel ;//TODO 家庭电话
@property(nonatomic,strong)NSString * blood;//血型
@property(nonatomic,strong)NSString * height;//高度
@property(nonatomic,strong)NSString *birthdays;//生日
@property(nonatomic,strong)NSString * bornProvince;
@property(nonatomic,strong)NSString * bornCity;
@property(nonatomic,strong)NSString * bornArea;
@property(nonatomic,strong)NSString * bornAddress;
@property(nonatomic,strong)NSString * liveProvince;
@property(nonatomic,strong)NSString * liveCity;
@property(nonatomic,strong)NSString * liveArea;
@property(nonatomic,strong)NSString * liveAddress;
@property(nonatomic,strong)NSString * jkNo;
@property(nonatomic,assign)int isQuit;//TODO 是否退出
@property(nonatomic,strong)NSString * familyPhoto;//家庭图片
@property(nonatomic,strong)NSString *companyName;
@property(nonatomic,strong)NSString *companyAddress;
//预警信息
@property(nonatomic,assign)int warningId;//预警数据Id
@property(nonatomic,assign)int warningDataup;//预警信息是否数据上传
@property(nonatomic,assign)int isNote;//短信提醒
@property(nonatomic,assign)int pcpMax;//高压最高
@property(nonatomic,assign)int pcpMin;//高压最低
@property(nonatomic,assign)int pdpMax;//低压最高
@property(nonatomic,assign)int pdpMin;//低压最高
@property(nonatomic,assign)double gluMax;//血糖最高
@property(nonatomic,assign)double gluMin;//血糖最低
@property(nonatomic,assign)double earMax;//耳温最高
@property(nonatomic,assign)double earMin;//耳温最低
@property(nonatomic,assign)int locusId;//轨迹数据Id
@property(nonatomic,assign)int locusDataup;//轨迹信息是否数据上传       1上传
@property(nonatomic,assign)int upTime;//轨迹信息上传间隔时间
@end
