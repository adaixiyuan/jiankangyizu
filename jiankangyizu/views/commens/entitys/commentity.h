//
//  commentity.h
//  yuehandier
//
//  Created by apple on 14/12/15.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface commentity : NSObject
{
    int identity;
    NSString *title;
    NSString *content;
}
@property(nonatomic,assign)int identity;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *content;
@end
