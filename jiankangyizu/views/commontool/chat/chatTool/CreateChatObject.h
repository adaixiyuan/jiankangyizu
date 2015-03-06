//
//  CreateChatObject.h
//  ViewDeckExample
//
//  Created by apple on 13-2-26.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BbsChatInfo.h"
#import "WcmCmsMemberMessage.h"


@interface CreateChatObject : NSObject

//发送时根据BbsChatInfo创建BbsMemberMessage
-(WcmCmsMemberMessage *)getMessage:(NSString *)_message uuid:(NSString *)_uuid date:(NSDate *)date type:(int)type length:(int)length fileName:(NSString *)fileName receiveInfo:(BbsChatInfo *)_chatInfo;


-(NSString *)uuid;

-(NSString *)getChatId:(int)sendId receiveId:(int)receiveId;

@end
