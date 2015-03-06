//
//  ChatData.h
//  ViewDeckExample
//
//  Created by apple on 13-4-16.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BbsChatInfo.h"
#import "WcmCmsMemberMessage.h"

@interface ChatData : NSObject
{
BbsChatInfo *chatInfo;
}
//根据消息来更新聊天室
-(void)flushChatWithMessage:(WcmCmsMemberMessage *)message;

//根据消息构建聊天室
-(BbsChatInfo *)getBbsChatInfoWithMessage:(WcmCmsMemberMessage *)message;

//构建一个聊天室
-(BbsChatInfo *)getChat:(int)receiveUserId chatId:(NSString *)chatId;

//得到聊天室列表
-(NSMutableArray *)getChatList:(int)userId;

//查看消息（update）
-(void)updateChat:(NSString *)chatId;
-(void)updateMessageIsNew:(NSString *)messageId;
-(void)updateMessageIsPlay:(NSString *)messageId;
-(void)updateMessageSendStatus:(NSString *)messageId status:(int)status;
-(void)updateMessageSendStatus:(NSString *)messageId status:(int)status date:(NSDate *)date;

-(NSString *)getChatId:(int)sendId receiveId:(int)receiveId;

-(NSString *)uuid;

@end
