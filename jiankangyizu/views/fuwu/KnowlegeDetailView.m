//
//  KnowlegeDetailView.m
//  jiankangyizu
//
//  Created by JEREI on 15-2-11.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "KnowlegeDetailView.h"
#import "CommonStr.h"
#import "SDImageView+SDWebCache.h"
#import "RDVTabBarController.h"
@interface KnowlegeDetailView ()
{
    int  contentheigth;
}


@end

@implementation KnowlegeDetailView
@synthesize jknews;
- (void)viewDidLoad {
    self.view.backgroundColor = BACK_COLOR;
    [super viewDidLoad];
    [self initNav];
    [self initView];
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
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame=CGRectMake(0, 0,30.5, 42);//52, 42
    UILabel *backLabel=[[UILabel alloc]initWithFrame:CGRectMake(32, 0, 300, 42)];
    backLabel.backgroundColor=[UIColor clearColor];
    backLabel.textColor=YINGYONG_COLOR;
    backLabel.textAlignment=NSTextAlignmentLeft;
    backLabel.font=[UIFont boldSystemFontOfSize:23];
    backLabel.text=@"多多健康·知识库详情";
    UIView *backView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 330, 42)];
    backView1.backgroundColor=[UIColor clearColor];
    [backView1 addSubview:backBtn];
    [backView1 addSubview:backLabel];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView1];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}
- (void)initView
{
    UIScrollView *myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,kDeviceWidth,KDeviceHeight)];
    myScrollView.directionalLockEnabled = YES;
    myScrollView.pagingEnabled = NO;
    myScrollView.backgroundColor = [UIColor whiteColor];
    myScrollView.showsVerticalScrollIndicator = YES;
    myScrollView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.delegate = self;
    [myScrollView setContentSize:CGSizeMake(kDeviceWidth, KDeviceHeight)];

      [self.view addSubview:myScrollView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kDeviceWidth-20, 20)];
    title.font = [UIFont boldSystemFontOfSize:18.0];
    
    UILabel *keshiName = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, kDeviceWidth/2, 20)]; keshiName.font = [UIFont systemFontOfSize:15.0];
    
    UILabel *addtime = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2, 30, kDeviceWidth/2, 20)];
     addtime.font = [UIFont systemFontOfSize:15.0];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, kDeviceWidth, 1)];
    [line setBackgroundColor:[UIColor lightGrayColor]];
    
    UILabel *jianjie = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, kDeviceWidth-10, 20)];
    contentheigth = 0;
    if(![jknews.img isEqual:nil] && ![jknews.img isEqual:@"" ])
    {
        UIImageView *newsImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 90, kDeviceWidth, 200)];
        [newsImage setImageWithURL:[NSURL URLWithString:jknews.img] refreshCache:NO placeholderImage:[UIImage imageNamed:@"iocn.png"]];
        
        [myScrollView addSubview:newsImage];
        contentheigth  = 205;
    }
    
    
    UILabel *newsDetail = [[UILabel alloc] init];
    newsDetail.numberOfLines = 0;
    CGSize sizeOfdetailcontent =[CommonStr TextSize:jknews.content];
    newsDetail.frame = CGRectMake(0, 90+contentheigth, kDeviceWidth, sizeOfdetailcontent.height);
    CGSize newSize = CGSizeMake(kDeviceWidth, 90+contentheigth+sizeOfdetailcontent.height);
    
    jianjie.text = jknews.summary;
    title.text = jknews.title;
    keshiName.text = [NSString stringWithFormat:@"科室：%@",jknews.name];
    addtime.text = [CommonStr getDateFormLongSince1970:jknews.addDate];
    newsDetail.text = jknews.content;
    
    
    
    [myScrollView addSubview:title];
    [myScrollView addSubview:keshiName];
    [myScrollView addSubview:addtime];
    [myScrollView addSubview:line];
    [myScrollView addSubview:jianjie];
    [myScrollView addSubview:newsDetail];
    
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}
- (void)goBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
