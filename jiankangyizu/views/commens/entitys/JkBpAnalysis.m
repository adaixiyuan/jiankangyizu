//
//  JkBpAnalysis.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkBpAnalysis.h"
@implementation JkBpAnalysisDAO
+(Class)getBindingModelClass
{
    return [JkBpAnalysis class];
}
const static NSString* tablename = @"JkBpAnalysis";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation JkBpAnalysis
@synthesize identity;
@synthesize avgPcp;
@synthesize avgPdp;
@synthesize avgRate;
@synthesize maxPcp;
@synthesize maxPdp;
@synthesize maxRate;
@synthesize minPcp;
@synthesize minPdp;
@synthesize minRate;
@synthesize totalCount;
@end
