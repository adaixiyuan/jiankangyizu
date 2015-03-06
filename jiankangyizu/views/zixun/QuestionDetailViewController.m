//
//  QuestionDetailViewController.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-6.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "QuestionDetailViewController.h"
#import "commonJudgeMent.h"
#import "commonAction.h"
#import "SDImageView+SDWebCache.h"
#import "CallBackCell.h"
#import "CommonStr.h"
#import "RDVTabBarController.h"
#import "MyDictionary.h"
@interface QuestionDetailViewController ()

@end

@implementation QuestionDetailViewController
@synthesize jkconsultation;
@synthesize postView,postArray,page,refreshing;
@synthesize height;
@synthesize wait;
@synthesize connection2;
@synthesize receiveData2;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    
    NSData *userData=[[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
    user= [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    now=NO;
    page=0;
    
    postArray=[[NSMutableArray alloc]initWithCapacity:0];
    FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
    JkConsultationDAO* dao = [[JkConsultationDAO alloc]initWithDbqueue:queue];
    [dao searchWhere:[NSString stringWithFormat:@"where  user_id=%d",jkconsultation.identity] orderBy:@"identity desc" offset:0 count:PAGESIZE callback:^(NSArray *array){
        self.postArray=(NSMutableArray *)array;
    }];
    
    postView=[[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth,[[UIScreen mainScreen] bounds].size.height-64) pullingDelegate:self];
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
    [self initTopView];
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
    [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame=CGRectMake(0, 0,52, 42);//52, 42
    UILabel *backLabel=[[UILabel alloc]initWithFrame:CGRectMake(52, 0, 300, 42)];
    backLabel.backgroundColor=[UIColor clearColor];
    backLabel.textColor=YINGYONG_COLOR;
    backLabel.textAlignment=NSTextAlignmentLeft;
    backLabel.font=[UIFont boldSystemFontOfSize:23];
    backLabel.text=@"问题详细";
    UIView *backView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 330, 42)];
    backView1.backgroundColor=[UIColor clearColor];
    [backView1 addSubview:backBtn];
    [backView1 addSubview:backLabel];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView1];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

- (void)goback
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
//            NSData *userData=[[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
//            CommonUser *user= [NSKeyedUnarchiver unarchiveObjectWithData:userData];
            str =[NSString stringWithFormat:@"table_name=jk_consultation&start_page=%d&is_page=1&page_size=%d&condition=parent_id=%d",page,PAGESIZE,jkconsultation.identity];//设置参数
            
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            [request setHTTPBody:data];
            //第二步，连接服务器
            now = YES;
            connection2 = [[NSURLConnection alloc]initWithRequest:request delegate:self];
            
        }else{
           [commonAction showToast:NONETWORK WhithNavigationController:self];
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
    CallBackCell *cell = (CallBackCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
           cell = [[CallBackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.userHeadImg setImageWithURL:[NSURL URLWithString:health.img] refreshCache:NO placeholderImage:[UIImage imageNamed:@"icon.png"]];
    
    cell.userNameAndcallbackdate.text = [NSString stringWithFormat:@"%@ %@",health.addUser,[CommonStr getDateFormLongSince1970:health.addDate]];
    cell.callbackContent.frame = CGRectMake(5, 90, kDeviceWidth, [CommonStr TextSize:health.content].height);
    cell.callbackContent.text = health.content;
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JkConsultation *jkconsu = postArray[indexPath.row];

    return 90+[CommonStr TextSize:jkconsu.content].height+5 ;
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response

{
    
    if(connection==connection2){
        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
      
        self.receiveData2 = [NSMutableData data];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    CaseDetailViewController *caseController = [[CaseDetailViewController alloc] init];
    //    caseController.jkcase = postArray[indexPath.row];
    //    caseController.jkUserManage = userManage;
    //    [self.navigationController pushViewController:caseController animated:YES];
}


- (void)initTopView
{
    topview = [[UIView alloc] init];
    topview.backgroundColor = [UIColor whiteColor];
    UILabel *questtitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, kDeviceWidth, 20)];
    UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(5, 30, 120, 20)];
    UILabel *adddate = [[UILabel alloc] initWithFrame:CGRectMake(130, 30, 100, 20)];
    UILabel *callbackNum = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-70, 30, 70, 20)];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, kDeviceWidth, 1)];
    line.backgroundColor = [UIColor grayColor];
    adddate.font = [UIFont systemFontOfSize:15.0];
    userName.font = [UIFont systemFontOfSize:15.0];
    callbackNum.font = [UIFont systemFontOfSize:15.0];
    userName.textColor = LIGHTBLUECOLOR;
//    UILabel *questioncontent = [[UILabel alloc]initWithFrame:CGRectMake(5, kDeviceWidth/2-51, kDeviceWidth, kDeviceWidth/2-51)];
    UILabel *questioncontent  = [[UILabel alloc] init];
    CGSize textsize = [CommonStr TextSize:jkconsultation.content];
    questioncontent.frame = CGRectMake(5, 80, kDeviceWidth,textsize.height+5);
    imageheigth = 0;
    if(jkconsultation.img !=nil)
    {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80+textsize.height+5, kDeviceWidth, 200)];
        [image setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",jkconsultation.img]]refreshCache:NO placeholderImage:[UIImage imageNamed:@"icon.png"]];
        [topview addSubview:image];
        imageheigth = 200;
        
    }
    UIButton *callbackBtn = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth-90,80+textsize.height+5+imageheigth, 80, 40)];
    [callbackBtn setImage:[UIImage imageNamed:@"club_op_reply_btn.png"] forState:UIControlStateNormal];
    [callbackBtn setTitle:@"回复" forState:UIControlStateNormal];
    [callbackBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [callbackBtn addTarget:self action:@selector(callBack:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 80+textsize.height+5+imageheigth+1+40, kDeviceWidth, 1)];
    line2.backgroundColor = [UIColor lightGrayColor];
    questioncontent.textAlignment = NSTextAlignmentLeft;
    questioncontent.lineBreakMode = UILineBreakModeWordWrap;
    questioncontent.numberOfLines = 0;
    questioncontent.text = jkconsultation.content;
    
    questtitle.text = jkconsultation.content;
    userName.text = jkconsultation.addUser;
    adddate.text = [CommonStr getDateFormLongSince1970:jkconsultation.addDate];
    callbackNum.text = [NSString stringWithFormat:@"%d条回复",jkconsultation.replyCount];
    
    callbackContent = [[UITextField alloc] initWithFrame:CGRectMake(0, 80+textsize.height+5+imageheigth+1+40+1, kDeviceWidth-70, 40)];
    callbackContent.font = [UIFont systemFontOfSize:15.0];
    callbackContent.placeholder = @"回复内容";
        UIToolbar * keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 38.0f)];
        keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
        UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                      target:nil
                                                                                      action:nil];
        
        UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", @"")
                                                                        style:UIBarButtonItemStyleDone
                                                                       target:callbackContent
                                                                       action:@selector(resignFirstResponder)];
        
        [keyboardToolbar setItems:[NSArray arrayWithObjects:spaceBarItem, doneBarItem, nil]];
        callbackContent.inputAccessoryView = keyboardToolbar;
        
    submitbtn = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth-70, 80+textsize.height+5+imageheigth+1+40, 70, 40)];
    submitbtn.hidden = YES;
    callbackContent.hidden = YES;
    [submitbtn addTarget:self action:@selector(sendCallBack) forControlEvents:UIControlEventTouchUpInside];
    [submitbtn setTitle:@"发送" forState:UIControlStateNormal];
    [submitbtn setBackgroundColor:[UIColor lightGrayColor]];
    [submitbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    topview.frame = CGRectMake(0, 0, kDeviceWidth, 120+textsize.height+5+imageheigth+1);
    

    [topview addSubview:questtitle];
    [topview addSubview:userName];
    [topview addSubview:adddate];
    [topview addSubview:line];
    [topview addSubview:callbackNum];
    [topview addSubview:questioncontent];
    [topview addSubview:callbackBtn];
    [topview addSubview:line2];
    
    [topview addSubview:submitbtn];
    [topview addSubview:callbackContent];
    postView.tableHeaderView = topview;
    

}
- (void)callBack:(id)sender
{
   if (submitbtn.hidden==YES && callbackContent.hidden == YES)
   {
       submitbtn.hidden = NO;
       callbackContent.hidden = NO;
       CGRect rect = topview.frame;
       rect.size.height += 40;
       imageheigth += 40;
       topview.frame = rect;
       
      
   }
    else
    {
        
        submitbtn.hidden = YES;
        callbackContent.hidden = YES;
        CGRect rect = topview.frame;
        rect.size.height -= 40;
        imageheigth -= 40;
        topview.frame = rect;
       

    }
    postView.tableHeaderView = topview;
    
}

#pragma mark 回复内容
- (void)sendCallBack
{
    now = NO;
    NSString *huifuneirong = callbackContent.text;
    if([huifuneirong isEqualToString:@""])
    {
       [commonAction showToast:@"请输入回复内容" WhithNavigationController:self.navigationController];
    }
    else
    {
        NSString *urlString = [NSString stringWithFormat:@"%@%@?table_name=jk_consultation&obj.id=%d&obj.reply_count=%d",BASE_URL,SUBMIT_URL,jkconsultation.identity,jkconsultation.replyCount+1];
        
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
                     dispatch_async(dispatch_get_main_queue(), ^{
//                     page = 1;
//                     [self moreData];
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
        
        
        
        
        
        NSMutableArray *urlArray = [[NSMutableArray alloc] init];
        [urlArray addObject:[[MyDictionary alloc] initWithName:@"obj.add_user" Andvale:user.name]];
        [urlArray addObject:[[MyDictionary alloc] initWithName:@"obj.user_id" Andvale:[NSString stringWithFormat:@"%d",user.identity]]];
        
        [urlArray addObject:[[MyDictionary alloc] initWithName:@"obj.content" Andvale:[huifuneirong stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]];
        [urlArray addObject:[[MyDictionary alloc] initWithName:@"obj.parent_id" Andvale:[NSString stringWithFormat:@"%d",jkconsultation.identity]]];

        [urlArray addObject:[[MyDictionary alloc] initWithName:@"obj.department_no" Andvale:jkconsultation.departmentNo]];

        [urlArray addObject:[[MyDictionary alloc] initWithName:@"obj.img" Andvale:user.headImg]];

        NSString *urlString2 = [NSString stringWithFormat:@"table_name=jk_consultation%@",[self objectToUrl:urlArray]];
       

        
        NSURL *url3 = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,SUBMIT_URL]];
        NSMutableURLRequest *request2 = [[NSMutableURLRequest alloc]initWithURL:url3 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        
        [request2 setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
        
        NSData *data = [urlString2 dataUsingEncoding:NSUTF8StringEncoding];
        
        [request2 setHTTPBody:data];
        /*
               同步请求
         */
        @autoreleasepool {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSURLResponse *respons2 = nil;
                NSError *error2 = nil;
                NSData *data = [NSURLConnection sendSynchronousRequest:request2 returningResponse:&respons2 error:&error2];
                
                if(data != nil)
                {
                dispatch_async(dispatch_get_main_queue(), ^{
                     page = 1;
                    [postArray removeAllObjects];
                    [postView reloadData];
                    [self moreData];
                     });
                    
                }
                else if(data == nil && error2 == nil)
                {
                    NSLog(@"接收到空数据");
                }
                else
                {
                    NSLog(@"%@",error2.localizedDescription);
                }
            });
        }


    }


}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
//{
//   
//    CGSize textsize = [CommonStr TextSize:jkconsultation.content];
//    
//       return 120+textsize.height+5+imageheigth+1+40;
//    
//   }
//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    if (connection==connection2) {
        [self.receiveData2 appendData:data];
    }
    
}
//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [wait removeFromSuperview];
    [moreButton setTitle:@"加载失败" forState:UIControlStateNormal];
    [moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    NSLog(@"%@",[error localizedDescription]);
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
//                now=NO;
        //        [postView reloadData];
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

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}
@end
