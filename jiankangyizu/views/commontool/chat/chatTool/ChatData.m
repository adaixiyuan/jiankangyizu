//
//  ChatData.m
//  ViewDeckExample
//
//  Created by apple on 13-4-16.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import "ChatData.h"
#import "BbsMemberSelf.h"
//#import "SQLiteInstanceManager.h"
#import "WcmCmsMemberMessage.h"
@implementation ChatData

//根据消息来更新聊天室
-(void)flushChatWithMessage:(WcmCmsMemberMessage *)message{
    
}
//根据消息构建聊天室
-(BbsChatInfo *)getBbsChatInfoWithMessage:(WcmCmsMemberMessage *)message{
    
    //准备数据
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSData *userData=[userDefaults objectForKey:@"user"];
    BbsMemberSelf *user= [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    BbsChatInfo *chatInfo1=[self getChat:message.addUserId chatId:message.chatId];
    chatInfo1.infoCatalogText=message.textMessage;
    chatInfo1.messageContent=message.textMessage;
    chatInfo1.messageTitle=message.textMessage;
//    chatInfo.newMsgCount=message.isNew?1:0;
    
    if (message.addUserId==user.identity) {
        chatInfo1.sendUserId=message.memberId;
    }else{
        chatInfo1.sendUserId=message.addUserId;
        
    }
    chatInfo1.resourceFileAddress=message.fileAddress;
    chatInfo1.resourceFileType=message.messageTypeId;
    chatInfo1.sendDate=message.addDate;
    chatInfo1.sendStatus=message.status;
    
    return chatInfo1;
}

//构建一个聊天室
-(BbsChatInfo *)getChat:(int)receiveUserId chatId:(NSString *)chatId{
    
    //准备数据
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSData *userData=[userDefaults objectForKey:@"user"];
    BbsMemberSelf *user= [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    

  
        FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
        BbsChatInfoDAO* dao = [[BbsChatInfoDAO alloc]initWithDbqueue:queue];
        [dao searchWhere:[NSString stringWithFormat:@"(sendUserId = %d AND receiveUserId=%d) OR (sendUserId = %d AND receiveUserId=%d)",receiveUserId,user.identity,user.identity,receiveUserId] orderBy:@"identity desc" offset:0 count:PAGESIZE callback:^(NSArray *array){
            if ([array count]>0) {
                chatInfo=(BbsChatInfo *)[(NSMutableArray *)array objectAtIndex:0];
            }
            
           
            
        }];
    
    if (chatInfo.chatId) {
        if (chatInfo.sendUserId==user.identity) {
            chatInfo.sendUserId=chatInfo.receiveUserId;
            chatInfo.sendUserName=chatInfo.receiveUserName;
            chatInfo.sendUserFace=chatInfo.receiveUserFace;
        }
        
        return chatInfo;
        
    }else{
        BbsChatInfo *chatInfo2=[[BbsChatInfo alloc]init];
        
        if (chatId==nil || [chatId isEqualToString:@"(null)"] || [chatId isEqualToString:@""]) {
            
            chatInfo2.chatId=[self getChatId:receiveUserId receiveId:user.identity];
            
        }
        
        chatInfo2.sendUserId=receiveUserId;
        
        return chatInfo2 ;
        
    }

    
   }

//得到聊天室列表
-(NSMutableArray *)getChatList:(int)userId{
    //准备数据
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSData *userData=[userDefaults objectForKey:@"user"];
    BbsMemberSelf *user= [NSKeyedUnarchiver unarchiveObjectWithData:userData];
   
    NSMutableArray *array=[[NSMutableArray alloc]initWithCapacity:0];
    
    NSString *selectString=[NSString stringWithFormat:@"SELECT pk,chat_id, send_user_id, send_user_name, send_user_face,max(send_date) AS send_date, receive_user_id, receive_user_name, receive_user_face, max(receive_date) AS receive_date, info_catalog_text, message_title, message_content, resource_file_address, resource_file_type, min(status) AS status, share_log, share_lat, share_address, SUM((CASE WHEN is_new=1 THEN 1 ELSE 0 END)) AS new_msg_count from bbs_member_new_message where member_id=%d or create_user_id=%d group by chat_id order by send_date desc",userId,userId];//
    
    NSArray *selectArray;
//    =[BbsChatInfo findByAllCriteria:selectString];
    
    
    
    if ([selectArray count]>0) {
        for (id obj in selectArray) {
            BbsChatInfo *chat=obj;
            if (chat.sendUserId==user.identity) {
                chat.sendUserId=chat.receiveUserId;
                chat.sendUserName=chat.receiveUserName;
                chat.sendUserFace=chat.receiveUserFace;
            }
            [array addObject:chat];
        }
        
    }
    
    return array ;
    
}

//查看消息（update）

//查看消息（update）
-(void)updateChat:(NSString *)chatId{
//     FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
    
    NSString *updateString=[NSString stringWithFormat:@"update bbs_member_new_message SET is_new=0 where chat_id='%@'",chatId];
    FMDatabase *db = [FMDatabase databaseWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
    [db executeUpdate:updateString];
}

-(void)updateMessageIsNew:(NSString *)messageId{
    NSString *updateString=[NSString stringWithFormat:@"update bbs_member_new_message SET is_new=0 where identity='%@'",messageId];
    FMDatabase *db = [FMDatabase databaseWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
    [db executeUpdate:updateString];
}

-(void)updateMessageIsPlay:(NSString *)messageId{

    NSString *updateString=[NSString stringWithFormat:@"update bbs_member_new_message SET is_read=0 where identity='%@'",messageId];
    FMDatabase *db = [FMDatabase databaseWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
    [db executeUpdate:updateString];
}

-(void)updateMessageSendStatus:(NSString *)messageId status:(int)status{
    NSString *updateString=[NSString stringWithFormat:@"update bbs_member_new_message SET status=%d where identity='%@'",status,messageId];
    FMDatabase *db = [FMDatabase databaseWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
    [db executeUpdate:updateString];
}

-(void)updateMessageSendStatus:(NSString *)messageId status:(int)status date:(NSDate *)date{
    
    //日期转换
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSSS";
    NSString *dateString=[df stringFromDate:date];
    
    NSString *updateString=[NSString stringWithFormat:@"update WcmCmsMemberMessage SET flag=1 status=%d where identity='%@'",status,messageId];
    FMDatabase *db = [FMDatabase databaseWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
    [db executeUpdate:updateString];
}

-(NSString *)getChatId:(int)sendId receiveId:(int)receiveId{
    NSString *chatId=@"";
    if (sendId>receiveId) {
        chatId=[NSString stringWithFormat:@"%d_%d",receiveId,sendId];
    }else{
        chatId=[NSString stringWithFormat:@"%d_%d",sendId,receiveId];
    }
    
    return chatId;
}






-(NSString *)uuid {  
    CFUUIDRef puuid = CFUUIDCreate( nil );  
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );  
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));  
    CFRelease(puuid);  
    CFRelease(uuidString);  
    return result;  
}

@end
