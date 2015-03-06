//
//  JkBpAnalysis.h
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface JkBpAnalysisDAO: ZUOYLDAOBase

@end
@interface JkBpAnalysis : ZUOYLModelBase
@property(nonatomic,assign)int identity;
@property(nonatomic,strong)NSString * avgPcp;
@property(nonatomic,strong)NSString * avgPdp;
@property(nonatomic,strong)NSString * avgRate;
@property(nonatomic,strong)NSString * maxPcp;
@property(nonatomic,strong)NSString * maxPdp;
@property(nonatomic,strong)NSString * maxRate;
@property(nonatomic,strong)NSString * minPcp;
@property(nonatomic,strong)NSString * minPdp;
@property(nonatomic,strong)NSString * minRate;
@property(nonatomic,assign)int totalCount;
@end
