//
//  WcmCmsMemberMessage.h
//  asiastarbus
//
//  Created by apple on 14-9-29.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface WcmCmsMemberMessageDAO : ZUOYLDAOBase

@end
@interface WcmCmsMemberMessage : ZUOYLModelBase
{
    NSString *identity;
    NSString *uuid;
    int memberId;// 收件人id
    NSString *chatId;// 记录聊天室
    int materialId;// 素材ID
    int messageTypeId;// TODO 信息类型 基础代码 { CD10005：文本、语音、图片、视频、图文结合 }
    NSString *fileName;
    NSString *fileAddress;
    NSString *fileSmallAddress;
    int fileSize;
    int fileTimeLength;
    NSString *textMessage;
    int flag;// 发送是否成功 程序自动设置 { 接受、未发送、发送 }
    int status;// 是否已读 未读、已读、删除
    int addUserId;
    NSString *addUser;
    NSString *addDate;
    int updateUserId;
    NSString *updateDate;
    int sid;
    int isAll;// 是否群发消息，这个只是为了前后台实体类一致后台琮杰用到了
    NSString *fileServerAddress;//保存服务器上图片路径
    NSString *fileServerSmallAddress;//保存服务器上小图片路径
    
    NSString *title;
    NSString *cover;
    NSString *summary;
    NSString *linkUrl;
    NSString *toUser;
}
@property(nonatomic,strong) NSString *identity;
@property(nonatomic,strong)NSString *uuid;
@property(nonatomic,assign)int memberId;// 收件人id
@property(nonatomic,strong)NSString *chatId;// 记录聊天室
@property(nonatomic,assign)int materialId;// 素材ID
@property(nonatomic,assign)int messageTypeId;// TODO 信息类型 基础代码 { CD10005：文本、语音、图片、视频、图文结合 }
@property(nonatomic,strong)NSString *fileName;
@property(nonatomic,strong)NSString *fileAddress;
@property(nonatomic,strong)NSString *fileSmallAddress;
@property(nonatomic,assign)int fileSize;
@property(nonatomic,assign)int fileTimeLength;
@property(nonatomic,strong)NSString *textMessage;
@property(nonatomic,assign)int flag;// 发送是否成功 程序自动设置 { 接受、未发送、发送 }
@property(nonatomic,assign)int status;// 是否已读 未读、已读、删除
@property(nonatomic,assign)int addUserId;
@property(nonatomic,strong)NSString *addUser;
@property(nonatomic,strong)NSString *addDate;
@property(nonatomic,assign)int updateUserId;
@property(nonatomic,strong)NSString *updateDate;
@property(nonatomic,assign)int sid;
@property(nonatomic,assign)int isAll;// 是否群发消息，这个只是为了前后台实体类一致后台琮杰用到了
@property(nonatomic,strong)NSString *fileServerAddress;//保存服务器上图片路径
@property(nonatomic,strong)NSString *fileServerSmallAddress;//保存服务器上小图片路径
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *cover;
@property(nonatomic,strong)NSString *summary;
@property(nonatomic,strong)NSString *linkUrl;
@property(nonatomic,strong)NSString *toUser;
@end
