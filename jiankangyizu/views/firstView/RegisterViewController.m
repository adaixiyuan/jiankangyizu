//
//  dengLuView.m
//  yuehandier
//
//  Created by apple on 14/12/11.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import "RegisterViewController.h"
#import "shezhi.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "UserManage.h"
#import "zhiShiKuList.h"
#import "FirstView.h"
#import "ziXunView.h"
#import "mySelfView.h"
#import "JkDepartment.h"
#import "CommonStr.h"
@interface RegisterViewController ()

@end
#import "commonAction.h"
#import "commonJudgeMent.h"
//#import "firstView.h"
@implementation RegisterViewController
@synthesize connection1;
@synthesize receiveData1;
@synthesize connection2;
@synthesize receiveData2;
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initShuJu];
    [self initNav];
    [self initTableView];
    NSData *userData=[[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
    CommonUser *user= [NSKeyedUnarchiver unarchiveObjectWithData:userData];
//    if (user!=nil) {
//        name = user.usern;
//        password = user.password;
//        [self denglu];
//        
//    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initShuJu{
    name =[[NSString alloc]initWithFormat:@""];
    password = [[NSString alloc]initWithFormat:@""];
    method = @"personnel_login";
}
-(void)initTableView{
    self.view.backgroundColor =BACK_COLOR;
    UIButton *topView = [[UIButton alloc]initWithFrame:CGRectMake(20, 10, kDeviceWidth, 184)];
    topView.backgroundColor = QIANLANCOLOR;
    [topView setBackgroundImage:[UIImage imageNamed:@"toolbarback@2x.tiff"] forState:UIControlStateNormal];
    topView.userInteractionEnabled = NO;
    UIImageView *topImage = [[UIImageView alloc]initWithFrame:CGRectMake((kDeviceWidth-144)/2, 30, 144, 144)];
    topImage.image = [UIImage imageNamed:@"login_logo.png"];
    [topView addSubview:topImage];
    tableViewOfDenglu = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-64)];
    tableViewOfDenglu.backgroundColor = [UIColor clearColor];
    tableViewOfDenglu.delegate =self;
    tableViewOfDenglu.dataSource = self;
    tableViewOfDenglu.tableHeaderView = topView;
    tableViewOfDenglu.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableViewOfDenglu];
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 184)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *dengluButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dengluButton.frame=CGRectMake(10, 20, kDeviceWidth-20, 34);
    [dengluButton setBackgroundImage:[[UIImage imageNamed:@"button_blue.png"]
                                      stretchableImageWithLeftCapWidth:15 topCapHeight:10] forState:UIControlStateNormal];
    [dengluButton setTitle:@"注册" forState:UIControlStateNormal];
    [dengluButton addTarget:self action:@selector(denglu) forControlEvents:UIControlEventTouchUpInside];
    [dengluButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    dengluButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [footerView addSubview:dengluButton];
    

    tableViewOfDenglu.tableFooterView = footerView;
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goBack) name:UIApplicationDidBecomeActiveNotification object:nil];
    
}
//返回上一个界面
- (void)goBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d",indexPath.row];
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    if (indexPath.row==0) {
        UIView *mimaView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, kDeviceWidth-20, 44)];
        UIImageView *mimaImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mimaView.frame.size.width, mimaView.frame.size.height)];
        [mimaImage setImage:[[UIImage imageNamed:@"chanpinzhongxin_cell_back.png"]
                             stretchableImageWithLeftCapWidth:12.5 topCapHeight:7.5]];
        [mimaView addSubview:mimaImage];
        
     
        UITextField  *mimaField  = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, mimaView.frame.size.width-30, 44)];
        //    [pingLunField setBackground:[[UIImage imageNamed:@"chanpinzhongxin_cell_back.png"]
        //                                 stretchableImageWithLeftCapWidth:12.5 topCapHeight:7.5]];
        //        mimaField.secureTextEntry=YES;
        mimaField.delegate =self;
        mimaField.tag=1;
        mimaField.backgroundColor = [UIColor clearColor];
        mimaField.placeholder = @"请填写手机号";
        mimaField.font = [UIFont systemFontOfSize:12];
        [mimaView addSubview:mimaField];
        
        UIToolbar * keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 38.0f)];
        keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
        keyboardToolbar.tag = 100+indexPath.row;
        UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                      target:nil
                                                                                      action:nil];
        
        UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", @"")
                                                                        style:UIBarButtonItemStyleDone
                                                                       target:mimaField
                                                                       action:@selector(resignFirstResponder)];
        
        [keyboardToolbar setItems:[NSArray arrayWithObjects:spaceBarItem, doneBarItem, nil]];
        mimaField.inputAccessoryView = keyboardToolbar;
        [cell addSubview:mimaView];
        
        
    }else if (indexPath.row==1){
        UIView *mimaView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, kDeviceWidth-20, 44)];
        UIImageView *mimaImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mimaView.frame.size.width, mimaView.frame.size.height)];
        [mimaImage setImage:[[UIImage imageNamed:@"chanpinzhongxin_cell_back.png"]
                             stretchableImageWithLeftCapWidth:12.5 topCapHeight:7.5]];
        [mimaView addSubview:mimaImage];
        
      
        UITextField  *mimaField  = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, mimaView.frame.size.width-30, 44)];
        //    [pingLunField setBackground:[[UIImage imageNamed:@"chanpinzhongxin_cell_back.png"]
        //                                 stretchableImageWithLeftCapWidth:12.5 topCapHeight:7.5]];
        mimaField.secureTextEntry=YES;
        mimaField.delegate =self;
        mimaField.tag=2;
        mimaField.backgroundColor = [UIColor clearColor];
        mimaField.placeholder = @"密码请输入6-16位数字或字母";
        mimaField.font = [UIFont systemFontOfSize:12];
        [mimaView addSubview:mimaField];
        
        UIToolbar * keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 38.0f)];
        keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
        keyboardToolbar.tag = 100+indexPath.row;
        UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                      target:nil
                                                                                      action:nil];
        
        UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", @"")
                                                                        style:UIBarButtonItemStyleDone
                                                                       target:mimaField
                                                                       action:@selector(resignFirstResponder)];
        
        [keyboardToolbar setItems:[NSArray arrayWithObjects:spaceBarItem, doneBarItem, nil]];
        mimaField.inputAccessoryView = keyboardToolbar;
        [cell addSubview:mimaView];
        
    }
    else if(indexPath.row == 2)
    {
        UIView *mimaView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, kDeviceWidth-20, 44)];
        UIImageView *mimaImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mimaView.frame.size.width, mimaView.frame.size.height)];
        [mimaImage setImage:[[UIImage imageNamed:@"chanpinzhongxin_cell_back.png"]
                             stretchableImageWithLeftCapWidth:12.5 topCapHeight:7.5]];
        [mimaView addSubview:mimaImage];
        
      
        UITextField  *mimaField  = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, mimaView.frame.size.width-30, 44)];
        
        
        mimaField.delegate =self;
        mimaField.tag=3;
        mimaField.backgroundColor = [UIColor clearColor];
        mimaField.placeholder = @"请填写邮箱";
        mimaField.font = [UIFont systemFontOfSize:12];
        [mimaView addSubview:mimaField];
        
        UIToolbar * keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 38.0f)];
        keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
        keyboardToolbar.tag = 100+indexPath.row;
        UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                      target:nil
                                                                                      action:nil];
        
        UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", @"")
                                                                        style:UIBarButtonItemStyleDone
                                                                       target:mimaField
                                                                       action:@selector(resignFirstResponder)];
        
        [keyboardToolbar setItems:[NSArray arrayWithObjects:spaceBarItem, doneBarItem, nil]];
        mimaField.inputAccessoryView = keyboardToolbar;
        [cell addSubview:mimaView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)initNav{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tb_navbar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitle:@"                  " forState:UIControlStateNormal];
    backBtn.frame=CGRectMake(0, 0,33, 33);//52, 42//52, 42
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 72, 33)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.textAlignment=NSTextAlignmentLeft;
    titleLabel.font=[UIFont systemFontOfSize:18];
    titleLabel.text=@"登录";
    self.navigationItem.titleView = titleLabel;
    
}
-(void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag==1) {
        name = textField.text;
    }
    else if (textField.tag==2) {
        password = textField.text;
    }
    else if (textField.tag == 3)
    {
        email = textField.text;
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag==1) {
        name = textField.text;
    }
    else if (textField.tag==2) {
        password = textField.text;
    }
    else if(textField.tag == 3)
    {
        email = textField.text;
    }
    
}

-(void)denglu{
    if ([name isEqualToString:@""]) {
       
        [commonAction showToast:@"请填写手机号" WhithNavigationController:self];
    }else if ([password isEqualToString:@""]){
        [commonAction showToast:@"请填写密码" WhithNavigationController:self];
    }
//    else if ([comm])
    else if([password length] <6 || [password length]>16)
    {
        [commonAction showToast:@"密码范围在6-16位之间" WhithNavigationController:self];
    }
    else if ([email isEqualToString:@""]){
       [commonAction showToast:@"请填写邮箱" WhithNavigationController:self];
    }
   
    else{
        if ([commonJudgeMent ifConnectNet]){
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,REGISTER_URL]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
            [request setHTTPMethod:@"POST"];
            NSString *str;
            str =[NSString stringWithFormat:@"flag=register&role=doctor&tel=%@&pwd=%@&email=%@",name,password,email];//设置参数
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            [request setHTTPBody:data];
            //第二步，连接服务器
            connection1 = [[NSURLConnection alloc]initWithRequest:request delegate:self];
        }else{
            [commonAction showToast:NONETWORK WhithNavigationController:self.navigationController];        }
    }
    
    //    [self setupViewControllers];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if(connection==connection1){
        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
        NSLog(@"%@",[res allHeaderFields]);
        self.receiveData1 = [NSMutableData data];
    }
}

//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection==connection1) {
        [self.receiveData1 appendData:data];
    }
}
//数据传完之后调用此方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if(connection==connection1){
        NSString *receiveStr = [[NSString alloc]initWithData:self.receiveData1 encoding:NSUTF8StringEncoding];
        NSLog(@"%@",receiveStr);
       
        [commonAction showToast:[JsonToModel getMessageFromDictionaryData:receiveData1] WhithNavigationController:self];
        if ([JsonToModel ifSuccessFromDictionaryData:receiveData1]) {
            NSArray *objects =  [JsonToModel objectsFromDictionaryData:self.receiveData1 className:@"CommonUser"];
            if ([objects count]>0) {
                CommonUser *user=(CommonUser *)[objects objectAtIndex:0];
                user.password = password;
                NSData *userData=[NSKeyedArchiver archivedDataWithRootObject:user];
                [[NSUserDefaults standardUserDefaults] setObject:userData forKey:@"user"];
                //                firstView *first = [[firstView alloc]init];
                //                first.nowMember= user;
                //                UINavigationController *firstNav = [[UINavigationController alloc]initWithRootViewController:first];
                //                [self presentViewController:firstNav animated:YES completion:nil];
                [self createUser:user];
                [self initDataBaseWithuserid:user.identity];
                [self setupViewControllers];
//                                [self.navigationController pushViewController:first animated:YES];
                                NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
                                [userDefaults setObject:@"tiebi123" forKey:@"userPassword"];
                                NSLog(@"password : %@",[userDefaults objectForKey:@"userPassword"]);
                                NSLog(@"userName = %@",user.usern);
                //断开聊天
                 if ([APPALL connect]){
                 [APPALL disconnect];
                 
                 [userDefaults removeObjectForKey:@"kXMPPmyJID"];
                 [userDefaults removeObjectForKey:@"kXMPPmyPassword"];
                 }
                 [userDefaults setObject:[NSString stringWithFormat:@"%d_%@",PROJECTSID,user.usern] forKey:@"kXMPPmyJID"];
                 NSLog(@"jid:%@",[userDefaults objectForKey:@"kXMPPmyJID"]);
                 NSString *userPass=[userDefaults objectForKey:@"userPassword"];
                 [userDefaults setObject:userPass forKey:@"kXMPPmyPassword"];
                 NSLog(@"kxmppmypassword%@",[userDefaults objectForKey:@"kXMPPmyPassword"]);
                 [APPALL connect];
                 
                FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
                CommonUserDAO* dao = [[CommonUserDAO alloc]initWithDbqueue:queue];
                
                [dao replaceArrayToDB:objects callback:^(BOOL result){
                }];
            }
            [self backAction];
        }
        
    }
    
    
    
}
- (void)initDataBaseWithuserid:(int)userid
{
    FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
    JkDepartmentDAO *dao = [[JkDepartmentDAO alloc]initWithDbqueue:queue];
    NSString *urlString = [NSString stringWithFormat:@"%@%@?table_name=jk_department",BASE_URL,COMMONINDEX_URL];
    
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
                
                NSArray *objects=[JsonToModel objectsFromDictionaryData:data className:@"JkDepartment"];
                
                
                [dao replaceArrayToDB:objects callback:^(BOOL block){
                    
                }];
                
                
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
}
//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}

-(void)registerDone{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupViewControllers {
    UIViewController *firstViewController = [[UserManage alloc] init];
    UIViewController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    UIViewController *secondViewController = [[ziXunView alloc] init];
    UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    UIViewController *thirdViewController = [[FirstView alloc] init];
    UIViewController *thirdNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    UIViewController *forthViewController = [[zhiShiKuList alloc] init];
    UIViewController *forthNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:forthViewController];
    UIViewController *fifthViewController = [[mySelfView alloc] init];
    UIViewController *fifthNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:fifthViewController];
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[firstNavigationController, secondNavigationController,
                                           thirdNavigationController,forthNavigationController,fifthNavigationController]];
    
    
    tabBarController.selectedIndex = 2;
    [self customizeTabBarForController:tabBarController];
    [self presentViewController:tabBarController animated:YES completion:nil];
    //    [self.navigationController pushViewController:tabBarController animated:YES];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    //    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    //    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"second", @"third", @"first",@"fifth",@"forth"];
    NSArray *tabBarItemTitles = @[@"用户",@"咨询",@"首页",@"知识库",@"我"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        
        //        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

//临时账户
-(void)createUser:(CommonUser *)user{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"user"]) {
        if ([commonJudgeMent ifConnectNet]){
            
            //        举例：BASEURL//saleout/saleout_list.jsp?sid=10&longitude=0&latitude=0&distance=26400&page_size=2&start_page=1&is_page=1
            NSString *str=[self createProperties:user];//设置参数
            if (str!=nil && ![str isEqualToString:@""]) {
                //                NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URLL,pushURL]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
                //                [request setHTTPMethod:@"POST"];
                //                NSLog(@"%@%@",BASE_URLL,pushURL);
                //                NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
                //                [request setHTTPBody:data];
                //                //第二步，连接服务器
                //                connection2 = [[NSURLConnection alloc]initWithRequest:request delegate:self];
            }
        }else{
            //            [commonAction showToast:NONETWORK];
        }
    }
    
}

-(NSString *)createProperties:(CommonUser *)user{
    
    NSMutableString *properties = [[NSMutableString alloc]init];
    [properties appendString:@"sid=001"];
    [properties appendString:[NSString stringWithFormat:@"&usern=%@",user.usern]];
//    [properties appendString:[NSString stringWithFormat:@"&token=%@",APPALL.token]];
//    NSLog(@"=-=-=-=-=-= %@",APPALL.token);
    [properties appendString:[NSString stringWithFormat:@"&push_path=%@",@"push.p12"]];
    [properties appendString:[NSString stringWithFormat:@"&push_password=%@",@"123456"]];
    
    NSLog(@"%@",properties);
    return properties;
}


@end
