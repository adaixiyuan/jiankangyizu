//
//  YuJingSheZhiController.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-14.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "YuJingSheZhiController.h"
#import "YuJingDetailController.h"
#import "RDVTabBarController.h"
#import "MyDictionary.h"
#define XUEYAYUJING 1
#define XUETANGYUJING 2
#define ERWENYUJING 3
@interface YuJingSheZhiController ()

@end

@implementation YuJingSheZhiController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self initView];
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNav{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tb_navbar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"comm_top_button_left.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    backBtn.frame=CGRectMake(0, 0,52, 42);//52, 42
    UILabel *backLabel=[[UILabel alloc]initWithFrame:CGRectMake(52, 0, 300, 42)];
    backLabel.backgroundColor=[UIColor clearColor];
    backLabel.textColor=YINGYONG_COLOR;
    backLabel.textAlignment=NSTextAlignmentLeft;
    backLabel.font=[UIFont boldSystemFontOfSize:23];
    backLabel.text=@"健康预警";
    UIView *backView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 330, 42)];
    backView1.backgroundColor=[UIColor clearColor];
    [backView1 addSubview:backBtn];
    [backView1 addSubview:backLabel];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView1];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    self.view.backgroundColor=BACK_COLOR;
}
- (void)initView
{
    UIButton *xueyayujing = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, kDeviceWidth, 50)];
    [xueyayujing setBackgroundColor:[UIColor whiteColor]];
    UILabel *xuelable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 50)];
    xuelable.backgroundColor = [UIColor colorWithRed:70.0/255.0 green:133.0/255.0 blue:236.0/255.0 alpha:1];
    UIImageView *xueyaImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 20, 20)];
    xueyaImg.image = [UIImage imageNamed:@"jk_healthy_setting_bp.png"];
    UILabel *xueyatitle = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 100, 50)];
    xueyatitle.text = @"血压预警";
    xueyatitle.textColor =  [UIColor colorWithRed:70.0/255.0 green:133.0/255.0 blue:236.0/255.0 alpha:1];
    xueyatitle.font = [UIFont boldSystemFontOfSize:20.0];
    UIImageView *xueyaIndicator = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth-30, 15, 20, 20)];
    xueyaIndicator.image = [UIImage imageNamed:@"bus_img_clickright.png"];
    xueyayujing.tag = XUEYAYUJING;
    [xueyayujing addTarget:self action:@selector(yuJing:) forControlEvents:UIControlEventTouchUpInside];
    [xueyayujing addSubview:xuelable];
    [xueyayujing addSubview:xueyaImg];
    [xueyayujing addSubview:xueyatitle];
    [xueyayujing addSubview:xueyaIndicator];
    [self.view addSubview:xueyayujing];
    
    
    UIButton *xuetangyujing = [[UIButton alloc] initWithFrame:CGRectMake(0, 70, kDeviceWidth, 50)];
    [xuetangyujing setBackgroundColor:[UIColor whiteColor]];
    UILabel *xuetanglable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 50)];
    xuetanglable.backgroundColor = [UIColor colorWithRed:58.0/255.0 green:210.0/255.0 blue:195.0/255.0 alpha:1];
    UIImageView *xuetangImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 20, 20)];
    xuetangImg.image = [UIImage imageNamed:@"jk_healthy_setting_glu.png"];
    UILabel *xuetangtitle = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 100, 50)];
    xuetangtitle.text = @"血糖预警";
    xuetangtitle.textColor = [UIColor colorWithRed:58.0/255.0 green:210.0/255.0 blue:195.0/255.0 alpha:1];
    xuetangtitle.font = [UIFont boldSystemFontOfSize:20.0];
    UIImageView *xuetangIndicator = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth-30, 15, 20, 20)];
    xuetangIndicator.image = [UIImage imageNamed:@"bus_img_clickright.png"];
    xuetangyujing.tag  = XUETANGYUJING;
    [xuetangyujing addTarget:self action:@selector(yuJing:) forControlEvents:UIControlEventTouchUpInside];
    [xuetangyujing addSubview:xuetanglable];
    [xuetangyujing addSubview:xuetangImg];
    [xuetangyujing addSubview:xuetangtitle];
    [xuetangyujing addSubview:xuetangIndicator];
    [self.view addSubview:xuetangyujing];
    
    
    UIButton *erwenyujing = [[UIButton alloc] initWithFrame:CGRectMake(0, 130, kDeviceWidth, 50)];
    [erwenyujing setBackgroundColor:[UIColor whiteColor]];
    UILabel *erwenlable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 50)];
    erwenlable.backgroundColor = [UIColor colorWithRed:102.0/255.0 green:178.0/255.0 blue:254.0/255.0 alpha:1];
    UIImageView *erwenImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 20, 20)];
    erwenImg.image = [UIImage imageNamed:@"jk_healthy_setting_ear.png"];
    UILabel *erwentitle = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 100, 50)];
    erwentitle.text = @"耳温预警";
    erwentitle.textColor = [UIColor colorWithRed:102.0/255.0 green:178.0/255.0 blue:254.0/255.0 alpha:1];
    erwentitle.font = [UIFont boldSystemFontOfSize:20.0];
    UIImageView *erwenIndicator = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth-30, 15, 20, 20)];
    erwenyujing.tag = ERWENYUJING;
    [erwenyujing addTarget:self action:@selector(yuJing:) forControlEvents:UIControlEventTouchUpInside];
    erwenIndicator.image = [UIImage imageNamed:@"bus_img_clickright.png"];
    [erwenyujing addSubview:erwenlable];
    [erwenyujing addSubview:erwenImg];
    [erwenyujing addSubview:erwentitle];
    [erwenyujing addSubview:erwenIndicator];
    [self.view addSubview:erwenyujing];
    
    UIButton *tongbubtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [tongbubtn setBackgroundColor:[UIColor whiteColor]];
    [tongbubtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    tongbubtn.frame = CGRectMake(kDeviceWidth/2-50, 200, 100, 40);
    [tongbubtn addTarget:self action:@selector(justTongbu) forControlEvents:UIControlEventTouchUpInside];
    [tongbubtn setTitle:@"马上同步" forState:UIControlStateNormal];
    [tongbubtn.layer setMasksToBounds:YES];
    [tongbubtn.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
//    [tongbubtn.layer setBorderWidth:1.0]; //边框宽度
    [self.view addSubview:tongbubtn];
}
- (void)yuJing:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    YuJingDetailController *yujingdetail = [[YuJingDetailController alloc] init];
    switch (btn.tag) {
        case XUEYAYUJING:
        {
          yujingdetail.viewTitle = @"血压预警";
          yujingdetail.Flag = XUEYAYUJING;
        }
            break;
            
        case XUETANGYUJING:
        {
            yujingdetail.viewTitle = @"血糖预警";
            yujingdetail.Flag = XUETANGYUJING;

        }
            break;
        case ERWENYUJING:
        {
            yujingdetail.viewTitle = @"耳温预警";
            yujingdetail.Flag = ERWENYUJING;
        }
            break;
    }
    
    [self.navigationController pushViewController:yujingdetail animated:YES];
}

#pragma mark 马上同步
- (void)justTongbu
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"一键同步会把当前设置与服务器同步，是否确定需要同步?" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            [self shangChuan];
        }
            break;
            
        default:
            break;
    }
}


- (void)shangChuan
{
//    FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
//    CommonUserDAO *dao = [[CommonUserDAO alloc]initWithDbqueue:queue];
//    [dao searchWhere:[NSString stringWithFormat:@"identity=%d",user.identity] callback:^(NSArray *array) {
//        user = array[0];
//    }];
    
    
    NSMutableArray *urlArray = [[NSMutableArray alloc] init];
    [urlArray addObject:[[MyDictionary alloc]initWithName:@"obj.user_id" Andvale:[NSString stringWithFormat:@"%d",user.identity]]];
    if(user.warningId  > 0)
    {
    [urlArray addObject:[[MyDictionary alloc]initWithName:@"obj.id" Andvale:[NSString stringWithFormat:@"%d",user.warningId]]];
    }
    [urlArray addObject:[[MyDictionary alloc]initWithName:@"obj.is_dataup" Andvale:[NSString stringWithFormat:@"%d",user.warningDataup]]];
    [urlArray addObject:[[MyDictionary alloc]initWithName:@"obj.is_note" Andvale:[NSString stringWithFormat:@"%d",user.isNote]]];
    [urlArray addObject:[[MyDictionary alloc]initWithName:@"obj.pcp_max" Andvale:[NSString stringWithFormat:@"%d",user.pcpMax]]];
    [urlArray addObject:[[MyDictionary alloc]initWithName:@"obj.pcp_min" Andvale:[NSString stringWithFormat:@"%d",user.pcpMin]]];
    [urlArray addObject:[[MyDictionary alloc]initWithName:@"obj.pdp_max" Andvale:[NSString stringWithFormat:@"%d",user.pdpMax]]];
    [urlArray addObject:[[MyDictionary alloc]initWithName:@"obj.pdp_min" Andvale:[NSString stringWithFormat:@"%d",user.pdpMin]]];
    [urlArray addObject:[[MyDictionary alloc]initWithName:@"obj.glu_max" Andvale:[NSString stringWithFormat:@"%f",user.gluMax]]];
    [urlArray addObject:[[MyDictionary alloc]initWithName:@"obj.glu_min" Andvale:[NSString stringWithFormat:@"%0.2f",user.gluMin]]];
    [urlArray addObject:[[MyDictionary alloc]initWithName:@"obj.ear_max" Andvale:[NSString stringWithFormat:@"%0.2f",user.earMax]]];
    [urlArray addObject:[[MyDictionary alloc]initWithName:@"obj.ear_min" Andvale:[NSString stringWithFormat:@"%0.2f",user.earMin]]];
    [urlArray addObject:[[MyDictionary alloc]initWithName:@"locus_id" Andvale:[NSString stringWithFormat:@"%d",user.locusId]]];
    [urlArray addObject:[[MyDictionary alloc]initWithName:@"locus_dataup" Andvale:[NSString stringWithFormat:@"%d",user.locusDataup]]];
    [urlArray addObject:[[MyDictionary alloc]initWithName:@"up_time" Andvale:[NSString stringWithFormat:@"%d",user.upTime]]];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?table_name=jk_department%@",BASE_URL,SETTINGUPDATE_URL,[self objectToUrl:urlArray]];
    
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
            
            if(data != nil)
            {
                
//                NSArray *objects=[JsonToModel objectsFromDictionaryData:data className:@"JkDepartment"];
                
//                [dao replaceArrayToDB:objects callback:^(BOOL block){
//                    
//                }];
                NSLog(@"上传成功");
                 dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
                 });
                
            }
            else if(data == nil && error == nil)
            {
                NSLog(@"接收到空数据");
            }
            else
            {
                NSLog(@"%@",error.localizedDescription);
            }
        });
    }

}
- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    NSData *userData=[[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
    user= [NSKeyedUnarchiver unarchiveObjectWithData:userData];

}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}

- (NSString *)objectToUrl:(NSMutableArray *)myObjectArray
{
    NSMutableString *urlString = [[NSMutableString alloc] init];
    for (MyDictionary *object in myObjectArray)
    {
        [urlString appendString:@"&"];
        [urlString appendString:[NSString stringWithFormat:@"%@=%@",object.name,object.value]];
        
        
    }
    return urlString;
}
@end
