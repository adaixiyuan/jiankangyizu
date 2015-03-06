//
//  JkNews.h
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface JkNewsDAO: ZUOYLDAOBase

@end
@interface JkNews : ZUOYLModelBase
@property(nonatomic,assign)int identity;
@property(nonatomic,strong)NSString *uuid;
@property(nonatomic,strong)NSString *addDate;
@property(nonatomic,strong)NSString *addIp;
@property(nonatomic,strong)NSString *addUser;
@property(nonatomic,assign)int catId;
@property(nonatomic,strong)NSString *source;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *subTitle;
@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *summary;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *pubDate;
@property(nonatomic,strong)NSString *linkOther;
@property(nonatomic,assign)int isShow;
@property(nonatomic,assign)int viewCount;
@property(nonatomic,assign)int replyCount;
@property(nonatomic,assign)int shareCount;
@property(nonatomic,assign)int isRecommend;
@property(nonatomic,strong)NSString *departmentNo;
@property(nonatomic,assign)int userId;
@end
