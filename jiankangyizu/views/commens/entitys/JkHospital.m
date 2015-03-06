//
//  JkHospital.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkHospital.h"
@implementation JkHospitalDAO
+(Class)getBindingModelClass
{
    return [JkHospital class];
}
const static NSString* tablename = @"JkHospital";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation JkHospital
@synthesize identity;
@synthesize addUser;
@synthesize addDate;
@synthesize addIp;
@synthesize uuid;
@synthesize name;
@synthesize departmentName;
@synthesize linkMan;
@synthesize linkPhone;
@synthesize province;
@synthesize city;
@synthesize area;
@synthesize address;
@synthesize state;
@synthesize no;
@synthesize linkEmail;
@synthesize img;
@synthesize departmentNo;
@synthesize intro;
@synthesize type;
@end
