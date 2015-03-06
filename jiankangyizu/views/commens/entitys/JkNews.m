//
//  JkNews.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkNews.h"
@implementation JkNewsDAO
+(Class)getBindingModelClass
{
    return [JkNews class];
}
const static NSString* tablename = @"JkNews";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation JkNews

@synthesize identity;
@synthesize uuid;
@synthesize addDate;
@synthesize addIp;
@synthesize addUser;
@synthesize catId;
@synthesize source;
@synthesize title;
@synthesize subTitle;
@synthesize img;
@synthesize name;
@synthesize summary;
@synthesize content;
@synthesize pubDate;
@synthesize linkOther;
@synthesize isShow;
@synthesize viewCount;
@synthesize replyCount;
@synthesize shareCount;
@synthesize isRecommend;
@synthesize departmentNo;
@synthesize userId;
@end
