//
//  BbsMemberSelf.m
//  ViewDeckExample
//
//  Created by wang kevin on 13-1-29.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import "BbsMemberSelf.h"

@implementation BbsMemberSelf
@synthesize   identity ;
@synthesize isTemp;
@synthesize    username ;
@synthesize    email ;
@synthesize    phone ;
@synthesize    password ;
@synthesize    nickname ;
@synthesize    realName ;
@synthesize    shortName ;
@synthesize    minShortName ;
@synthesize    birthday ;
@synthesize  areaId ;
@synthesize  areaName ;
@synthesize  sex ;
@synthesize  workYearsId ;
@synthesize    intro ;
@synthesize    cardId ;
@synthesize    qq ;
@synthesize    qqUid ;
@synthesize  score ;
@synthesize     regDate ;
@synthesize   regIp ;
@synthesize     lastDeviceId;
@synthesize  lastDeviceNo;
@synthesize    lastLoginLongitude ;
@synthesize    lastLoginLatitude ;
@synthesize     lastLoginAddress ;
@synthesize     loginContinuedDayCount ;
@synthesize     loginCount ;
@synthesize     uuid ;


@synthesize nameRemark;//new
@synthesize userFace;//new
@synthesize userFaceCenter;//new
@synthesize userFaceSmall;//new
@synthesize ewmImg;//new
@synthesize  weixinNo;//new
@synthesize weixinUid;//new

@synthesize memberNo;//new
@synthesize regAddress;//new
@synthesize regLongitude;//new
@synthesize regLatitude;//new

@synthesize lastLoginIp;//new

@synthesize lastLoginTime;// new
@synthesize    birthdayNl ;//new



@synthesize jobId;//new

@synthesize status;//new
@synthesize isWeixin;//new
@synthesize isWeinet;//new
@synthesize isApp;//new
@synthesize regDeviceId;//new
@synthesize purviewId;//new
@synthesize platformId;//newn

@synthesize machineId;
@synthesize industryId;
@synthesize workObjectId;


@synthesize lastRegistrationDate;//最后一次签到时间
//内部管理
@synthesize isInner;
@synthesize innerRoleId;
@synthesize innerJobNo;
//子平台编号
@synthesize childPlatformId;//子平台编号
@synthesize identityAuthId;//身份认证区分 0：未认证 1认证通过 -1认证失败
@synthesize spreadUserId;//推广用户编号
@synthesize authMachineCount;//认证设备台数
@synthesize weixinAuthId;//微信认证区分 0：未认证 1认证通过 -1认证失败
//用户邮箱地址
@synthesize postId;
@synthesize postMemberId;//用户id
@synthesize postReceiverName;//收件人姓名
@synthesize postAreaId;//地区id
@synthesize postAreaName;
@synthesize postHomeAreaName;//详细地址
@synthesize postCode;//邮政编码
@synthesize postLinkTel;//联系电话

-(id)init{
    self=[super init];
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:lastRegistrationDate forKey:@"lastRegistrationDate"];
    [aCoder encodeObject:innerJobNo forKey:@"innerJobNo"];
    [aCoder encodeObject:postReceiverName forKey:@"postReceiverName"];
    [aCoder encodeObject:postAreaName forKey:@"postAreaName"];
    [aCoder encodeObject:postHomeAreaName forKey:@"postHomeAreaName"];
    [aCoder encodeObject:postCode forKey:@"postCode"];
    [aCoder encodeObject:postLinkTel forKey:@"postLinkTel"];
    [aCoder encodeInteger:innerRoleId forKey:@"innerRoleId"];
    [aCoder encodeInteger:childPlatformId forKey:@"childPlatformId"];
    [aCoder encodeInteger:identityAuthId forKey:@"identityAuthId"];
    [aCoder encodeInteger:spreadUserId forKey:@"spreadUserId"];
    [aCoder encodeInteger:authMachineCount forKey:@"authMachineCount"];
    [aCoder encodeInteger:weixinAuthId forKey:@"weixinAuthId"];
    [aCoder encodeInteger:postId forKey:@"postId"];
    [aCoder encodeInteger:postMemberId forKey:@"postMemberId"];
    [aCoder encodeInteger:postAreaId forKey:@"postAreaId"];
    [aCoder encodeBool:isInner forKey:@"isInner"];
    [aCoder encodeObject:nameRemark forKey:@"nameRemark"];
    [aCoder encodeObject:userFace forKey:@"userFace"];
    [aCoder encodeObject:userFaceCenter forKey:@"userFaceCenter"];
    [aCoder encodeObject:userFaceSmall forKey:@"userFaceSmall"];
    [aCoder encodeObject:ewmImg forKey:@"ewmImg"];
    [aCoder encodeObject:weixinNo forKey:@"weixinNo"];
    [aCoder encodeObject:weixinUid forKey:@"weixinUid"];
    [aCoder encodeObject:memberNo forKey:@"memberNo"];
    [aCoder encodeObject:regAddress forKey:@"regAddress"];
    [aCoder encodeObject:regLongitude forKey:@"regLongitude"];
    [aCoder encodeObject:regLatitude forKey:@"regLatitude"];
    [aCoder encodeObject:lastLoginIp forKey:@"lastLoginIp"];
    [aCoder encodeObject:lastLoginTime forKey:@"lastLoginTime"];
    [aCoder encodeObject:birthdayNl forKey:@"birthdayNl"];
    
    [aCoder encodeInteger:jobId forKey:@"jobId"];
    [aCoder encodeInteger:status forKey:@"status"];
    [aCoder encodeInteger:regDeviceId forKey:@"regDeviceId"];
    [aCoder encodeInteger:purviewId forKey:@"purviewId"];
    [aCoder encodeInteger:platformId forKey:@"platformId"];
    [aCoder encodeBool:isWeixin forKey:@"isWeixin"];
    [aCoder encodeBool:isWeinet forKey:@"isWeinet"];
    [aCoder encodeBool:isApp forKey:@"isApp"];
    [aCoder encodeBool:isTemp forKey:@"isTemp"];
    
    [aCoder encodeInteger:identity forKey:@"identity"];
    
    

    [aCoder encodeObject:username forKey:@"username"];
    [aCoder encodeObject:email forKey:@"email"];
    [aCoder encodeObject:phone forKey:@"phone"];
    [aCoder encodeObject:password forKey:@"password"];
    [aCoder encodeObject:nickname forKey:@"nickname"];
    [aCoder encodeObject:realName forKey:@"realName"];
    [aCoder encodeObject:shortName forKey:@"shortName"];

    [aCoder encodeObject:minShortName forKey:@"minShortName"];
    [aCoder encodeObject:birthday forKey:@"birthday"];
    [aCoder encodeInteger:areaId forKey:@"areaId"];
    [aCoder encodeObject:areaName forKey:@"areaName"];
    [aCoder encodeInteger:sex forKey:@"sex"];
    [aCoder encodeInteger:workYearsId forKey:@"workYearsId"];
    [aCoder encodeObject:intro forKey:@"intro"];
    [aCoder encodeObject:cardId forKey:@"cardId"];
    [aCoder encodeObject:qq forKey:@"qq"];
    [aCoder encodeObject:qqUid forKey:@"qqUid"];
    [aCoder encodeInteger:score forKey:@"score"];
    

    [aCoder encodeObject:regDate forKey:@"regDate"];
    [aCoder encodeObject:regIp forKey:@"regIp"];
    [aCoder encodeInteger:lastDeviceId forKey:@"lastDeviceId"];
    [aCoder encodeObject:lastDeviceNo forKey:@"lastDeviceNo"];
    [aCoder encodeDouble:lastLoginLongitude forKey:@"lastLoginLongitude"];
    [aCoder encodeDouble:lastLoginLatitude forKey:@"lastLoginLatitude"];
    [aCoder encodeObject:lastLoginAddress forKey:@"lastLoginAddress"];
    [aCoder encodeInteger:loginContinuedDayCount forKey:@"loginContinuedDayCount"];
    [aCoder encodeInteger:loginCount forKey:@"loginCount"];
    [aCoder encodeObject:uuid forKey:@"uuid"];
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    self.isInner=[aDecoder decodeBoolForKey:@"isInner"];
    
    self.lastRegistrationDate =[aDecoder decodeObjectForKey:@"lastRegistrationDate"];
    self.innerJobNo =[aDecoder decodeObjectForKey:@"innerJobNo"];
    self.postAreaName =[aDecoder decodeObjectForKey:@"postAreaName"];
    self.postReceiverName =[aDecoder decodeObjectForKey:@"postReceiverName"];
    self.postHomeAreaName =[aDecoder decodeObjectForKey:@"postHomeAreaName"];
    self.postCode =[aDecoder decodeObjectForKey:@"postCode"];
    self.postLinkTel =[aDecoder decodeObjectForKey:@"postLinkTel"];
    self.innerRoleId=[aDecoder decodeIntForKey:@"innerRoleId"];
    self.childPlatformId=[aDecoder decodeIntForKey:@"childPlatformId"];
    self.spreadUserId=[aDecoder decodeIntForKey:@"spreadUserId"];
    self.authMachineCount=[aDecoder decodeIntForKey:@"authMachineCount"];
    self.weixinAuthId=[aDecoder decodeIntForKey:@"weixinAuthId"];
    self.postId=[aDecoder decodeIntForKey:@"postId"];
    self.postMemberId=[aDecoder decodeIntForKey:@"postMemberId"];
    self.postAreaId=[aDecoder decodeIntForKey:@"postAreaId"];
    self.identityAuthId=[aDecoder decodeIntForKey:@"identityAuthId"];
    self.identity=[aDecoder decodeIntForKey:@"identity"];
    self.username =[aDecoder decodeObjectForKey:@"username"];
    self.email=[aDecoder decodeObjectForKey:@"email"] ;
    self.phone=[aDecoder decodeObjectForKey:@"phone"] ;
    self.password =[aDecoder decodeObjectForKey:@"password"];
    self.nickname =[aDecoder decodeObjectForKey:@"nickname"];
    self.realName =[aDecoder decodeObjectForKey:@"realName"];
    self.shortName=[aDecoder decodeObjectForKey:@"shortName"] ;
    self.minShortName=[aDecoder decodeObjectForKey:@"minShortName"] ;
    self.birthday =[aDecoder decodeObjectForKey:@"birthday"];;
    self.areaId=[aDecoder decodeIntForKey:@"areaId"] ;
    self.areaName=[aDecoder decodeObjectForKey:@"areaName"] ;
    self.sex=[aDecoder decodeIntForKey:@"sex"] ;
    self.workYearsId=[aDecoder decodeIntForKey:@"workYearsId"] ;
    self.intro =[aDecoder decodeObjectForKey:@"intro"];
    self.cardId =[aDecoder decodeObjectForKey:@"cardId"];
    self.qq =[aDecoder decodeObjectForKey:@"qq"];
    self.qqUid=[aDecoder decodeObjectForKey:@"qqUid"] ;
    self.score =[aDecoder decodeIntForKey:@"score"];
    self.regDate=[aDecoder decodeObjectForKey:@"regDate"] ;
    self.regIp =[aDecoder decodeObjectForKey:@"regIp"];
    self.lastDeviceId=[aDecoder decodeIntForKey:@"lastDeviceId"];
    self.lastDeviceNo=[aDecoder decodeObjectForKey:@"lastDeviceNo"];
    self.lastLoginLongitude=[aDecoder decodeDoubleForKey:@"lastLoginLongitude"] ;
    self.lastLoginLatitude =[aDecoder decodeDoubleForKey:@"lastLoginLatitude"];
    self.lastLoginAddress=[aDecoder decodeObjectForKey:@"lastLoginAddress"] ;
    self.loginContinuedDayCount=[aDecoder decodeIntForKey:@"loginContinuedDayCount"] ;
    self.loginCount=[aDecoder decodeIntForKey:@"loginCount"] ;
    self.uuid =[aDecoder decodeObjectForKey:@"uuid"];
    self.isTemp=[aDecoder decodeBoolForKey:@"isTemp"];
    
    self.nameRemark =[aDecoder decodeObjectForKey:@"nameRemark"];
    self.userFace =[aDecoder decodeObjectForKey:@"userFace"];
    self.userFaceCenter =[aDecoder decodeObjectForKey:@"userFaceCenter"];
    self.userFaceSmall =[aDecoder decodeObjectForKey:@"userFaceSmall"];
    self.ewmImg =[aDecoder decodeObjectForKey:@"ewmImg"];
    self.weixinNo =[aDecoder decodeObjectForKey:@"weixinNo"];
    self.weixinUid =[aDecoder decodeObjectForKey:@"weixinUid"];
    self.memberNo =[aDecoder decodeObjectForKey:@"memberNo"];
    self.regAddress =[aDecoder decodeObjectForKey:@"regAddress"];
    self.regLongitude =[aDecoder decodeObjectForKey:@"regLongitude"];
    self.regLatitude =[aDecoder decodeObjectForKey:@"regLatitude"];
    self.lastLoginIp =[aDecoder decodeObjectForKey:@"lastLoginIp"];
    self.lastLoginTime =[aDecoder decodeObjectForKey:@"lastLoginTime"];
    self.birthdayNl =[aDecoder decodeObjectForKey:@"birthdayNl"];
    
    self.jobId =[aDecoder decodeIntForKey:@"jobId"];
    self.status =[aDecoder decodeIntForKey:@"status"];
    self.regDeviceId =[aDecoder decodeIntForKey:@"regDeviceId"];
    self.purviewId =[aDecoder decodeIntForKey:@"purviewId"];
    self.platformId =[aDecoder decodeIntForKey:@"platformId"];
    
    
     self.isWeixin=[aDecoder decodeBoolForKey:@"isWeixin"];
     self.isWeinet=[aDecoder decodeBoolForKey:@"isWeinet"];
     self.isApp=[aDecoder decodeBoolForKey:@"isApp"];
    
    return self;
}


@end
