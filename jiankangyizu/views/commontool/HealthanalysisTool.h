//
//  HealthanalysisTool.h
//  jiankangyizu
//
//  Created by JEREI on 15-2-4.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HealthyInfo.h"
@interface HealthanalysisTool : NSObject

+ (HealthyInfo *) analysisBpBySettingwithPcp:(int)pcp andPdp:(int)pdp;
+ (HealthyInfo *) analysisGluBySetting:(double)glu ;
+ (HealthyInfo *) analysisEarBySetting:(double)ear ;
+ (HealthyInfo *) analysisOxiBySetting:(int)pro;
+ (HealthyInfo *) analysisEcgBySetting:(int)result;
+ (HealthyInfo *) analysisBongSetting:(double)glu;
@end
