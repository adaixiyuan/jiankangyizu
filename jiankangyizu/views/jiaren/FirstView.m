//
//  jiaRenView.m
//  jiankangyizu
//
//  Created by apple on 15/2/2.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "FirstView.h"
#import "JsonToModel.h"
#import "WarnNumberDeailViewController.h"
#import  "CommonUser.h"
#define  XUEYATAG 1;
#define  XTTAG 2;
#define  ERWENTAT 3;
#define  JIANCETAG 4;
@interface FirstView ()

@end

@implementation FirstView


- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationController.navigationBar.hidden = YES;
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    CommonUser *user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [self getWarnNumber:user.identity conpanyId:user.companyId];
    UIImage *bgImage = [UIImage imageNamed:@"jkyi_main_backgroud.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 30,120, 40)];
    lable.textColor = [UIColor whiteColor];
    lable.shadowColor  = [UIColor grayColor];
    lable.shadowOffset = CGSizeMake(0, 0.5);
    lable.text = @"多多健康医生版";
    
    UIImage *xueyaimg = [UIImage imageNamed:@"jk_xueyayujing_bt_bg.png"];
    UIImage *xuetangyujing = [UIImage imageNamed:@"jk_xuetangyujing_bt_bg.png"];
    UIImage *erwenimg = [UIImage imageNamed:@"jk_erwenyujing_bt.png"];
    UIImage *jianceimg = [UIImage imageNamed:@"jk_jianche_zhengchang.png"];
    
      xueyabtn= [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/2-120, lable.frame.size.height+110, xueyaimg.size.width/1.5, xueyaimg.size.height/1.5)];
    [xueyabtn setBackgroundImage:xueyaimg forState:UIControlStateNormal];
    [xueyabtn setBackgroundImage:[UIImage imageNamed:@"jk_xueyayujing_bt"] forState:UIControlStateHighlighted];
    
    
     erwenbtn = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/2-137, xueyabtn.frame.size.height+83, erwenimg.size.width/1.5, erwenimg.size.height/1.5)];
    [erwenbtn setBackgroundImage:erwenimg forState:UIControlStateNormal];
    [erwenbtn setBackgroundImage:[UIImage imageNamed:@"jk_erwenyujing_bt"] forState:UIControlStateHighlighted];
    
    xuetangbtn = [[UIButton alloc] initWithFrame:CGRectMake((kDeviceWidth/2-137)+erwenbtn.frame.size.width, xueyabtn.frame.size.height+83, xuetangyujing.size.width/1.5, xuetangyujing.size.height/1.5)];
    [xuetangbtn setBackgroundImage:xuetangyujing forState:UIControlStateNormal];
    [xuetangbtn setBackgroundImage:[UIImage imageNamed:@"jk_xuetangyujing_bt"] forState:UIControlStateHighlighted];
    
     jiancebtn = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/2-xuetangbtn.frame.size.width/2-15, lable.frame.size.height+xuetangbtn.frame.size.height/2+70, jianceimg.size.width/1.8, jianceimg.size.height/1.8)];
    [jiancebtn setBackgroundImage:jianceimg forState:UIControlStateNormal];
    
    jiancerenci = [[UILabel alloc] initWithFrame:CGRectMake(jiancebtn.frame.size.width/2-50, jiancebtn.frame.size.height/2-50, 100, 50)];
    jiancerenci.textColor = [UIColor whiteColor];
    jiancerenci.textAlignment = NSTextAlignmentCenter;
    jiancerenci.text = @"0人次";
    
    UILabel *yujinglable = [[UILabel alloc] initWithFrame:CGRectMake(jiancebtn.frame.size.width/2-35, jiancebtn.frame.size.height/2-15, 100, 50)];
    yujinglable.text = @"预警\n >>";
    yujinglable.textColor = [UIColor whiteColor];
    yujinglable.font = [UIFont fontWithName:@"Helvetica-Bold" size:35];
    [jiancebtn addSubview:jiancerenci];
    [jiancebtn addSubview:yujinglable];
    
    
     xuetangbtn.tag = XTTAG;
     erwenbtn.tag = ERWENTAT;
     xueyabtn.tag = XUEYATAG;
     jiancebtn.tag = JIANCETAG;
    
    [xueyabtn addTarget:self action:@selector(buttonTouchListener:) forControlEvents:UIControlEventTouchUpInside];
    [erwenbtn addTarget:self action:@selector(buttonTouchListener:) forControlEvents:UIControlEventTouchUpInside];
    [xuetangbtn addTarget:self action:@selector(buttonTouchListener:) forControlEvents:UIControlEventTouchUpInside];
    [jiancebtn addTarget:self action:@selector(buttonTouchListener:) forControlEvents:UIControlEventTouchUpInside];
    
    
    cityAndWeather = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2, 40,kDeviceWidth/2-10, 20)];
    cityAndWeather.textColor = [UIColor whiteColor];
    cityAndWeather.shadowColor  = [UIColor grayColor];
    cityAndWeather.shadowOffset = CGSizeMake(0, 0.5);
    
    cityAndWeather.textAlignment = NSTextAlignmentRight;
    cityAndWeather.font = [UIFont boldSystemFontOfSize:18.0];
    
    dateAndWeather = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2, 65,kDeviceWidth/2-10, 20)];
    dateAndWeather.textColor = [UIColor whiteColor];
    dateAndWeather.shadowColor  = [UIColor grayColor];
    dateAndWeather.shadowOffset = CGSizeMake(0, 0.5);
    dateAndWeather.font = [UIFont systemFontOfSize:12.0];
    dateAndWeather.textAlignment = NSTextAlignmentRight;
    
    [self.view addSubview:lable];
    [self.view addSubview:xueyabtn];
    [self.view addSubview:erwenbtn];
    [self.view addSubview:xuetangbtn];
    [self.view addSubview:jiancebtn];
    [self.view addSubview:cityAndWeather];
    [self.view addSubview:dateAndWeather];
    
    [self initWeather];
}

/*
 
    public static final int Bp=1;//血压
	public static final int Glu=2;//血糖
	public static final int Ear=3;//耳温
	public static final int Bong=4;//耳温
	public static final int Oxi=5; //血氧
	public static final int Ecg=6; //心电
          XUEYATAG 1;
 #define  XUETANGTAG 2;
 #define  ERWENTAT 3;
 #define  JIANCETAG 4;
 */
- (void)buttonTouchListener:(id)button
{
    UIButton *receviebtn = (UIButton *)button;
    int buttonFlag = (int)receviebtn.tag;
    [self resetbuttonbackgroundbutton];
    switch (buttonFlag) {
        case 1:  //血压
          warnTableName = @"jk_bp";
          warnTitle = @"血压预警";
          warnhealflag = 1;
            
          jiancerenci.text = [NSString stringWithFormat:@"%d人次" ,jkWarnNumber.bpCount];
          [xueyabtn setBackgroundImage:[UIImage imageNamed:@"jk_xueyayujing_bt.png"] forState:UIControlStateNormal];
            break;
        case 2: //血糖
         
            warnTableName = @"jk_glu";
            warnTitle = @"血糖预警";
            warnhealflag = 2;
            
         jiancerenci.text = [NSString stringWithFormat:@"%d人次" ,jkWarnNumber.gluCount];
         [xuetangbtn setBackgroundImage:[UIImage imageNamed:@"jk_xuetangyujing_bt.png"] forState:UIControlStateNormal];
            break;
        case 3: //耳温
            
            warnTableName = @"jk_ear";
            warnTitle = @"耳温预警";
            warnhealflag = 3;
          jiancerenci.text = [NSString stringWithFormat:@"%d人次" ,jkWarnNumber.earCount];
          [erwenbtn setBackgroundImage:[UIImage imageNamed:@"jk_erwenyujing_bt.png"] forState:UIControlStateNormal];
            break;
        case 4:
             WarnController = [[WarnNumberDeailViewController alloc] init];
             WarnController.titles=warnTitle;
             WarnController.healthFlag = warnhealflag;
             WarnController.tableName = warnTableName;
            [self.navigationController pushViewController:WarnController animated:YES];
            self.navigationController.navigationBar.hidden = NO;
            break;
    }
    
}

-(void)resetbuttonbackgroundbutton
{
    [xueyabtn setBackgroundImage:[UIImage imageNamed:@"jk_xueyayujing_bt_bg.png"] forState:UIControlStateNormal];
    [erwenbtn setBackgroundImage:[UIImage imageNamed:@"jk_erwenyujing_bt_bg.png"] forState:UIControlStateNormal];
    [xuetangbtn setBackgroundImage:[UIImage imageNamed:@"jk_xuetangyujing_bt_bg.png"] forState:UIControlStateNormal];

}

#pragma mark 获取预警人次
-(void)getWarnNumber:(int)userid conpanyId:(int)companyid
{
    //1.确定地址nsurl
    NSString *urlString = [NSString stringWithFormat:@"%@%@?user_id=%d&company_id=%d",BASE_URL,GETWARNNUMBER_URL,userid,companyid];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];   //get请求方式
    /*
     同步请求
     */
    @autoreleasepool {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURLResponse *respons = nil;
            NSError *error = nil;
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&respons error:&error];
            NSLog(@"请求的线程:%@",[NSThread currentThread]);
            dispatch_async(dispatch_get_main_queue(), ^{
                if(data != nil)
                {
//                    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    jkWarnNumber  = [JsonToModel objectFromDictionaryData:data className:@"JKWarnNumber"];
                    
                }
                else if(data == nil && error == nil)
                {
                    NSLog(@"接收到空数据");
                }
                else
                {
                    NSLog(@"%@",error.localizedDescription);
                }
            });});
    }
    
}

- (void)initWeather
{
    @autoreleasepool {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
    //解析网址通过ip 获取城市天气代码
    NSURL *url = [NSURL URLWithString:@"http://61.4.185.48:81/g/"];
    NSString  *_intString = @"";
    //    定义一个NSError对象，用于捕获错误信息
    NSError *error;
    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    
    
    // 得到城市代码字符串，截取出城市代码
    NSString *Str;
    for (int i = 0; i<=[jsonString length]; i++)
    {
        for (int j = i+1; j <=[jsonString length]; j++)
        {
            Str = [jsonString substringWithRange:NSMakeRange(i, j-i)];
            if ([Str isEqualToString:@"id"]) {
                if (![[jsonString substringWithRange:NSMakeRange(i+3, 1)] isEqualToString:@"c"]) {
                    _intString = [jsonString substringWithRange:NSMakeRange(i+3, 9)];
                   
                }
            }
        }
    }
    
    //    //中国天气网解析地址；
    NSString *path=@"http://m.weather.com.cn/atad/cityNumber.html";
    //将城市代码替换到天气解析网址cityNumber 部分！
    path=[path stringByReplacingOccurrencesOfString:@"cityNumber" withString:_intString];
    
    NSURL *url1 = [NSURL URLWithString:path];
    NSLog(@"path:%@",path);
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];   //get请求方式
    /*
     同步请求
     */
   
            NSURLResponse *respons = nil;
//            NSError *error = nil;
            NSData *data = [NSURLConnection sendSynchronousRequest:request1 returningResponse:&respons error:&error];
            NSLog(@"请求的线程:%@",[NSThread currentThread]);
            dispatch_async(dispatch_get_main_queue(), ^{
                if(data != nil)
                {
//                    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                    NSLog(@"str:%@",str);
                    
                    NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                    
                    
                    NSDictionary *weatherinfo = [weatherDic objectForKey:@"weatherinfo"];
                    
                    
                    //当前城市
                    NSString *city = [weatherinfo objectForKey:@"city"];
                   
                    //日期
                    NSString *date = [weatherinfo objectForKey:@"date_y"];
                   
//                    //星期
//                    NSString *week = [weatherinfo objectForKey:@"week"];
//                  
//                    //城市天气编码
//                    NSString *cityid = [weatherinfo objectForKey:@"cityid"];
                    //当前温度
                    NSString *temp = [weatherinfo objectForKey:@"temp1"];
                    
                    //当前天气状况
                    NSString *weather = [weatherinfo objectForKey:@"weather1"];
                    if(temp != nil && city != nil && date !=nil && weather != nil)
                    {
                    cityAndWeather.text = [NSString stringWithFormat:@"%@ %@",temp,city];
                    dateAndWeather.text = [NSString stringWithFormat:@"%@ %@",date,weather];
                    }
                    
                }
                else if(data == nil && error == nil)
                {
                    NSLog(@"接收到空数据");
                }
                else
                {
                    NSLog(@"%@",error.localizedDescription);
                }
            });});
    }
    
    
}

@end
