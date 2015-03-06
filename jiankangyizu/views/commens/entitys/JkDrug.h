//
//  JkDrug.h
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface JkDrugDAO: ZUOYLDAOBase

@end
@interface JkDrug : ZUOYLModelBase
@property(nonatomic,assign)int identity;
@property(nonatomic,strong)NSString * addDate;
@property(nonatomic,strong)NSString * addIp;
@property(nonatomic,assign)int userId;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,assign)int number;
@property(nonatomic,assign)int hour;
@property(nonatomic,assign)int minute;
@property(nonatomic,strong)NSString * drugImg;
@end
