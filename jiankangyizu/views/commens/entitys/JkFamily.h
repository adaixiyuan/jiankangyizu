//
//  JkFamily.h
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface JkFamilyDAO: ZUOYLDAOBase

@end
@interface JkFamily : ZUOYLModelBase
@property(nonatomic,assign)int identity ;
@property(nonatomic,assign)NSString *addUser;
@property(nonatomic,assign)NSString *addDate;
@property(nonatomic,assign)NSString *addIp;
@property(nonatomic,assign)NSString *uuid;
@property(nonatomic,assign)NSString *name;
@property(nonatomic,assign)int userId;
@property(nonatomic,assign)int relationUserId;  //关联的用户id
@property(nonatomic,assign)NSString *jkState;
@property(nonatomic,assign)NSString *locusState;
@property(nonatomic,assign)NSString *caseState;
@property(nonatomic,assign)NSString *username;
@property(nonatomic,assign)NSString *relationName;  //关联的姓名
@property(nonatomic,assign)NSString *address;
@property(nonatomic,assign)int sex;
@property(nonatomic,assign)int age;
@property(nonatomic,assign)NSString *tel;
@property(nonatomic,assign)NSString *headImg;
@end
