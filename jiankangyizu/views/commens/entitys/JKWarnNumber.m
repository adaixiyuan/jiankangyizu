
//
//  JKWarnNumber.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-3.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JKWarnNumber.h"
#import "ZUOYLDAOBase.h"
@implementation JKWarnNumber : ZUOYLDAOBase
+(Class)getBindingModelClass
{
    return [JKWarnNumber class];
}
const static NSString* tablename = @"JKWarnNumber";
+(const NSString *)getTableName
{
    return tablename;
}
@synthesize bpCount;
@synthesize earCount;
@synthesize gluCount;
@end
