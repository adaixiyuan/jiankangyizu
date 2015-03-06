//
//  notificationMessage.m
//  asiastarbus
//
//  Created by apple on 14-10-14.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import "notificationMessage.h"

@interface notificationMessage ()

@end

@implementation notificationMessage
@synthesize notifiction;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initRightView];
    UIButton *backButton=[UIButton buttonWithType:UIButtonTypeCustom];
//    [backButton setImage:[UIImage imageNamed:@"backButtonHui.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    backButton.frame=CGRectMake(10, 10, 37, 35);
    [self.view addSubview:backButton];
	// Do any additional setup after loading the view.
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)initRightView{
    rightView = [[UIView alloc]initWithFrame:CGRectMake(50, 0, kDeviceWidth-100, KDeviceHeight)];
    rightView.backgroundColor=[UIColor whiteColor];
    
    
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, rightView.frame.size.width - 100, 14)];
    titleLabel.font=[UIFont boldSystemFontOfSize:14];
    titleLabel.backgroundColor= [UIColor clearColor] ;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.text = notifiction.title;
    
    
    contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y+titleLabel.frame.size.height+7, rightView.frame.size.width-2*titleLabel.frame.origin.x, 10)];
    contentLabel.font=[UIFont boldSystemFontOfSize:10];
    contentLabel.backgroundColor= [UIColor clearColor] ;
    contentLabel.textColor = [UIColor darkGrayColor];
    contentLabel.textAlignment = NSTextAlignmentLeft;
//    contentLabel.text = [NSString stringWithFormat:@"%@        %@",[self getDateWithString:[NSDate dateWithTimeIntervalSince1970:no.pubDate]],nowNews.catName];
    //    [NSDate dateWithTimeIntervalSince1970];
    
    
    topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, rightView.frame.size.width, contentLabel.frame.size.height+contentLabel.frame.origin.y)];
    [topView addSubview:titleLabel];
    [topView addSubview:contentLabel];
    
    viewCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(topView.frame.size.width - 90, titleLabel.frame.origin.y, 50, 12)];
    viewCountLabel.font=[UIFont boldSystemFontOfSize:10];
    viewCountLabel.backgroundColor= [UIColor clearColor] ;
    viewCountLabel.textColor = [UIColor darkGrayColor];
    viewCountLabel.textAlignment = NSTextAlignmentRight;
//    viewCountLabel.text = [NSString stringWithFormat:@"%d浏览",nowNews.viewCount];
    [topView addSubview:viewCountLabel];
    /*
    shareButton = [[UIButton alloc]initWithFrame:CGRectMake(topView.frame.size.width-10-30, 12, 30, 30)];
    [shareButton addTarget:self action:@selector(shareTo) forControlEvents:UIControlEventTouchUpInside];
    shareButton.backgroundColor=[UIColor clearColor];
    [shareButton setImage:[UIImage imageNamed:@"shareButton.png"] forState:UIControlStateNormal];
    [topView addSubview:shareButton];
    */
    [rightView addSubview:topView];
    
    newsWebView=[[UIWebView alloc]initWithFrame:CGRectMake(contentLabel.frame.origin.x, topView.frame.size.height+topView.frame.origin.y, contentLabel.frame.size.width, rightView.frame.size.height-topView.frame.size.height)];
    //    newsWebView.delegate=self;
    //    postDetail.backgroundColor=[UIColor whiteColor];
    newsWebView.backgroundColor = [UIColor clearColor];
    newsWebView.opaque = NO;
    
//    NSString *topicContent2=[NSString stringWithFormat:@""];
//    if (nowNews != nil) {
//        topicContent2   =nowNews.content ;
//    }
//    
//    topicContent2=[topicContent2 stringByReplacingOccurrencesOfString:@"<img" withString:[NSString stringWithFormat:@"<img style=\"max-width:%.fpx;\"",newsWebView.frame.size.width-20]];
//    NSMutableString *htmlPage=[[NSMutableString alloc]initWithCapacity:0];
//    [htmlPage appendString:@"<html><head><meta charset=\"utf-8\"/></head><body>"];
//    [htmlPage appendString:topicContent2];
//    [htmlPage appendString:@"</body></html>"];
//    [newsWebView loadHTMLString:htmlPage baseURL:[NSURL URLWithString:@""]];
    [newsWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:notifiction.linkUrl]]];
    [rightView addSubview:newsWebView];
    
    [self.view addSubview:rightView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
