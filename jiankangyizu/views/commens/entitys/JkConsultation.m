//
//  JkConsultation.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkConsultation.h"
@implementation JkConsultationDAO
+(Class)getBindingModelClass
{
    return [JkConsultation class];
}
const static NSString* tablename = @"JkConsultation";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation JkConsultation
@synthesize identity;
@synthesize addDate;
@synthesize addIp;
@synthesize addUser;
@synthesize caseDate;
@synthesize img;
@synthesize consultationDate;
@synthesize uuid;
@synthesize content;
@synthesize file;
@synthesize parentId;
@synthesize userId;
@synthesize departmentNo;
@synthesize replyCount;
@synthesize departmentName;
@synthesize doctorId;
@end
