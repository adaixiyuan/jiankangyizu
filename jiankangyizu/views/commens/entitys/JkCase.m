//
//  JkCase.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkCase.h"
@implementation JkCaseDAO
+(Class)getBindingModelClass
{
    return [JkCase class];
}
const static NSString* tablename = @"JkCase";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation JkCase
@synthesize identity;
@synthesize addDate;
@synthesize addIp;
@synthesize addUser;
@synthesize uuid;
@synthesize caseDate;
@synthesize resultContent;
@synthesize resultImg;
@synthesize prescriptionContent;
@synthesize prescriptionImg;
@synthesize userId;
@synthesize hospital;
@synthesize departmentNo;
@synthesize name;
@end
