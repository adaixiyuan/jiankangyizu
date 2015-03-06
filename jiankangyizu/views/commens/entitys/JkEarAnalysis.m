//
//  JkEarAnalysis.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkEarAnalysis.h"
@implementation JkEarAnalysisDAO
+(Class)getBindingModelClass
{
    return [JkEarAnalysis class];
}
const static NSString* tablename = @"JkEarAnalysis";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation JkEarAnalysis
@synthesize identity;
@synthesize avgEar;
@synthesize maxEar;
@synthesize minEar;
@synthesize totalCount;
@end
