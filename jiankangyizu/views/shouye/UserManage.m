//
//  shouYeView.m
//  jiankangyizu
//
//  Created by apple on 15/2/2.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "UserManage.h"
#import "commonJudgeMent.h"
#import "UerManageListViewCell.h"
#import "commonAction.h"
#import "SDImageView+SDWebCache.h"
#import "UserMessageViewController.h"
#import "JianKangJianHuViewController.h"
#import "GuijijianceController.h"
#import "RDVTabBarController.h"
#import "ChatDetailView.h"
#define  ON  @"1"
#define  OFF @"2"
#define  NETON 3
#define  NETOFF 4
#define  YIJUJUE @"103002"
@interface UserManage ()

@end

@implementation UserManage

@synthesize postView,postArray,page,refreshing;
@synthesize height;
@synthesize wait;
@synthesize connection2;
@synthesize receiveData2;
@synthesize user;
@synthesize itemheight;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    flagarray = [NSMutableArray array];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    self.view.backgroundColor=BACK_COLOR;
    networkFlag = NETON;
   
    postArray=[[NSMutableArray alloc]initWithCapacity:0];
    FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
    dao = [[JkUserManageDao alloc]initWithDbqueue:queue];
    
   
    
    postView=[[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth,[[UIScreen mainScreen] bounds].size.height-64-28.5) pullingDelegate:self];
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
    [backBtn setImage:[UIImage imageNamed:@"common_top_back_icon.png"] forState:UIControlStateNormal];
    backBtn.frame=CGRectMake(0, 0,32, 42);//52, 42
    UILabel *backLabel=[[UILabel alloc]initWithFrame:CGRectMake(32, 0, 200, 42)];
    backLabel.backgroundColor=[UIColor clearColor];
    backLabel.textColor=YINGYONG_COLOR;
    backLabel.textAlignment=NSTextAlignmentLeft;
    backLabel.font=[UIFont boldSystemFontOfSize:23];
    backLabel.text=@"多多健康·用户管理";
    UIView *backView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 42)];
    backView1.backgroundColor=[UIColor clearColor];
    [backView1 addSubview:backBtn];
    [backView1 addSubview:backLabel];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView1];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"群发消息" forState:UIControlStateNormal];
    [rightButton setTitleColor:YINGYONG_COLOR forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:15];
    [rightButton addTarget:self action:@selector(sendAllMessage) forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame=CGRectMake(0, 0,60, 42);//52, 42
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];

}
- (void)sendAllMessage
{
    ChatDetailView *chatDetailView = [[ChatDetailView alloc] init];
    chatDetailView.toMemberId = -1;
    chatDetailView.sendMessageFlag = -1;
    [self.navigationController pushViewController:chatDetailView animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (height==1) {
        postView.frame=CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height-152);
    }
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    now=NO;
    page=0;
    if([postArray count] > 0)
    {
       [postArray removeAllObjects];
        [postView reloadData];
    }
    [postView launchRefreshing];

    
}

-(void)moreData{
    
    if (now==NO) {
        
        [moreButton setTitle:@"" forState:UIControlStateNormal];
        if (wait==nil) {
            wait=[[WaitProgress alloc]initWithFrame:CGRectMake(145, 5, 30, 30)];
        }
        [moreButton addSubview:wait];
        if(networkFlag == NETOFF)
        {
            [postArray removeAllObjects];
            [flagarray removeAllObjects];
            [postView reloadData];
            networkFlag = NETON;
            page = 0;
        }
        if ([commonJudgeMent ifConnectNet]){
            page++;
//            NSString *str1 = [NSString stringWithFormat:@"company_id=%d&user_id=%d",self.user.companyId,self.user.identity];
            NSString  *str =[NSString stringWithFormat:@"company_id=%d&user_id=%d&start_page=%ld&is_page=1&page_size=%d",self.user.companyId,user.identity,(long)page,PAGESIZE];//设置参数
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,GETUSERMANAGELIST_URL]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
            [request setHTTPMethod:@"POST"];
            //        举例：BASEURL//saleout/saleout_list.jsp?sid=10&longitude=0&latitude=0&distance=26400&page_size=2&start_page=1&is_page=1
          
        
            
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            [request setHTTPBody:data];
            //第二步，连接服务器
            now = YES;
            connection2 = [[NSURLConnection alloc]initWithRequest:request delegate:self];
            
        }else{
            networkFlag = NETOFF;
            [postArray removeAllObjects];
            [flagarray removeAllObjects];
            [postView reloadData];
            
            [commonAction showToast:NONETWORK WhithNavigationController:self.navigationController];
            [dao searchWhere:[NSString stringWithFormat:@"companyId=%d",user.companyId] orderBy:@"identity desc" offset:0 count:10000 callback:^(NSArray *array){
                self.postArray=(NSMutableArray *)array;
                 [self setArrayFlag:array];
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
    self.page++;
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
    JkUserManage *health = [self.postArray objectAtIndex:indexPath.row];
    UerManageListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
         cell = [[UerManageListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.itemlable.tag = indexPath.row;
    [cell.itemlable addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.userHeadImg setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",health.headImg]]refreshCache:NO placeholderImage:[UIImage imageNamed:@"icon.png"]];
    cell.userName.text = health.name;
    [cell.warnDetail setTitle:[NSString stringWithFormat:@"%d预警",health.warnNumber] forState:UIControlStateNormal];
    if(health.sex == 0)
    {
        cell.sexAndage.text = [NSString stringWithFormat:@"女 %d岁",health.age];
    }
    else if(health.sex == 1)
    {
        cell.sexAndage.text = [NSString stringWithFormat:@"男 %d岁",health.age];
    }
   
    if(![flagarray[indexPath.row]  isEqual: ON])
    {
        cell.sublable.hidden = NO;
      
        if([health.jkState isEqualToString:YIJUJUE])
        {
            
            cell.jiankanjianhubtn.hidden = NO;
            cell.jiankanjianhubtn.tag = indexPath.row;
            [cell.jiankanjianhubtn addTarget:self action:@selector(jiankangjiancebuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            cell.jiankanjianhubtn.hidden = YES;
        }
        if([health.locusState isEqualToString:YIJUJUE])
        {
            
            cell.guijijiancebtn.hidden = NO;
            cell.guijijiancebtn.tag = indexPath.row;
            [cell.guijijiancebtn addTarget:self action:@selector(guijijianceClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
           cell.guijijiancebtn.hidden = YES;
        }
        if([health.caseState isEqualToString:YIJUJUE])
        {
                       cell.yonghuxinxibth.hidden = NO;
            cell.yonghuxinxibth.tag = indexPath.row;
            [cell.yonghuxinxibth addTarget:self action:@selector(yonghuxinxibuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            cell.yonghuxinxibth.hidden = YES;
            
        }
        cell.jiankanjianhubtn.userInteractionEnabled = YES;
        cell.sublable.userInteractionEnabled = YES;
        cell.incator.image = [UIImage imageNamed:@"comm_salout_more_press.png"];
       
    }
    else
    {
      cell.sublable.hidden = YES;
        cell.incator.image = [UIImage imageNamed:@"comm_salout_more_unpress.png"];
    }
  
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
    
}
- (void)jiankangjiancebuttonClicked:(id)button
{
    UIButton *btn = button;
    JianKangJianHuViewController *jjjhcontroller = [[JianKangJianHuViewController alloc] init];
    jjjhcontroller.jkuserManahe = postArray[btn.tag];
    [self.navigationController pushViewController:jjjhcontroller animated:YES];
    
    }
- (void)guijijianceClicked:(id)button
{
    UIButton *btn = button;
    GuijijianceController *guijijiancecontroller = [[GuijijianceController alloc] init];
    guijijiancecontroller.userMessage = postArray[btn.tag];
    [self.navigationController pushViewController:guijijiancecontroller animated:YES];

}
- (void)yonghuxinxibuttonClicked:(id)button
{
    UIButton *btn = button;
    UserMessageViewController *usermessagecontroller = [[UserMessageViewController alloc] init];
    usermessagecontroller.userManage = postArray[btn.tag];
    [self.navigationController pushViewController:usermessagecontroller animated:YES];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
   //    NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
//    [self.postView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationBottom];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(![flagarray[indexPath.row]  isEqual: ON])
    {
    
        return 130;
        
    }
    else{
         return 80;
    }
    
    
//    [postView reloadData];
   
}

- (void)buttonClick:(UIButton *)button
{
    if([flagarray[button.tag]  isEqual:ON])
    {
       flagarray[button.tag] = OFF;
    }
    else
    {
      flagarray[button.tag] = ON;
    }
    [postView reloadData];
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
//数据传完之后调用此方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
        
        NSArray *objects=[JsonToModel objectsFromDictionaryData:self.receiveData2 className:@"JkUserManage"];
       [self setArrayFlag:objects];
                @autoreleasepool {
        [dao replaceArrayToDB:objects callback:^(BOOL block){
                
            }];
        }
        if ([objects count]== PAGESIZE) {
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
            now=YES;
        }
            firstDone = 1;
//                now=NO;
    
}
- (void)setArrayFlag:(NSArray *)array
{
    int i;
    for(i = 0 ; i < [array count] ;i ++)
    {
        [flagarray addObject:ON];
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
@end
