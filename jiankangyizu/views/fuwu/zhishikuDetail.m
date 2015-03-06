//
//  zhishikuDetail.m
//  jiankangyizu
//
//  Created by apple on 15/2/12.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "zhishikuDetail.h"
#import "CommonStr.h"
#import "SDImageView+SDWebCache.h"
@interface zhishikuDetail ()

@end

@implementation zhishikuDetail
@synthesize news;
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
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}
-(void)initNav{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tb_navbar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"comm_top_button_left.png"] forState:UIControlStateNormal];
    backBtn.frame=CGRectMake(0, 0,56, 31);//52, 42
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UILabel *backLabel=[[UILabel alloc]initWithFrame:CGRectMake(57, 0, 100, 31)];
    backLabel.backgroundColor=[UIColor clearColor];
    backLabel.textColor=YINGYONG_COLOR;
    backLabel.textAlignment=NSTextAlignmentLeft;
    backLabel.font=[UIFont boldSystemFontOfSize:23];
    backLabel.text=@"知识库";
    UIView *backView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 160, 31)];
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
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-64)];
    [self.view addSubview:tableView];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth,44)];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kDeviceWidth-20, 24)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = news.title;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    UILabel *keshiLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 24, kDeviceWidth-20, 20)];
    keshiLabel.backgroundColor = [UIColor clearColor];
    keshiLabel.textColor = [UIColor blackColor];
    keshiLabel.text = [NSString stringWithFormat:@"科室：%@",news.name];
    keshiLabel.font = [UIFont systemFontOfSize:12];
    keshiLabel.textAlignment = NSTextAlignmentLeft;
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 24, kDeviceWidth-20, 20)];
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.textColor = [UIColor blackColor];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.text = [CommonStr getDateFormLongSince1970:news.addDate];
    [topView addSubview:titleLabel];
    [topView addSubview:keshiLabel];
    [topView addSubview:timeLabel];
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 43.5, kDeviceWidth, 0.5)];
    line.backgroundColor = [UIColor blackColor];
    [topView addSubview:line];
    tableView.tableHeaderView = topView;
    
    UIView *downview=[[UIView alloc]init];
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.numberOfLines = 0;
    CGSize requiredSize = CGSizeZero;
    CGSize boundingSize = CGSizeMake(kDeviceWidth-20, MAXFLOAT);
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f]};
    [news.content sizeWithAttributes:attribute];
    requiredSize = [news.content boundingRectWithSize:boundingSize options:\
                    NSStringDrawingTruncatesLastVisibleLine |
                    NSStringDrawingUsesLineFragmentOrigin |
                    NSStringDrawingUsesFontLeading
                                               attributes:attribute context:nil].size;
    contentLabel.frame = CGRectMake(10, 5, kDeviceWidth-20, requiredSize.height+10);
    contentLabel.text = news.content;
   
    [downview addSubview:contentLabel];
    if (news.img !=nil && ![news.img isEqualToString:@""]) {
        UIImageView *contentImage = [[UIImageView alloc]initWithFrame:CGRectMake(40, contentLabel.frame.size.height, kDeviceWidth-80, kDeviceWidth-80)];
        if ([news.img hasPrefix:@"http"]) {
            [contentImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",news.img]] refreshCache:NO placeholderImage:[UIImage imageNamed:@"login_logo.png"]];
        }else{
            [contentImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,news.img]] refreshCache:NO placeholderImage:[UIImage imageNamed:@"login_logo.png"]];
        }
        [downview addSubview:contentImage];
    }
    
    UILabel *summaryLabel = [[UILabel alloc]init];
    summaryLabel.backgroundColor = [UIColor clearColor];
    summaryLabel.text = news.summary;
    summaryLabel.textColor = [UIColor blackColor];
    summaryLabel.font = [UIFont systemFontOfSize:14];
    summaryLabel.textAlignment = NSTextAlignmentLeft;
    summaryLabel.numberOfLines = 0;
    CGSize requiredSize1 = CGSizeZero;
    CGSize boundingSize1 = CGSizeMake(kDeviceWidth-20, MAXFLOAT);
    NSDictionary *attribute1 = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f]};
    [news.summary sizeWithAttributes:attribute1];
    requiredSize1 = [news.summary boundingRectWithSize:boundingSize1 options:\
                    NSStringDrawingTruncatesLastVisibleLine |
                    NSStringDrawingUsesLineFragmentOrigin |
                    NSStringDrawingUsesFontLeading
                                           attributes:attribute context:nil].size;
    if (news.img !=nil && ![news.img isEqualToString:@""]) {
        summaryLabel.frame = CGRectMake(10, contentLabel.frame.size.height+contentLabel.frame.origin.y+5+kDeviceWidth-80, kDeviceWidth-20, requiredSize1.height+10);
    }else{
         summaryLabel.frame = CGRectMake(10, contentLabel.frame.size.height+contentLabel.frame.origin.y+5, kDeviceWidth-20, requiredSize1.height+10);
    }
    [downview addSubview:summaryLabel];
    downview.frame = CGRectMake(0, 0, kDeviceWidth, summaryLabel.frame.origin.y+summaryLabel.frame.size.height);
    tableView.tableFooterView = downview;
    
   
    
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
