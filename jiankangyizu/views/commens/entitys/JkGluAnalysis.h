//
//  JkGluAnalysis.h
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface JkGluAnalysisDAO: ZUOYLDAOBase

@end
@interface JkGluAnalysis : ZUOYLModelBase
@property(nonatomic,assign)int identity;
@property(nonatomic,strong)NSString * avgGlu;
@property(nonatomic,strong)NSString * maxGlu;
@property(nonatomic,strong)NSString * minGlu;
@property(nonatomic,assign)int totalCount;
@end
