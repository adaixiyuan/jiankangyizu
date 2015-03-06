//
//  JkCompany.h
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface JkCompanyDAO: ZUOYLDAOBase

@end
@interface JkCompany : ZUOYLModelBase
@property(nonatomic,assign)int identity;
@property(nonatomic,strong)NSString *addUser;
@property(nonatomic,strong)NSString *addDate;
@property(nonatomic,strong)NSString *addIp;
@property(nonatomic,strong)NSString *uuid;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *departmentName;
@property(nonatomic,strong)NSString *linkMan;
@property(nonatomic,strong)NSString *linkPhone;
@property(nonatomic,strong)NSString *province;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *area;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,assign)int state;
@property(nonatomic,strong)NSString *no;
@property(nonatomic,strong)NSString *linkEmail;
@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSString *departmentNo;
@end
