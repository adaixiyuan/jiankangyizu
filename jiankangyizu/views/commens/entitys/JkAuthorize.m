//
//  JkAuthorize.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkAuthorize.h"
@implementation JkAuthorizeDAO
+(Class)getBindingModelClass
{
    return [JkAuthorize class];
}
const static NSString* tablename = @"JkAuthorize";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation JkAuthorize
@synthesize	identity ;
@synthesize	no ;
@synthesize	name;
@synthesize	linkMan ;
@synthesize	linkPhone ;
@synthesize 	address;
@synthesize	companyId ;
@synthesize	userId ;
@synthesize	jkState ;
@synthesize locusState;
@synthesize caseState;
@end
