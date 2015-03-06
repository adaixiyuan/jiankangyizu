//
//  JkGoodDoctor.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkGoodDoctor.h"
@implementation JkGoodDoctorDAO
+(Class)getBindingModelClass
{
    return [JkGoodDoctor class];
}
const static NSString* tablename = @"JkGoodDoctor";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation JkGoodDoctor
@synthesize	identity ;
@synthesize 	uuid ;
@synthesize 	headImg ;//TODO 大头像
@synthesize 	usern ;//TODO 用户名
@synthesize 	password ;//TODO 密码
@synthesize 	loginPassword ;//TODO 密码
@synthesize 	email ;//TODO 邮箱
@synthesize 	name ;//TODO 真实姓名
@synthesize	sex ;//TODO 性别
@synthesize 	tel ;//TODO 联系电话
@synthesize 	homeTel ;//TODO 家庭电话
@synthesize blood;//血型
@synthesize height;//高度
@synthesize  birthdays;//生日
@synthesize bornProvince;
@synthesize bornCity;
@synthesize bornArea;
@synthesize bornAddress;
@synthesize liveProvince;
@synthesize liveCity;
@synthesize liveArea;
@synthesize liveAddress;
@synthesize bongUid;//bong用户Id
@synthesize gudongUid;//咕咚用户Id
@synthesize typeNo;
@synthesize jkNo;
@synthesize isQuit;//TODO 是否退出
@synthesize familyPhoto;//家庭图片
@synthesize summary;
@synthesize favorite;
@synthesize departmentNo;
//预警信息
@synthesize warningId;//预警数据Id
@synthesize warningDataup;//预警信息是否数据上传
@synthesize isNote;//短信提醒
@synthesize pcpMax;//高压最高
@synthesize pcpMin;//高压最低
@synthesize pdpMax;//低压最高
@synthesize pdpMin;//低压最高
@synthesize gluMax;//血糖最高
@synthesize gluMin;//血糖最低
@synthesize earMax;//耳温最高
@synthesize earMin;//耳温最低
@synthesize locusId;//轨迹数据Id
@synthesize locusDataup;//轨迹信息是否数据上传       1上传
@synthesize upTime;//轨迹信息上传间隔时间
@end
