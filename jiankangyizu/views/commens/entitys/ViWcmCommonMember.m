//
//  ViWcmCommonMember.m
//  asiastarbus
//
//  Created by apple on 14-10-10.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import "ViWcmCommonMember.h"
@implementation ViWcmCommonMemberDAO
+(Class)getBindingModelClass
{
    return [ViWcmCommonMember class];
}
const static NSString* tablename = @"ViWcmCommonMember";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation ViWcmCommonMember
@synthesize	identity ;
@synthesize	uuid ;
@synthesize	headImg ;//TODO 大头像
@synthesize	usern ;//TODO 用户名
@synthesize	password ;//TODO 密码
@synthesize	email ;//TODO 邮箱
@synthesize	phone ;//TODO 手机
@synthesize	realName ;//TODO 真实姓名
@synthesize	sex ;//TODO 性别
@synthesize birthday ;//TODO 生日
@synthesize	telephone ;//TODO 座机
@synthesize	provinceId ;//TODO 省id
@synthesize	cityId ;//TODO 市id
@synthesize	areaId ;//TODO 区id
@synthesize address;//详细地址
@synthesize zip;//邮编
@synthesize	intro ;//TODO 个性签名
@synthesize	qq ;//TODO QQ号
@synthesize	qqOpenId ;//TODO QQ开放Id
@synthesize	sinaOpenId ;//TODO sina开放Id
//TODO 会员卡、积分等信息
@synthesize	memberNo ;
@synthesize	nowScore ;
//TODO 辅助信息
@synthesize	isTemp ;//TODO 是否是临时账户
@synthesize isQuit;//TODO 是否退出
@synthesize lastRegistrationDate;//最后一次签到时间

@synthesize nickName;//TODO 昵称
@synthesize weixinNo;//TODO 微信编号
@synthesize lastDeviceId;//TODO 手机设备类型
@synthesize lastDeviceNo;//TODO 手机设备编号
@synthesize jobId;//TODO 职业编号
@synthesize isOwn;//TODO 自有客户
@synthesize identityAuthId;//TODO 认证编号

@synthesize postReceiverName;//TODO 邮寄收件人地址
@synthesize postAreaId;//TODO  邮寄地区编号
@synthesize postAddress;//TODO 邮寄地址
@synthesize postCode;//TODO 邮寄邮编
@synthesize postLinkTel;//TODO 邮寄联系电话

-(id)init{
    self=[super init];
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:lastRegistrationDate forKey:@"lastRegistrationDate"];
    [aCoder encodeObject:memberNo forKey:@"memberNo"];
    [aCoder encodeObject:sinaOpenId forKey:@"sinaOpenId"];
    [aCoder encodeObject:qqOpenId forKey:@"qqOpenId"];
    [aCoder encodeObject:qq forKey:@"qq"];
    [aCoder encodeObject:intro forKey:@"intro"];
    [aCoder encodeObject:zip forKey:@"zip"];
    [aCoder encodeObject:address forKey:@"address"];
    [aCoder encodeObject:telephone forKey:@"telephone"];
    [aCoder encodeObject:birthday forKey:@"birthday"];
    [aCoder encodeObject:realName forKey:@"realName"];
    [aCoder encodeObject:phone forKey:@"phone"];
    [aCoder encodeObject:email forKey:@"email"];
    [aCoder encodeObject:password forKey:@"password"];
    [aCoder encodeObject:usern forKey:@"usern"];
    [aCoder encodeObject:headImg forKey:@"headImg"];
    [aCoder encodeObject:uuid forKey:@"uuid"];
    [aCoder encodeInteger:nowScore forKey:@"nowScore"];
    [aCoder encodeInteger:areaId forKey:@"areaId"];
    [aCoder encodeInteger:cityId forKey:@"cityId"];
    [aCoder encodeInteger:provinceId forKey:@"provinceId"];
    [aCoder encodeInteger:sex forKey:@"sex"];
    
    [aCoder encodeBool:isQuit forKey:@"isQuit"];
    [aCoder encodeBool:isTemp forKey:@"isTemp"];
    
    [aCoder encodeInteger:identity forKey:@"identity"];
    
    [aCoder encodeObject:nickName forKey:@"nickName"];

     [aCoder encodeObject:weixinNo forKey:@"weixinNo"];
    [aCoder encodeInteger:lastDeviceId forKey:@"lastDeviceId"];
     [aCoder encodeObject:lastDeviceNo forKey:@"lastDeviceNo"];

      [aCoder encodeInteger:jobId forKey:@"jobId"];
      [aCoder encodeInteger:isOwn forKey:@"isOwn"];
    [aCoder encodeInteger:identityAuthId forKey:@"identityAuthId"];
    
    [aCoder encodeObject:postReceiverName forKey:@"postReceiverName"];
    [aCoder encodeInteger:postAreaId forKey:@"postAreaId"];
    [aCoder encodeObject:postAddress forKey:@"postAddress"];
    [aCoder encodeObject:postCode forKey:@"postCode"];
    [aCoder encodeObject:postLinkTel forKey:@"postLinkTel"];
    
   }
-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self.lastRegistrationDate =[aDecoder decodeObjectForKey:@"lastRegistrationDate"];
    self.memberNo =[aDecoder decodeObjectForKey:@"memberNo"];
    self.sinaOpenId =[aDecoder decodeObjectForKey:@"sinaOpenId"];
    self.qqOpenId =[aDecoder decodeObjectForKey:@"qqOpenId"];
    self.qq =[aDecoder decodeObjectForKey:@"qq"];
    self.intro =[aDecoder decodeObjectForKey:@"intro"];
    self.zip =[aDecoder decodeObjectForKey:@"zip"];
    self.address=[aDecoder decodeObjectForKey:@"address"];
    self.telephone=[aDecoder decodeObjectForKey:@"telephone"] ;
    self.birthday=[aDecoder decodeObjectForKey:@"birthday"] ;
    self.realName =[aDecoder decodeObjectForKey:@"realName"];
    self.phone =[aDecoder decodeObjectForKey:@"phone"];
    self.email =[aDecoder decodeObjectForKey:@"email"];
    self.password=[aDecoder decodeObjectForKey:@"password"] ;
    self.usern=[aDecoder decodeObjectForKey:@"usern"] ;
    self.headImg =[aDecoder decodeObjectForKey:@"headImg"];;
    self.uuid =[aDecoder decodeObjectForKey:@"uuid"];
    self.isTemp=[aDecoder decodeBoolForKey:@"isTemp"];
    
    self.identity=[aDecoder decodeIntForKey:@"identity"];
    self.sex=[aDecoder decodeIntForKey:@"sex"];
    self.provinceId=[aDecoder decodeIntForKey:@"provinceId"];
    self.cityId=[aDecoder decodeIntForKey:@"cityId"];
    self.areaId=[aDecoder decodeIntForKey:@"areaId"];
    self.nowScore=[aDecoder decodeIntForKey:@"nowScore"];
    
    self.isQuit=[aDecoder decodeBoolForKey:@"isQuit"];
    
    
    self.nickName = [aDecoder decodeObjectForKey:@"nickName"];
    self.weixinNo = [aDecoder decodeObjectForKey:@"weixinNo"];
    self.lastDeviceNo = [aDecoder decodeObjectForKey:@"lastDeviceNo"];
    self.postReceiverName = [aDecoder decodeObjectForKey:@"postReceiverName"];
    self.postAddress = [aDecoder decodeObjectForKey:@"postAddress"];
    self.postCode = [aDecoder decodeObjectForKey:@"postCode"];
    self.postLinkTel = [aDecoder decodeObjectForKey:@"postLinkTel"];
    
    self.lastDeviceId =[aDecoder decodeIntForKey:@"lastDeviceId"] ;
    self.jobId = [aDecoder decodeIntForKey:@"jobId"];
    self.isOwn =[aDecoder decodeIntForKey:@"isOwn"] ;
    self.identityAuthId =[aDecoder decodeIntForKey:@"identityAuthId"] ;
    self.postAreaId = [aDecoder decodeIntForKey:@"postAreaId"];
    
    return self;
}


@end
