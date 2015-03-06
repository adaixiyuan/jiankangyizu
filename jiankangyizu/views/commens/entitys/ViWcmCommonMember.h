//
//  ViWcmCommonMember.h
//  asiastarbus
//
//  Created by apple on 14-10-10.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface ViWcmCommonMemberDAO : ZUOYLDAOBase

@end
@interface ViWcmCommonMember : ZUOYLModelBase<NSCoding>
{
    int	identity ;
    NSString *	uuid ;
    NSString *	headImg ;//TODO 大头像
    NSString *	usern ;//TODO 用户名
    NSString *	password ;//TODO 密码
    NSString *	email ;//TODO 邮箱
    NSString *	phone ;//TODO 手机
    NSString *	realName ;//TODO 真实姓名
    int	sex ;//TODO 性别
    NSString	*birthday ;//TODO 生日
    NSString *	telephone ;//TODO 座机
    int	provinceId ;//TODO 省id
    int	cityId ;//TODO 市id
    int	areaId ;//TODO 区id
    NSString * address;//详细地址
    NSString * zip;//邮编
    NSString *	intro ;//TODO 个性签名
    NSString *	qq ;//TODO QQ号
    NSString *	qqOpenId ;//TODO QQ开放Id
    NSString *	sinaOpenId ;//TODO sina开放Id
	//TODO 会员卡、积分等信息
    NSString *	memberNo ;
    int	nowScore ;
	//TODO 辅助信息
    int	isTemp ;//TODO 是否是临时账户
	int isQuit;//TODO 是否退出
	NSString *lastRegistrationDate;//最后一次签到时间
    





    
    NSString *nickName;//TODO 昵称
    
    NSString *weixinNo;//TODO 微信编号
    
    int lastDeviceId;//TODO 手机设备类型
    NSString *lastDeviceNo;//TODO 手机设备编号
    int jobId;//TODO 职业编号
    int isOwn;//TODO 自有客户
    int identityAuthId;//TODO 认证编号
    
    NSString *postReceiverName;//TODO 邮寄收件人地址
    int postAreaId;//TODO  邮寄地区编号
   NSString *postAddress;//TODO 邮寄地址
   NSString *postCode;//TODO 邮寄邮编
    NSString * postLinkTel;//TODO 邮寄联系电话
    
}
@property(nonatomic,assign) int	identity ;
@property(nonatomic,strong) NSString *	uuid ;
@property(nonatomic,strong)NSString *	headImg ;//TODO 大头像
@property(nonatomic,strong)NSString *	usern ;//TODO 用户名
@property(nonatomic,strong)NSString *	password ;//TODO 密码
@property(nonatomic,strong)NSString *	email ;//TODO 邮箱
@property(nonatomic,strong)NSString *	phone ;//TODO 手机
@property(nonatomic,strong)NSString *	realName ;//TODO 真实姓名
@property(nonatomic,assign)int	sex ;//TODO 性别
@property(nonatomic,strong)NSString	*birthday ;//TODO 生日
@property(nonatomic,strong)NSString *	telephone ;//TODO 座机
@property(nonatomic,assign)int	provinceId ;//TODO 省id
@property(nonatomic,assign)int	cityId ;//TODO 市id
@property(nonatomic,assign)int	areaId ;//TODO 区id
@property(nonatomic,strong)NSString * address;//详细地址
@property(nonatomic,strong)NSString * zip;//邮编
@property(nonatomic,strong)NSString *	intro ;//TODO 个性签名
@property(nonatomic,strong)NSString *	qq ;//TODO QQ号
@property(nonatomic,strong)NSString *	qqOpenId ;//TODO QQ开放Id
@property(nonatomic,strong)NSString *	sinaOpenId ;//TODO sina开放Id
//TODO 会员卡、积分等信息
@property(nonatomic,strong)NSString *	memberNo ;
@property(nonatomic,assign)int	nowScore ;
//TODO 辅助信息
@property(nonatomic,assign)int	isTemp ;//TODO 是否是临时账户
@property(nonatomic,assign)int isQuit;//TODO 是否退出
@property(nonatomic,strong)NSString *lastRegistrationDate;//最后一次签到时间


@property(nonatomic,strong)NSString *nickName;//TODO 昵称

@property(nonatomic,strong)NSString *weixinNo;//TODO 微信编号

@property(nonatomic,assign)int lastDeviceId;//TODO 手机设备类型
@property(nonatomic,strong)NSString *lastDeviceNo;//TODO 手机设备编号
@property(nonatomic,assign)int jobId;//TODO 职业编号
@property(nonatomic,assign)int isOwn;//TODO 自有客户
@property(nonatomic,assign)int identityAuthId;//TODO 认证编号

@property(nonatomic,strong)NSString *postReceiverName;//TODO 邮寄收件人地址
@property(nonatomic,assign)int postAreaId;//TODO  邮寄地区编号
@property(nonatomic,strong)NSString *postAddress;//TODO 邮寄地址
@property(nonatomic,strong)NSString *postCode;//TODO 邮寄邮编
@property(nonatomic,strong)NSString * postLinkTel;//TODO 邮寄联系电话
@end
