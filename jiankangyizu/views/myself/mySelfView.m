//
//  CaseDetailViewController.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-5.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "mySelfView.h"
#import "MyDictionary.h"
#import "CommonStr.h"
#import "FormDetailCell.h"
#import "SDImageView+SDWebCache.h"
#import "dengLuView.h"
#import "FeedBackController.h"
#import "geRenXinXi.h"
#import "YuJingSheZhiController.h"
#import "MyMessageListController.h"
#define MINE 0
#define SHOUQUANGUANLI 0
#define WODEXIAOXi 1
#define QIEHUANUSER 2
#define YUJINGSETUP 3
#define SHIYONGFANKUI 4
@interface mySelfView ()

@end

@implementation mySelfView
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
     user = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-100)];
    myTableView.backgroundColor = BACK_COLOR;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    arrayData = [[NSMutableArray alloc] init];
    NSMutableArray *array1 = [[NSMutableArray alloc] init];
    [array1 addObject:[[MyDictionary alloc] initWithName:@" " Andvale:@" "]];
    
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] init];
    [dic1 setObject:array1 forKey:@"q1"];
    
    NSMutableArray *array2 = [[NSMutableArray alloc] init];
       [array2 addObject:[[MyDictionary alloc] initWithName:@"my_05@2x.png" Andvale:@"我的消息"]];
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
    [dic2 setObject:array2 forKey:@"q2"];
    
    NSMutableArray *array3 = [[NSMutableArray alloc] init];
    [array3 addObject:[[MyDictionary alloc] initWithName:@"my_06@2x.jpg" Andvale:@"切换用户"]];
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc] init];
    [dic3 setObject:array3 forKey:@"q3"];
    
    NSMutableArray *array4 = [[NSMutableArray alloc] init];
    [array4 addObject:[[MyDictionary alloc] initWithName:@"bt_warn_set@2x.png" Andvale:@"预警设置"]];
    NSMutableDictionary *dic4 = [[NSMutableDictionary alloc] init];
    [dic4 setObject:array4 forKey:@"q4"];
    
    NSMutableArray *array5 = [[NSMutableArray alloc] init];
    [array5 addObject:[[MyDictionary alloc] initWithName:@"my_08@2x.png" Andvale:@"使用反馈"]];
    NSMutableDictionary *dic5 = [[NSMutableDictionary alloc] init];
    [dic5 setObject:array5 forKey:@"q5"];
    
    [arrayData addObject:dic1];
    [arrayData addObject:dic2];
    [arrayData addObject:dic3];
    [arrayData addObject:dic4];
    [arrayData addObject:dic5];
    [self.view addSubview:myTableView];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)initNav{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tb_navbar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"common_top_back_icon.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame=CGRectMake(0, 0,30.5, 42);//52, 42
    UILabel *backLabel=[[UILabel alloc]initWithFrame:CGRectMake(32, 0, 300, 42)];
    backLabel.backgroundColor=[UIColor clearColor];
    backLabel.textColor=YINGYONG_COLOR;
    backLabel.textAlignment=NSTextAlignmentLeft;
    backLabel.font=[UIFont boldSystemFontOfSize:23];
    backLabel.text=@"多多健康.我";
    UIView *backView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 330, 42)];
    backView1.backgroundColor=[UIColor clearColor];
    [backView1 addSubview:backBtn];
    [backView1 addSubview:backLabel];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView1];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
}

- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arrayData.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *diction = [arrayData objectAtIndex:section];
    NSArray *keys = [diction allKeys];
    NSArray *array = [diction objectForKey:[keys objectAtIndex:0]];
    return array.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSString *text;
    NSDictionary *diction = [arrayData objectAtIndex:indexPath.section];
    NSArray *keys = [diction allKeys];
    NSArray *array = [diction objectForKey:[keys objectAtIndex:0]];
    MyDictionary *dictionary = [array objectAtIndex:indexPath.row];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        if (indexPath.section == 0)
        {
            userTitleImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
            [userTitleImg setImageWithURL:[NSURL URLWithString:user.headImg] refreshCache:NO placeholderImage:[UIImage imageNamed:@"icon.png"]];
            username = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 20)];
            username.text = user.name;
            usersexAndage = [[UILabel alloc] initWithFrame:CGRectMake(80, 35, 200, 20)];
            if(user.sex == 0)
            {
              
                    
                    usersexAndage.text = [NSString stringWithFormat:@"女  %d岁",[self getUserAgewithBirthdate:user.birthdays]];
                
              
            }
            else{
                
                    usersexAndage.text = [NSString stringWithFormat:@"男  %d岁",[self getUserAgewithBirthdate:user.birthdays]];
               
            }
            zhanghao = [[UILabel alloc] initWithFrame:CGRectMake(80, 60, 200, 20)];
            zhanghao.text = [NSString stringWithFormat:@"账号:%@",user.usern];
            [cell.contentView addSubview:userTitleImg];
            [cell.contentView addSubview:username];
            [cell.contentView addSubview:usersexAndage];
            [cell.contentView addSubview:zhanghao];
        }
        else if(indexPath.section == 1)
        {
            mymessageBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            mymessageBtn.frame = CGRectMake(120, 2, 18, 18);
            [mymessageBtn setBackgroundColor:[UIColor redColor]];
            mymessageBtn.layer.cornerRadius = 9 ;
            [mymessageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            mymessageBtn.hidden = YES;
           [cell.contentView addSubview:mymessageBtn];
        }
    }
    
        text = dictionary.value;
        cell.textLabel.text = text;
        cell.imageView.image = [UIImage imageNamed:dictionary.name];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [userTitleImg setImageWithURL:[NSURL URLWithString:user.headImg] refreshCache:NO placeholderImage:[UIImage imageNamed:@"touxiang.png"]];
     username.text = user.name;
    if(user.sex == 0)
    {
   
        usersexAndage.text = [NSString stringWithFormat:@"女  %d岁",[self getUserAgewithBirthdate:user.birthdays]];

    }
    else if(user.sex == 1){
        
        usersexAndage.text = [NSString stringWithFormat:@"男  %d岁",[self getUserAgewithBirthdate:user.birthdays]];
        
    }
   zhanghao.text = [NSString stringWithFormat:@"账号:%@",user.usern];
     [self getMessageCount];
    
}
//根据生日获取当前用户年龄
- (int )getUserAgewithBirthdate:(NSString *)birthdate
{
//    birthdate = [CommonStr getDateFormLongSince1970:birthdate];
    @try {
    
    if(birthdate !=nil)
    {
    NSDate *senddate = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *locationString = [dateFormat stringFromDate:senddate];
   
    int intbirthdate = [[birthdate substringWithRange:NSMakeRange(0,4)]intValue];
    int currentDate = [locationString intValue];
    return currentDate - intbirthdate;
    }
    else
    {
        return 0;
    }
    }
    @catch (NSException *exception) {
        NSLog(@"error:%@",exception);
        return 0;
    }
    @finally {
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   if(indexPath.section == 0)
   {
       return 80;
   }
   else
   {
        return 50;
   }
   
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)];
    [view setBackgroundColor:BACK_COLOR];
   
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case MINE:
        {
            geRenXinXi *gerenxinxi = [[geRenXinXi alloc] init];
            [self.navigationController pushViewController:gerenxinxi animated:YES];
        }
            break;
            
        case WODEXIAOXi:
        {
            MyMessageListController *chatController = [[MyMessageListController alloc] init];
            [self.navigationController pushViewController:chatController animated:YES];
        }
            break;
        case QIEHUANUSER:
        {
            dengLuView *loginController = [[dengLuView alloc] init];
            loginController.LoginFlag = 2;
            [self presentViewController:loginController animated:YES completion:nil];
        }
            break;
        case YUJINGSETUP:
        {
            YuJingSheZhiController *yujingController = [[YuJingSheZhiController alloc] init];
            [self.navigationController pushViewController:yujingController animated:YES];
        }
            break;
        case SHIYONGFANKUI:
        {
            FeedBackController *controller = [[FeedBackController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;

    }
}
#pragma mark 获取提醒数量
- (void)getMessageCount
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@?user_id=%d",BASE_URL,MESSAGECOUNT_URL,user.identity];
    
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
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if(data != nil)
                {
                    NSMutableDictionary *dir = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                    NSString *string=[dir objectForKey:@"resultObject"];
                    if([string intValue] > 0)
                    {
                      mymessageBtn.hidden = NO;
                      [mymessageBtn setTitle:string forState:UIControlStateNormal];
                    }
                    else
                    {
                        mymessageBtn.hidden = YES;
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
