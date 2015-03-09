//
//  zhiShiKuList.m
//  jiankangyizu
//
//  Created by apple on 15/2/8.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "zhiShiKuList.h"

@interface zhiShiKuList ()

@end


#import "commonAction.h"
#import "commonJudgeMent.h"
#import "CommonStr.h"
#import "SDImageView+SDWebCache.h"

#import "zhiShiKuCell.h"
//#import "relationDetail.h"
#import "zhishikuDetail.h"
#import "zhishikuAdd.h"
//#import "wodeGuanZhuAdd.h"
#define ON 1
#define OFF 2

@implementation zhiShiKuList
@synthesize receiveData1;
@synthesize receiveData2;
@synthesize connection1;
@synthesize connection2;
@synthesize islach;
@synthesize refreshing;
@synthesize page;
@synthesize user;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACK_COLOR;
    [self initData];
    [self initNav];
    [self initchaxun];
    [self initTableView];
    // Do any additional setup after loading the view.
}
-(void)initData{
    conditionString =@"";
    networkFlag = ON;
    NSData *userData=[[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
    user= [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    NSNumber *userId= [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    user.identity = userId.intValue;
    FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
    dao = [[JkNewsDAO alloc]initWithDbqueue:queue];

}

-(void)initNav{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tb_navbar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"common_top_back_icon.png"] forState:UIControlStateNormal];
    backBtn.frame=CGRectMake(0, 0,30.5, 42);//52, 42
    UILabel *backLabel=[[UILabel alloc]initWithFrame:CGRectMake(32, 0, 200, 42)];
    backLabel.backgroundColor=[UIColor clearColor];
    backLabel.textColor=YINGYONG_COLOR;
    backLabel.textAlignment=NSTextAlignmentLeft;
    backLabel.font=[UIFont boldSystemFontOfSize:23];
    backLabel.text=@"多多健康.知识库";
    UIView *backView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 160, 42)];
    backView1.backgroundColor=[UIColor clearColor];
    [backView1 addSubview:backBtn];
    [backView1 addSubview:backLabel];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView1];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"添加" forState:UIControlStateNormal];
    [rightButton setTitleColor:YINGYONG_COLOR forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:20];
    [rightButton addTarget:self action:@selector(tianjia) forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame=CGRectMake(0, 0,50, 42);//52, 42
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    
}

-(void)tianjia{
    
    zhishikuAdd *add = [[zhishikuAdd alloc]init];
    [self.navigationController pushViewController:add animated:YES];
}
-(void)initchaxun{
    tableViewWithOutHeight = 44;
    topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 44)];
    topView.backgroundColor = [UIColor clearColor];
    topView.frame =CGRectMake(0, 0, kDeviceWidth, tableViewWithOutHeight);
    [self.view addSubview:topView];
    
    topView.backgroundColor=[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];
    UIView *pingluView = [[UIView alloc]initWithFrame:CGRectMake(10, 5, kDeviceWidth-30-50, 34)];
    pingluView.backgroundColor = [UIColor clearColor];
    UIImageView *pinglunbackImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth-30-50, 34)];
    pinglunbackImageView.image=  [[UIImage imageNamed:@"chanpinzhongxin_cell_back.png"]stretchableImageWithLeftCapWidth:12.5 topCapHeight:7.5];
    [pingluView addSubview:pinglunbackImageView];
    
    UIImageView *pinglunImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 15, 15)];
    pinglunImage.image = [UIImage imageNamed:@"btn_search_left_normal.png"];
    [pingluView addSubview:pinglunImage];
    pingLunField  = [[UITextField alloc]initWithFrame:CGRectMake(24, 0, pingluView.frame.size.width-24, 34)];
    pingLunField.backgroundColor = [UIColor clearColor];
    pingLunField.placeholder = @"搜索条件......";
 //   pingLunField.delegate = self;
    
    UIToolbar * keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 38.0f)];
    keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
    keyboardToolbar.tag = 100;
    UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                  target:nil
                                                                                  action:nil];
    
    UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", @"")
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:pingLunField
                                                                   action:@selector(resignFirstResponder)];
    
    [keyboardToolbar setItems:[NSArray arrayWithObjects:spaceBarItem, doneBarItem, nil]];
    pingLunField.inputAccessoryView = keyboardToolbar;
    
    pingLunField.font = [UIFont systemFontOfSize:12];
    [pingluView addSubview:pingLunField];
    [topView addSubview:pingluView];
    UIButton *pingLun=[UIButton buttonWithType:UIButtonTypeCustom];
    pingLun.frame=CGRectMake(10+pingluView.frame.size.width+10, 5, 50, 34);
    [pingLun setBackgroundImage:[[UIImage imageNamed:@"button_zhuce.png"]
                                 stretchableImageWithLeftCapWidth:15 topCapHeight:10] forState:UIControlStateNormal];
    
    [pingLun setTitle:[NSString stringWithFormat:@"查询"] forState:UIControlStateNormal];
    [pingLun setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    pingLun.titleLabel.font=[UIFont systemFontOfSize:12];
    [pingLun addTarget:self action:@selector(chaxun) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:pingLun];
}
-(void)chaxun{
    [postTable launchRefreshing];
}
-(void)initTableView{
    postTable=[[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, tableViewWithOutHeight, kDeviceWidth, KDeviceHeight - 64-tableViewWithOutHeight-44)];
    postTable.pullingDelegate=self;
    postTable.delegate=self;
    postTable.dataSource=self;
    postTable.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    postTable.backgroundColor=[UIColor clearColor];
    
    
    tableBottomButton=[UIButton buttonWithType:UIButtonTypeCustom];
    tableBottomButton.frame=CGRectMake(0, 0, 320, 44);
    tableBottomButton.backgroundColor = [UIColor whiteColor];
    tableBottomButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [tableBottomButton addTarget:self action:@selector(getMoreNetWorkArrayFromNetWork) forControlEvents:UIControlEventTouchUpInside];
    [tableBottomButton setTitle:@"点击加载更多" forState:UIControlStateNormal];
    [tableBottomButton setTitle:@"加载" forState:UIControlStateHighlighted];
    [tableBottomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    postTable.tableFooterView=tableBottomButton;
    [self.view addSubview:postTable];
    [postTable launchRefreshing];
    
}
- (void)loadData{
    [postTable tableViewDidFinishedLoadingWithMessage:@""];
    self.page++;
    if (self.refreshing) {
        self.page = 1;
        self.refreshing = NO;
        [self getNetWorkArrayFromNetWork];
    }
    if (self.page>=1) {
        [postTable tableViewDidFinishedLoading];
        postTable.reachedTheEnd  = NO;
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
//homeview pulling....delegate
-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    refreshing = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}

- (NSDate *)pullingTableViewRefreshingFinishedDate{
    NSDate *date2=[NSDate date];
    return date2;
}

- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}

#pragma mark - Scroll

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [postTable tableViewDidEndDragging:scrollView];
}
-(void)scrollViewDidScroll:(UIScrollView *)_scrollView{
    [postTable tableViewDidScroll:_scrollView];
    CGPoint contentOffsetPoint = postTable.contentOffset;
    CGRect frame = postTable.frame;
    if ( postTable.contentSize.height < frame.size.height&&contentOffsetPoint.y>0&&firstDone==1&&self.islach==0&&!now)
    {
        [self getMoreNetWorkArrayFromNetWork];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.postArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 84;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d" ,indexPath.row];
    JkNews *relation = [self.postArray objectAtIndex:indexPath.row];
    zhiShiKuCell *cell = (zhiShiKuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[zhiShiKuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.otherXinxilabel.text = relation.content;
    [cell.typeLabel setTitle:relation.name forState:UIControlStateNormal];
    if (relation.img !=nil&&![relation.img isEqualToString:@""]) {
        if ([relation.img hasPrefix:@"http"]) {
            [cell.touxiangImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",relation.img]] refreshCache:NO placeholderImage:[UIImage imageNamed:@"login_logo.png"]];
        }else{
            [cell.touxiangImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,relation.img]] refreshCache:NO placeholderImage:[UIImage imageNamed:@"login_logo.png"]];
        }
    }else{
        cell.touxiangImage.image = [UIImage imageNamed:@"login_logo.png"];
    }
    cell.titleLabel.text = relation.title;
    cell.zhanghaoLabel.text = [CommonStr getDateFormLongSince1970:relation.addDate];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JkNews *relation = [self.postArray objectAtIndex:indexPath.row];
    zhishikuDetail *detail = [[zhishikuDetail alloc]init];
    detail.news = relation;

    [self.navigationController pushViewController:detail animated:YES];
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    [self inPinglun];
//    [textField resignFirstResponder];
//}
//-(void)inPinglun{
//    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//    alertView.alertViewStyle=UIAlertViewStylePlainTextInput;
//    [alertView textFieldAtIndex:0].placeholder=@"搜索关注......";
//    [alertView show];
//    [[alertView textFieldAtIndex:0] becomeFirstResponder];
//    
//}
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex==0) {
//        if ([alertView textFieldAtIndex:0].text == nil || [[alertView textFieldAtIndex:0].text isEqualToString:@""]) {
//            conditionString = @"";
//            pingLunField.text = @"";
//        }else{
//            conditionString =[alertView textFieldAtIndex:0].text;
//            pingLunField.text = conditionString;
//            [self chaxun];
//        }
//    }else{
//    }
//}

-(void)getNetWorkArrayFromNetWork{
    if (!now) {
        now=YES;
        conditionString = pingLunField.text;
        if(networkFlag == OFF)
        {
            [self.postArray removeAllObjects];
            [postTable reloadData];
            networkFlag = ON;
            page = 0;
        }

        if ([commonJudgeMent ifConnectNet]){
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,COMMONINDEX_URL]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
            [request setHTTPMethod:@"POST"];
            
            if (conditionString == nil || [conditionString isEqualToString:@""]) {
                NSString *str=[NSString stringWithFormat:@"start_page=1&page_size=%d&is_page=1&table_name=vi_news",PAGESIZE];//设置参数'
                NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
                [request setHTTPBody:data];
            }
            else{
                NSString *str=[NSString stringWithFormat:@"start_page=1&page_size=%d&is_page=1&table_name=vi_news&condition= department_no like '%%%@%%' or title like '%%%@%%' or summary like '%%%@%%' or content like '%%%@%%' ",PAGESIZE,conditionString,conditionString,conditionString,conditionString];//设置参数
                str = [str stringByReplacingOccurrencesOfString:@"%" withString:@"%25"];
                NSLog(@"url str:%@",str);
            
                NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
                [request setHTTPBody:data];
            }
            //第二步，连接服务器
            connection1 = [[NSURLConnection alloc]initWithRequest:request delegate:self];
        }else{
            networkFlag = OFF;
            [self.postArray removeAllObjects];
            [postTable reloadData];
            [commonAction showToast:NONETWORK WhithNavigationController:self.navigationController];
            [dao searchWhere:nil orderBy:@"identity desc" offset:0 count:10000 callback:^(NSArray *array){
                self.postArray=(NSMutableArray *)array;
                
            }];
            [postTable reloadData];
              [tableBottomButton setTitle:@"数据全部加载完毕" forState:UIControlStateNormal];
            [commonAction showToast:NONETWORK WhithNavigationController:self.navigationController];
        }
        now=NO;
        
    }
}
-(void)getMoreNetWorkArrayFromNetWork{
    if (!now) {
        
        now=YES;
        conditionString = pingLunField.text;
        if(networkFlag == OFF)
        {
            [self.postArray removeAllObjects];
            [postTable reloadData];
            networkFlag = ON;
            page = 0;
        }
        if ([commonJudgeMent ifConnectNet]){
            page++;
            
            [tableBottomButton setTitle:@"" forState:UIControlStateNormal];
            if (waitPrograss==nil) {
                waitPrograss=[[WaitProgress alloc]initWithFrame:CGRectMake((kDeviceWidth-30)/2, 5, 30, 30)];
            }
            [tableBottomButton addSubview:waitPrograss];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,COMMONINDEX_URL]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
            [request setHTTPMethod:@"POST"];
            //            NSString *str=[NSString stringWithFormat:@"flag=%@&method=%@&jsonStr={\"%@\":%d,\"page_index\":%d,\"page_size\":%d,\"state\":%d}",space,method,firstCanShuString,seletId,page,PAGESIZE,state];//设置参数
            if (conditionString != nil && ![conditionString isEqualToString:@""]) {
                NSString *str=[NSString stringWithFormat:@"start_page=%d&page_size=%d&is_page=1&table_name=vi_news",page,PAGESIZE];//设置参数'
                NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
                [request setHTTPBody:data];
            }
            else{
                NSString *str=[NSString stringWithFormat:@"start_page=1&page_size=%d&is_page=1&table_name=vi_news&condition= department_no like '%%%@%%' or title like '%%%@%%' or summary like '%%%@%%' or content like '%%%@%%' ",PAGESIZE,conditionString,conditionString,conditionString,conditionString];//设置参数
                NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
                [request setHTTPBody:data];
            }
            
            //第二步，连接服务器
            connection2 = [[NSURLConnection alloc]initWithRequest:request delegate:self];
        }else{
            networkFlag = OFF;
            [self.postArray removeAllObjects];
            [postTable reloadData];
            [commonAction showToast:NONETWORK WhithNavigationController:self.navigationController];
            [dao searchWhere:nil orderBy:@"identity desc" offset:0 count:10000 callback:^(NSArray *array){
                self.postArray=(NSMutableArray *)array;
                
            }];
           [postTable reloadData];
              [tableBottomButton setTitle:@"数据全部加载完毕" forState:UIControlStateNormal];
            
        }
    }
    
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (connection==connection1) {
        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
        NSLog(@"%@",[res allHeaderFields]);
        self.receiveData1 = [NSMutableData data];
    }else if(connection==connection2){
        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
        NSLog(@"%@",[res allHeaderFields]);
        self.receiveData2 = [NSMutableData data];
    }
}

//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection==connection1) {
        [self.receiveData1 appendData:data];
    }else if (connection==connection2) {
        [self.receiveData2 appendData:data];
    }
}
//数据传完之后调用此方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection==connection1) {
//        NSString *receiveStr = [[NSString alloc]initWithData:self.receiveData1 encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",receiveStr);
        if ([JsonToModel ifSuccessFromDictionaryData:receiveData1]) {
            NSArray *objects=[JsonToModel objectsFromDictionaryData:receiveData1 className:@"JkNews"];
            self.postArray =(NSMutableArray *)objects;
            [dao replaceArrayToDB:objects callback:^(BOOL block){
                
            }];
            if ([objects count]<PAGESIZE){
                [tableBottomButton setTitle:@"数据全部加载完毕" forState:UIControlStateNormal];
            }
            else{
                [tableBottomButton setTitle:@"点击加载更多" forState:UIControlStateNormal];
            }
            [postTable reloadData];
        }else{
            [self.postArray removeAllObjects];
            [postTable reloadData];
            [tableBottomButton setTitle:@"暂无数据" forState:UIControlStateNormal];
        }
        
        now=NO;
        firstDone = 1;
        self.islach=0;
    }
    else if (connection==connection2) {
        if ([JsonToModel ifSuccessFromDictionaryData:receiveData2]) {
            NSArray *objects=[JsonToModel objectsFromDictionaryData:receiveData2 className:@"JkNews"];
            [dao replaceArrayToDB:objects callback:^(BOOL block){
                
            }];
            if ([objects count]<PAGESIZE) {
                [tableBottomButton setTitle:@"数据全部加载完毕" forState:UIControlStateNormal];
            }else if ([objects count]>0){
                [self.postArray addObjectsFromArray:objects];
                [postTable reloadData];
                [tableBottomButton setTitle:@"点击加载更多" forState:UIControlStateNormal];
            }
        }else{
            [tableBottomButton setTitle:@"数据全部加载完毕" forState:UIControlStateNormal];
        }
        now=NO;
        [waitPrograss removeFromSuperview];
    }
    
}
//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

