//
//  JkDrug.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkDrug.h"
@implementation JkDrugDAO
+(Class)getBindingModelClass
{
    return [JkDrug class];
}
const static NSString* tablename = @"JkDrug";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation JkDrug
@synthesize identity;
@synthesize addDate;
@synthesize addIp;
@synthesize userId;
@synthesize name;
@synthesize number;
@synthesize hour;
@synthesize minute;
@synthesize drugImg;
@end
