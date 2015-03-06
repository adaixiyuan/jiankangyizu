//
//  CommonUser.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "CommonUser.h"
@implementation CommonUserDAO
+(Class)getBindingModelClass
{
    return [CommonUser class];
}
const static NSString* tablename = @"CommonUser";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation CommonUser

@synthesize	identity;
@synthesize	uuid ;
@synthesize companyId;
@synthesize	headImg ;//TODO 大头像
@synthesize	usern ;//TODO 用户名
@synthesize	password ;//TODO 密码
@synthesize	email ;//TODO 邮箱
@synthesize	name ;//TODO 真实姓名
@synthesize	sex ;//TODO 性别
@synthesize	tel ;//TODO 联系电话
@synthesize	homeTel ;//TODO 家庭电话
@synthesize blood;//血型
@synthesize height;//高度
@synthesize birthdays;//生日
@synthesize bornProvince;
@synthesize bornCity;
@synthesize bornArea;
@synthesize bornAddress;
@synthesize liveProvince;
@synthesize liveCity;
@synthesize liveArea;
@synthesize liveAddress;
@synthesize companyName;//机构名称
@synthesize companyAddress;//机构地址
@synthesize jkNo;
@synthesize isQuit;//TODO 是否退出
@synthesize familyPhoto;//家庭图片

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

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:identity forKey:@"identity"];
    [aCoder encodeInteger:sex forKey:@"sex"];
    [aCoder encodeInteger:isQuit forKey:@"isQuit"];
    [aCoder encodeInteger:companyId forKey:@"companyId"];
    [aCoder encodeInteger:warningId forKey:@"warningId"];
    [aCoder encodeInteger:warningDataup forKey:@"warningDataup"];
    [aCoder encodeInteger:isNote forKey:@"isNote"];
    [aCoder encodeInteger:pcpMax forKey:@"pcpMax"];
    [aCoder encodeInteger:pcpMin forKey:@"pcpMin"];
    [aCoder encodeInteger:pdpMax forKey:@"pdpMax"];
    [aCoder encodeInteger:pdpMin forKey:@"pdpMin"];
    [aCoder encodeInteger:locusId forKey:@"locusId"];
    [aCoder encodeInteger:locusDataup forKey:@"locusDataup"];
    [aCoder encodeInteger:upTime forKey:@"upTime"];
    [aCoder encodeObject:uuid forKey:@"uuid"];
    [aCoder encodeObject:headImg forKey:@"headImg"];
    [aCoder encodeObject:usern forKey:@"usern"];
    [aCoder encodeObject:password forKey:@"password"];
    [aCoder encodeObject:email forKey:@"email"];
    [aCoder encodeObject:name forKey:@"name"];
    [aCoder encodeObject:tel forKey:@"tel"];
    [aCoder encodeObject:homeTel forKey:@"homeTel"];
    [aCoder encodeObject:blood forKey:@"blood"];
    [aCoder encodeObject:height forKey:@"height"];
    [aCoder encodeObject:birthdays forKey:@"birthdays"];
    [aCoder encodeObject:bornProvince forKey:@"bornProvince"];
    [aCoder encodeObject:bornCity forKey:@"bornCity"];
    [aCoder encodeObject:bornArea forKey:@"bornArea"];
    [aCoder encodeObject:bornAddress forKey:@"bornAddress"];
    [aCoder encodeObject:liveProvince forKey:@"liveProvince"];
    [aCoder encodeObject:liveCity forKey:@"liveCity"];
    [aCoder encodeObject:liveArea forKey:@"liveArea"];
    [aCoder encodeObject:liveAddress forKey:@"liveAddress"];
    [aCoder encodeObject:companyAddress forKey:@"companyName"];
    [aCoder encodeObject:companyAddress forKey:@"companyAddress"];
    [aCoder encodeObject:jkNo forKey:@"jkNo"];
    [aCoder encodeObject:familyPhoto forKey:@"familyPhoto"];
    [aCoder encodeDouble:gluMax forKey:@"gluMax"];
    [aCoder encodeDouble:gluMin forKey:@"gluMin"];
    [aCoder encodeDouble:earMax forKey:@"earMax"];
    [aCoder encodeDouble:earMin forKey:@"earMin"];
    
    

    
}
-(id)initWithCoder:(NSCoder *)aDecoder{
     self.identity=[aDecoder decodeIntForKey:@"identity"];
     self.sex=[aDecoder decodeIntForKey:@"sex"];
     self.isQuit=[aDecoder decodeIntForKey:@"isQuit"];
     self.warningId=[aDecoder decodeIntForKey:@"warningId"];
     self.warningDataup=[aDecoder decodeIntForKey:@"warningDataup"];
     self.isNote=[aDecoder decodeIntForKey:@"isNote"];
     self.pcpMax=[aDecoder decodeIntForKey:@"pcpMax"];
     self.pcpMin=[aDecoder decodeIntForKey:@"pcpMin"];
     self.pdpMax=[aDecoder decodeIntForKey:@"pdpMax"];
     self.pdpMin=[aDecoder decodeIntForKey:@"pdpMin"];
     self.locusId=[aDecoder decodeIntForKey:@"locusId"];
     self.locusDataup=[aDecoder decodeIntForKey:@"locusDataup"];
     self.upTime=[aDecoder decodeIntForKey:@"upTime"];
    self.companyId = [aDecoder decodeIntForKey:@"companyId"];
    self.uuid =[aDecoder decodeObjectForKey:@"uuid"];
    self.headImg =[aDecoder decodeObjectForKey:@"headImg"];
    self.usern =[aDecoder decodeObjectForKey:@"usern"];
    self.password =[aDecoder decodeObjectForKey:@"password"];
    self.email =[aDecoder decodeObjectForKey:@"email"];
    self.name =[aDecoder decodeObjectForKey:@"name"];
    self.tel =[aDecoder decodeObjectForKey:@"tel"];
    self.homeTel =[aDecoder decodeObjectForKey:@"homeTel"];
    self.blood =[aDecoder decodeObjectForKey:@"blood"];
    self.height =[aDecoder decodeObjectForKey:@"height"];
    self.birthdays =[aDecoder decodeObjectForKey:@"birthdays"];
    self.bornProvince =[aDecoder decodeObjectForKey:@"bornProvince"];
    self.bornCity =[aDecoder decodeObjectForKey:@"bornCity"];
    self.bornArea =[aDecoder decodeObjectForKey:@"bornArea"];
    self.bornAddress =[aDecoder decodeObjectForKey:@"bornAddress"];
    self.liveProvince =[aDecoder decodeObjectForKey:@"liveProvince"];
    self.liveCity =[aDecoder decodeObjectForKey:@"liveCity"];
    self.liveArea =[aDecoder decodeObjectForKey:@"liveArea"];
    self.liveAddress =[aDecoder decodeObjectForKey:@"liveAddress"];
    self.companyName =[aDecoder decodeObjectForKey:@"companyName"];
    self.companyAddress =[aDecoder decodeObjectForKey:@"companyAddress"];
    self.jkNo =[aDecoder decodeObjectForKey:@"jkNo"];
    self.familyPhoto =[aDecoder decodeObjectForKey:@"familyPhoto"];
    self.gluMax = [aDecoder decodeDoubleForKey:@"gluMax"];
    self.gluMin = [aDecoder decodeDoubleForKey:@"gluMin"];
    self.earMax = [aDecoder decodeDoubleForKey:@"earMax"];
    self.earMin = [aDecoder decodeDoubleForKey:@"earMin"];
    
       
    return self;
}
@end
