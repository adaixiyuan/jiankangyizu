//
//  dengLuView.m
//  yuehandier
//
//  Created by apple on 14/12/11.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import "dengLuView.h"
#import "shezhi.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "UserManage.h"
#import "FirstView.h"
#import "ziXunView.h"
#import "mySelfView.h"
#import "JkDepartment.h"
#import "RegisterViewController.h"
#import "zhiShiKuList.h"
#define QIEHUANLONGIN 2
@interface dengLuView ()

@end
#import "commonAction.h"
#import "commonJudgeMent.h"
//#import "firstView.h"
@implementation dengLuView
@synthesize connection1;
@synthesize receiveData1;
@synthesize connection2;
@synthesize receiveData2;
@synthesize LoginFlag;
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
//    NSData *userData=[[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
//    CommonUser *user= [NSKeyedUnarchiver unarchiveObjectWithData:userData];
//    
//    if (user!=nil)
//    {
//        [self denglu];
//    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initShuJu];
    [self initTableView];

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
    [dengluButton setTitle:@"登录" forState:UIControlStateNormal];
    [dengluButton addTarget:self action:@selector(denglu) forControlEvents:UIControlEventTouchUpInside];
    [dengluButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    dengluButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [footerView addSubview:dengluButton];
    
//    
    UIButton *wangjimimaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    wangjimimaButton.frame=CGRectMake(kDeviceWidth-10-70, 74, 70, 34);
    wangjimimaButton.backgroundColor = [UIColor clearColor];
    [wangjimimaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [wangjimimaButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [wangjimimaButton addTarget:self action:@selector(wangjimima) forControlEvents:UIControlEventTouchUpInside];
    wangjimimaButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [footerView addSubview:wangjimimaButton];
    
    
    UIButton *zhuceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    zhuceButton.frame=CGRectMake(10, 74, 70, 34);
    zhuceButton.backgroundColor = [UIColor clearColor];
//    zhuceButton.layer.borderColor = [[UIColor darkGrayColor]CGColor];
//    zhuceButton.layer.borderWidth = 0.5;
    [zhuceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [zhuceButton setTitle:@"注册" forState:UIControlStateNormal];
    [zhuceButton addTarget:self action:@selector(inzhuceView) forControlEvents:UIControlEventTouchUpInside];
    zhuceButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [footerView addSubview:zhuceButton];
    tableViewOfDenglu.tableFooterView = footerView;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
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
        UIView *mimaView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, kDeviceWidth-20, 34)];
        UIImageView *mimaImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mimaView.frame.size.width, mimaView.frame.size.height)];
        [mimaImage setImage:[[UIImage imageNamed:@"chanpinzhongxin_cell_back.png"]
                             stretchableImageWithLeftCapWidth:12.5 topCapHeight:7.5]];
        [mimaView addSubview:mimaImage];
        
        UIImageView *pinglunImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 4.5, 14, 25)];
        pinglunImage.image = [UIImage imageNamed:@"login_username_left_panel.png"];
        [mimaView addSubview:pinglunImage];
        UITextField  *mimaField  = [[UITextField alloc]initWithFrame:CGRectMake(30, 0, mimaView.frame.size.width-30, 34)];
        //    [pingLunField setBackground:[[UIImage imageNamed:@"chanpinzhongxin_cell_back.png"]
        //                                 stretchableImageWithLeftCapWidth:12.5 topCapHeight:7.5]];
//        mimaField.secureTextEntry=YES;
        mimaField.delegate =self;
        mimaField.tag=1;
        mimaField.backgroundColor = [UIColor clearColor];
        mimaField.placeholder = @"请输入用户名";
        NSData *userData=[[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
        CommonUser *user= [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        if (user!=nil && LoginFlag!= QIEHUANLONGIN) {
            mimaField.text = user.usern;
            name  = user.usern;
        }
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
        UIView *mimaView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, kDeviceWidth-20, 34)];
        UIImageView *mimaImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mimaView.frame.size.width, mimaView.frame.size.height)];
        [mimaImage setImage:[[UIImage imageNamed:@"chanpinzhongxin_cell_back.png"]
                              stretchableImageWithLeftCapWidth:12.5 topCapHeight:7.5]];
        [mimaView addSubview:mimaImage];
        
        UIImageView *pinglunImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 4.5, 14, 25)];
        pinglunImage.image = [UIImage imageNamed:@"login_psw_left_panel.png"];
        [mimaView addSubview:pinglunImage];
        UITextField  *mimaField  = [[UITextField alloc]initWithFrame:CGRectMake(30, 0, mimaView.frame.size.width-30, 34)];
        //    [pingLunField setBackground:[[UIImage imageNamed:@"chanpinzhongxin_cell_back.png"]
        //                                 stretchableImageWithLeftCapWidth:12.5 topCapHeight:7.5]];
        mimaField.secureTextEntry=YES;
        mimaField.delegate =self;
        mimaField.tag=2;
        mimaField.backgroundColor = [UIColor clearColor];
        mimaField.placeholder = @"请输入密码";
        mimaField.font = [UIFont systemFontOfSize:12];
        NSData *userData=[[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
        CommonUser *user= [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        if (user!=nil && LoginFlag != QIEHUANLONGIN) {
            mimaField.text = user.password;
            password = user.password;
        }
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
-(void)inzhuceView
{
    RegisterViewController *registercontroller = [[RegisterViewController alloc] init];
    [self presentViewController:registercontroller animated:YES completion:nil];
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
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag==1) {
        name = textField.text;
            }
    else if (textField.tag==2) {
        password = textField.text;
    }
    
}

-(void)denglu{
//   [self setupViewControllers];
    if ([name isEqualToString:@""]) {
        [commonAction showToast:@"请输入用户名" WhithNavigationController:self.navigationController];
    }else if ([password isEqualToString:@""]){
         [commonAction showToast:@"请输入密码" WhithNavigationController:self.navigationController];
        
    }else{
        alert = [[UIAlertView alloc]initWithTitle:@"" message:@"登录中....." delegate:nil
                                             cancelButtonTitle:nil otherButtonTitles:nil];
        [alert show];
        if ([commonJudgeMent ifConnectNet]){
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,DENGLU_URL]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
            [request setHTTPMethod:@"POST"];
            NSString *str;
            str =[NSString stringWithFormat:@"sid=%d&user_name=%@&password=%@&role=doctor",PROJECTSID,name,password];//设置参数
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            [request setHTTPBody:data];
            //第二步，连接服务器
            connection1 = [[NSURLConnection alloc]initWithRequest:request delegate:self];
        }else{
           
            [commonAction showToast:NONETWORK WhithNavigationController:self.navigationController];
        }
    }
    

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
//        NSString *receiveStr = [[NSString alloc]initWithData:self.receiveData1 encoding:NSUTF8StringEncoding];
        
        [alert dismissWithClickedButtonIndex:0 animated:YES];
      
//        [commonAction showToast:[JsonToModel getMessageFromDictionaryData:receiveData1] WhithNavigationController:self];
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
                LoginFlag =  1;
//                [self.navigationController pushViewController:first animated:YES];
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
    [alert dismissWithClickedButtonIndex:0 animated:YES];
   [commonAction showToast:@"登录失败" WhithNavigationController:self.navigationController];
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
    
    tabBarController = [[RDVTabBarController alloc] init];
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
    NSArray *tabBarItemImages = @[@"second", @"third", @"first",@"forth",@"fifth"];
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
        [properties appendString:[NSString stringWithFormat:@"&usern=jkdoctor_%@",user.usern]];
    [properties appendString:[NSString stringWithFormat:@"&token=%@",APPALL.token]];
    NSLog(@"=-=-=-=-=-= %@",APPALL.token);
    [properties appendString:[NSString stringWithFormat:@"&push_path=%@",@"push.p12"]];
    [properties appendString:[NSString stringWithFormat:@"&push_password=%@",@"123456"]];
    
    NSLog(@"%@",properties);
    return properties;
}


@end
