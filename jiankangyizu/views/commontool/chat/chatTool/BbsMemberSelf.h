//
//  BbsMemberSelf.h
//  ViewDeckExample
//
//  Created by wang kevin on 13-1-29.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "SQLitePersistentObject.h"
@interface BbsMemberSelf : NSObject<NSCoding>{
     int  identity ;
    NSString*   username ;
    NSString*    password ;
    //个人信息
    NSString*   nickname ;
    NSString *realName ;
    NSString *nameRemark;//new
    NSString *shortName ;
    NSString *minShortName ;
    int  sex ;
    NSString *   cardId ;
    NSDate *   birthday ;
    NSDate *   birthdayNl ;//new
    int jobId;//new
    int workYearsId;
    int  areaId ;
    NSString * areaName ;
    NSString *areaStreet;
    NSString *intro;
    //头像身份
    NSString *userFace;//new
    NSString *userFaceCenter;//new
    NSString *userFaceSmall;//new
    NSString *ewmImg;//new
    //联系信息
    NSString*   email ;
    NSString*   phone ;
    NSString *   qq ;
    NSString *   qqUid ;
    NSString * weixinNo;//new
    NSString *weixinUid;//new
    //会员卡、积分等信息
    NSString *memberNo;//new
    int score;
    //辅助信息
    int status;//new
    BOOL isTemp;
    BOOL isWeixin;//new
    BOOL isWeinet;//new
    BOOL isApp;//new
    //注册信息
    NSDate *   regDate ;
    NSString *  regIp ;
    NSString *regAddress;//new
    NSString *regLongitude;//new
    NSString *regLatitude;//new
    int regDeviceId;//new
    NSString *regDeviceNo;//new
    //登录信息
    int  loginContinuedDayCount ;
    int  loginCount ;
    NSDate *lastLoginTime;// new
    NSString *lastLoginIp;//new
    double    lastLoginLongitude ;
    double    lastLoginLatitude ;
    NSString *    lastLoginAddress ;
    int lastDeviceId;
    NSString * lastDeviceNo;
    //唯一识别码
    NSString *uuid;
    //平台信息
    int purviewId;//new
    int platformId;//new
    NSDate *lastRegistrationDate;//最后一次签到时间
    //内部管理
    BOOL isInner;
    int innerRoleId;
    NSString *innerJobNo;
    //子平台编号
    int childPlatformId;//子平台编号
    int identityAuthId;//身份认证区分 0：未认证 1认证通过 -1认证失败
    int spreadUserId;//推广用户编号
    int authMachineCount;//认证设备台数
    int weixinAuthId;//微信认证区分 0：未认证 1认证通过 -1认证失败
    //用户邮箱地址
    int postId;
    int postMemberId;//用户id
    NSString *postReceiverName;//收件人姓名
    int postAreaId;//地区id
    NSString *postAreaName;
    NSString *postHomeAreaName;//详细地址
    NSString *postCode;//邮政编码
    NSString *postLinkTel;//联系电话
    
   
}

@property(nonatomic,assign) int  identity ;
@property(nonatomic,assign)BOOL isTemp;
@property(nonatomic,strong)NSString *   username ;
@property(nonatomic,strong)NSString *   email ;
@property(nonatomic,strong)NSString *   phone ;
@property(nonatomic,strong)NSString *    password ;
@property(nonatomic,strong)NSString *   nickname ;
@property(nonatomic,strong)NSString *   realName ;
@property(nonatomic,strong)NSString *   shortName ;
@property(nonatomic,strong)NSString *   minShortName ;

@property(nonatomic,strong)NSDate *   birthday ;
@property(nonatomic,assign)int  areaId ;
@property(nonatomic,strong)NSString * areaName ;
@property(nonatomic,assign)int  sex ;
@property(nonatomic,assign)int  workYearsId ;
@property(nonatomic,strong)NSString *   intro ;
@property(nonatomic,strong)NSString *   cardId ;
@property(nonatomic,strong)NSString *   qq ;
@property(nonatomic,strong)NSString *   qqUid ;

@property(nonatomic,assign)int  score ;

@property(nonatomic,strong)NSDate *   regDate ;
@property(nonatomic,strong)NSString *  regIp ;
@property(nonatomic,assign)int lastDeviceId;
@property(nonatomic,strong)NSString * lastDeviceNo;
@property(nonatomic,assign)double    lastLoginLongitude ;
@property(nonatomic,assign)double    lastLoginLatitude ;
@property(nonatomic,strong)NSString *    lastLoginAddress ;
@property(nonatomic,assign)int  loginContinuedDayCount ;
@property(nonatomic,assign)int  loginCount ;
@property(nonatomic,strong)NSString *    uuid ;

@property(nonatomic,strong)NSString *nameRemark;//new
@property(nonatomic,strong)NSString *userFace;//new
@property(nonatomic,strong)NSString *userFaceCenter;//new
@property(nonatomic,strong)NSString *userFaceSmall;//new
@property(nonatomic,strong)NSString *ewmImg;//new
@property(nonatomic,strong)NSString * weixinNo;//new
@property(nonatomic,strong)NSString *weixinUid;//new

@property(nonatomic,strong)NSString *memberNo;//new

@property(nonatomic,strong)NSString *regAddress;//new
@property(nonatomic,strong)NSString *regLongitude;//new
@property(nonatomic,strong)NSString *regLatitude;//new

@property(nonatomic,strong)NSString *lastLoginIp;//new

@property(nonatomic,strong)NSDate *lastLoginTime;// new
@property(nonatomic,strong)NSDate *   birthdayNl ;//new
@property(nonatomic,assign)int jobId;//new

@property(nonatomic,assign)int status;//new
@property(nonatomic,assign)BOOL isWeixin;//new
@property(nonatomic,assign)BOOL isWeinet;//new
@property(nonatomic,assign)BOOL isApp;//new
@property(nonatomic,assign)int regDeviceId;//new
@property(nonatomic,assign)int purviewId;//new
@property(nonatomic,assign)int platformId;//new

@property(nonatomic,assign)int machineId;
@property(nonatomic,assign)int industryId;
@property(nonatomic,assign)int workObjectId;


@property(nonatomic,strong)NSDate *lastRegistrationDate;//最后一次签到时间
//内部管理
@property(nonatomic,assign)BOOL isInner;
@property(nonatomic,assign)int innerRoleId;
@property(nonatomic,strong)NSString *innerJobNo;
//子平台编号
@property(nonatomic,assign)int childPlatformId;//子平台编号
@property(nonatomic,assign)int identityAuthId;//身份认证区分 0：未认证 1认证通过 -1认证失败
@property(nonatomic,assign)int spreadUserId;//推广用户编号
@property(nonatomic,assign)int authMachineCount;//认证设备台数
@property(nonatomic,assign)int weixinAuthId;//微信认证区分 0：未认证 1认证通过 -1认证失败
//用户邮箱地址
@property(nonatomic,assign)int postId;
@property(nonatomic,assign)int postMemberId;//用户id
@property(nonatomic,strong)NSString *postReceiverName;//收件人姓名
@property(nonatomic,assign)int postAreaId;//地区id
@property(nonatomic,strong)NSString *postAreaName;
@property(nonatomic,strong)NSString *postHomeAreaName;//详细地址
@property(nonatomic,strong)NSString *postCode;//邮政编码
@property(nonatomic,strong)NSString *postLinkTel;//联系电话


@end
