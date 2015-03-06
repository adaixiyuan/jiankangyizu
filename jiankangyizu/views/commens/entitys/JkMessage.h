//
//  JkMessage.h
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface JkMessageDAO : ZUOYLDAOBase

@end
@interface JkMessage : ZUOYLModelBase
{
    int identity;
    NSString *addUser;
    NSString *addDate;
    NSString *addIp;
    NSString *uuid;
    int memberId; //发消息人的id
    NSString *content;   //消息内容
    NSString *version;
    int toMemberId; //收到消息的人I
    int messageTypeId;//消息类型
    int isAll;        //是否群发(0，单发，1，群发)
    NSString *textMessage;   //显示的文本
    int status;
    int isRead;
    int messageType; //消息类型
}
@property(nonatomic,assign)int identity;
@property(nonatomic,strong)NSString *addUser;
@property(nonatomic,strong)NSString *addDate;
@property(nonatomic,strong)NSString *addIp;
@property(nonatomic,strong)NSString *uuid;
@property(nonatomic,assign)int memberId; //发消息人的id
@property(nonatomic,strong)NSString *content;   //消息内容
@property(nonatomic,strong)NSString *version;
@property(nonatomic,assign)int toMemberId; //收到消息的人I
@property(nonatomic,assign)int messageTypeId;//消息类型
@property(nonatomic,assign)int isAll;        //是否群发(0，单发，1，群发)
@property(nonatomic,strong)NSString *textMessage;   //显示的文本
@property(nonatomic,assign)int status;
@property(nonatomic,assign)int isRead;
@property(nonatomic,assign)int messageType; //消息类型
@end
