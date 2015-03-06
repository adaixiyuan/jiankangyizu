//
//  FeedBackController.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-13.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "FeedBackController.h"
#import "commonAction.h"
#import "CommonUser.h"
#import "RDVTabBarController.h"
@interface FeedBackController ()
{
    UITextView *feedBackContent;
    CommonUser *user;
}
@end

@implementation FeedBackController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self initView];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    user = [NSKeyedUnarchiver unarchiveObjectWithData:data];

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
    UIButton *saveBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitle:@"提交" forState:UIControlStateNormal];
    [saveBtn setTitleColor:YINGYONG_COLOR forState:UIControlStateNormal];
    saveBtn.frame=CGRectMake(0, 0,70.5, 42);//52, 42
    [saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    
  
    backLabel.backgroundColor=[UIColor clearColor];
    backLabel.textColor=YINGYONG_COLOR;
    backLabel.textAlignment=NSTextAlignmentLeft;
    backLabel.font=[UIFont boldSystemFontOfSize:23];
    backLabel.text=@"使用反馈";
    UIView *backView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth-71, 42)];
    backView1.backgroundColor=[UIColor clearColor];
    [backView1 addSubview:backBtn];
    [backView1 addSubview:backLabel];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView1];
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    self.navigationItem.rightBarButtonItem = saveButtonItem;
}
- (void)initView
{
    
    feedBackContent = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight)];
    feedBackContent.font = [UIFont systemFontOfSize:18.0];
    UIToolbar * keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 38.0f)];
    keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
     UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                  target:nil
                                                                                  action:nil];
    
    UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", @"")
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:feedBackContent
                                                                   action:@selector(resignFirstResponder)];
    
    [keyboardToolbar setItems:[NSArray arrayWithObjects:spaceBarItem, doneBarItem, nil]];
    feedBackContent.inputAccessoryView = keyboardToolbar;

    [self.view addSubview:feedBackContent];

}
- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)save
{
    if([feedBackContent.text isEqualToString:@""] || feedBackContent.text == nil)
    {
        
          [commonAction showToast:@"请您先输入信息！！" WhithNavigationController:self];
    }
    else
    {
    NSString *urlString = [NSString stringWithFormat:@"%@%@?table_name=jk_feedback&obj.user_id=%d&obj.content=%@&obj.version=2",BASE_URL,SUBMIT_URL,user.identity,feedBackContent.text];
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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
                NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                NSArray *objects=[JsonToModel objectsFromDictionaryData:data className:@"JkDepartment"];
                if([result containsString:@"操作成功"])
                {
               dispatch_async(dispatch_get_main_queue(), ^{
                   [self.navigationController popViewControllerAnimated:YES];
                   
               });
                }
                
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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}

@end
