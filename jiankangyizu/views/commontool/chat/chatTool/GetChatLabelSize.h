//
//  GetChatLabelSize.h
//  ViewDeckExample
//
//  Created by apple on 13-4-12.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetChatLabelSize : NSObject

+(void)getImageRange:(NSString*)message : (NSMutableArray*)array;
+(CGSize)GetChatLabelSize:(NSString *)_label withFont:(int)font;
+(CGSize)GetLabelSize:(NSString *)_label withWidth:(float)width1 withFont:(int)font;

@end
