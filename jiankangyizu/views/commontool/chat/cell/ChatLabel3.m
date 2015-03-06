//
//  ChatLabel3.m
//  ViewDeckExample
//
//  Created by apple on 13-4-11.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import "ChatLabel3.h"

#define KFacialSizeWidth 14
#define KFacialSizeHeight 14
#define KFacialSizeWidth2 75//37.5
#define KFacialSizeHeight2 85//42.5

#define kMar 3

#define kStartPoint 1

#define BEGIN_FLAG @"[h"
#define END_FLAG @"]"

@implementation ChatLabel3
@synthesize data,_string,font2,colorFlag;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

-(void)getImageRange:(NSString*)message : (NSMutableArray*)array {
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

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    self._string=[_string stringByReplacingOccurrencesOfString:@"[y" withString:@"[h0"];
    
    NSMutableArray *array=[[NSMutableArray alloc]initWithCapacity:0];
    [self getImageRange:_string :array];
    data=array;
    UIFont *fon;
    if (font2==0) {
        fon=[UIFont systemFontOfSize:14];
    }
	else{
      fon=[UIFont systemFontOfSize:font2];  
    }
    
	NSInteger upX = 0;
	NSInteger upY = 2;
    NSInteger height=0;
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
                    size = [imageName sizeWithFont:fon constrainedToSize:CGSizeMake(self.frame.size.width, 9000)];
                    if (upX >= self.frame.size.width-KFacialSizeWidth2)
                    {
                        
                        upX = kMar;
                        
                        upY += lineHeight;//KFacialSizeHeight2+2;//size.height;
                        height+=lineHeight;
                        lineHeight=0;
                    }else{
                        lineHeight=KFacialSizeHeight2+2;
                    }
                    UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",imageName]];
                    UIImageView* gifImageView = [[UIImageView alloc] initWithImage:image];
                    gifImageView.frame = CGRectMake(upX, upY, KFacialSizeWidth2, KFacialSizeHeight2);
                    upX = upX + KFacialSizeWidth2 ;//+ 2;
                    
                    [self addSubview:gifImageView];
    
                    
                }else{
                    if (lineHeight==0 || lineHeight<KFacialSizeHeight+2) {
                        lineHeight=KFacialSizeHeight+2;
                    }
                    size = [imageName sizeWithFont:fon constrainedToSize:CGSizeMake(self.frame.size.width, 9000)];
                    if (upX >= self.frame.size.width-size.width)
                    {
                        upX = kMar;
                        
                        upY += lineHeight;//KFacialSizeHeight2+2;//size.height;
                        height+=lineHeight;
                        lineHeight=0;
                    }
                    UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",imageName]];
                    UIImageView* gifImageView = [[UIImageView alloc] initWithImage:image];
                    gifImageView.frame = CGRectMake(upX, upY, KFacialSizeWidth, KFacialSizeHeight);
                    upX = upX + KFacialSizeWidth + 2;
                    
                    [self addSubview:gifImageView];
               
                    
                }
                
				
			}else {
				for (int i = 0; i < [str length]; i++) 
                {
                    
                    NSString *tem = [str substringWithRange:NSMakeRange(i, kStartPoint)];
                    size = [tem sizeWithFont:fon constrainedToSize:CGSizeMake(self.frame.size.width, 9000)];
                    if (lineHeight==0 || lineHeight<size.height) {
                        lineHeight=size.height;
                    }
                    if (upX >= self.frame.size.width-size.width)
                    {
                        upX = kMar;
                        
                        upY += lineHeight;//size.height;
                        height+=lineHeight;
                        lineHeight=0;
                    }
                    switch (colorFlag) {
                        case 0:
                            [[UIColor blackColor] set];
                            break;
                        case 1:
                            [[UIColor grayColor] set];
                            break;
                        case 2:
                            [[UIColor whiteColor] set];
                            break;
                        default:
                            break;
                    }
                    
                    [tem drawInRect:CGRectMake(upX, upY, size.width, size.height) withFont:fon];
                    
                    upX += size.width;
                    
                }
                
			}
            
		}	
	}
    
}




@end
