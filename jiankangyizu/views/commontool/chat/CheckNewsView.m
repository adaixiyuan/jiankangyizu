//
//  CheckNewsView.m
//  ViewDeckExample
//
//  Created by apple on 13-4-7.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import "CheckNewsView.h"

@implementation CheckNewsView
@synthesize urlStr,detailView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setHidesBackButton:YES];
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame=CGRectMake(0, 0,54, 32);//52, 42
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backButtonItem;

    
    //顶部栏视图
    UIView *titleView=[[UIView alloc]initWithFrame:CGRectMake(80, 0, 160, 44)];
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160, 44)];
    titleLabel.text=@"新闻";
    titleLabel.font=[UIFont systemFontOfSize:20];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.textColor=[UIColor whiteColor];
    [titleView addSubview:titleLabel];

    self.navigationItem.titleView=titleView;

    
    
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"right_btn.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame=CGRectMake(0, 0, 41, 32);
    UIImageView *refImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"refresh_btn.png"]];
    refImg.frame=CGRectMake(11, 7, 19, 17);
    [rightBtn addSubview:refImg];

    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;

    
    detailView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, [[UIScreen mainScreen] bounds].size.height-64)];
    detailView.delegate=self;
    detailView.backgroundColor=[UIColor whiteColor];
    UIScrollView *scrollView = (UIScrollView *)[[detailView subviews] objectAtIndex:0];  
    scrollView.bounces = NO;
//    scrollView.showsHorizontalScrollIndicator=NO;
//    scrollView.showsVerticalScrollIndicator=NO;
//    scrollView.scrollEnabled=NO;
    [self.view addSubview:detailView];
    
    NSURL *url=[NSURL URLWithString:urlStr];//@"http://finance.qq.com/a/20130407/000950.htm"
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [detailView loadRequest:request];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightAction{
    NSURL *url=[NSURL URLWithString:urlStr];//@"http://finance.qq.com/a/20130407/000950.htm"
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [detailView loadRequest:request];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


@end
