//
//  JkEarAnalysis.h
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface JkEarAnalysisDAO: ZUOYLDAOBase

@end
@interface JkEarAnalysis : ZUOYLModelBase
@property(nonatomic,assign)int identity;
@property(nonatomic,strong)NSString * avgEar;
@property(nonatomic,strong)NSString * maxEar;
@property(nonatomic,strong)NSString * minEar;
@property(nonatomic,assign)int totalCount;
@end
