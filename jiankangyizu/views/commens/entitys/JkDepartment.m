//
//  JkDepartment.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkDepartment.h"
@implementation JkDepartmentDAO
+(Class)getBindingModelClass
{
    return [JkDepartment class];
}
const static NSString* tablename = @"JkDepartment";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation JkDepartment
@synthesize identity;
@synthesize addUser;
@synthesize addDate;
@synthesize addIp;
@synthesize uuid;
@synthesize parentNo;
@synthesize no;
@synthesize name;
@synthesize val;
@synthesize img;
@synthesize intro;
@synthesize isShow;
@synthesize orderNo;
@synthesize isSystem;
@end
