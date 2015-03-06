//
//  JkFamily.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkFamily.h"
@implementation JkFamilyDAO
+(Class)getBindingModelClass
{
    return [JkFamily class];
}
const static NSString* tablename = @"JkFamily";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation JkFamily

@synthesize identity ;
@synthesize addUser;
@synthesize addDate;
@synthesize addIp;
@synthesize uuid;
@synthesize name;
@synthesize userId;
@synthesize relationUserId;  //关联的用户id
@synthesize jkState;
@synthesize locusState;
@synthesize caseState;
@synthesize username;
@synthesize relationName;  //关联的姓名
@synthesize address;
@synthesize sex;
@synthesize age;
@synthesize tel;
@synthesize headImg;
@end
