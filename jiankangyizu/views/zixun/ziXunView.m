//
//  ziXunView.m
//  jiankangyizu
//
//  Created by apple on 15/2/2.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "ziXunView.h"
#import "SDImageView+SDWebCache.h"
#import "commonJudgeMent.h"

#import "commonAction.h"
#import "CommonStr.h"
#import "QuestionListCell.h"
#import "QuestionDetailViewController.h"
#import "JkDepartment.h"
#import "WodeShouQuanController.h"
#import "WodeWenTiController.h"
#define ALLDEPARTMENT 1
#define ALLQUESTIONS 2
#define WODESHOUQUAN 3
#define WODEWENTI 4
#define ON 1
#define OFF 2


@interface ziXunView ()

@end

@implementation ziXunView
@synthesize postView,postArray,page,refreshing;
@synthesize height;
@synthesize wait;
@synthesize connection2;
@synthesize receiveData2;
@synthesize alert;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    networkFlag = ON;
    dataList = [[NSMutableArray alloc] init];
    departmentNo = @"";
    questionFlag = 0;
    queryCondition =  @"parent_id=0 and doctor_id is null";
    NSDictionary *diction = [NSDictionary dictionaryWithObject:@"全部问题" forKey:@"0001"];
    NSDictionary *diction1 = [NSDictionary dictionaryWithObject:@"已回复"forKey:@"0002"];
    NSDictionary *diction2 = [NSDictionary dictionaryWithObject:@"未回复" forKey:@"0003"];
    [dataList addObject:diction];
    [dataList addObject:diction1];
    [dataList addObject:diction2];
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    queryFlag = @"all";
   
    UIButton *wodewentibtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth/2-0.5, 100)];
     wodewentibtn.backgroundColor = [UIColor whiteColor];
    UIImage *wodewentiimage = [UIImage imageNamed:@"jk_wodewenti_bt.png"] ;
    [wodewentibtn setImage:wodewentiimage forState:UIControlStateNormal];
   
    [wodewentibtn setTitle:@"我的问题" forState:UIControlStateNormal];
    [wodewentibtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    wodewentibtn.tag = WODEWENTI;
    [wodewentibtn addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [wodewentibtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    [wodewentibtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
     wodewentibtn.imageEdgeInsets = UIEdgeInsetsMake((100-54)/2, (kDeviceWidth/2-40)/2, 0, 0);
     wodewentibtn.titleEdgeInsets = UIEdgeInsetsMake((100-54)/2+39,-45,0, 0);
     wodewentibtn.titleLabel.textColor = [UIColor blackColor];
    [wodewentibtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIButton *wodeguanzhubtn = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/2+0.5, 0, kDeviceWidth/2-0.5, 100)];
    wodeguanzhubtn.backgroundColor = [UIColor whiteColor];
    UIImage *wodeguanzhuimage = [UIImage imageNamed:@"jk_wodeguanzhu_bt.png"] ;
    [wodeguanzhubtn setImage:wodeguanzhuimage forState:UIControlStateNormal];
    [wodeguanzhubtn setTitle:@"我的授权" forState:UIControlStateNormal];
    [wodeguanzhubtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [wodeguanzhubtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    wodeguanzhubtn.imageEdgeInsets = UIEdgeInsetsMake((100-54)/2, (kDeviceWidth/2-40)/2, 0, 0);
    wodeguanzhubtn.tag = WODESHOUQUAN;
    [wodeguanzhubtn addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    wodeguanzhubtn.titleEdgeInsets = UIEdgeInsetsMake((100-54)/2+39,-45,0, 0);
    wodeguanzhubtn.titleLabel.textColor = [UIColor blackColor];
    [wodeguanzhubtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UILabel *wodewentilabe = [[UILabel alloc] initWithFrame:CGRectMake(5, 100, kDeviceWidth, 40)];
    wodewentilabe.textColor = LIGHTBLUECOLOR;
    wodewentilabe.textAlignment=NSTextAlignmentLeft;
    wodewentilabe.text = @"咨询问题";
    
    quanbukeshibtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 140, kDeviceWidth/2-0.5, 44)];
    [quanbukeshibtn setTitle:@"全部科室" forState:UIControlStateNormal];
    [quanbukeshibtn setTitleColor:LIGHTBLUECOLOR forState:UIControlStateNormal];
    [quanbukeshibtn setBackgroundColor:[UIColor whiteColor]];
    [quanbukeshibtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [quanbukeshibtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    [quanbukeshibtn setImage:[UIImage imageNamed:@"jk_zixunzhishi_bg.png"] forState:UIControlStateNormal];
    quanbukeshibtn.tag = ALLDEPARTMENT;

    [quanbukeshibtn addTarget:self action:@selector(queryBySelected:) forControlEvents:UIControlEventTouchUpInside];
     [quanbukeshibtn setTitleEdgeInsets:UIEdgeInsetsMake(10, 0, 0, 0)];
     [quanbukeshibtn setImageEdgeInsets:UIEdgeInsetsMake(10, 140, 0, 0)];
    
    quanbuwentibtn = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/2+0.5, 140, kDeviceWidth/2-0.5, 44)];
    [quanbuwentibtn setTitle:@"全部问题" forState:UIControlStateNormal];
    [quanbuwentibtn setTitleColor:LIGHTBLUECOLOR forState:UIControlStateNormal];
    [quanbuwentibtn setBackgroundColor:[UIColor whiteColor]];
    [quanbuwentibtn setImage:[UIImage imageNamed:@"jk_zixunzhishi_bg.png"] forState:UIControlStateNormal];
    quanbuwentibtn.tag = ALLQUESTIONS;
    [quanbuwentibtn addTarget:self action:@selector(queryBySelected:) forControlEvents:UIControlEventTouchUpInside];
    [quanbuwentibtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [quanbuwentibtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    [quanbuwentibtn setTitleEdgeInsets:UIEdgeInsetsMake(10, 0, 0, 0)];
    [quanbuwentibtn setImageEdgeInsets:UIEdgeInsetsMake(10, 140, 0, 0)];
    
    
    
    [self.view addSubview:wodewentibtn];
    [self.view addSubview:wodeguanzhubtn];
    [self.view addSubview:wodewentilabe];
    [self.view addSubview:quanbukeshibtn];
    [self.view addSubview:quanbuwentibtn];
    
    now=NO;
    page=-1;
    
    postArray=[[NSMutableArray alloc]initWithCapacity:0];
    FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
     dao = [[JkConsultationDAO alloc]initWithDbqueue:queue];
        departmentList = [[NSMutableArray alloc] init];
    JkDepartmentDAO *departmentdao = [[JkDepartmentDAO alloc] initWithDbqueue:queue];
    [departmentdao searchAll:^(NSArray *array){
        int i;
        for (i = 0; i < [array count]; i++) {
            JkDepartment *department = array[i];
            [departmentList addObject:[NSDictionary dictionaryWithObject:department.name forKey:department.no]];
            
        }
    }];
    postView=[[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 185, kDeviceWidth,KDeviceHeight-185-64) pullingDelegate:self];
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
    [postView launchRefreshing];
    
}
    

-(void)initNav{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tb_navbar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"common_top_back_icon.png"] forState:UIControlStateNormal];
    backBtn.frame=CGRectMake(0, 0,30.5, 42);//52, 42
    UILabel *backLabel=[[UILabel alloc]initWithFrame:CGRectMake(32, 0, 300, 42)];
    backLabel.backgroundColor=[UIColor clearColor];
    backLabel.textColor=YINGYONG_COLOR;
    backLabel.textAlignment=NSTextAlignmentLeft;
    backLabel.font=[UIFont boldSystemFontOfSize:23];
    backLabel.text=@"多多健康·咨询";
    UIView *backView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 330, 42)];
    backView1.backgroundColor=[UIColor clearColor];
    [backView1 addSubview:backBtn];
    [backView1 addSubview:backLabel];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView1];
    self.navigationItem.leftBarButtonItem = backButtonItem;
     self.view.backgroundColor=BACK_COLOR;
}

#pragma mark 全部问题和全部科室点击查询
- (void)queryBySelected:(id)sender
{
    
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case ALLQUESTIONS:
        {
                departmentNo = @"";
                self.alert = [MLTableAlert tableAlertWithTitle:@"选择框" cancelButtonTitle:@"关闭" numberOfRows:^NSInteger (NSInteger section)
                          {
                              if ([dataList count] == 0)
                                  return 1;
                              else
                                  return [dataList count];
                          }
                andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                          {
                              static NSString *CellIdentifier = @"CellIdentifier";
                              UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                              NSDictionary *diction = dataList[indexPath.row];
                                  NSString *key = [diction allKeys][0];
                                  NSString *value = [diction objectForKey:key];
                              if (cell == nil)
                                  cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                              //输入值
                              cell.textLabel.text = value;
                                                           return cell;
                          }];
            
            // Setting custom alert height'
           ;
            if (44 *[postArray count] > 350)
            {
             self.alert.height = 350;
            }
            else
            {
              self.alert.height = 44 *[postArray count];
            }
            
            // 返回值
            [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex){
                NSDictionary *diction = dataList[selectedIndex.row];
                NSString *key = [diction allKeys][0];
                NSString *value = [diction objectForKey:key];
                [quanbuwentibtn setTitle:value forState:UIControlStateNormal];
                [self clearList];
                 questionFlag = [key intValue];
                [self moreData];
             } andCompletionBlock:^{
                
            }];
             [self.alert show];
        }
            break;
            
        case ALLDEPARTMENT:
        {
                      questionFlag = 0;
                      self.alert = [MLTableAlert tableAlertWithTitle:@"Choose an option..." cancelButtonTitle:@"关闭" numberOfRows:^NSInteger (NSInteger section)
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
            
            if (44 *[postArray count] > 350)
            {
                self.alert.height = 350;
            }
            else
            {
                self.alert.height = 44 *[postArray count];
            }

            
            // 返回值
            [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex){
                NSDictionary *diction = departmentList[selectedIndex.row];
                NSString *key = [diction allKeys][0];
                NSString *value = [diction objectForKey:key];
              [quanbukeshibtn setTitle:value forState:UIControlStateNormal];
                [self clearList];
                 departmentNo = key;
                [self moreData];
                
            } andCompletionBlock:^{
                
            }];
             [self.alert show];
        }
            break;
    }
}

- (void)clearList
{
     now=NO;
     page = 0;
    
    [postArray removeAllObjects];
    [postView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)viewWillAppear:(BOOL)animated{
    if (height==1) {
        postView.frame=CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height-152);
    }
 [self.navigationController setNavigationBarHidden:NO animated:NO];
       now = NO;
       page = 0;
       questionFlag = 0;
       departmentNo = @"";
    [postArray removeAllObjects];
    [postView reloadData];
    [self moreData];
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
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,GETZIXUNWENTILIST]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
            [request setHTTPMethod:@"POST"];
            //        举例：BASEURL//saleout/saleout_list.jsp?sid=10&longitude=0&latitude=0&distance=26400&page_size=2&start_page=1&is_page=1
            NSString *str;
            NSData *userData=[[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
            CommonUser *user= [NSKeyedUnarchiver unarchiveObjectWithData:userData];
            NSString *queryselection = @"parent_id=0 and doctor_id is null ";
            if(departmentNo != @"")
            {
                queryCondition = [NSString stringWithFormat:@"%@ and jc.department_no='%@' ",queryselection,departmentNo];
            }
           if(questionFlag != 0)
           {
                switch (questionFlag) {
                    case 0001:
                    {
                      queryCondition =  @"parent_id=0 and doctor_id is null";
                    }
                    break;
                    case 0002:
                    {
                         queryCondition = [NSString stringWithFormat:@"%@ and reply_count > 0",queryselection];
                    }
                    break;
                    case 0003:
                    {
                         queryCondition = [NSString stringWithFormat:@"%@ and reply_count <= 0",queryselection];
                    }
                    break;
                }
            }
            
            str =[NSString stringWithFormat:@"company_id=%d&start_page=%d&is_page=1&page_size=%d&flag=%@&condition=%@",user.companyId,page,PAGESIZE,queryFlag,queryCondition];//设置参数
            NSLog(@"string url:%@",str);
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            [request setHTTPBody:data];
            //第二步，连接服务器
//            now = YES;
            connection2 = [[NSURLConnection alloc]initWithRequest:request delegate:self];
            
        }else{
            networkFlag = OFF;
           [commonAction showToast:NONETWORK WhithNavigationController:self.navigationController];
            [postArray removeAllObjects];
            [postView reloadData];
            [dao searchWhere:@"" orderBy:@"identity desc" offset:0 count:10000 callback:^(NSArray *array)
            {
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
    self.refreshing = YES;
    [self performSelector:@selector(moreData) withObject:nil afterDelay:1.f];
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
    QuestionDetailViewController *caseController = [[QuestionDetailViewController alloc] init];
    caseController.jkconsultation = postArray[indexPath.row];
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
        
        NSArray *objects=[JsonToModel objectsFromDictionaryData:self.receiveData2 className:@"JkConsultation"];
        FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
        JkConsultationDAO* dao = [[JkConsultationDAO alloc]initWithDbqueue:queue];
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
        }else if([objects count] < PAGESIZE){
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

#pragma mark  我的授权 我的问题
-(void)ButtonClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case WODEWENTI:
        {
            WodeWenTiController *wodeWenti = [[WodeWenTiController alloc] init];
            [self.navigationController pushViewController:wodeWenti animated:YES];
        }
            break;
            
        case WODESHOUQUAN:
        {
            WodeShouQuanController *wodeshouquan = [[WodeShouQuanController alloc] init];
            [self.navigationController pushViewController:wodeshouquan animated:YES];
          
        }
            break;
    }

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
