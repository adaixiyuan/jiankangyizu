//
//  Wcm_Common_Region.m
//  asiastarbus
//
//  Created by apple on 14-8-29.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import "Wcm_Common_Region.h"
@implementation Wcm_Common_RegionDao
+(Class)getBindingModelClass
{
    return [Wcm_Common_Region class];
}
const static NSString* tablename = @"Wcm_Common_Region";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation Wcm_Common_Region
@synthesize identity;
@synthesize uuid;
@synthesize first_letter;
@synthesize area_name;
@synthesize parent_area_id;
@synthesize node_path;
@synthesize node_full_name;
@synthesize level_id;
@synthesize show_order;
@synthesize is_use;
@synthesize remark;
-(id)init{
    self = [super init];
    return self;
}
@end
