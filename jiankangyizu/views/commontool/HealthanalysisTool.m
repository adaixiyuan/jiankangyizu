//
//  HealthanalysisTool.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-4.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "HealthanalysisTool.h"
#import "CommonUser.h"
#define STANDARD_OXI_MAX 99
#define STANDARD_OXI_MIN 95
@implementation HealthanalysisTool

#pragma mark 分析血压
+ (HealthyInfo *) analysisBpBySettingwithPcp:(int)pcp andPdp:(int)pdp
{
    HealthyInfo *healthInfo = [[HealthyInfo alloc] init];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    CommonUser *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if(pcp > userInfo.pcpMax || pdp > userInfo.pdpMax)
    {
        healthInfo = [self HealthyInfoForHigh];
    }
    else if(pcp < userInfo.pcpMin || pdp < userInfo.pdpMin)
    {
        healthInfo = [self HealthyInfoForLow];
    }
    else
    {
        healthInfo = [self HealthyInfoForNormal];
    }
    return healthInfo;

}


#pragma mark 分析血糖
+ (HealthyInfo *) analysisGluBySetting:(double)glu
{
    HealthyInfo *healthInfo = [[HealthyInfo alloc] init];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    CommonUser *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if(glu > userInfo.gluMax)
    {
        healthInfo = [self HealthyInfoForHigh];
    }
    else if(glu < userInfo.gluMin)
    {
        healthInfo = [self HealthyInfoForLow];
    }
    else
    {
        healthInfo = [self HealthyInfoForNormal];
    }
    return healthInfo;
    
}
#pragma mark 分析耳温
+ (HealthyInfo *) analysisEarBySetting:(double)ear 
{
    HealthyInfo *healthInfo = [[HealthyInfo alloc] init];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    CommonUser *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if(ear > userInfo.earMax)
    {
        healthInfo = [self HealthyInfoForHigh];
    }
    else if(ear < userInfo.earMin)
    {
        healthInfo = [self HealthyInfoForLow];
    }
    else
    {
        healthInfo = [self HealthyInfoForNormal];
    }
    return healthInfo;
    
}

#pragma mark 分析血氧

+ (HealthyInfo *) analysisOxiBySetting:(int)pro
{
    HealthyInfo *healthInfo = [[HealthyInfo alloc] init];
    if (pro >= STANDARD_OXI_MAX) {
        healthInfo = [self HealthyInfoForHigh];
    }else if (pro <  STANDARD_OXI_MIN) {
        healthInfo = [self HealthyInfoForLow];
    }else{
        healthInfo = [self HealthyInfoForNormal];
    }
    return healthInfo;
}

#pragma mark 分析手环

+ (HealthyInfo *) analysisBongSetting:(double)glu
{
    HealthyInfo *healthInfo = [[HealthyInfo alloc] init];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    CommonUser *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if(glu > userInfo.gluMax)
    {
        healthInfo = [self HealthyInfoForHigh];
    }
    else if(glu < userInfo.gluMin)
    {
        healthInfo = [self HealthyInfoForLow];
    }
    else
    {
        healthInfo = [self HealthyInfoForNormal];
    }
    return healthInfo;
    
}




#pragma  mark 分析心电
+ (HealthyInfo *) analysisEcgBySetting:(int)result {
    HealthyInfo *heathyInfo=[[HealthyInfo alloc] init];
    if (result!= 0) {
        heathyInfo = [self HealthyInfoForHigh];
       heathyInfo.meaage = @"不正常";
    }else{
        heathyInfo = [self HealthyInfoForNormal];
    }
    return heathyInfo;
}

+ (HealthyInfo *)HealthyInfoForHigh
{
    HealthyInfo *heathinfo = [[HealthyInfo alloc] init];
    heathinfo.meaage = @"偏高";
    heathinfo.point = 40;
    heathinfo.colorId = [UIColor colorWithRed:241.0/255.0 green:119.0/255.0 blue:118.0/255.0 alpha:1];
    heathinfo.listBtnId= @"common_list_high_btn";
    heathinfo.listBigBtnId=@"common_list_high_btn_press";
    return heathinfo;
}

+ (HealthyInfo *)HealthyInfoForLow
{
    HealthyInfo *heathinfo = [[HealthyInfo alloc] init];
    heathinfo.meaage = @"偏低";
    heathinfo.point = 60;
    heathinfo.colorId =[UIColor colorWithRed:44.0/255.0 green:138.0/255.0 blue:225.0/255.0 alpha:1];
    heathinfo.listBigBtnId=@"common_list_low_btn";
    heathinfo.listBtnId=@"common_list_low_btn_press";
    return heathinfo;
}

+ (HealthyInfo *)HealthyInfoForNormal
{
    HealthyInfo *heathinfo = [[HealthyInfo alloc] init];
    heathinfo.meaage = @"正常";
    heathinfo.point = 80;
    heathinfo.colorId = [UIColor colorWithRed:69.0/255.0 green:178.0/255.0 blue:139.0/255.0 alpha:1];
    heathinfo.listBtnId=@"common_list_normal_btn";
    heathinfo.listBigBtnId=@"common_list_normal_btn_press";
    
    return heathinfo;
}


@end
