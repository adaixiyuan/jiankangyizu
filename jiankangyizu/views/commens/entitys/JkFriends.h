//
//  JkFriends.h
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface JkFriendsDAO : ZUOYLDAOBase

@end
@interface JkFriends : ZUOYLModelBase
{
    int identity;
    NSString *name;
    NSString *headImg;
    NSString *bongUid;
    NSString *gudongUid;
    int calories; // 能量
    int sleepNum; // 睡眠
}
@property(nonatomic,assign)int identity;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *headImg;
@property(nonatomic,strong)NSString *bongUid;
@property(nonatomic,strong)NSString *gudongUid;
@property(nonatomic,assign)int calories; // 能量
@property(nonatomic,assign)int sleepNum; // 睡眠
@end
