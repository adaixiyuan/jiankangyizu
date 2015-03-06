//
//  ChatLabel3.h
//  ViewDeckExample
//
//  Created by apple on 13-4-11.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ChatLabel3 : UIView {
	NSArray	*data;
    NSString *_string;
    int font2;//字体大小
    int colorFlag;
    
}
@property(nonatomic,retain)NSArray *data;
@property(nonatomic,retain)NSString *_string;
@property(nonatomic,assign)int font2;
@property(nonatomic,assign)int colorFlag;

@end
