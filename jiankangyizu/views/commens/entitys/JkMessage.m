//
//  JkMessage.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkMessage.h"
@implementation JkMessageDAO
+(Class)getBindingModelClass
{
    return [JkMessage class];
}
const static NSString* tablename = @"JkMessage";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation JkMessage
@synthesize identity;
@synthesize addUser;
@synthesize addDate;
@synthesize addIp;
@synthesize uuid;
@synthesize memberId; //发消息人的id
@synthesize content;   //消息内容
@synthesize version;
@synthesize toMemberId; //收到消息的人I
@synthesize messageTypeId;//消息类型
@synthesize isAll;        //是否群发(0，单发，1，群发)
@synthesize textMessage;   //显示的文本
@synthesize status;
@synthesize isRead;
@synthesize messageType; //消息类型
@end
