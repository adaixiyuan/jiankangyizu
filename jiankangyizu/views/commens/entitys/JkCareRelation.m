//
//  JkCareRelation.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkCareRelation.h"
@implementation JkCareRelationDAO
+(Class)getBindingModelClass
{
    return [JkCareRelation class];
}
const static NSString* tablename = @"JkCareRelation";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation JkCareRelation
@synthesize	identity ;
@synthesize	careUserId ;
@synthesize	caredUserId ;
@synthesize	address ;
@synthesize	age ;
@synthesize jkNo;
@synthesize	name ;
@synthesize	sex ;
@synthesize	tel ;
@synthesize status;
@synthesize headImg;
@synthesize summary;//简介
@synthesize department;//科室
@synthesize favorite;//擅长
@end
