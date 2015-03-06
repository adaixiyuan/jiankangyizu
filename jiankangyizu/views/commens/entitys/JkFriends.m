//
//  JkFriends.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkFriends.h"
@implementation JkFriendsDAO
+(Class)getBindingModelClass
{
    return [JkFriends class];
}
const static NSString* tablename = @"JkFriends";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation JkFriends
@synthesize identity;
@synthesize  name;
@synthesize headImg;
@synthesize bongUid;
@synthesize gudongUid;
@synthesize calories; // 能量
@synthesize sleepNum; // 睡眠
@end
