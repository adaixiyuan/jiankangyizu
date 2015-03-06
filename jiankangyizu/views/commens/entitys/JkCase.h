//
//  JkCase.h
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface JkCaseDAO: ZUOYLDAOBase

@end
@interface JkCase : ZUOYLModelBase
@property(nonatomic,assign)int identity;
@property(nonatomic,strong)NSString * addDate;
@property(nonatomic,strong)NSString * addIp;
@property(nonatomic,strong)NSString * addUser;
@property(nonatomic,strong)NSString * uuid;
@property(nonatomic,strong)NSString * caseDate;
@property(nonatomic,strong)NSString * resultContent;
@property(nonatomic,strong)NSString * resultImg;
@property(nonatomic,strong)NSString * prescriptionContent;
@property(nonatomic,strong)NSString * prescriptionImg;
@property(nonatomic,strong)NSString * hospital;
@property(nonatomic,strong)NSString * departmentNo;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,assign)int userId;
@end
