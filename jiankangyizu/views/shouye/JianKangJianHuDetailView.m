
//
//  JianKangJianHuDetailView.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-13.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JianKangJianHuDetailView.h"
#import "CommonStr.h"
#import "HealthanalysisTool.h"
#import "RDVTabBarController.h"
#define XUEYA 1
#define ERWEN 2
#define XUETANG 3
#define XINDIAN 4
#define XUEYANG 5
#define BONG 6
@interface JianKangJianHuDetailView ()
{
    UILabel *addressTile ;
    UILabel *celiangTile;
}
@end

@implementation JianKangJianHuDetailView

@synthesize modeObject;
@synthesize DetailFlag;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self initView];
    [self initValue];
}
-(void)initNav{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tb_navbar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"comm_top_button_left.png"] forState:UIControlStateNormal];
    backBtn.frame=CGRectMake(0, 0,52, 42);//52, 42
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UILabel *backLabel=[[UILabel alloc]initWithFrame:CGRectMake(52, 0, 300, 42)];
    backLabel.backgroundColor=[UIColor clearColor];
    backLabel.textColor=YINGYONG_COLOR;
    backLabel.textAlignment=NSTextAlignmentLeft;
    backLabel.font=[UIFont boldSystemFontOfSize:23];
    backLabel.text=@"监测详情";
    UIView *backView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 330, 42)];
    backView1.backgroundColor=[UIColor clearColor];
    [backView1 addSubview:backBtn];
    [backView1 addSubview:backLabel];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView1];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}
- (void)initValue
{
    
    
    switch (DetailFlag) {
    case XUEYA:
    {
        jkbp = (JkBp *)modeObject;
        HealthyInfo *info = [HealthanalysisTool analysisBpBySettingwithPcp:jkbp.pcp andPdp:jkbp.pdp];
        celiangTile.text = [CommonStr getDateFormLongSince1970:jkbp.catDate];
        addressTile.text = jkbp.catAddress;
        
        UIButton *titlebg = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight/3+10)];
        titlebg.userInteractionEnabled = YES;
        titlebg.backgroundColor = info.colorId;
        
        
        UIView *gaoya = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth/3, KDeviceHeight/6+5)];
        
        UIImageView *gaoyaImg = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/6-43, 10, 86, 71)];
        gaoyaImg.image = [UIImage imageNamed:@"common_detail_normal_bg.png"];
        [gaoya addSubview:gaoyaImg];
        
        UILabel *gaoyalable = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, kDeviceWidth/3, 20)];
        gaoyalable.text = [NSString stringWithFormat:@"%d",jkbp.pcp];
        gaoyalable.textAlignment = NSTextAlignmentCenter;
        gaoyalable.textColor = [UIColor whiteColor];
        
        UILabel *mmhggaoya = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, kDeviceWidth/3-40, 20)];
        mmhggaoya.textColor = [UIColor whiteColor];
        mmhggaoya.text = @"mmHg";
        mmhggaoya.textAlignment = NSTextAlignmentCenter;
        
        UILabel *mmhggaoyalable = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, kDeviceWidth/3-40, 20)];
        mmhggaoyalable.textColor = [UIColor whiteColor];
        mmhggaoyalable.text = @"高压";
        mmhggaoyalable.textAlignment = NSTextAlignmentCenter;
        mmhggaoyalable.font = [UIFont systemFontOfSize:15.0];

        [gaoya addSubview:gaoyalable];
        [gaoya addSubview:mmhggaoya];
        [gaoya addSubview:mmhggaoyalable];
        [titlebg addSubview:gaoya];
        
        
        UIView *diya = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/3, 0, kDeviceWidth/3, KDeviceHeight/6+5)];
        
        UIImageView *diyaImg = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/6-43, 10, 86, 71)];
        diyaImg.image = [UIImage imageNamed:@"common_detail_normal_bg.png"];
        [diya addSubview:diyaImg];
        
        UILabel *diyalable = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, kDeviceWidth/3, 20)];        diyalable.text = [NSString stringWithFormat:@"%d",jkbp.pdp];
        diyalable.textAlignment = NSTextAlignmentCenter;
        diyalable.textColor = [UIColor whiteColor];
        
        UILabel *mmhgdiya = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, kDeviceWidth/3-40, 20)];
        mmhgdiya.textColor = [UIColor whiteColor];
        mmhgdiya.text = @"mmHg";
        mmhgdiya.textAlignment = NSTextAlignmentCenter;
        
        UILabel *mmhgdiyalable = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, kDeviceWidth/3-40, 20)];
        mmhgdiyalable.textColor = [UIColor whiteColor];
        mmhgdiyalable.text = @"低压";
        mmhgdiyalable.textAlignment = NSTextAlignmentCenter;
        mmhgdiyalable.font = [UIFont systemFontOfSize:15.0];

        [diya addSubview:diyalable];
        [diya addSubview:mmhgdiya];
        [diya addSubview:mmhgdiyalable];
        [titlebg addSubview:diya];
        
        
        UIView *xinlv = [[UIView alloc] initWithFrame:CGRectMake((kDeviceWidth/3)*2, 0, kDeviceWidth/3, KDeviceHeight/6+5)];
        
        
        UIImageView *xinlvImg = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/6-43, 10, 86, 71)];
        xinlvImg.image = [UIImage imageNamed:@"common_detail_normal_bg.png"];
        [xinlv addSubview:xinlvImg];
        
        UILabel *xinlvlable = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, kDeviceWidth/3, 20)];        xinlvlable.text = [NSString stringWithFormat:@"%d",jkbp.heartRate];
        xinlvlable.textAlignment = NSTextAlignmentCenter;
        xinlvlable.textColor = [UIColor whiteColor];
        
        UILabel *mmhgxinlv = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, kDeviceWidth/3-40, 20)];
        mmhgxinlv.textColor = [UIColor whiteColor];
        mmhgxinlv.text = @"次";
        mmhgxinlv.textAlignment = NSTextAlignmentCenter;
        
        UILabel *mmhgxinlvlable = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, kDeviceWidth/3-40, 20)];
        mmhgxinlvlable.textColor = [UIColor whiteColor];
        mmhgxinlvlable.text = @"心率";
        mmhgxinlvlable.textAlignment = NSTextAlignmentCenter;
        mmhgxinlvlable.font = [UIFont systemFontOfSize:15.0];

        [xinlv addSubview:xinlvlable];
        [xinlv addSubview:mmhgxinlv];
        [xinlv addSubview:mmhgxinlvlable];
        [titlebg addSubview:xinlv];
        
        
        UILabel *doctorResult = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, kDeviceWidth-20, (kDeviceWidth/3+10) - (KDeviceHeight/6+5))];
        doctorResult.text = [NSString stringWithFormat:@"根据设定：您的血压测量结果为：%@",info.meaage];
        doctorResult.textColor = [UIColor whiteColor];
        doctorResult.font = [UIFont systemFontOfSize:15.0];
        [titlebg addSubview:doctorResult];
        [self.view addSubview:titlebg];
       
    }
        break;
        
    case XUETANG:
    {
        jkGlu = (JkGlu *)modeObject;
        celiangTile.text = [CommonStr getDateFormLongSince1970:jkGlu.catDate];
        addressTile.hidden = YES;
        
        HealthyInfo *info = [HealthanalysisTool analysisGluBySetting:[jkGlu.glu doubleValue]];
        
        UIButton *titlebg = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight/3+10)];
        titlebg.backgroundColor = info.colorId;
        titlebg.userInteractionEnabled = YES;
        
        
        UIView *diya = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight/6+5)];
        
        UIImageView *diyaImg = [[UIImageView alloc] initWithFrame:CGRectMake((kDeviceWidth/2-43), 10, 86, 71)];
        diyaImg.image = [UIImage imageNamed:@"common_detail_normal_bg.png"];
        [diya addSubview:diyaImg];
        
        UILabel *diyalable = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, kDeviceWidth, 20)];
        diyalable.text = [NSString stringWithFormat:@"%@",jkGlu.glu];;
        diyalable.textAlignment = NSTextAlignmentCenter;
        diyalable.textColor = [UIColor whiteColor];
        
        UILabel *mmhgdiya = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, kDeviceWidth, 20)];
        mmhgdiya.textAlignment = NSTextAlignmentCenter;
        mmhgdiya.textColor = [UIColor whiteColor];
        mmhgdiya.text = @"mmol";
        
        
        UILabel *mmhgdiyalable = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, kDeviceWidth, 20)];
        mmhgdiyalable.textColor = [UIColor whiteColor];
        mmhgdiyalable.text = @"血糖";
        mmhgdiyalable.textAlignment = NSTextAlignmentCenter;
        mmhgdiyalable.font = [UIFont systemFontOfSize:15.0];
        
        [diya addSubview:diyalable];
        [diya addSubview:mmhgdiya];
        [diya addSubview:mmhgdiyalable];
        [titlebg addSubview:diya];
        
        
        
        UILabel *doctorResult = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, kDeviceWidth-20, (kDeviceWidth/3+10) - (KDeviceHeight/6+5))];
        doctorResult.text = [NSString stringWithFormat:@"根据设定：您的血糖测量结果为：%@",info.meaage];
        doctorResult.textColor = [UIColor whiteColor];
        doctorResult.font = [UIFont systemFontOfSize:15.0];
        [titlebg addSubview:doctorResult];
        [self.view addSubview:titlebg];
    }
        break;
    case ERWEN:
    {
        jkEar = (JkEar *)modeObject;
        celiangTile.text = [CommonStr getDateFormLongSince1970:jkEar.catDate];
        addressTile.text = jkEar.catAddress;
        
         HealthyInfo *info = [HealthanalysisTool analysisEarBySetting:[jkEar.ear doubleValue]];
        UIButton *titlebg = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight/3+10)];
        titlebg.backgroundColor = info.colorId;
        titlebg.userInteractionEnabled = YES;
        
        
        UIView *diya = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight/6+5)];
        
        UIImageView *diyaImg = [[UIImageView alloc] initWithFrame:CGRectMake((kDeviceWidth/2-43), 10, 86, 71)];
        diyaImg.image = [UIImage imageNamed:@"common_detail_normal_bg.png"];
        [diya addSubview:diyaImg];
        
        UILabel *diyalable = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, kDeviceWidth, 20)];
        diyalable.text = [NSString stringWithFormat:@"%@",jkEar.ear];;
        diyalable.textAlignment = NSTextAlignmentCenter;
        diyalable.textColor = [UIColor whiteColor];
        
        UILabel *mmhgdiya = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, kDeviceWidth, 20)];
        mmhgdiya.textAlignment = NSTextAlignmentCenter;
        mmhgdiya.textColor = [UIColor whiteColor];
        mmhgdiya.text = @"℃";
      
        
        UILabel *mmhgdiyalable = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, kDeviceWidth, 20)];
        mmhgdiyalable.textColor = [UIColor whiteColor];
        mmhgdiyalable.text = @"耳温";
        mmhgdiyalable.textAlignment = NSTextAlignmentCenter;
        mmhgdiyalable.font = [UIFont systemFontOfSize:15.0];
        
        [diya addSubview:diyalable];
        [diya addSubview:mmhgdiya];
        [diya addSubview:mmhgdiyalable];
        [titlebg addSubview:diya];
        
        
        
        
        UILabel *doctorResult = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, kDeviceWidth-20, (kDeviceWidth/3+10) - (KDeviceHeight/6+5))];
        doctorResult.text = [NSString stringWithFormat:@"根据设定：您的耳温测量结果为：%@",info.meaage];;
        doctorResult.textColor = [UIColor whiteColor];
        doctorResult.font = [UIFont systemFontOfSize:15.0];
        [titlebg addSubview:doctorResult];
        [self.view addSubview:titlebg];

    }
        break;
    case XINDIAN:
    {
        jkEcg = (JkEcg *)modeObject;
        celiangTile.text = [CommonStr getDateFormLongSince1970:jkEcg.catDate];
        addressTile.text = jkEcg.catAddress;
        
        UIButton *titlebg = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight/3+10)];
        titlebg.backgroundColor =[UIColor colorWithRed:69.0/255.0 green:178.0/255.0 blue:139.0/255.0 alpha:1];
        titlebg.userInteractionEnabled = YES;
        
    }
        break;
        
    case XUEYANG:
    {
        jkOximeter = (JkOximeter *)modeObject;
        celiangTile.text = [CommonStr getDateFormLongSince1970:jkOximeter.catDate];
        addressTile.text = jkOximeter.catAddress;
        
        HealthyInfo *info = [HealthanalysisTool analysisOxiBySetting:jkOximeter.pr];
      
        
        UIButton *titlebg = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight/3+10)];
        titlebg.userInteractionEnabled = YES;
        titlebg.backgroundColor = info.colorId;
        
        
        UIView *gaoya = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth/3, KDeviceHeight/6+5)];
        
        UIImageView *gaoyaImg = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/6-43, 10, 86, 71)];
        gaoyaImg.image = [UIImage imageNamed:@"common_detail_normal_bg.png"];
        [gaoya addSubview:gaoyaImg];
        
        UILabel *gaoyalable = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, kDeviceWidth/3, 20)];
        gaoyalable.text = [NSString stringWithFormat:@"%d",jkOximeter.spo];
        gaoyalable.textAlignment = NSTextAlignmentCenter;
        gaoyalable.textColor = [UIColor whiteColor];
        
        UILabel *mmhggaoya = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, kDeviceWidth/3-40, 20)];
        mmhggaoya.textColor = [UIColor whiteColor];
        mmhggaoya.text = @"%";
        mmhggaoya.textAlignment = NSTextAlignmentCenter;
        
        UILabel *mmhggaoyalable = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, kDeviceWidth/3-40, 20)];
        mmhggaoyalable.textColor = [UIColor whiteColor];
        mmhggaoyalable.text = @"血氧饱和度";
        mmhggaoyalable.textAlignment = NSTextAlignmentCenter;
        mmhggaoyalable.font = [UIFont systemFontOfSize:12.0];
        
        [gaoya addSubview:gaoyalable];
        [gaoya addSubview:mmhggaoya];
        [gaoya addSubview:mmhggaoyalable];
        [titlebg addSubview:gaoya];
        
        
        UIView *diya = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/3, 0, kDeviceWidth/3, KDeviceHeight/6+5)];
        
        UIImageView *diyaImg = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/6-43, 10, 86, 71)];
        diyaImg.image = [UIImage imageNamed:@"common_detail_normal_bg.png"];
        [diya addSubview:diyaImg];
        
        UILabel *diyalable = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, kDeviceWidth/3, 20)];        diyalable.text = [NSString stringWithFormat:@"%d",jkOximeter.pr];
        diyalable.textAlignment = NSTextAlignmentCenter;
        diyalable.textColor = [UIColor whiteColor];
        
        UILabel *mmhgdiya = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, kDeviceWidth/3-40, 20)];
        mmhgdiya.textColor = [UIColor whiteColor];
        mmhgdiya.text = @"次";
        mmhgdiya.textAlignment = NSTextAlignmentCenter;
        
        UILabel *mmhgdiyalable = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, kDeviceWidth/3-40, 20)];
        mmhgdiyalable.textColor = [UIColor whiteColor];
        mmhgdiyalable.text = @"心率";
        mmhgdiyalable.textAlignment = NSTextAlignmentCenter;
        mmhgdiyalable.font = [UIFont systemFontOfSize:12.0];
        
        [diya addSubview:diyalable];
        [diya addSubview:mmhgdiya];
        [diya addSubview:mmhgdiyalable];
        [titlebg addSubview:diya];
        
        
        UIView *xinlv = [[UIView alloc] initWithFrame:CGRectMake((kDeviceWidth/3)*2, 0, kDeviceWidth/3, KDeviceHeight/6+5)];
        
        
        UIImageView *xinlvImg = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/6-43, 10, 86, 71)];
        xinlvImg.image = [UIImage imageNamed:@"common_detail_normal_bg.png"];
        [xinlv addSubview:xinlvImg];
        
        UILabel *xinlvlable = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, kDeviceWidth/3, 20)];        xinlvlable.text = [NSString stringWithFormat:@"%0.2f",jkOximeter.pi];
        xinlvlable.textAlignment = NSTextAlignmentCenter;
        xinlvlable.textColor = [UIColor whiteColor];
        
        UILabel *mmhgxinlv = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, kDeviceWidth/3-40, 20)];
        mmhgxinlv.textColor = [UIColor whiteColor];
        mmhgxinlv.text = @"PI";
        mmhgxinlv.textAlignment = NSTextAlignmentCenter;
        
        UILabel *mmhgxinlvlable = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, kDeviceWidth/3-30, 20)];
        mmhgxinlvlable.textColor = [UIColor whiteColor];
        mmhgxinlvlable.text = @"血流灌注指数";
        mmhgxinlvlable.textAlignment = NSTextAlignmentCenter;
        mmhgxinlvlable.font = [UIFont systemFontOfSize:12.0];
        
        [xinlv addSubview:xinlvlable];
        [xinlv addSubview:mmhgxinlv];
        [xinlv addSubview:mmhgxinlvlable];
        [titlebg addSubview:xinlv];
        

        
        
        UILabel *doctorResult = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, kDeviceWidth-20, (kDeviceWidth/3+10) - (KDeviceHeight/6+5))];
        doctorResult.text = [NSString stringWithFormat:@"根据设定：您的血氧测量结果为：%@",info.meaage];;
        doctorResult.textColor = [UIColor whiteColor];
        doctorResult.font = [UIFont systemFontOfSize:15.0];

        [titlebg addSubview:doctorResult];
        [self.view addSubview:titlebg];

        
    }
        break;
   case BONG:
   {
       jkBong = (JkBong *)modeObject;
       celiangTile.text = [CommonStr getDateFormLongSince1970:jkBong.catDate];
//       addressTile.text = jkBong.catAddress;
       HealthyInfo *info = [HealthanalysisTool analysisEarBySetting:[jkEar.ear doubleValue]];
       UIButton *titlebg = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight/3+10)];
       titlebg.backgroundColor = info.colorId;
       titlebg.userInteractionEnabled = YES;
       
       
       UIView *diya = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth/2, KDeviceHeight/6+5)];
       
       UIImageView *diyaImg = [[UIImageView alloc] initWithFrame:CGRectMake((kDeviceWidth/2-43), 10, 86, 71)];
       diyaImg.image = [UIImage imageNamed:@"common_detail_normal_bg.png"];
       [diya addSubview:diyaImg];
       
       UILabel *diyalable = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, kDeviceWidth, 20)];
       diyalable.text = [NSString stringWithFormat:@"%d",jkBong.calories];
       diyalable.textAlignment = NSTextAlignmentCenter;
       diyalable.textColor = [UIColor whiteColor];
       
       UILabel *mmhgdiya = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, kDeviceWidth, 20)];
       mmhgdiya.textAlignment = NSTextAlignmentCenter;
       mmhgdiya.textColor = [UIColor whiteColor];
       mmhgdiya.text = @"卡路里";
       
       UIView *shuimian = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/2, 0, kDeviceWidth/2, KDeviceHeight/6+5)];
       
       UIImageView *shuimianImg = [[UIImageView alloc] initWithFrame:CGRectMake((kDeviceWidth/2-43), 10, 86, 71)];
       shuimianImg.image = [UIImage imageNamed:@"common_detail_normal_bg.png"];
       [shuimian addSubview:shuimianImg];
       
       UILabel *shuimianlable = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, kDeviceWidth, 20)];
       shuimianlable.text = [NSString stringWithFormat:@"%d",jkBong.sleepNum];
       shuimianlable.textAlignment = NSTextAlignmentCenter;
       shuimianlable.textColor = [UIColor whiteColor];
       
       UILabel *shumiandiya = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, kDeviceWidth, 20)];
       shumiandiya.textAlignment = NSTextAlignmentCenter;
       shumiandiya.textColor = [UIColor whiteColor];
       shumiandiya.text = @"睡眠";
       
       
//       UILabel *mmhgdiyalable = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, kDeviceWidth, 20)];
//       mmhgdiyalable.textColor = [UIColor whiteColor];
//       mmhgdiyalable.text = @"耳温";
//       mmhgdiyalable.textAlignment = NSTextAlignmentCenter;
//       mmhgdiyalable.font = [UIFont systemFontOfSize:15.0];
       
       [diya addSubview:diyalable];
       [diya addSubview:mmhgdiya];
//       [diya addSubview:mmhgdiyalable];
       [shuimian addSubview:shumiandiya];
       [shuimian addSubview:shuimianlable];
       [titlebg addSubview:diya];
       [titlebg addSubview:shuimianlable];
       
       UILabel *doctorResult = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, kDeviceWidth-20, (kDeviceWidth/3+10) - (KDeviceHeight/6+5))];
       doctorResult.text = [NSString stringWithFormat:@"根据设定：您的运动测量结果为：%@",info.meaage];;
       doctorResult.textColor = [UIColor whiteColor];
       doctorResult.font = [UIFont systemFontOfSize:15.0];
       [titlebg addSubview:doctorResult];
       [self.view addSubview:titlebg];
       
       
   }
            break;
}
    
}
- (void)initView
{

    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, KDeviceHeight/3+39, kDeviceWidth, 1)];
    line1.backgroundColor = BACK_COLOR;
    UIImageView *celiangshijian = [[UIImageView alloc] initWithFrame:CGRectMake(10, KDeviceHeight/3+50, 20, 20)];
    celiangshijian.image = [UIImage imageNamed:@"jk_healthy_cat_time.png"];
    
    UILabel *testTime = [[UILabel alloc] initWithFrame:CGRectMake(40, KDeviceHeight/3+50, 100, 20)];
    testTime.text = @"测量时间";
    celiangTile = [[UILabel alloc] initWithFrame:CGRectMake(150, KDeviceHeight/3+50, kDeviceWidth-(kDeviceWidth/3+50), 20)];
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(40, KDeviceHeight/3+80, kDeviceWidth-40, 1)];
    line2.backgroundColor = BACK_COLOR;
    
    UIImageView *celiangdidian = [[UIImageView alloc] initWithFrame:CGRectMake(10, KDeviceHeight/3+90, 20, 20)];
    celiangdidian.image = [UIImage imageNamed:@"jk_healthy_cat_place"];
    
    UILabel *testAdress = [[UILabel alloc] initWithFrame:CGRectMake(40, KDeviceHeight/3+90, 100, 20)];
    testAdress.text = @"测量地点";
    
    addressTile = [[UILabel alloc] initWithFrame:CGRectMake(150, KDeviceHeight/3+90, kDeviceWidth-(kDeviceWidth/3+50), 60)];
    addressTile.textAlignment  = NSTextAlignmentLeft;
    addressTile.numberOfLines = 0;
    UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(0, KDeviceHeight/3+150, kDeviceWidth, 1)];
    line3.backgroundColor = BACK_COLOR;
    
    
    [self.view addSubview:line1];
    [self.view addSubview:line2];
    [self.view addSubview:line3];
    
    [self.view addSubview:celiangshijian];
    [self.view addSubview:testTime];
    [self.view addSubview:celiangTile];
    [self.view addSubview:celiangdidian];
    [self.view addSubview:testAdress];
    [self.view addSubview:addressTile];
}
- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}
@end
