//
//  GetMessageTool.m
//  ViewDeckExample
//
//  Created by apple on 13-3-6.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import "GetMessageTool.h"
#import "BbsMemberSelf.h"

@implementation GetMessageTool




-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
   
        if (buttonIndex==0) {
            [[NSUserDefaults standardUserDefaults] setObject:@"ISFIRSIN" forKey:@"ISFIRSIN"];
            
        }
        
    
}
/*
    结束时收到
    <iq xmlns="jabber:client" type="result" to="15275527777@127.0.0.1/tiebiPushClient"></iq>
*/
//转变为小写
-(NSString *)replaceLower:(NSString *)str{
    NSMutableString *ms=[[NSMutableString alloc]init];
    char c[50];
    strcpy(c,(char *)[str UTF8String]);
    
    for (int i = 0; c != nil && i < str.length; i++) {
        if (c[i] < 97 && c[i] > 57) {
            [ms appendFormat:[NSString stringWithFormat:@"_%c",c[i]]];
        } else {
            [ms appendFormat:[NSString stringWithFormat:@"%c",c[i]]];
        }
    }
    
    str=[ms lowercaseString];

    
    return str;
}



-(WcmCmsMemberMessage *)getObjectWithXml:(NSString *)xmlString{
    NSData *datas=[xmlString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *arry=[NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingAllowFragments error:nil];
    NSArray *objects=[JsonToModel objectsFromDictionaryArray:arry className:@"WcmCmsMemberMessage"];
    if ([objects count]>0) {
        return  [objects objectAtIndex:0];
    }else{
        return nil;
    }}

@end
