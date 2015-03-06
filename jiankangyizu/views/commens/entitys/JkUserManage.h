//
//  JkUserManage.h
//  jiankangyizu
//
//  Created by JEREI on 15-2-5.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "ZUOYLDAOBase.h"


@interface JkUserManageDao : ZUOYLDAOBase

@end

@interface JkUserManage : ZUOYLModelBase

@property(nonatomic,assign) int identity;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *jkNo;
@property(nonatomic,assign) int sex;
@property(nonatomic,assign) int age;
@property(nonatomic,strong) NSString *headImg;
@property(nonatomic,strong) NSString *tel;
@property(nonatomic,strong) NSString *liveProvince;
@property(nonatomic,strong) NSString *liveCity;
@property(nonatomic,strong) NSString *liveArea;
@property(nonatomic,strong) NSString *address;
@property(nonatomic,strong) NSString *bongUid;
@property(nonatomic,strong) NSString *gudongUid;
@property(nonatomic,assign) int companyId;
@property(nonatomic,assign) int userId;
@property(nonatomic,strong) NSString *jkState;
@property(nonatomic,strong) NSString *locusState;
@property(nonatomic,strong) NSString *caseState;
@property(nonatomic,assign) int warnNumber;



@end
