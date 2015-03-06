
//
//  WarnNumberDeailViewViewController.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-3.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "WarnNumberDeailViewController.h"
#import "JkHealthy.h"
#import "commonJudgeMent.h"
#import "commonAction.h"
#import "WarnDetailCellTableViewCell.h"
#import "HealthanalysisTool.h"
#import "RDVTabBarController.h"
#import "CommonStr.h"
#define ON 1
#define OFF 2
/*
 *	public static final int Bp=1;//血压
	public static final int Glu=2;//血糖
	public static final int Ear=3;//耳温
	public static final int Bong=4;//耳温
	public static final int Oxi=5; //血氧
	public static final int Ecg=6; //心电
 */

@interface WarnNumberDeailViewController ()

@end

@implementation WarnNumberDeailViewController
@synthesize postView,postArray,page,refreshing;
@synthesize height;
@synthesize wait;
@synthesize connection1;
@synthesize connection2;
@synthesize receiveData2;
@synthesize receiveData1;
@synthesize titles;
@synthesize tableName;
@synthesize healthFlag;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    NSData *userData=[[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
    user= [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    self.view.backgroundColor=BACK_COLOR;
    FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
    dao = [[JkHealthyDAO alloc]initWithDbqueue:queue];
    
    now=NO;
    page=0;
    networkFlag = ON;
    postArray=[[NSMutableArray alloc]initWithCapacity:0];
//      NSLog(@"%f",self.view.frame.size.height);
    
    postView=[[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth,[[UIScreen mainScreen] bounds].size.height-64)
                                           pullingDelegate:self];
    postView.delegate=self;
    postView.dataSource=self;
    postView.backgroundColor=BACK_COLOR;
    postView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:postView];
    UIView *footer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    moreButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [moreButton setTitle:@"点击加载更多" forState:UIControlStateNormal];
    [moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(moreData) forControlEvents:UIControlEventTouchUpInside];
     moreButton.frame=CGRectMake(0, 0, 320, 44);
    [footer addSubview:moreButton];
    self.postView.tableFooterView=footer;
    [self moreData];

}
-(void)initNav{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tb_navbar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"comm_top_button_left.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    
    backBtn.frame=CGRectMake(0, 0,52, 42);//52, 42
    UILabel *backLabel=[[UILabel alloc]initWithFrame:CGRectMake(52, 0, 300, 42)];
    backLabel.backgroundColor=[UIColor clearColor];
    backLabel.textColor=YINGYONG_COLOR;
    backLabel.textAlignment=NSTextAlignmentLeft;
    backLabel.font=[UIFont boldSystemFontOfSize:23];
    backLabel.text= titles;
    UIView *backView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 330, 42)];
    backView1.backgroundColor=[UIColor clearColor];
    [backView1 addSubview:backBtn];
    [backView1 addSubview:backLabel];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView1];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}


-(void)viewWillAppear:(BOOL)animated{
    if (height==1) {
        postView.frame=CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height-152);
    }
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

-(void)moreData{
    if (now==NO) {
        [moreButton setTitle:@"" forState:UIControlStateNormal];
        if (wait==nil) {
            wait=[[WaitProgress alloc]initWithFrame:CGRectMake(145, 5, 30, 30)];
        }
        [moreButton addSubview:wait];
        if(networkFlag == OFF) //如果网络第一次恢复了 清除缓存
        {
            [postArray removeAllObjects];
            [postView reloadData];
            networkFlag = NO;
            page = 0;
        }
        if ([commonJudgeMent ifConnectNet]){
              page++;
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,GETWARNNUMBERDETAIL_URL]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
            [request setHTTPMethod:@"POST"];
            //        举例：BASEURL//saleout/saleout_list.jsp?sid=10&longitude=0&latitude=0&distance=26400&page_size=2&start_page=1&is_page=1
            NSString *str;
          
            str =[NSString stringWithFormat:@"company_id=%d&user_id=%d&start_page=%d&is_page=1&page_size=%d&health_flg=%d&table_name=%@",user.companyId,user.identity,page,PAGESIZE,healthFlag,tableName];//设置参数
            
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            [request setHTTPBody:data];
            //第二步，连接服务器
            now = YES;
            connection2 = [[NSURLConnection alloc]initWithRequest:request delegate:self];
     
        }else{
            networkFlag = OFF;
            [postArray removeAllObjects];
            [postView reloadData];
            [dao searchWhere:[NSString stringWithFormat:@" healthFlag=%d and userId=%d",healthFlag,user.identity] orderBy:@"identity desc" offset:0 count:10000 callback:^(NSArray *array){
                self.postArray=(NSMutableArray *)array;
            }];
            [postView reloadData];
            [wait removeFromSuperview];
            [moreButton setTitle:@"加载完毕" forState:UIControlStateNormal];
            [moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

             [commonAction showToast:NONETWORK WhithNavigationController:self.navigationController];
        }
    }
}

- (void)loadData{
    [postView tableViewDidFinishedLoadingWithMessage:@""];
    self.page++;
    if (self.refreshing) {
        self.page = 1;
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
     self.navigationController.navigationBar.hidden = YES;

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
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld",indexPath.row];
    JkHealthy *health = [self.postArray objectAtIndex:indexPath.row];
    WarnDetailCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
       cell = [[WarnDetailCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.userHeadImg setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",health.headImg]]refreshCache:NO placeholderImage:[UIImage imageNamed:@"icon.png"]];
    cell.userName.text = health.usern;
    if(health.sex == 0)
    {
        cell.sexAndage.text = [NSString stringWithFormat:@"女 %d岁",health.age];
    }
    else if(health.sex == 1)
    {
        cell.sexAndage.text = [NSString stringWithFormat:@"男 %d岁",health.age];
    }
    cell.warnTime.text = [CommonStr getDateFormLongSince1970:health.catDate];
    switch (healthFlag) {
        case 1:  //血压
            [cell.warnDetail setTitle:[[HealthanalysisTool analysisBpBySettingwithPcp:health.pcp andPdp:health.pdp] meaage] forState:UIControlStateNormal]  ;
            cell.warnNumber.text = [NSString stringWithFormat:@"%d %d",health.pcp,health.pdp];
             break;
            
        case 2:  //血糖
              [cell.warnDetail setTitle:[[HealthanalysisTool analysisGluBySetting:health.glu] meaage] forState:UIControlStateNormal]  ;
            cell.warnNumber.text = [NSString stringWithFormat:@"%0.2f",health.glu];

            break;
        case 3:  //耳温
              [cell.warnDetail setTitle:[[HealthanalysisTool analysisEarBySetting:health.ear] meaage] forState:UIControlStateNormal]  ;
            cell.warnNumber.text = [NSString stringWithFormat:@"%0.2f",health.ear];
            break;
    }
    
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response

{
//    if (connection==connection1) {
//        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
//        NSLog(@"%@",[res allHeaderFields]);
//        self.receiveData1 = [NSMutableData data];
//    }else
    if(connection==connection2){
        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
        NSLog(@"%@",[res allHeaderFields]);
        self.receiveData2 = [NSMutableData data];
    }
}

//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
//    if (connection==connection1) {
//        [self.receiveData1 appendData:data];
//    }else
    if (connection==connection2) {
        [self.receiveData2 appendData:data];
    }
    
}
//数据传完之后调用此方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection==connection2) {
//        NSString *receiveStr = [[NSString alloc]initWithData:self.receiveData2 encoding:NSUTF8StringEncoding];
//        NSLog(@"返回的结果2%@",receiveStr);
        
        NSArray *objects=[JsonToModel objectsFromDictionaryData:self.receiveData2 className:@"JkHealthy"];
        @autoreleasepool {
            [dao replaceArrayToDB:objects callback:^(BOOL block){
                
            }];
        }
        if ([objects count]==PAGESIZE) {
            [self.postArray addObjectsFromArray:objects];
            [self.postView reloadData];
            [wait removeFromSuperview];
            [moreButton setTitle:@"点击加载更多" forState:UIControlStateNormal];
            [moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
             now=NO;
        }
        else if([objects count]< PAGESIZE)
        {
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
             now=YES;
        }
        firstDone = 1;
//      now=NO;
//      [postView reloadData];
    }
}

//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [wait removeFromSuperview];
    [moreButton setTitle:@"加载完毕" forState:UIControlStateNormal];
    [moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    NSLog(@"%@",[error localizedDescription]);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}



- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}
@end
