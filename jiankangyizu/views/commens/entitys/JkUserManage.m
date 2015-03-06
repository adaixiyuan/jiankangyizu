//
//  JkUserManage.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-5.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkUserManage.h"
#import "ZUOYLDAOBase.h"

@implementation JkUserManageDao

+ (Class)getBindingModelClass
{
    return [JkUserManage class];
}
const static NSString* tablename = @"JkUserManage";
+(const NSString *)getTableName
{
    return tablename;
}
@end

@implementation JkUserManage

@synthesize identity;
@synthesize name;
@synthesize jkNo;
@synthesize sex;
@synthesize age;
@synthesize headImg;
@synthesize tel;
@synthesize liveProvince;
@synthesize liveCity;
@synthesize liveArea;
@synthesize address;
@synthesize bongUid;
@synthesize gudongUid;
@synthesize companyId;
@synthesize userId;
@synthesize jkState;
@synthesize locusState;
@synthesize caseState;
@synthesize warnNumber;

@end
