//
//  JkMessageUser.m
//  jiankangyizu
//
//  Created by JEREI on 15-3-3.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkMessageUser.h"

@implementation JkMessageUserDao

+ (Class)getBindingModelClass
{
    return [JkMessageUser class];
}
const static NSString* tablename = @"JkMessageUser";
+(const NSString *)getTableName
{
    return tablename;
}
@end

@implementation JkMessageUser

@synthesize identity;
@synthesize name;
@synthesize count;

@end