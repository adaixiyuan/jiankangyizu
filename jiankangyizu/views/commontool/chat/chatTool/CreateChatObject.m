//
//  CreateChatObject.m
//  ViewDeckExample
//
//  Created by apple on 13-2-26.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import "CreateChatObject.h"
#import "BbsMemberSelf.h"

@implementation CreateChatObject

//发送时创建BbsMemberMessage
-(WcmCmsMemberMessage *)getMessage:(NSString *)_message uuid:(NSString *)_uuid date:date type:(int)type length:(int)length fileName:(NSString *)fileName receiveInfo:(BbsChatInfo *)_chatInfo{
    
    //准备数据
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSData *userData=[userDefaults objectForKey:@"user"];
    BbsMemberSelf *user= [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    NSString *deviceNo=[userDefaults objectForKey:@"serialNumber"];
    if ([deviceNo isEqualToString:@"(null)"] || [deviceNo isEqualToString:@""] || deviceNo==nil) {
        deviceNo=_uuid;
    }
    
    WcmCmsMemberMessage *message=[[WcmCmsMemberMessage alloc]init];
    message.identity=_uuid;
    
//    message.parentId=0;
//    message.infoCatalog=@"";
//    message.infoCatalogText=@"";
//    message.infoUserId=0;
//    message.infoUserName=@"";
//    message.infoUserFace=@"";
    message.chatId=[self getChatId:user.identity receiveId:_chatInfo.sendUserId];
    message.flag = 1;
    message.status = 1;
    message.addUserId=user.identity;

//    message.sendIp=@"";
    message.memberId=_chatInfo.sendUserId;
//    message.receiveDate=date;
    message.messageTypeId=type;//TODO 文件名类型 1文字 2音频 3照片 4视频 5位置 6联系人
    message.fileTimeLength=length;//TODO 文件长度

//    message.re=@"";
    switch (type) {
        case 1:{
            message.textMessage=_message;
            message.fileAddress=@"";//TODO 文件下载地址
            message.fileSmallAddress=@"";//TODO 文件(图片)小图地址
   
            break;
        }
        case 2:{
            message.textMessage=@"";
            message.fileAddress=[NSString stringWithFormat:@"%@.mp3",fileName];//TODO 文件下载地址
            message.fileSmallAddress=@"";//TODO 文件(图片)小图地址
//            message.resourceBigFileIOS=@"";
            break;
        }
        case 3:{
            message.textMessage=@"";
            message.fileAddress=[NSString stringWithFormat:@"%@.jpg",fileName];//TODO 文件下载地址
            message.fileSmallAddress=@"";//TODO 文件(图片)小图地址
//            message.resourceBigFileIOS=@"";
            break;
        }
        case 4:{
            message.textMessage=@"";
            message.fileAddress=[NSString stringWithFormat:@"%@.mp4",fileName];//TODO 文件下载地址
            message.fileSmallAddress=@"";//TODO 文件(图片)小图地址
//            message.resourceBigFileIOS=_message;
            break;
        }
        default:
            break;
    }
    message.status=0;
    message.status=0;//0.正在发送 -1.发送失败 1.发送成功

//    message.isNew=0;//TODO 针对非文字性的内容(语音未播放\视频未播放\图片未下载\位置未查看等)
//    message.isRead=0;//TODO 针对语音内容(是否正在播放)
    message.isAll=1;

//    message.distance=0;
    
    return message;
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
