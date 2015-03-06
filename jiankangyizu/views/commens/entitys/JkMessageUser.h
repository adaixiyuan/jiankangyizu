//
//  JkMessageUser.h
//  jiankangyizu
//
//  Created by JEREI on 15-3-3.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "ZUOYLDAOBase.h"

@interface JkMessageUserDao : ZUOYLDAOBase

@end
@interface JkMessageUser : ZUOYLModelBase
@property(nonatomic,assign) int identity;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,assign) int count;
@end
