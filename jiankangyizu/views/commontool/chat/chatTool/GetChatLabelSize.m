//
//  GetChatLabelSize.m
//  ViewDeckExample
//
//  Created by apple on 13-4-12.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import "GetChatLabelSize.h"

#define BEGIN_FLAG @"[h"
#define END_FLAG @"]"
#define KFacialSizeWidth 24
#define KFacialSizeHeight 24
#define KFacialSizeWidth2 75//37.5
#define KFacialSizeHeight2 85//42.5
#define kMar 3
#define kStartPoint 1

@implementation GetChatLabelSize

+(void)getImageRange:(NSString*)message : (NSMutableArray*)array {
    NSRange range=[message rangeOfString: BEGIN_FLAG];
    NSRange range1=[message rangeOfString: END_FLAG];
    
    //判断当前字符串是否还有表情的标志。
    if ((range.length>0 && range1.length>0)) {
        if (range.location<range1.location) {
            if (range.location > 0) {
                [array addObject:[message substringToIndex:range.location]];
                [array addObject:[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)]];
                NSString *str=[message substringFromIndex:range1.location+1];
                [self getImageRange:str :array];
            }else {
                NSString *nextstr=[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)];
                //排除文字是“”的
                if (![nextstr isEqualToString:@""]) {
                    [array addObject:nextstr];
                    NSString *str=[message substringFromIndex:range1.location+1];
                    [self getImageRange:str :array];
                }else {
                    return;
                }
            }
        }else{
            [array addObject:message];
        }
        
        
    }else if (message != nil) {
        [array addObject:message];
    }
    
}

+(CGSize)GetChatLabelSize:(NSString *)_label withFont:(int)font{
    CGSize size2 = [_label sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(160.0f, 9000.0f) lineBreakMode:UILineBreakModeCharacterWrap];
    
    _label=[_label stringByReplacingOccurrencesOfString:@"[y" withString:@"[h0"];
    NSMutableArray *array=[[NSMutableArray alloc]initWithCapacity:0];
    [self getImageRange:_label :array];
    
    NSInteger upX = 0;
	NSInteger upY = 2;
    NSInteger height=0;
    NSInteger width=0;
    NSInteger lineHeight=0;
    CGSize size;
    if (array) {
		for (int i=0; i<[array count]; i++) {
			NSString *str = [array objectAtIndex:i];
			if ([str hasPrefix:@"[h"] && [str hasSuffix:@"]"]) {
				NSString *imageName = [str substringWithRange:NSMakeRange(1, str.length-2)];
                if (imageName.length==5) {
                    if (lineHeight==0) {
                        lineHeight=KFacialSizeHeight2+2;
                    }
                    if (height==0) {
                        height=KFacialSizeHeight2+2;
                    }
                    size = [imageName sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(160, 9000)];
                    if (upX >= 160-KFacialSizeWidth2)
                    {
                        upX = kMar;
                        upY += lineHeight;//size.height;
                        height+=KFacialSizeHeight2+2;
                    }else{
                        height=height-lineHeight+KFacialSizeHeight2+2;
                        lineHeight=KFacialSizeHeight2+2;
                    }
                    
                    upX = upX + KFacialSizeWidth2 ;//+ 2;
                    if (width<160) {
                        width+=upX;
                    }
                    
                }else{
                    if (lineHeight==0 || lineHeight<KFacialSizeHeight+2) {
                        lineHeight=KFacialSizeHeight+2;
                    }
                    if (height==0) {
                        height=KFacialSizeHeight+2;
                    }
                    size = [imageName sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(160, 9000)];
                    if (upX >= 160-size.width)
                    {
                        upX = kMar;
                        upY += lineHeight;//size.height;
                        height+=KFacialSizeHeight+2;
                        
                    }
                    
                    upX = upX + KFacialSizeWidth + 2;
                    if (width<160) {
                        width+=upX;
                    }
                    
                }
                
				
			}else {
				for (int i = 0; i < [str length]; i++) 
                {
                    
                    NSString *tem = [str substringWithRange:NSMakeRange(i, kStartPoint)];
                    size = [tem sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(160, 9000)];
                    if (lineHeight==0 || lineHeight<size.height) {
                        lineHeight=size.height;
                    }
                    if (height==0) {
                        height=size.height;
                    }
                    if (upX >= 160-size.width)
                    {
                        upX = kMar;
                        upY += lineHeight;
                        height+=size.height;
                        width=160;
                    }
                    upX += size.width;
                    if (width<160) {
                        width=upX;
                    }
                }
                
			}
            
		}
        NSLog(@"width %d",width);
        NSLog(@"height %d",height);
        
	}
    if (width>=160) {
        width=160;
    }
    size2.width=width;
    size2.height=height;
    
    return size2;
    
}

+(CGSize)GetLabelSize:(NSString *)_label withWidth:(float)width1 withFont:(int)font{
    
    CGSize size2 = [_label sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(width1, 9000.0f) lineBreakMode:UILineBreakModeCharacterWrap];
    
    _label=[_label stringByReplacingOccurrencesOfString:@"[y" withString:@"[h0"];
    NSMutableArray *array=[[NSMutableArray alloc]initWithCapacity:0];
    [self getImageRange:_label :array];
    
    NSInteger upX = 0;
	NSInteger upY = 2;
    NSInteger height=0;
    NSInteger width=0;
    NSInteger lineHeight=0;
    CGSize size;
    if (array) {
		for (int i=0; i<[array count]; i++) {
			NSString *str = [array objectAtIndex:i];
			if ([str hasPrefix:@"[h"] && [str hasSuffix:@"]"]) {
				NSString *imageName = [str substringWithRange:NSMakeRange(1, str.length-2)];
                if (imageName.length==5) {
                    if (lineHeight==0) {
                        lineHeight=KFacialSizeHeight2+2;
                    }
                    if (height==0) {
                        height=KFacialSizeHeight2+2;
                    }
                    size = [imageName sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(width1, 9000)];
                    if (upX >= width1-KFacialSizeWidth2)
                    {
                        upX = kMar;
                        upY += lineHeight;//size.height;
                        height+=KFacialSizeHeight2+2;
                    }else{
                        height=height-lineHeight+KFacialSizeHeight2+2;
                        lineHeight=KFacialSizeHeight2+2;
                    }
                    
                    upX = upX + KFacialSizeWidth2 ;//+ 2;
                    if (width<width1) {
                        width+=upX;
                    }
                    
                }else{
                    if (lineHeight==0 || lineHeight<KFacialSizeHeight+2) {
                        lineHeight=KFacialSizeHeight+2;
                    }
                    if (height==0) {
                        height=KFacialSizeHeight+2;
                    }
                    size = [imageName sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(width1, 9000)];
                    if (upX >= width1-size.width)
                    {
                        upX = kMar;
                        upY += lineHeight;//size.height;
                        height+=KFacialSizeHeight+2;
                        
                    }
                    
                    upX = upX + KFacialSizeWidth + 2;
                    if (width<width1) {
                        width+=upX;
                    }
                }
                
				
			}else {
				for (int i = 0; i < [str length]; i++)
                {
                    if (lineHeight==0 || lineHeight<size.height) {
                        lineHeight=size.height;
                    }
                    if (height==0) {
                        height=size.height;
                    }
                    NSString *tem = [str substringWithRange:NSMakeRange(i, kStartPoint)];
                    size = [tem sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(width1, 9000)];
                    if (upX >= width1-size.width)
                    {
                        upX = kMar;
                        upY += lineHeight;
                        height+=size.height;
                    }
                    upX += size.width;
                    if (width<width1) {
                        width+=upX;
                    }
                }
                
			}
            
		}
        
	}
    if (width>=width1) {
        width=width1;
    }
    size2.width=width;
    size2.height=height;
    
    return size2;
}

@end
