//
//  ShouQuanDetailController.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-15.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "ShouQuanDetailController.h"
#import "SDImageView+SDWebCache.h"
#import "RDVTabBarController.h"
#import "MyDictionary.h"
#define SHENQINGZHONG 103001
#define YISHOUQUAN 103002
#define YIJUJUE 103003
#define QUXIAO 103004

#define JIANKANGBTN 1
#define GUJIBTN 2
#define BINGLIBTN 3
@interface ShouQuanDetailController ()
{
    UIButton *jkShouquanBtn;
    UILabel *jkshouquanindic;
    
    UIButton *gjShouquanBtn;
    UILabel *gjshouquanindic;

    UIButton *blShouquanBtn;
    UILabel *blshouquanindic;

}
@end

@implementation ShouQuanDetailController
@synthesize userManage;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self addTitle];
    [self initValue];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNav{
    self.view.backgroundColor = BACK_COLOR;
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tb_navbar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"comm_top_button_left.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    backBtn.frame=CGRectMake(0, 0,52, 42);//52, 42
    UILabel *backLabel=[[UILabel alloc]initWithFrame:CGRectMake(52, 0, 300, 42)];
//    UIButton *saveBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
//    [saveBtn setTitleColor:YINGYONG_COLOR forState:UIControlStateNormal];
//    saveBtn.frame=CGRectMake(0, 0,70.5, 42);//52, 42
//    [saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    backLabel.backgroundColor=[UIColor clearColor];
    backLabel.textColor=YINGYONG_COLOR;
    backLabel.textAlignment=NSTextAlignmentLeft;
    backLabel.font=[UIFont boldSystemFontOfSize:23];
    backLabel.text=@"授权";
    UIView *backView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth-71, 42)];
    backView1.backgroundColor=[UIColor clearColor];
    [backView1 addSubview:backBtn];
    [backView1 addSubview:backLabel];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView1];
//    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    self.navigationItem.leftBarButtonItem = backButtonItem;
//    self.navigationItem.rightBarButtonItem = saveButtonItem;
}
- (void)addTitle
{
    
    UIButton *buttonview = [[UIButton alloc ] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 130)];
    [buttonview setBackgroundImage:[UIImage imageNamed:@"jk_healthy_care_bg.png"] forState:UIControlStateNormal];
    [buttonview setBackgroundImage:[UIImage imageNamed:@"jk_healthy_care_bg.png"] forState:UIControlStateHighlighted];
    UIImageView *userFace = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/2-35, 10, 70, 70)];
    [userFace setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",userManage.headImg]]refreshCache:NO placeholderImage:[UIImage imageNamed:@"icon.png"]];
    UILabel *username = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, kDeviceWidth, 20)];
    username.textAlignment = NSTextAlignmentCenter;
    username.textColor = [UIColor whiteColor];
    username.text = userManage.name;
    
     UIButton *userMessage = [[UIButton alloc] initWithFrame:CGRectMake(0, 120, kDeviceWidth, 80)];
    userMessage.backgroundColor = [UIColor whiteColor];
    UILabel *linkPhoneTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    linkPhoneTitle.textColor = YINGYONG_COLOR;
    linkPhoneTitle.text = @"联系电话" ;
    UILabel *linkPhone = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, kDeviceWidth-120, 20)];
    linkPhone.text = userManage.tel;
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, kDeviceWidth, 1)];
    line1.backgroundColor = BACK_COLOR;
    
    UILabel *addressTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 51, 100, 20)];
    addressTitle.textColor = YINGYONG_COLOR;
    addressTitle.text = @"地址" ;
    UILabel *address = [[UILabel alloc] initWithFrame:CGRectMake(120, 51, kDeviceWidth-120, 20)];
    address.text = userManage.address;
    [userMessage addSubview:linkPhoneTitle];
    [userMessage addSubview:linkPhone];
    [userMessage addSubview:line1];
    [userMessage addSubview:addressTitle];
    [userMessage addSubview:address];

    
    
    UIButton *jiankangshouquan = [[UIButton alloc] initWithFrame:CGRectMake(0, 210, kDeviceWidth, 44)];
    jiankangshouquan.backgroundColor = [UIColor whiteColor];
    UILabel *jiankangshouqanlable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kDeviceWidth/2, 20)];
    jiankangshouqanlable.text = @"健康授权" ;
    
    jkshouquanindic = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2+10, 10, 70, 20)];
    jkshouquanindic.text = [self getStatu:[userManage.jkState intValue]];
    jkShouquanBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [jkShouquanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [jkShouquanBtn.layer setMasksToBounds:YES];
    [jkShouquanBtn.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    jkShouquanBtn.frame = CGRectMake(kDeviceWidth/2+80, 5, (kDeviceWidth/2-100), 30);
    jkShouquanBtn.backgroundColor = YINGYONG_COLOR;
    jkShouquanBtn.tag = JIANKANGBTN;
    [jkShouquanBtn addTarget:self action:@selector(changeAnthStatu:) forControlEvents:UIControlEventTouchUpInside];
    [jiankangshouquan addSubview:jiankangshouqanlable];
    [jiankangshouquan addSubview:jkshouquanindic];
    [jiankangshouquan addSubview:jkShouquanBtn];
    
    
    UIButton *guijishouquan = [[UIButton alloc] initWithFrame:CGRectMake(0, 264, kDeviceWidth, 44)];
    guijishouquan.backgroundColor = [UIColor whiteColor];
    UILabel *guijishouqanlable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kDeviceWidth/2, 20)];
    guijishouqanlable.text = @"轨迹授权" ;
    
    gjshouquanindic = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2+10, 10, 70, 20)];
    gjshouquanindic.text = [self getStatu:[userManage.jkState intValue]];
    gjShouquanBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [gjShouquanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [gjShouquanBtn.layer setMasksToBounds:YES];
    [gjShouquanBtn.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    gjShouquanBtn.frame = CGRectMake(kDeviceWidth/2+80, 5, (kDeviceWidth/2-100), 30);
    gjShouquanBtn.backgroundColor = YINGYONG_COLOR;
    gjShouquanBtn.tag = GUJIBTN;
    [gjShouquanBtn addTarget:self action:@selector(changeAnthStatu:) forControlEvents:UIControlEventTouchUpInside];
    [guijishouquan addSubview:guijishouqanlable];
    [guijishouquan addSubview:gjshouquanindic];
    [guijishouquan addSubview:gjShouquanBtn];
    
    
    
    
    UIButton *binglishouquan = [[UIButton alloc] initWithFrame:CGRectMake(0, 318, kDeviceWidth, 44)];
    binglishouquan.backgroundColor = [UIColor whiteColor];
    UILabel *binglishouqanlable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kDeviceWidth/2, 20)];
    binglishouqanlable.text = @"病例授权" ;
    
    blshouquanindic = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2+10, 10, 70, 20)];
    blshouquanindic.text = [self getStatu:[userManage.jkState intValue]];
    blShouquanBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [blShouquanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [blShouquanBtn.layer setMasksToBounds:YES];
    [blShouquanBtn.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    
    blShouquanBtn.frame = CGRectMake(kDeviceWidth/2+80, 5, (kDeviceWidth/2-100), 30);
    
    blShouquanBtn.backgroundColor = YINGYONG_COLOR;
    blShouquanBtn.tag = BINGLIBTN;
    [blShouquanBtn addTarget:self action:@selector(changeAnthStatu:) forControlEvents:UIControlEventTouchUpInside];
    [binglishouquan addSubview:binglishouqanlable];
    [binglishouquan addSubview:blshouquanindic];
    [binglishouquan addSubview:blShouquanBtn];

   
    UIButton *sendMesageBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sendMesageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendMesageBtn.layer setMasksToBounds:YES];
    [sendMesageBtn.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    sendMesageBtn.frame = CGRectMake(kDeviceWidth/2-100, 370, 200, 30);
    
    sendMesageBtn.backgroundColor = YINGYONG_COLOR;
    [sendMesageBtn setTitle:@"发送消息" forState:UIControlStateNormal];
    [sendMesageBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [buttonview addSubview:userFace];
    [buttonview addSubview:username];
   
    [self.view addSubview:buttonview];
    [self.view addSubview:userMessage];
    [self.view addSubview:jiankangshouquan];
    [self.view addSubview:guijishouquan];
    [self.view addSubview:binglishouquan];
    [self.view addSubview:sendMesageBtn];
}

- (void)sendMessage
{
    ChatDetailView *chatDetailView = [[ChatDetailView alloc] init];
    chatDetailView.toMemberId = userManage.identity;
    chatDetailView.toMemberHeadImg = userManage.headImg;
    chatDetailView.sendMessageFlag = 1;
    [self.navigationController pushViewController:chatDetailView animated:YES];
}
#pragma mark 初始化控件
- (void)initValue
{
    
    
    jkshouquanindic.text = [self getTextStatu:[userManage.jkState intValue]];
    [self setTitleForBtn:jkShouquanBtn andStringFlag: jkshouquanindic.text];
    
    gjshouquanindic.text = [self getTextStatu:[userManage.locusState intValue]];
    [self setTitleForBtn:gjShouquanBtn andStringFlag: gjshouquanindic.text];
    
    blshouquanindic.text = [self getTextStatu:[userManage.caseState intValue]];
    [self setTitleForBtn:blShouquanBtn andStringFlag: blshouquanindic.text];

}
-(void)viewWillAppear:(BOOL)animated{
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}


- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}

-(void)save
{

    NSMutableArray *urlArray = [[NSMutableArray alloc] init];
    [urlArray addObject:[[MyDictionary alloc]initWithName:@"company_id" Andvale:[NSString stringWithFormat:@"%d",user.companyId]]];
    [urlArray addObject:[[MyDictionary alloc]initWithName:@"user_id" Andvale:[NSString stringWithFormat:@"%d",userManage.identity]]];
    [urlArray addObject:[[MyDictionary alloc]initWithName:@"jk_state" Andvale:[NSString stringWithFormat:@"%@",userManage.jkState]]];
    [urlArray addObject:[[MyDictionary alloc]initWithName:@"locus_state" Andvale:[NSString stringWithFormat:@"%@",userManage.locusState]]];
    [urlArray addObject:[[MyDictionary alloc]initWithName:@"case_state" Andvale:[NSString stringWithFormat:@"%@",userManage.caseState]]];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?%@",BASE_URL,JIANKANGSHOUQUAN_URL,[self objectToUrl:urlArray]];
    
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
                if ([JsonToModel ifSuccessFromDictionaryData:data])
                {
                 dispatch_async(dispatch_get_main_queue(), ^{
//                [self.navigationController popViewControllerAnimated:YES];
                 });
                }
                else
                {
                     dispatch_async(dispatch_get_main_queue(), ^{
                    [commonAction showToast:@"保存失败" WhithNavigationController:self];
                         });
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
        });
    }


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

#pragma mark 改变授权状态
-(void)changeAnthStatu:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case JIANKANGBTN:
        {
            [self buttonChangeStateWithBtn:jkShouquanBtn];
        }
            break;
            
        case GUJIBTN:
        {
          [self buttonChangeStateWithBtn:gjShouquanBtn];
        }
            break;
        case BINGLIBTN:
        {
          [self buttonChangeStateWithBtn:blShouquanBtn];
        }
            break;
    }

}

#pragma mark 改变授权状态
- (void) buttonChangeStateWithBtn:(UIButton *)btn
{
    NSString *butonText = btn.titleLabel.text;
    if([butonText isEqual:@"同意"])
    {
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        
        switch (btn.tag)
        {
            case JIANKANGBTN:
            {
               
                userManage.jkState = @"103002";
                jkshouquanindic.text = @"已授权";
            }
                break;
                
            case GUJIBTN:
            {
                userManage.locusState = @"103002";
                gjshouquanindic.text = @"已授权";
            }
                break;
            case BINGLIBTN:
            {
                userManage.caseState = @"103002";
                blshouquanindic.text = @"已授权";
            }
            break;
        }

    }
    else if([butonText isEqual:@"取消"])
    {
       
        btn.hidden = YES;
        switch (btn.tag)
        {
            case JIANKANGBTN:
            {
                userManage.jkState = @"103004";
                jkshouquanindic.text = @"已取消";

            }
                break;
                
            case GUJIBTN:
            {
                userManage.locusState = @"103004";
                gjshouquanindic.text = @"已取消";
            }
                break;
            case BINGLIBTN:
            {
                userManage.caseState = @"103004";
                 blshouquanindic.text = @"已取消";
            }
                break;
        }

    }
    else
    {
        btn.hidden = YES;
    }
    [self save];
}


- (NSString *)getStatu:(int)state
{
    switch (state)
    {
        case SHENQINGZHONG:
        {
            return @"同意";
        }
            
        case YISHOUQUAN:
        {
           
            return @"取消";
        }
            break;
//        case YIJUJUE:
//        {
//            
//            return @"已拒绝";
//        }
//            
//        case QUXIAO:
//        {
//            return @"取消";
//        }
          
    }
    return nil;
}

- (NSString *)getTextStatu:(int)state
{
    switch (state)
    {
        case SHENQINGZHONG:
        {
            return @"申请中";
        }
            
        case YISHOUQUAN:
        {
            
            return @"已授权";
        }
            break;
        case YIJUJUE:
        {
            
            return @"已拒绝";
        }
            
        case QUXIAO:
        {
            return @"已取消";
        }
            
    }
    return nil;
}


- (void)setTitleForBtn:(UIButton *)btn andStringFlag:(NSString *)stringFlag
{
    if([stringFlag isEqual:@"申请中"])
    {
        [btn setTitle:@"同意" forState:UIControlStateNormal];
    }
    else if([stringFlag isEqual:@"已授权"])
    {
      [btn setTitle:@"取消" forState:UIControlStateNormal];
    }
    else
    {
        btn.hidden = YES;
    
    }
        

}
- (void)goBack
{
  [self.navigationController popViewControllerAnimated:YES];
}
@end
