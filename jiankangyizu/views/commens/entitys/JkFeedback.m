//
//  JkFeedback.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkFeedback.h"
@implementation JkFeedbackDAO
+(Class)getBindingModelClass
{
    return [JkFeedback class];
}
const static NSString* tablename = @"JkFeedback";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation JkFeedback
@synthesize identity;
@synthesize addDate;
@synthesize addIp;
@synthesize addUser;
@synthesize userId;
@synthesize content;
@synthesize version;
@end
