//
//  WcmCmsMemberMessage.m
//  asiastarbus
//
//  Created by apple on 14-9-29.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import "WcmCmsMemberMessage.h"
@implementation WcmCmsMemberMessageDAO
+(Class)getBindingModelClass
{
    return [WcmCmsMemberMessage class];
}
const static NSString* tablename = @"WcmCmsMemberMessage";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation WcmCmsMemberMessage
@synthesize identity;
@synthesize uuid;
@synthesize memberId;// 收件人id
@synthesize chatId;// 记录聊天室
@synthesize materialId;// 素材ID
@synthesize messageTypeId;// TODO 信息类型 基础代码 { CD10005：文本、语音、图片、视频、图文结合 }
@synthesize fileName;
@synthesize fileAddress;
@synthesize fileSmallAddress;
@synthesize fileSize;
@synthesize fileTimeLength;
@synthesize textMessage;
@synthesize flag;// 发送是否成功 程序自动设置 { 接受、未发送、发送 }
@synthesize status;// 是否已读 未读、已读、删除
@synthesize addUserId;
@synthesize addUser;
@synthesize addDate;
@synthesize updateUserId;
@synthesize updateDate;
@synthesize sid;
@synthesize isAll;// 是否群发消息，这个只是为了前后台实体类一致后台琮杰用到了
@synthesize fileServerAddress;//保存服务器上图片路径
@synthesize fileServerSmallAddress;//保存服务器上小图片路径
@synthesize title;
@synthesize cover;
@synthesize summary;
@synthesize linkUrl;
@synthesize toUser;
-(id)init{
    self = [super init];
    return self;
}
@end
