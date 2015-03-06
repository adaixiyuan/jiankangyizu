//
//  GetMessageTool.h
//  ViewDeckExample
//
//  Created by apple on 13-3-6.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WcmCmsMemberMessage.h"
//#import "TBXML.h"
@interface GetMessageTool : NSObject{
}
//@property(nonatomic,strong)TBXML *tbxml;
-(WcmCmsMemberMessage *)getMessage:(NSString *)xmlString;
-(WcmCmsMemberMessage *)getObjectWithXml:(NSString *)xmlString;

@end
