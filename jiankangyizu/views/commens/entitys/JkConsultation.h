//
//  JkConsultation.h
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface JkConsultationDAO: ZUOYLDAOBase

@end
@interface JkConsultation : ZUOYLModelBase
{
   
}
@property(nonatomic,assign)int identity;
@property(nonatomic,strong)NSString *addDate;
@property(nonatomic,strong)NSString *addIp;
@property(nonatomic,strong)NSString *addUser;
@property(nonatomic,strong)NSString *caseDate;
@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSString *consultationDate;
@property(nonatomic,strong)NSString *uuid;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *file;
@property(nonatomic,assign)int parentId;
@property(nonatomic,assign)int userId;
@property(nonatomic,strong)NSString *departmentNo;
@property(nonatomic,assign)int replyCount;
@property(nonatomic,strong)NSString *departmentName;
@property(nonatomic,assign)int doctorId;
@end
