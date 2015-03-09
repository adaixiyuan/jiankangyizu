//
//  JianKangJianHuViewController.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-9.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JianKangJianHuViewController.h"
#import "MDRadialProgressView.h"
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressLabel.h"
#import "commonJudgeMent.h"
#import "commonAction.h"
#import "JiankangJIanHuCell.h"
#import "JkBp.h"
#import "CommonStr.h"
#import "HealthanalysisTool.h"
#import "HealthyInfo.h"
#import "JkEar.h"
#import "JkGlu.h"
#import "JkOximeter.h"
#import "JkEcg.h"
#import "SDImageView+SDWebCache.h"
#import "JianKangJianHuDetailView.h"
#import "RDVTabBarController.h"
#import "EcgDetailController.h"
#import "JkBong.h"
#define XUEYA 1
#define ERWEN 2
#define XUETANG 3
#define XINDIAN 4
#define XUEYANG 5
#define BONG 6
#define CHAKANYUJING 7
@interface JianKangJianHuViewController ()
{
    MDRadialProgressView *progressView;
    UILabel *zhibiao;
    UILabel *zhibiaoNumber;
    UIButton *chakanxiangqing;
    PMCalendarController *datacontroller;
    int flag ;
    UITextField *startTimeBtn ;
    UITextField *endTimeBtn;
    NSString *searchCondition;
    UIButton *searchTimeBtn;
    UIButton *searchyujing;
    NSString *yujingxiangqing;
    UIButton *titlebg ;
    
    UIButton *xueyabtn;
    UIButton *erwenbtn;
    UIButton *xuetangbtn;
    UIButton *xindianbtn;
    UIButton *xueyangbtn;
    UIButton *bongbtn;
  
}
//@property (nonatomic, strong) PMCalendarController *pmCC;
@end

@implementation JianKangJianHuViewController

@synthesize postView,postArray,page,refreshing;
@synthesize height;
@synthesize wait;
@synthesize connection2;
@synthesize receiveData2;

@synthesize jkuserManahe;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self iniView];
    [self initButtonBackGroud];
    [xueyabtn setBackgroundImage:[UIImage imageNamed:@"healthy_list_btn_press.png"] forState:UIControlStateNormal];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    user = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    searchCondition =  searchCondition = [NSString stringWithFormat:@"user_id=%d and CONVERT(varchar(10), cat_date , 120 ) BETWEEN '%@' and '%@'",jkuserManahe.identity,startTimeBtn.text,endTimeBtn.text];
    
    [self selectQueryByTime];;
    yujingxiangqing = @"";
    queyFlag = XUEYA;
    flagarray = [NSMutableArray array];
    
    self.view.backgroundColor=BACK_COLOR;
    now=NO;
    page=0;
    postArray=[[NSMutableArray alloc]initWithCapacity:0];
    
    FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
    switch (queyFlag) {
        case XUEYA:
        {
          JkBpDAO* dao = [[JkBpDAO alloc]initWithDbqueue:queue];
            [dao searchWhere:[NSString stringWithFormat:@"where company_id=%d",user.companyId] orderBy:@"identity desc" offset:0 count:PAGESIZE callback:^(NSArray *array){
                self.postArray=(NSMutableArray *)array;
            }];
         }
            break;
            
        case XUETANG:
        {
            JkGluDAO* dao = [[JkGluDAO alloc]initWithDbqueue:queue];
            [dao searchWhere:[NSString stringWithFormat:@"where company_id=%d",user.companyId] orderBy:@"identity desc" offset:0 count:PAGESIZE callback:^(NSArray *array){
                self.postArray=(NSMutableArray *)array;
            }];
        }
            break;
        case ERWEN:
        {
          
            JkEarDAO* dao = [[JkEarDAO alloc]initWithDbqueue:queue];
            [dao searchWhere:[NSString stringWithFormat:@"where company_id=%d",user.companyId] orderBy:@"identity desc" offset:0 count:PAGESIZE callback:^(NSArray *array){
                self.postArray=(NSMutableArray *)array;
            }];
        }
            break;
        case XINDIAN:
        {
            JkEcgDao* dao = [[JkEcgDao alloc]initWithDbqueue:queue];
            [dao searchWhere:[NSString stringWithFormat:@"where company_id=%d",user.companyId] orderBy:@"identity desc" offset:0 count:PAGESIZE callback:^(NSArray *array){
                self.postArray=(NSMutableArray *)array;
            }];
        }
            break;

        case XUEYANG:
        {
            JkOximeterDAO* dao = [[JkOximeterDAO alloc]initWithDbqueue:queue];
            [dao searchWhere:[NSString stringWithFormat:@"where company_id=%d",user.companyId] orderBy:@"identity desc" offset:0 count:PAGESIZE callback:^(NSArray *array){
                self.postArray=(NSMutableArray *)array;
            }];
        }
            break;
        case BONG:
        {
            JkOximeterDAO* dao = [[JkOximeterDAO alloc]initWithDbqueue:queue];
            [dao searchWhere:[NSString stringWithFormat:@"where company_id=%d",user.companyId] orderBy:@"identity desc" offset:0 count:PAGESIZE callback:^(NSArray *array){
                self.postArray=(NSMutableArray *)array;
            }];
        }
    }
    
    postView=[[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 240, kDeviceWidth,[[UIScreen mainScreen] bounds].size.height-64-240) pullingDelegate:self];
    postView.delegate=self;
    postView.dataSource=self;
    postView.backgroundColor=BACK_COLOR;
    postView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    postView.separatorStyle = NO;
    [self.view addSubview:postView];
    UIView *footer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    moreButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [moreButton setTitle:@"点击加载更多" forState:UIControlStateNormal];
    [moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(moreData) forControlEvents:UIControlEventTouchUpInside];
    moreButton.frame=CGRectMake(0, 0, 320, 44);
    [footer addSubview:moreButton];
    self.postView.tableFooterView=footer;
     [postView launchRefreshing];

}
-(void)viewWillAppear:(BOOL)animated{
    if (height==1) {
        postView.frame=CGRectMake(0, (kDeviceWidth/3)+50, 320, [[UIScreen mainScreen] bounds].size.height-152);
    }
    [self.navigationController setNavigationBarHidden:NO animated:NO];
     [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}


- (void)loadData{
    [postView tableViewDidFinishedLoadingWithMessage:@""];
//    self.page++;
    if (self.refreshing) {
//        self.page = 1;
        self.refreshing = NO;
        [self moreData];
    }
    if (self.page>=1) {
        [postView tableViewDidFinishedLoading];
        postView.reachedTheEnd  = NO;
    }
}

-(void)reloadPostView{
    [self.postView launchRefreshing];
}

- (void)goback
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    //    self.navigationController.navigationBar.hidden = YES;
    
}
#pragma mark - PullingRefreshTableViewDelegate
//开始数据刷新
-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    
     self.refreshing = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}

- (NSDate *)pullingTableViewRefreshingFinishedDate{
    
    NSDate *date2=[NSDate date];
    return date2;
}
//上拉时加载数据
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}

#pragma mark - Scroll
-(void)scrollViewDidScroll:(UIScrollView *)_scrollView{
    
    [self.postView tableViewDidScroll:_scrollView];
    CGPoint contentOffsetPoint = postView.contentOffset;
    CGRect frame = postView.frame;
    //    scrollView.contentOffset.y + (scrollView.frame.size.height) > scrollView.contentSize.height;
    if ((contentOffsetPoint.y == postView.contentSize.height - frame.size.height || postView.contentSize.height < frame.size.height)&&firstDone==1)
    {
        [self moreData];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)_scrollView willDecelerate:(BOOL)decelerate{
    if (_scrollView.tag!=1) {
        [self.postView tableViewDidEndDragging:_scrollView];
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView{
    pcIsChange=NO;
}

-(void)refreshTopicAll{
    [self.postView setContentOffset:CGPointMake(0,-75) animated:YES];
    [self performSelector:@selector(doneManualRefresh) withObject:nil afterDelay:0.4];
}

-(void)doneManualRefresh{
    [self.postView tableViewDidScroll:postView];
    [self.postView tableViewDidEndDragging:postView];
}

#pragma mark tableViewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.postArray count];
    
}
//返回条目数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

// 填充每个条目上的数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = @"Cell";
    
    JiankangJIanHuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
         cell = [[JiankangJIanHuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    switch (queyFlag) {
        case XUEYA:
        {
           JkBp *jkbp = [self.postArray objectAtIndex:indexPath.row];
            HealthyInfo *healthInfo = [HealthanalysisTool analysisBpBySettingwithPcp:jkbp.pcp andPdp:jkbp.pdp];
           cell.zhibiaolable.text = healthInfo.meaage;
           cell.zhibiaoimg.image = [UIImage imageNamed:healthInfo.listBtnId];
           cell.celiangtime.text = [CommonStr getDateFormLongSince1970:jkbp.catDate];
           cell.celiangaddress.text = jkbp.catAddress;
           cell.zhibiaolable.textColor = healthInfo.colorId;

            if([healthInfo.meaage isEqualToString:@"正常"])// 如果为正常则隐藏预警指示
            {
                cell.yujing.hidden=YES;
            }
            else
            {
                cell.yujing.hidden = NO;
            }
           if(indexPath.row == 0)
           {
              
           }
            
        }
            break;
            
        case XUETANG:
        {
            JkGlu *jkglu = [self.postArray objectAtIndex:indexPath.row];
            HealthyInfo *healthInfo = [HealthanalysisTool analysisGluBySetting:[jkglu.glu doubleValue]];
            cell.zhibiaolable.text = healthInfo.meaage;
            cell.zhibiaoimg.image = [UIImage imageNamed:healthInfo.listBtnId];
            cell.celiangtime.text = [CommonStr getDateFormLongSince1970:jkglu.catDate];
            cell.celiangaddress.text = jkglu.catAddress;
            cell.zhibiaolable.textColor = healthInfo.colorId;

            if([healthInfo.meaage isEqualToString:@"正常"])
            {
                cell.yujing.hidden=YES;
            }
            else
            {
                cell.yujing.hidden = NO;
            }
           
        }
            break;
        case ERWEN:
        {
            JkEar *jkear = [self.postArray objectAtIndex:indexPath.row];
            HealthyInfo *healthInfo = [HealthanalysisTool analysisEarBySetting:[jkear.ear doubleValue]];
            cell.zhibiaolable.text = healthInfo.meaage;
            cell.zhibiaoimg.image = [UIImage imageNamed:healthInfo.listBtnId];
            cell.celiangtime.text = [CommonStr getDateFormLongSince1970:jkear.catDate];
            cell.celiangaddress.text = jkear.catAddress;
            cell.zhibiaolable.textColor = healthInfo.colorId;

            if([healthInfo.meaage isEqualToString:@"正常"])
            {
                cell.yujing.hidden=YES;
            }
            else
            {
                cell.yujing.hidden = NO;
            }
        }
            break;
        case XINDIAN:
        {
            JkEcg *jkecg = [self.postArray objectAtIndex:indexPath.row];
            HealthyInfo *healthInfo = [HealthanalysisTool analysisEcgBySetting:jkecg.result];
            cell.zhibiaolable.text = healthInfo.meaage;
            cell.zhibiaoimg.image = [UIImage imageNamed:healthInfo.listBtnId];
            cell.celiangtime.text = [CommonStr getDateFormLongSince1970:jkecg.catDate];
            cell.celiangaddress.text = jkecg.catAddress;
            cell.zhibiaolable.textColor = healthInfo.colorId;

            if([healthInfo.meaage isEqualToString:@"正常"])
            {
                cell.yujing.hidden=YES;
            }
            else
            {
                cell.yujing.hidden = NO;
            }
        }
            break;
            
        case XUEYANG:
        {
            JkOximeter *jkoximeter = [self.postArray objectAtIndex:indexPath.row];
            HealthyInfo *healthInfo = [HealthanalysisTool analysisOxiBySetting:jkoximeter.pr];
            cell.zhibiaolable.text = healthInfo.meaage;
            cell.zhibiaoimg.image = [UIImage imageNamed:healthInfo.listBtnId];
            cell.celiangtime.text = [CommonStr getDateFormLongSince1970:jkoximeter.catDate];
            cell.celiangaddress.text = jkoximeter.catAddress;
            cell.zhibiaolable.textColor = healthInfo.colorId;
            if([healthInfo.meaage isEqualToString:@"正常"])
            {
                cell.yujing.hidden=YES;
            }
            else
            {
                cell.yujing.hidden = NO;
            }
        }
            break;
            
        case BONG:
        {
            JkBong *jkbong = [self.postArray objectAtIndex:indexPath.row];
            HealthyInfo *healthInfo = [HealthanalysisTool analysisOxiBySetting:[jkbong.calories doubleValue]];
            cell.zhibiaolable.text = healthInfo.meaage;
            cell.zhibiaoimg.image = [UIImage imageNamed:healthInfo.listBtnId];
            cell.celiangtime.text = [CommonStr getDateFormLongSince1970:jkbong.catDate];
            cell.celiangaddress.hidden = YES;
            cell.zhibiaolable.textColor = healthInfo.colorId;
            if([healthInfo.meaage isEqualToString:@"正常"])
            {
                cell.yujing.hidden=YES;
            }
            else
            {
                cell.yujing.hidden = NO;
            }
        }
            break;

}
  if(indexPath.row == 0)
  {
     [self setTitleValue:0];
  }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self setTitleValue:indexPath];
    chakanxiangqing.tag = indexPath.row;

    
}
- (void)setTitleValue:(NSIndexPath *)index
{
   
    
    switch (queyFlag) {
        case XUEYA:
        {
            progressView.progressTotal = 200;
            JkBp *jkbp = [self.postArray objectAtIndex:index.row];
            HealthyInfo *healthInfo = [HealthanalysisTool analysisBpBySettingwithPcp:jkbp.pcp andPdp:jkbp.pdp];
            zhibiao.text = healthInfo.meaage;
            zhibiaoNumber.text = [NSString stringWithFormat:@"%d %d %d",jkbp.pcp,jkbp.pdp,jkbp.heartRate];
            progressView.progressCounter = jkbp.pcp;
            [titlebg setBackgroundColor:healthInfo.colorId];
        }
            break;
            
        case XUETANG:
        {
            progressView.progressTotal = 100;
            JkGlu *jkglu = [self.postArray objectAtIndex:index.row];
            HealthyInfo *healthInfo = [HealthanalysisTool analysisGluBySetting:[jkglu.glu doubleValue]];
            zhibiao.text = healthInfo.meaage;
            zhibiaoNumber.text = [NSString stringWithFormat:@"%@",jkglu.glu];
            progressView.progressCounter = (int)[jkglu.glu doubleValue];
            [titlebg setBackgroundColor:healthInfo.colorId];

        }
            break;
        case ERWEN:
        {
            progressView.progressTotal = 100;
            JkEar *jkear = [self.postArray objectAtIndex:index.row];
            HealthyInfo *healthInfo = [HealthanalysisTool analysisEarBySetting:[jkear.ear doubleValue]];
            zhibiao.text = healthInfo.meaage;
            zhibiaoNumber.text = [NSString stringWithFormat:@"%@",jkear.ear];
            progressView.progressCounter = [jkear.ear intValue];
           [titlebg setBackgroundColor:healthInfo.colorId];
        }
            break;
        case XINDIAN:
        {
            progressView.progressTotal = 100;
            JkEcg *jkecg = [self.postArray objectAtIndex:index.row];
            HealthyInfo *healthInfo = [HealthanalysisTool analysisEcgBySetting:jkecg.result];
            zhibiao.text = healthInfo.meaage;
            zhibiaoNumber.text = @"点击查看";
            [titlebg setBackgroundColor:healthInfo.colorId];

            

        }
            break;
            
        case XUEYANG:
        {
            progressView.progressTotal = 100;
            JkOximeter *jkoximeter = [self.postArray objectAtIndex:index.row];
            HealthyInfo *healthInfo = [HealthanalysisTool analysisOxiBySetting:jkoximeter.pr];
            zhibiao.text = healthInfo.meaage;
            zhibiaoNumber.text = [NSString stringWithFormat:@"%d %d %0.2f",jkoximeter.spo,jkoximeter.pr,jkoximeter.pi];
            progressView.progressCounter = jkoximeter.pr;
            [titlebg setBackgroundColor:healthInfo.colorId];    
        }
            break;
        case BONG:
        {
            progressView.progressTotal = 100;
            JkBong *jkbong = [self.postArray objectAtIndex:index.row];
            HealthyInfo *healthInfo = [HealthanalysisTool analysisBongSetting:[jkbong.calories doubleValue]];
            zhibiao.text = healthInfo.meaage;
            zhibiaoNumber.text = [NSString stringWithFormat:@"%d %@",jkbong.sleepNum,jkbong.calories];
             progressView.progressCounter = [jkbong.calories intValue];
            [titlebg setBackgroundColor:healthInfo.colorId];
        
        }
    }
    

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 60;
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response

{
    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
    NSLog(@"%@",[res allHeaderFields]);
    self.receiveData2 = [NSMutableData data];
    
}

//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
   
    [self.receiveData2 appendData:data];
    
    
}

#pragma mark 加载网络数据
-(void)moreData{
    NSString *str = nil;
    if (now==NO) {
        page++;
        [moreButton setTitle:@"" forState:UIControlStateNormal];
        if (wait==nil) {
            wait=[[WaitProgress alloc]initWithFrame:CGRectMake(145, 5, 30, 30)];
        }
        [moreButton addSubview:wait];
        
        if ([commonJudgeMent ifConnectNet]){
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,COMMONINDEX_URL]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
            [request setHTTPMethod:@"POST"];
            //        举例：BASEURL//saleout/saleout_list.jsp?sid=10&longitude=0&latitude=0&distance=26400&page_size=2&start_page=1&is_page=1
            NSString *condition = [NSString stringWithFormat:@"user_id=%d",jkuserManahe.identity];
            if(![yujingxiangqing isEqualToString:@""])  //查看预警详情
            {
                condition = yujingxiangqing;
            }
            if(![searchCondition isEqualToString:@""])  //搜索
            {
                condition = searchCondition;
            }
            switch (queyFlag) {
                case XUEYA:
                {
                    str =[NSString stringWithFormat:@"start_page=%ld&is_page=1&page_size=%d&table_name=jk_bp&condition=%@",page,PAGESIZE,condition];//设置参数
                }
                    break;
                    
                case XUETANG:
                {
                    str =[NSString stringWithFormat:@"start_page=%ld&is_page=1&page_size=%d&table_name=jk_glu&condition=%@",page,PAGESIZE,condition];//设置参数
                }
                    break;
                case ERWEN:
                {
                    str =[NSString stringWithFormat:@"start_page=%ld&is_page=1&page_size=%d&table_name=jk_ear&condition=%@",page,PAGESIZE,condition];//设置参数
                }
                    break;
                case XINDIAN:
                {
                    
                   str =[NSString stringWithFormat:@"start_page=%ld&is_page=1&page_size=%d&table_name=jk_ecg&condition=%@",page,PAGESIZE,condition];//设置参数
                }
                    break;
                    
                case XUEYANG:
                {
                    
                    str =[NSString stringWithFormat:@"start_page=%ld&is_page=1&page_size=%d&table_name=jk_oximeter&condition=%@",page,PAGESIZE,condition];//设置参数
                }
                    break;
                case BONG:
                {
                    str =[NSString stringWithFormat:@"start_page=%ld&is_page=1&page_size=%d&table_name=jk_bong&condition=%@",page,PAGESIZE,condition];//设置参数

                }
                    
            }
            
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            [request setHTTPBody:data];
            //第二步，连接服务器
            
            NSLog(@"searchCondition:%@",str);
            now = YES;
            connection2 = [[NSURLConnection alloc]initWithRequest:request delegate:self];
            
        }else{
             [commonAction showToast:NONETWORK WhithNavigationController:self.navigationController];
        }
    }
}

//数据传完之后调用此方法
#pragma mark 数据传输完成
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
//    [self setArrayFlag:objects];
    FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
    ZUOYLDAOBase *dao = nil;
    NSArray *objects = nil;
    switch (queyFlag) {
        case XUEYA:
        {
             objects=[JsonToModel objectsFromDictionaryData:self.receiveData2 className:@"JkBp"];
             dao = [[JkUserManageDao alloc]initWithDbqueue:queue];
        }
            break;
            
        case XUETANG:
        {
            objects=[JsonToModel objectsFromDictionaryData:self.receiveData2 className:@"JkGlu"];
             dao = [[JkUserManageDao alloc]initWithDbqueue:queue];
        }
            break;
        case ERWEN:
        {
             objects=[JsonToModel objectsFromDictionaryData:self.receiveData2 className:@"JkEar"];
             dao = [[JkUserManageDao alloc]initWithDbqueue:queue];
        }
            break;
        case XINDIAN:
        {
            objects=[JsonToModel objectsFromDictionaryData:self.receiveData2 className:@"JkEcg"];
             dao = [[JkUserManageDao alloc]initWithDbqueue:queue];
        }
            break;
            
        case XUEYANG:
        {
            objects=[JsonToModel objectsFromDictionaryData:self.receiveData2 className:@"JkOximeter"];
             dao = [[JkUserManageDao alloc]initWithDbqueue:queue];
        }
            break;
        case BONG:
        {
            objects=[JsonToModel objectsFromDictionaryData:self.receiveData2 className:@"JkBong"];
            dao = [[JkUserManageDao alloc]initWithDbqueue:queue];
        }
            
    }
    @autoreleasepool {
        [dao replaceArrayToDB:objects callback:^(BOOL block){
            
        }];
    }
    if ([objects count] == PAGESIZE) {
        [self.postArray addObjectsFromArray:objects];
        [self.postView reloadData];
        [wait removeFromSuperview];
        [moreButton setTitle:@"点击加载更多" forState:UIControlStateNormal];
        [moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
         now=NO;
    }
    else if([objects count] < PAGESIZE){
        [self.postArray addObjectsFromArray:objects];
        [self.postView reloadData];
        [wait removeFromSuperview];
        [moreButton setTitle:@"加载完毕" forState:UIControlStateNormal];
        [moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
          now=YES;
    }
    else{
        [wait removeFromSuperview];
        [moreButton setTitle:@"加载失败" forState:UIControlStateNormal];
        [moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
          now=NO;
    }
    firstDone = 1;

    
}
//- (void)setArrayFlag:(NSArray *)array
//{
//    int i;
//    for(i = 0 ; i < [array count] ;i ++)
//    {
//        [flagarray addObject:ON];
//    }
//}
//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [wait removeFromSuperview];
    [moreButton setTitle:@"加载失败" forState:UIControlStateNormal];
    [moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

    NSLog(@"%@",[error localizedDescription]);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

- (void)iniView
{
   
    titlebg = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth,200)];
    titlebg.backgroundColor =[UIColor colorWithRed:69.0/255.0 green:178.0/255.0 blue:139.0/255.0 alpha:1];
    titlebg.userInteractionEnabled = YES;
    
    xueyabtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20,50, 20)];
    xueyabtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [xueyabtn setTitle:@"血压" forState:UIControlStateNormal];
    
    
    
    erwenbtn = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth-70, 20, 50, 20)];
    erwenbtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [erwenbtn setTitle:@"耳温" forState:UIControlStateNormal];
    
    xuetangbtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 70, 50, 20)];
    xuetangbtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [xuetangbtn setTitle:@"血糖" forState:UIControlStateNormal];
    
    xindianbtn = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth-70,70 ,50, 20)];
    xindianbtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [xindianbtn setTitle:@"心电" forState:UIControlStateNormal];
    
    xueyangbtn = [[UIButton alloc] initWithFrame:CGRectMake(10,120, 50, 20)];
    xueyangbtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [xueyangbtn setTitle:@"血氧" forState:UIControlStateNormal];
    
    bongbtn = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth-70,120,70, 20)];
    bongbtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [bongbtn setTitle:@"运动手环" forState:UIControlStateNormal];
    
    xueyabtn.tag = XUEYA;
    erwenbtn.tag = ERWEN;
    xuetangbtn.tag = XUETANG;
    xindianbtn.tag = XINDIAN;
    xueyangbtn.tag = XUEYANG;
    bongbtn.tag = BONG;
    [xueyabtn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    [erwenbtn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    [xuetangbtn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    [xindianbtn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    [xueyangbtn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    [bongbtn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    progressView = [[MDRadialProgressView alloc] initWithFrame:CGRectMake(kDeviceWidth/2-75, 10, 150,150) ];
    progressView.progressTotal = 10;
    progressView.theme.Thickness=10;
    progressView.progressCounter = 10;
    progressView.theme.sliceDividerHidden = YES;
    progressView.theme.completedColor = [UIColor whiteColor];
    progressView.label.hidden = YES;
    
    zhibiao = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2-50, 45, 100, 20)];
    zhibiao.textColor = [UIColor whiteColor];
    zhibiao.textAlignment = NSTextAlignmentCenter;
  
    
    zhibiaoNumber = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2-50, 75, 100, 20)];
    zhibiaoNumber.textColor = [UIColor whiteColor];
    zhibiaoNumber.textAlignment = NSTextAlignmentCenter;
    
    chakanxiangqing = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/2-50, 105, 100, 20)];
    [chakanxiangqing setTitle:@"查看详情>" forState:UIControlStateNormal];
    [chakanxiangqing addTarget:self action:@selector(chankandetail:) forControlEvents:UIControlEventTouchUpInside];
    
    //获取系统当前日期
    NSDate *senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *startdate=[dateformatter stringFromDate:[self getPriousDateFromDate:senddate withMonth:-3]];
    NSString *enddate=[dateformatter stringFromDate:senddate];
    
    UILabel *line1 =  [[UILabel alloc] initWithFrame:CGRectMake(0, 165, kDeviceWidth, 1)];
    line1.backgroundColor = [UIColor whiteColor];
    

    startTimeBtn = [[UITextField alloc] initWithFrame:CGRectMake(0,170 , (kDeviceWidth-50)/2, 20)];
    startTimeBtn.text = startdate;
    startTimeBtn.textColor = [UIColor whiteColor];
    startTimeBtn.textAlignment = NSTextAlignmentCenter;

    startdatePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 216)];
    startdatePicker.datePickerMode=UIDatePickerModeDate;
    [startdatePicker addTarget:self action:@selector(startdateChanged:) forControlEvents:UIControlEventValueChanged ];
    startTimeBtn.inputView = startdatePicker;
    
    UIToolbar * keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 38.0f)];
    keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                  target:nil
                                                                                  action:nil];
    
    UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", @"")
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:startTimeBtn
                                                                   action:@selector(resignFirstResponder)];
    
    [keyboardToolbar setItems:[NSArray arrayWithObjects:spaceBarItem, doneBarItem, nil]];
    startTimeBtn.inputAccessoryView = keyboardToolbar;

    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake((kDeviceWidth-50)/2, 166, 1, 200-166)];
    line2.backgroundColor = [UIColor whiteColor];
    
    endTimeBtn = [[UITextField alloc] initWithFrame:CGRectMake((kDeviceWidth-50)/2+1,170, (kDeviceWidth-50)/2, 20)];
    endTimeBtn.text = enddate;
    endTimeBtn.textColor = [UIColor whiteColor];
    endTimeBtn.textAlignment = NSTextAlignmentCenter;
//    endTimeBtn.tag = 2;
//    [endTimeBtn addTarget:self action:@selector(selectTime:) forControlEvents:UIControlEventTouchUpInside];
//    [endTimeBtn setTitle:locationString forState:UIControlStateNormal];
    
    enddatePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 216)];
    enddatePicker.datePickerMode=UIDatePickerModeDate;
    [enddatePicker addTarget:self action:@selector(enddateChanged:) forControlEvents:UIControlEventValueChanged ];
    endTimeBtn.inputView = enddatePicker;
    
    UIToolbar * keyboardToolbar2 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 38.0f)];
    keyboardToolbar2.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *spaceBarItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                  target:nil
                                                                                  action:nil];
    
    UIBarButtonItem *doneBarItem1 = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", @"")
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:endTimeBtn
                                                                   action:@selector(resignFirstResponder)];
    
    [keyboardToolbar2 setItems:[NSArray arrayWithObjects:spaceBarItem1, doneBarItem1, nil]];
    endTimeBtn.inputAccessoryView = keyboardToolbar2;
    
    
    
    UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake((kDeviceWidth-50)+1, 166, 1, 200-166)];
    line3.backgroundColor = [UIColor whiteColor];

    searchTimeBtn = [[UIButton alloc] initWithFrame:CGRectMake((kDeviceWidth-50)+2,170, 40,20)];
    [searchTimeBtn setTitle:@"搜索" forState:UIControlStateNormal];
    

    UILabel *userMessage = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, kDeviceWidth, 40)];
    userMessage.userInteractionEnabled  = YES;
    UIImageView *userTitleImge = [[UIImageView alloc] initWithFrame:CGRectMake(40, 5,40, 30)];
    [userTitleImge setImageWithURL:[NSURL URLWithString:jkuserManahe.headImg] refreshCache:NO placeholderImage:[UIImage imageNamed:@"icon.png"]];
    UILabel *username = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3,0, kDeviceWidth/3, 20)];
    username.textColor = [UIColor blackColor];
    username.text = jkuserManahe.name;
    username.font = [UIFont systemFontOfSize:15.0];
    UILabel *usersexandage = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3,20, kDeviceWidth/3, 20)];
    usersexandage.textColor = [UIColor blackColor];
    if(jkuserManahe.sex == 0)
    {
        usersexandage.text = [NSString stringWithFormat:@"女 %d岁",jkuserManahe.age];
    }
    else
    {
        usersexandage.text = [NSString stringWithFormat:@"男 %d岁",jkuserManahe.age];
    }
    usersexandage.font = [UIFont systemFontOfSize:15.0];
    UILabel *line4 = [[UILabel alloc] initWithFrame:CGRectMake((kDeviceWidth/3)*2, 0, 1, 40)];
    line4.backgroundColor = YINGYONG_COLOR;
    searchyujing = [[UIButton alloc] initWithFrame:CGRectMake((kDeviceWidth/3)*2+1, 0,  kDeviceWidth/3-1, 40)];
    [searchyujing setTitle:@"查看预警" forState:UIControlStateNormal];
    [searchyujing setTitleColor:YINGYONG_COLOR forState:UIControlStateNormal];
     searchyujing.userInteractionEnabled = YES;
    UILabel *line5 = [[UILabel alloc] initWithFrame:CGRectMake(0, 40-1, kDeviceWidth, 1)];
    line5.backgroundColor = YINGYONG_COLOR;
    [userMessage addSubview:userTitleImge];
    [userMessage addSubview:username];
    [userMessage addSubview:usersexandage];
    [userMessage addSubview:line4];
    [userMessage addSubview:searchyujing];
    [userMessage addSubview:line5];
   
   
     [searchTimeBtn addTarget:self action:@selector(searchTime:) forControlEvents:UIControlEventTouchUpInside];
    [searchyujing addTarget:self action:@selector(chakanYujings:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [titlebg addSubview:xueyabtn];
    [titlebg addSubview:erwenbtn];
    [titlebg addSubview:xuetangbtn];
    [titlebg addSubview:xindianbtn];
    [titlebg addSubview:xueyangbtn];
    [titlebg addSubview:bongbtn];
    [titlebg addSubview:progressView];
    [titlebg addSubview:zhibiao];
    [titlebg addSubview:zhibiaoNumber];
    [titlebg addSubview:chakanxiangqing];
    [self.view addSubview:titlebg];
    [self.view addSubview:startTimeBtn];
    [self.view addSubview:line1];
    [self.view addSubview:endTimeBtn];
    [self.view addSubview:line2];
    [self.view addSubview:line3];
    [self.view addSubview:searchTimeBtn];
    [self.view addSubview:userMessage];
}

-(NSDate *)getPriousDateFromDate:(NSDate *)date withMonth:(int)month
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:month];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];

    return mDate;
}

- (void)selectTime:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if ([datacontroller isCalendarVisible])
    {
        [datacontroller dismissCalendarAnimated:NO];
    }
    
    datacontroller = [[PMCalendarController alloc] initWithThemeName:@"default"];
    datacontroller.delegate = self;
    datacontroller.mondayFirstDayOfWeek = NO;

    //self.pmCC.showOnlyCurrentMonth = YES; //Only show days in current month
        BOOL isPopover = YES;
        [datacontroller presentCalendarFromView:btn
                  permittedArrowDirections:PMCalendarArrowDirectionAny
                                 isPopover:isPopover
                                  animated:YES];
    datacontroller.tag = (int)btn.tag;
    datacontroller.period = [PMPeriod oneDayPeriodWithDate:[NSDate date]];
    [self calendarController:datacontroller didChangePeriod:datacontroller.period];
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//}
//
//#pragma mark PMCalendarControllerDelegate methods
//
//- (void)calendarController:(PMCalendarController *)calendarController didChangePeriod:(PMPeriod *)newPeriod
//{
//
//   NSString *date = [NSString stringWithFormat:@"%@",[newPeriod.startDate dateStringWithFormat:@"yyyy-MM-dd"]];
//    
//    if(calendarController.tag == 0)  // 可能会导致月份选择出现问题
//    {
//        flag = 1;
//    }
//    else
//    {
//        flag += 1;
//    }
//    if(flag >=3)
//    {
//        switch (calendarController.tag)
//        {
//            case 1:
//            {
//                [startTimeBtn setTitle:date forState:UIControlStateNormal];
//            }
//                break;
//                
//            case 2:
//            {
//                [endTimeBtn setTitle:date forState:UIControlStateNormal];
//            }
//                break;
//        }
//
//        [calendarController dismissCalendarAnimated:YES];
//    }
//}
-(void)startdateChanged:(id)sender{
    UIDatePicker* control = (UIDatePicker*)sender;
    NSDate* _date = control.date;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd";
    NSString *dateString=[df stringFromDate:_date];
    startTimeBtn.text = dateString;
}

-(void)enddateChanged:(id)sender{
    UIDatePicker* control = (UIDatePicker*)sender;
    NSDate* _date = control.date;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd";
    NSString *dateString=[df stringFromDate:_date];
    endTimeBtn.text = dateString;
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
    backLabel.text=@"健康监护";
    UIView *backView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 330, 42)];
    backView1.backgroundColor=[UIColor clearColor];
    [backView1 addSubview:backBtn];
    [backView1 addSubview:backLabel];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView1];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}
#pragma mark 查看详情
- (void)chankandetail:(id)sender
{
     UIButton *btn = (UIButton *)sender;
     JianKangJianHuDetailView *jkjhDetailcontroller = [[JianKangJianHuDetailView alloc] init];
    switch (queyFlag) {
        case XUEYA:
        {
            jkjhDetailcontroller.DetailFlag = XUEYA;
        }
            break;
            
        case ERWEN:
        {
           jkjhDetailcontroller.DetailFlag = ERWEN;
        }
            break;
        case XUETANG:
        {
           jkjhDetailcontroller.DetailFlag = XUETANG;
        }
            break;
        case XINDIAN:
        {
            jkjhDetailcontroller.DetailFlag = XINDIAN;
            
            EcgDetailController *ecgController = [[EcgDetailController alloc] init];
            ecgController.jkecg = postArray[btn.tag];
            [self.navigationController pushViewController:ecgController animated:YES];

        }
            break;
        case XUEYANG:
        {
            jkjhDetailcontroller.DetailFlag = XUEYANG;
           
        }
            break;
        case BONG:
        {
            jkjhDetailcontroller.DetailFlag = BONG;
        }
    }
    if([postArray count] != 0 && queyFlag!= XINDIAN)
    {
     jkjhDetailcontroller.modeObject = postArray[btn.tag];
     [self.navigationController pushViewController:jkjhDetailcontroller animated:YES];
    }
}

#pragma mark 选择查询
- (void)search:(id)sender
{
    [self cleartitleView];
    now=NO;
    page = 0;
    UIButton *btn = (UIButton *)sender;
    [self initButtonBackGroud];
    switch (btn.tag) {
        case XUEYA:
        {
            queyFlag = XUEYA;
            [xueyabtn setBackgroundImage:[UIImage imageNamed:@"healthy_list_btn_press.png"] forState:UIControlStateNormal];
        }
            break;
            
        case ERWEN:
        {
            queyFlag = ERWEN;
            [erwenbtn setBackgroundImage:[UIImage imageNamed:@"healthy_list_btn_press.png"] forState:UIControlStateNormal];
        }
            break;
        case XUETANG:
        {
            queyFlag = XUETANG;
            [xuetangbtn setBackgroundImage:[UIImage imageNamed:@"healthy_list_btn_press.png"] forState:UIControlStateNormal];
        }
            break;
        case XINDIAN:
        {
            queyFlag = XINDIAN;
            [xindianbtn setBackgroundImage:[UIImage imageNamed:@"healthy_list_btn_press.png"] forState:UIControlStateNormal];
        }
            break;
        case XUEYANG:
        {
            queyFlag = XUEYANG;
            [xueyangbtn setBackgroundImage:[UIImage imageNamed:@"healthy_list_btn_press.png"] forState:UIControlStateNormal];
        }
            break;
        case BONG:
        {
            queyFlag = BONG;
            [bongbtn setBackgroundImage:[UIImage imageNamed:@"healthy_list_btn_press.png"] forState:UIControlStateNormal];
        }
    }
    
 [self selectQuery:XINDIAN];
}
- (void)cleartitleView
{
    zhibiao.text = @"";
    zhibiaoNumber.text = @"";
    progressView.progressTotal = 100;
    progressView.progressCounter = 0;
   
}
#pragma mark 搜索
- (void)searchTime:(id)sender
{
   searchCondition = [NSString stringWithFormat:@"user_id=%d and CONVERT(varchar(10), cat_date , 120 ) BETWEEN '%@' and '%@'",jkuserManahe.identity,startTimeBtn.text,endTimeBtn.text];
  [self selectQueryByTime];
    
}

#pragma mark 查看预警
- (void)chakanYujings:(id)sender
{
   
    now=NO;
    @try {
    switch (queyFlag) {
        case XUEYA:
        {
            searchTimeBtn.tag = XUEYA;
            searchyujing.tag = XUEYA;
            yujingxiangqing = [NSString stringWithFormat:@"user_id=%d and (pcp >= %d or pcp <=%d or pdp >= %d or pdp <= %d) and  CONVERT(varchar(10),cat_date,120) BETWEEN '%@' and '%@'",jkuserManahe.identity,user.pcpMax,user.pcpMin,user.pdpMax,user.pdpMin,startTimeBtn.text,endTimeBtn.text];
          
        }
            break;
        case XUETANG:
        {
            searchTimeBtn.tag = XUETANG;
            searchyujing.tag = XUETANG;
            yujingxiangqing = [NSString stringWithFormat:@"user_id=%d and (glu >= %f or glu <= %f)and  CONVERT(varchar(10),cat_date,120) BETWEEN '%@' and '%@'",jkuserManahe.identity,user.gluMax,user.gluMin,startTimeBtn.text,endTimeBtn.text];
          
        }
            break;
        case ERWEN:
        {
            searchTimeBtn.tag = ERWEN;
            searchyujing.tag = ERWEN;
             yujingxiangqing = [NSString stringWithFormat:@"user_id=%d and (ear >= %f or ear <= %f)and  CONVERT(varchar(10),cat_date,120) BETWEEN '%@' and '%@'",jkuserManahe.identity,user.earMax,user.earMin,startTimeBtn.text,endTimeBtn.text];
            
           
        }
            break;
        case XINDIAN:
        {
            searchTimeBtn.tag = XINDIAN;
            searchyujing.tag = XINDIAN;
            yujingxiangqing = [NSString stringWithFormat:@"user_id=%d and result!=0 and  CONVERT(varchar(10),cat_date,120) BETWEEN '%@' and '%@'",jkuserManahe.identity,startTimeBtn.text,endTimeBtn.text];
           
        }
            break;
        case XUEYANG:
        {
            searchTimeBtn.tag = XUEYANG;
            searchyujing.tag = XUEYANG;
              yujingxiangqing = [NSString stringWithFormat:@"user_id=%d and  (spo >= 99 OR spo < 95 )  and  CONVERT(varchar(10),cat_date,120) BETWEEN '%@' and '%@'",jkuserManahe.identity,startTimeBtn.text,endTimeBtn.text];
        }
        case BONG:
        {
            searchTimeBtn.tag = BONG;
            searchyujing.tag = BONG;
            yujingxiangqing = [NSString stringWithFormat:@"user_id=%d and  (spo >= 99 OR spo < 95 )  and  CONVERT(varchar(10),cat_date,120) BETWEEN '%@' and '%@'",jkuserManahe.identity,startTimeBtn.text,endTimeBtn.text];
        }
            break;
            
    }
     [self selectQueryByYuJing];
    } @catch (NSException *exception) {
        NSLog(@"exception:%@",exception.description);
    }
    @finally {
//        [commonAction showToast:@"查询失败" WhithNavigationController:self.navigationController];
    }
}

- (void)selectQuery:(int)flags
{
         page = 0;
        now=NO;
        [self.postArray removeAllObjects];
        [self.postView reloadData];

    searchCondition = [NSString stringWithFormat:@"user_id=%d and CONVERT(varchar(10), cat_date , 120 ) BETWEEN '%@' and '%@'",jkuserManahe.identity,startTimeBtn.text,endTimeBtn.text];
    [self selectQueryByTime];
    
         yujingxiangqing = @"";
    
        [postView launchRefreshing];
   
}

//搜索
- (void)selectQueryByTime
{
        [self.postArray removeAllObjects];
        [self.postView reloadData];
       page = 0;
       now = NO;
      yujingxiangqing = @"";
//    searchTimeBtn.tag = flags;
    [postView launchRefreshing];
    
}

//查看预警
- (void)selectQueryByYuJing
{
        page = 0;
        [self.postArray removeAllObjects];
        [self.postView reloadData];
        searchCondition = @"";
    [postView launchRefreshing];
    
}

- (void)initButtonBackGroud
{
    [xueyabtn setBackgroundImage:[UIImage imageNamed:@"healthy_list_btn_normal.png"] forState:UIControlStateNormal];
    [xuetangbtn setBackgroundImage:[UIImage imageNamed:@"healthy_list_btn_normal.png"] forState:UIControlStateNormal];
    [xueyangbtn setBackgroundImage:[UIImage imageNamed:@"healthy_list_btn_normal.png"] forState:UIControlStateNormal];
    [erwenbtn setBackgroundImage:[UIImage imageNamed:@"healthy_list_btn_normal.png"] forState:UIControlStateNormal];
    [xindianbtn setBackgroundImage:[UIImage imageNamed:@"healthy_list_btn_normal.png"] forState:UIControlStateNormal];
    [bongbtn setBackgroundImage:[UIImage imageNamed:@"healthy_list_btn_normal.png"] forState:UIControlStateNormal];
}
- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}
- (void)goBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
