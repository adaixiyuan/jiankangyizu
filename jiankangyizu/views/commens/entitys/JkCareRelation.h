//
//  JkCareRelation.h
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface JkCareRelationDAO: ZUOYLDAOBase

@end
@interface JkCareRelation : ZUOYLModelBase
@property(nonatomic,assign)int	identity ;
@property(nonatomic,assign)int	careUserId ;
@property(nonatomic,assign)int	caredUserId ;
@property(nonatomic,strong)NSString *	address ;
@property(nonatomic,assign)int	age ;
@property(nonatomic,strong)NSString * jkNo;
@property(nonatomic,strong)NSString *	name ;
@property(nonatomic,assign)int	sex ;
@property(nonatomic,strong)NSString *	tel ;
@property(nonatomic,strong)NSString * status;
@property(nonatomic,strong)NSString * headImg;
@property(nonatomic,strong)NSString * summary;//简介
@property(nonatomic,strong)NSString * department;//科室
@property(nonatomic,strong)NSString * favorite;//擅长
@end
