//
//  JkAuthorize.h
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface JkAuthorizeDAO: ZUOYLDAOBase

@end
@interface JkAuthorize : ZUOYLModelBase
@property(nonatomic,assign)int	identity ;
@property(nonatomic,strong)NSString *	no ;
@property(nonatomic,strong)NSString *	name;
@property(nonatomic,strong)NSString *	linkMan ;
@property(nonatomic,strong)NSString *	linkPhone ;
@property(nonatomic,strong)NSString * 	address;
@property(nonatomic,assign)int	companyId ;
@property(nonatomic,assign)int	userId ;
@property(nonatomic,strong)NSString *	jkState ;
@property(nonatomic,strong)NSString * locusState;
@property(nonatomic,strong)NSString * caseState;
@end
