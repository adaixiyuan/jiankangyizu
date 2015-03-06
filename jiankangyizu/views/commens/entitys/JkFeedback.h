//
//  JkFeedback.h
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface JkFeedbackDAO: ZUOYLDAOBase

@end
@interface JkFeedback : ZUOYLModelBase
@property(nonatomic,assign)int identity;
@property(nonatomic,strong)NSString * addDate;
@property(nonatomic,strong)NSString * addIp;
@property(nonatomic,strong)NSString * addUser;
@property(nonatomic,assign)int userId;
@property(nonatomic,strong)NSString * content;
@property(nonatomic,strong)NSString * version;
@end
