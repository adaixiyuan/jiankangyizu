//
//  shezhi.m
//  yuehandier
//
//  Created by apple on 14/12/13.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import "shezhi.h"
#import "commonAction.h"
#import "AppDelegate.h"
@interface shezhi ()

@end

@implementation shezhi
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self initViews];
    // Do any additional setup after loading the view.
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
    backBtn.frame=CGRectMake(0, 0,25, 31);//52, 42
    UILabel *backLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 0, 300, 31)];
    backLabel.backgroundColor=[UIColor clearColor];
    backLabel.textColor=[UIColor blueColor];
    backLabel.textAlignment=NSTextAlignmentLeft;
    backLabel.font=[UIFont boldSystemFontOfSize:25];
    backLabel.text=@"系统设置";
    UIView *backView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 330, 31)];
    backView1.backgroundColor=[UIColor clearColor];
    [backView1 addSubview:backBtn];
    [backView1 addSubview:backLabel];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView1];
    self.navigationItem.leftBarButtonItem = backButtonItem;

}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)initViews{
    setView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, [[UIScreen mainScreen] bounds].size.height-64) style:UITableViewStyleGrouped];
    setView.delegate=self;
    setView.dataSource=self;
    setView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:setView];
    

    UIView *footer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 44)];
    quitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    quitBtn.frame=CGRectMake(5, 0, kDeviceWidth-10, 40);
    [quitBtn setBackgroundImage:[[UIImage imageNamed:@"button_zhuce.png"]stretchableImageWithLeftCapWidth:15 topCapHeight:7.5] forState:UIControlStateNormal];
    [quitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [quitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    quitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [quitBtn addTarget:self action:@selector(quitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:quitBtn];
    
    
//    setView.tableFooterView=footer;

}
-(void)quitBtnAction{
    NSUserDefaults *ud=   [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:@"user"];
    
    //[[NSUserDefaults standardUserDefaults]delete:[[NSUserDefaults standardUserDefaults]objectForKey:@"user"]];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    //    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user"];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1) {
        if (buttonIndex==0) {
            [self clearCacheYes];
           [commonAction showToast:@"正在清除......" WhithNavigationController:self];
        }
        
        
    }else{
        if (buttonIndex==0) {
            
            if ([[NSUserDefaults standardUserDefaults]objectForKey:@"user"]){
                NSUserDefaults *ud=   [NSUserDefaults standardUserDefaults];
                [ud removeObjectForKey:@"user"];
                
                //[[NSUserDefaults standardUserDefaults]delete:[[NSUserDefaults standardUserDefaults]objectForKey:@"user"]];
       
                [self backAction];
            }else{
               [commonAction showToast:NONETWORK WhithNavigationController:self];
            }
            
        }
    }
    
}
- (AppDelegate *)appDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
-(void)clearBtnAction{
    
    
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"清空缓存文件" message:@"清空缓存将删除存储在您手机上的所有数据，清空后您需要重新下载才能进行阅读或查看，可能会给您带来额外的流量费用，请慎用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alertView.tag=1;
    [alertView show];
    //    if (clearCacheAlert==nil) {
    //        clearCacheAlert=[[ClearCacheAlert alloc]init];
    //        clearCacheAlert.delegate=self;
    //        clearCacheAlert.view.frame=CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height);
    //        [[UIApplication sharedApplication].keyWindow addSubview:clearCacheAlert.view];
    //    }
    //    clearCacheAlert.view.hidden=NO;
}

-(void)clearCacheYes{
    
    clearCacheAlert.view.hidden=YES;
    
    [NSThread detachNewThreadSelector:@selector(clearCacheAction) toTarget:self withObject:nil];
    
}

-(void)clearCacheAction{
    @autoreleasepool {
        //1.删除网页缓存
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //在这里获取应用程序Documents文件夹里的文件及文件夹列表
        NSString *documentDir = [NSString stringWithFormat:@"%@/Library/Caches",NSHomeDirectory()];
        NSError *error = nil;
        //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
        NSArray *fileList = [fileManager contentsOfDirectoryAtPath:documentDir error:&error];
        BOOL isDir = NO;
        //在上面那段程序中获得的fileList中列出文件夹名
        for (NSString *file in fileList) {
            NSString *path = [documentDir stringByAppendingPathComponent:file];
            [fileManager fileExistsAtPath:path isDirectory:(&isDir)];
            if (!isDir) {
                [fileManager removeItemAtPath:path error:nil];
            }
            isDir = NO;
        }
        
        //2.删除其他
        [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@/Library/Caches/DataCache",NSHomeDirectory()] error:nil];
        [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@/Library/Caches/ImageCache",NSHomeDirectory()] error:nil];
        [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@/tmp/MediaCache",NSHomeDirectory()] error:nil];
        


    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
        return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        int row=indexPath.row;
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d",row];
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
        cell.accessoryType=1;
        
        switch (row) {
                
            case 0:{
                cell.textLabel.text=@"删除文件释放内存";
                cell.textLabel.font=[UIFont systemFontOfSize:16];
                break;
            }
            case 1:{
                cell.textLabel.text=@"退出登录";
                cell.textLabel.font=[UIFont systemFontOfSize:16];
                break;
            }
            
                
            default:
                break;
        }
        return cell;
        
    }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

        switch (indexPath.row) {
                
            case 0:{
                [self clearBtnAction];
                break;
            }
            case 1:{
                [self quitBtnAction];
                break;
            }
            
                
            default:
                break;
        }
}

-(void)clearCacheNo{
    clearCacheAlert.view.hidden=YES;
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
