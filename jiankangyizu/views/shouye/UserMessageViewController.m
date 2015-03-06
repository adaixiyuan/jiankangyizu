//
//  UserMessageViewController.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-5.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "UserMessageViewController.h"
#import "commonJudgeMent.h"
#import "CommonUser.h"
#import "commonAction.h"
#import "userCaseTableViewCell.h"
#import "CommonStr.h"
#import "CaseDetailViewController.h"
#import "RDVTabBarController.h"
#import "ChatDetailView.h"
#define ON 1
#define OFF 2
@interface UserMessageViewController ()

@end

@implementation UserMessageViewController

@synthesize postView,postArray,page,refreshing;
@synthesize height;
@synthesize wait;
@synthesize connection1;
@synthesize connection2;
@synthesize receiveData2;
@synthesize receiveData1;
@synthesize user;
@synthesize userManage;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitle];
    [self initNav];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    self.view.backgroundColor=BACK_COLOR;
    networkFlag = ON;
    now=NO;
    page=0;
     
    postArray=[[NSMutableArray alloc]initWithCapacity:0];
    FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
     dao = [[JkCaseDAO alloc]initWithDbqueue:queue];
    
   
    
    postView=[[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 200, kDeviceWidth,[[UIScreen mainScreen] bounds].size.height-264)
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addTitle
{
    
    UIButton *buttonview = [[UIButton alloc ] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 200)];
    [buttonview setBackgroundImage:[UIImage imageNamed:@"jk_healthy_care_bg.png"] forState:UIControlStateNormal];
    [buttonview setBackgroundImage:[UIImage imageNamed:@"jk_healthy_care_bg.png"] forState:UIControlStateHighlighted];
    UIImageView *userFace = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/2-35, 20, 70, 70)];
    [userFace.layer setCornerRadius:35];
    [userFace.layer setMasksToBounds:YES];
    [userFace setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",userManage.headImg]]refreshCache:NO placeholderImage:[UIImage imageNamed:@"icon.png"]];
    UILabel *username = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, kDeviceWidth, 20)];
    username.textAlignment = NSTextAlignmentCenter;
     username.textColor = [UIColor whiteColor];
    username.text = userManage.name;
    
    UILabel *usermessage = [[UILabel alloc] initWithFrame:CGRectMake(0, 140, kDeviceWidth, 20)];
    usermessage.textAlignment = NSTextAlignmentCenter;
    usermessage.textColor = [UIColor whiteColor];
    if(userManage.sex == 0)
    {
        usermessage.text = [NSString stringWithFormat:@"女/%d岁/%@",userManage.age,userManage.address];
    }
    else if(userManage.sex == 1)
    {
         usermessage.text = [NSString stringWithFormat:@"男/%d岁/%@",userManage.age,userManage.address];
    }
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 165, kDeviceWidth, 2)];
    line.textAlignment = NSTextAlignmentCenter;
    line.textColor = [UIColor whiteColor];
    line.text = @"-----------------------------------------------";
    UILabel *usercase = [[UILabel alloc] initWithFrame:CGRectMake(0, 170, kDeviceWidth, 20)];
    usercase.textAlignment = NSTextAlignmentCenter;
    usercase.textColor = [UIColor whiteColor];
    usercase.text = @"用户病历";
    

    [buttonview addSubview:userFace];
    [buttonview addSubview:username];
    [buttonview addSubview:usermessage];
    [buttonview addSubview:line];
    [buttonview addSubview:usercase];
    [self.view addSubview:buttonview];
}
-(void)initNav{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tb_navbar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"comm_top_button_left.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame=CGRectMake(0, 0,52, 42);//52, 42
    UILabel *backLabel=[[UILabel alloc]initWithFrame:CGRectMake(52, 0, 200, 42)];
    backLabel.backgroundColor=[UIColor clearColor];
    backLabel.textColor=YINGYONG_COLOR;
    backLabel.textAlignment=NSTextAlignmentLeft;
    backLabel.font=[UIFont boldSystemFontOfSize:23];
    backLabel.text=@"用户信息";
    UIView *backView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 42)];
    backView1.backgroundColor=[UIColor clearColor];
    [backView1 addSubview:backBtn];
    [backView1 addSubview:backLabel];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView1];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"发送消息" forState:UIControlStateNormal];
    [rightButton setTitleColor:YINGYONG_COLOR forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:15];
    [rightButton addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame=CGRectMake(0, 0,60, 42);//52, 42
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];

}
- (void)sendMessage
{
    ChatDetailView *chatDetailView = [[ChatDetailView alloc] init];
    chatDetailView.toMemberId = userManage.identity;
    chatDetailView.toMemberHeadImg = userManage.headImg;
    chatDetailView.sendMessageFlag = 1;
    [self.navigationController pushViewController:chatDetailView animated:YES];
}
- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
       
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
        if(networkFlag == OFF)
        {
            [postArray removeAllObjects];
            [postView reloadData];
            networkFlag = ON;
            page = 0;
        }
        if ([commonJudgeMent ifConnectNet]){
             page++;
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,COMMONINDEX_URL]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
            [request setHTTPMethod:@"POST"];
            //        举例：BASEURL//saleout/saleout_list.jsp?sid=10&longitude=0&latitude=0&distance=26400&page_size=2&start_page=1&is_page=1
          
            NSString *str =[NSString stringWithFormat:@"&user_id=%d&start_page=%d&is_page=1&page_size=%d&table_name=%@",userManage.identity,page,PAGESIZE,@"vi_jk_case"];//设置参数
            
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            [request setHTTPBody:data];
            //第二步，连接服务器
            now = YES;
            connection2 = [[NSURLConnection alloc]initWithRequest:request delegate:self];
            
        }else{
            networkFlag = OFF;
            [commonAction showToast:NONETWORK WhithNavigationController:self.navigationController];
            [dao searchWhere:[NSString stringWithFormat:@"userId=%d",userManage.identity] orderBy:@"identity desc" offset:0 count:10000 callback:^(NSArray *array){
                self.postArray=(NSMutableArray *)array;
            }];
            [postView reloadData];
            [wait removeFromSuperview];
            [moreButton setTitle:@"加载完毕" forState:UIControlStateNormal];
            [moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

        }
    }
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
    JkCase *health = [self.postArray objectAtIndex:indexPath.row];
    userCaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[userCaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.CaseDetail.text = health.resultContent;
    cell.caseDate.text = [CommonStr getDateFormLongSince1970:health.caseDate];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CaseDetailViewController *caseController = [[CaseDetailViewController alloc] init];
    caseController.jkcase = postArray[indexPath.row];
    caseController.jkUserManage = userManage;
    [self.navigationController pushViewController:caseController animated:YES];
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
        
        NSArray *objects=[JsonToModel objectsFromDictionaryData:self.receiveData2 className:@"JkCase"];
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
        else if([objects count] < PAGESIZE)
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
            now=NO;
        }
        firstDone = 1;
        //        now=NO;
        //        [postView reloadData];
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


- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    
}
@end
