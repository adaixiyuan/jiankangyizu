//
//  fuwu.m
//  jiankangyizu
//
//  Created by apple on 15/2/2.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "Knowledge.h"
#import "commonJudgeMent.h"
#import "CommonStr.h"
#import "commonAction.h"
#import "JkNews.h"
#import "KnowledgeCell.h"
#import "SDImageView+SDWebCache.h"
#import "MLTableAlert.h"
#import "JkDepartment.h"
#import "KnowlegeDetailView.h"
#import "KnowledgeAddView.h"
@interface Knowledge ()
{
    MLTableAlert *alert;
    NSMutableArray *departmentList;
    NSString *departmentNo;
    UIButton *quanbukeshibtn;
}
@end

@implementation Knowledge

@synthesize postView,postArray,page,refreshing;
@synthesize height;
@synthesize wait;
@synthesize connection2;
@synthesize receiveData2;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNav];
    [self initView];
    
    departmentList = [[NSMutableArray alloc] init];
    departmentNo = @"";
   
    now=NO;
    page=0;
    postArray=[[NSMutableArray alloc]initWithCapacity:0];
    FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
    JkNewsDAO* dao = [[JkNewsDAO alloc]initWithDbqueue:queue];
    [dao searchAll:^(NSArray *array){
        self.postArray=(NSMutableArray *)array;
    }];
    
    JkDepartmentDAO *departmentdao = [[JkDepartmentDAO alloc] initWithDbqueue:queue];
    [departmentdao searchAll:^(NSArray *array){
        int i;
        for (i = 0; i < [array count]; i++) {
            JkDepartment *department = array[i];
            [departmentList addObject:[NSDictionary dictionaryWithObject:department.name forKey:department.no]];
            
        }
    }];

    
    postView=[[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 45, kDeviceWidth,[[UIScreen mainScreen] bounds].size.height-64-28.5) pullingDelegate:self];
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
-(void)initView{
     quanbukeshibtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 44)];
    [quanbukeshibtn setTitle:@"全部科室" forState:UIControlStateNormal];
    [quanbukeshibtn setTitleColor:LIGHTBLUECOLOR forState:UIControlStateNormal];
    [quanbukeshibtn setBackgroundColor:[UIColor whiteColor]];
    [quanbukeshibtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [quanbukeshibtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [quanbukeshibtn setImage:[UIImage imageNamed:@"jk_zixunzhishi_bg.png"] forState:UIControlStateNormal];
    [quanbukeshibtn addTarget:self action:@selector(queryBySelected) forControlEvents:UIControlEventTouchUpInside];
    [quanbukeshibtn setTitleEdgeInsets:UIEdgeInsetsMake(10, 0, 0, 0)];
    [quanbukeshibtn setImageEdgeInsets:UIEdgeInsetsMake(10, kDeviceWidth-20, 0, 0)];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, kDeviceWidth, 1)];
    line.backgroundColor = BACK_COLOR;
    [quanbukeshibtn addSubview:line];
    [self.view addSubview:quanbukeshibtn];
}


//选择科室
- (void)queryBySelected
{
   
    alert = [MLTableAlert tableAlertWithTitle:@"Choose an option..." cancelButtonTitle:@"关闭" numberOfRows:^NSInteger (NSInteger section)
                  {
                      if ([departmentList count] == 0)
                          return 1;
                      else
                          return [departmentList count];
                  }
                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      NSDictionary *diction = departmentList[indexPath.row];
                      NSString *key = [diction allKeys][0];
                      NSString *value = [diction objectForKey:key];
                      if (cell == nil)
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                      //输入值
                      cell.textLabel.text = value;
                      
                      return cell;
                  }];
    
    // Setting custom alert height
    
    if (44 *[departmentList count] > 350)
    {
        alert.height = 350;
    }
    else
    {
        alert.height = 44 *[departmentList count];
    }
    
    
    // 返回值
    [alert configureSelectionBlock:^(NSIndexPath *selectedIndex){
        NSDictionary *diction = departmentList[selectedIndex.row];
        NSString *key = [diction allKeys][0];
        NSString *value = [diction objectForKey:key];
        [quanbukeshibtn setTitle:value forState:UIControlStateNormal];
        if(departmentNo != key)
        {
            [postArray removeAllObjects];
            [postView reloadData];
        }
        departmentNo = key;
        [self moreData];
        
    } andCompletionBlock:^{
        
    }];
    [alert show];

}
-(void)initNav{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tb_navbar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"common_top_back_icon.png"] forState:UIControlStateNormal];
    backBtn.frame=CGRectMake(0, 0,30.5, 42);//52, 42
    
    UIButton *addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"＋添加" forState:UIControlStateNormal];
     addBtn.frame=CGRectMake(0, 0,70.5, 42);
    [addBtn setTitleColor:YINGYONG_COLOR forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addNews) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *backLabel=[[UILabel alloc]initWithFrame:CGRectMake(32, 0, kDeviceWidth-41, 42)];
    backLabel.backgroundColor=[UIColor clearColor];
    backLabel.textColor=YINGYONG_COLOR;
    backLabel.textAlignment=NSTextAlignmentLeft;
    backLabel.font=[UIFont boldSystemFontOfSize:23];
    backLabel.text=@"多多健康·知识库";
    UIView *backView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth-71, 42)];
    backView1.backgroundColor=[UIColor clearColor];
    [backView1 addSubview:backBtn];
    [backView1 addSubview:backLabel];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView1];
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = addButtonItem;
    self.navigationItem.leftBarButtonItem = backButtonItem;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
-(void)moreData{
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
            NSString *str;
            if(![departmentNo isEqual:@""])
            {
               str =[NSString stringWithFormat:@"table_name=vi_news&start_page=%ld&is_page=1&page_size=%d&condition=department_no=%@",page,PAGESIZE,departmentNo];//设置参数
            }
            else
            {
            str =[NSString stringWithFormat:@"table_name=vi_news&start_page=%ld&is_page=1&page_size=%d",page,PAGESIZE];//设置参数
            }
            
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            [request setHTTPBody:data];
            //第二步，连接服务器
            now = YES;
            connection2 = [[NSURLConnection alloc]initWithRequest:request delegate:self];
            
        }else{
            [commonAction showToast:NONETWORK];
        }
    }
}

- (void)loadData{
    if (now==NO) {
        if (self.refreshing) {
            self.refreshing = NO;
            [self moreData];
        }
        [self.postView tableViewDidFinishedLoading];
        [moreButton setTitle:@"点击加载更多" forState:UIControlStateNormal];
        [moreButton setTitleColor:BUTTON_COLOR forState:UIControlStateNormal];
    }
}

-(void)reloadPostView{
    [self.postView launchRefreshing];
}

//添加知识库
- (void)addNews
{
    KnowledgeAddView *knowledgeadd = [[KnowledgeAddView alloc] init];
    [self.navigationController pushViewController:knowledgeadd animated:YES];

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
    JkNews *health = [self.postArray objectAtIndex:indexPath.row];
     KnowledgeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[KnowledgeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.newsTitleImg setImageWithURL:[NSURL URLWithString:health.img] refreshCache:NO placeholderImage:[UIImage imageNamed:@"icon.png"]];
    [cell.keshiName setTitle:health.name forState:UIControlStateNormal];
    cell.summary.text = health.title;
    cell.detail.text = health.content;
    cell.newsDate.text  = [CommonStr getDateFormLongSince1970:health.addDate];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KnowlegeDetailView *knowledgedetail = [[KnowlegeDetailView alloc] init];
    knowledgedetail.jknews = postArray[indexPath.row];
    [self.navigationController pushViewController:knowledgedetail animated:YES];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 100;
        
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
    
    
    NSArray *objects=[JsonToModel objectsFromDictionaryData:self.receiveData2 className:@"JkNews"];
    
    FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
    JkNewsDAO* dao = [[JkNewsDAO alloc]initWithDbqueue:queue];
    @autoreleasepool {
        [dao replaceArrayToDB:objects callback:^(BOOL block){
            
        }];
    }
    if ([objects count]>0) {
        [self.postArray addObjectsFromArray:objects];
        [self.postView reloadData];
        [wait removeFromSuperview];
        [moreButton setTitle:@"点击加载更多" forState:UIControlStateNormal];
        [moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        now=NO;
    }else{
        [wait removeFromSuperview];
        [moreButton setTitle:@"加载完毕" forState:UIControlStateNormal];
        [moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        now=YES;
    }
    firstDone = 1;
            now=NO;
    
}
//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}


@end
