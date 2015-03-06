//
//  WodeWenTiController.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-15.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "WodeWenTiController.h"
#import "RDVTabBarController.h"
#import "QuestionListCell.h"
#import "CommonStr.h"
#import "QuestionDetailViewController.h"
#define ON 1
#define OFF 2
@interface WodeWenTiController ()

@end

@implementation WodeWenTiController

@synthesize postView,postArray,page,refreshing;
@synthesize height;
@synthesize wait;
@synthesize connection2;
@synthesize receiveData2;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    now=NO;
    page=0;
    networkFlag = ON;
    NSData *userData=[[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
    user= [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    postArray=[[NSMutableArray alloc]initWithCapacity:0];
    FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
    dao = [[JkConsultationDAO alloc]initWithDbqueue:queue];
    postView=[[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth,KDeviceHeight-44) pullingDelegate:self];
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
    backLabel.text=@"我的问题";
    UIView *backView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 330, 42)];
    backView1.backgroundColor=[UIColor clearColor];
    [backView1 addSubview:backBtn];
    [backView1 addSubview:backLabel];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView1];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    self.view.backgroundColor=BACK_COLOR;
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
            networkFlag = ON;
            [postArray removeAllObjects];
            [postView reloadData];
            page = 0;
        }
        if ([commonJudgeMent ifConnectNet]){
             page++;
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,GETZIXUNWENTILIST]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
            [request setHTTPMethod:@"POST"];
            //        举例：BASEURL//saleout/saleout_list.jsp?sid=10&longitude=0&latitude=0&distance=26400&page_size=2&start_page=1&is_page=1
            
          
            NSString *str = [NSString stringWithFormat:@"start_page=%ld&page_size=%d&is_page=1&table_name=jk_consulation&condition= doctor_id=%d",page,PAGESIZE,user.identity];
            
            
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            [request setHTTPBody:data];
            //第二步，连接服务器
            now = YES;
            connection2 = [[NSURLConnection alloc]initWithRequest:request delegate:self];
            
        }else{
            [commonAction showToast:NONETWORK WhithNavigationController:self.navigationController];
            networkFlag = OFF;
            [postArray removeAllObjects];
            [postView reloadData];
            
            [dao searchWhere:[NSString stringWithFormat:@"where  user_id=%d",user.identity] orderBy:@"identity desc" offset:0 count:10000 callback:^(NSArray *array){
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
    
    JkConsultation *health = [self.postArray objectAtIndex:indexPath.row];
    
    QuestionListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[QuestionListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if(health.departmentName == nil)
    {
        cell.questiontitle.text = health.content;
    }
    else
    {
        cell.questiontitle.text = [NSString stringWithFormat:@"[%@]%@",health.departmentName,health.content];
    }
    cell.questiondate.text = [CommonStr getDateFormLongSince1970:health.addDate];
    cell.huifuNumber.text = [NSString stringWithFormat:@"%d条回复",health.replyCount];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response

{
    
    if(connection==connection2){
        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
        NSLog(@"%@",[res allHeaderFields]);
        self.receiveData2 = [NSMutableData data];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionDetailViewController *caseController = [[QuestionDetailViewController alloc] init];
    caseController.jkconsultation = postArray[indexPath.row];
    [self.navigationController pushViewController:caseController animated:YES];
}
//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
 
    
    if (connection==connection2) {
        [self.receiveData2 appendData:data];
    }
    
}
//数据传完之后调用此方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"nsData:%@",self.receiveData2);
    if (connection==connection2) {
       
        @try {
            NSArray *objects=[JsonToModel objectsFromDictionaryData:self.receiveData2 className:@"JkConsultation"];
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
        }else if([objects count] < PAGESIZE){
            [self.postArray addObjectsFromArray:objects];
            [self.postView reloadData];
            [wait removeFromSuperview];
            [moreButton setTitle:@"加载完毕" forState:UIControlStateNormal];
            [moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                        now=YES;
        }
        else
        {
            [wait removeFromSuperview];
            [moreButton setTitle:@"加载完毕" forState:UIControlStateNormal];
            [moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            now = NO;
        }
        }
        @catch (NSException *exception) {
            NSLog(@"error:%@",exception);
        }
        @finally {
            [wait removeFromSuperview];
            [moreButton setTitle:@"加载失败" forState:UIControlStateNormal];
            [moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        firstDone = 1;
//        now=NO;
//        [postView reloadData];
    }
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
-(void)viewWillAppear:(BOOL)animated{
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}


- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIImage*)transformImage:(UIImage *)image Width:(CGFloat)width height:(CGFloat)height {
    
    CGFloat destW = width;
    CGFloat destH = height;
    CGFloat sourceW = width;
    CGFloat sourceH = height;
    
    CGImageRef imageRef = image.CGImage;
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                destW,
                                                destH,
                                                CGImageGetBitsPerComponent(imageRef),
                                                4*destW,
                                                CGImageGetColorSpace(imageRef),
                                                (kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, sourceW, sourceH), imageRef);
    
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage *resultImage = [UIImage imageWithCGImage:ref];
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return resultImage;
}
@end
