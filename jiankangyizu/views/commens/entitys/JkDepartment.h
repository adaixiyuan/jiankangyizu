//
//  JkDepartment.h
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface JkDepartmentDAO: ZUOYLDAOBase

@end
@interface JkDepartment : ZUOYLModelBase
@property(nonatomic,assign)int identity;
@property(nonatomic,strong)NSString * addUser;
@property(nonatomic,strong)NSString * addDate;
@property(nonatomic,strong)NSString * addIp;
@property(nonatomic,strong)NSString * uuid;
@property(nonatomic,strong)NSString * parentNo;
@property(nonatomic,strong)NSString * no;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * val;
@property(nonatomic,strong)NSString * img;
@property(nonatomic,strong)NSString * intro;
@property(nonatomic,assign)int isShow;
@property(nonatomic,assign)int orderNo;
@property(nonatomic,assign)int isSystem;
@end
