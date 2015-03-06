//
//  JkGluAnalysis.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkGluAnalysis.h"
@implementation JkGluAnalysisDAO
+(Class)getBindingModelClass
{
    return [JkGluAnalysis class];
}
const static NSString* tablename = @"JkGluAnalysis";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation JkGluAnalysis
@synthesize identity;
@synthesize avgGlu;
@synthesize maxGlu;
@synthesize minGlu;
@synthesize totalCount;
@end
