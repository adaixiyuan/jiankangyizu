//
//  ClearCacheAlert.m
//  ViewDeckExample
//
//  Created by apple on 13-4-1.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import "ClearCacheAlert.h"
#import "iToast.h"

@implementation ClearCacheAlert
@synthesize intro,yes,no,delegate;

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
    
    self.view.backgroundColor=[UIColor clearColor];
    
    UIView *level=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height)];
    level.backgroundColor=[UIColor blackColor];
    level.alpha=0.5;
    [self.view addSubview:level];

    
    UIButton *hiddenBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    hiddenBtn.frame=CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height);
    [hiddenBtn addTarget:self action:@selector(clearCacheNo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hiddenBtn];
    
    UIImage *image1=[[UIImage imageNamed:@"recommend_friend_bg.png"] stretchableImageWithLeftCapWidth:27 topCapHeight:66];
    UIImageView *backView=[[UIImageView alloc]initWithImage:image1];
    backView.frame=CGRectMake(20, 135, 280, 225);
    [self.view addSubview:backView];

    
    UIView *buttonView=[[UIView alloc]initWithFrame:CGRectMake(20, 135, 280, 225)];
    buttonView.backgroundColor=[UIColor clearColor];
    
    intro=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 251, 120)];
    intro.numberOfLines=0;
    intro.font=[UIFont systemFontOfSize:15];
    intro.backgroundColor=[UIColor clearColor];
    intro.text=@"清空缓存将删除乐易挖存储在您手机上的所有数据，包括图片、新闻、贴子等，清空后您需要重新下载才能进行阅读或查看，可能会给您带来额外的流量费用，请慎用！";
    [buttonView addSubview:intro];
    
    UIImage *bg1=[[UIImage imageNamed:@"pop_btn_red.png"]stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    UIImage *bg2=[[UIImage imageNamed:@"pop_btn_black.png"]stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    
    yes=[UIButton buttonWithType:UIButtonTypeCustom];
    yes.frame=CGRectMake(10, 125, 260, 40);
    [yes setBackgroundImage:bg1 forState:UIControlStateNormal];
    [yes addTarget:self action:@selector(clearCacheYes) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:yes];
    UILabel *superTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 260, 40)];
    superTitle.backgroundColor=[UIColor clearColor];
    superTitle.text=@"确认";
    superTitle.textColor=[UIColor whiteColor];
    superTitle.textAlignment=NSTextAlignmentCenter;
    superTitle.font=[UIFont systemFontOfSize:16];
    [yes addSubview:superTitle];
  
    
    no=[UIButton buttonWithType:UIButtonTypeCustom];
    no.frame=CGRectMake(10, 170, 260, 40);
    [no setBackgroundImage:bg2 forState:UIControlStateNormal];
    [no addTarget:self action:@selector(clearCacheNo) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:no];
    UILabel *bigTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 260, 40)];
    bigTitle.backgroundColor=[UIColor clearColor];
    bigTitle.text=@"取消";
    bigTitle.textColor=[UIColor whiteColor];
    bigTitle.textAlignment=NSTextAlignmentCenter;
    bigTitle.font=[UIFont systemFontOfSize:16];
    [no addSubview:bigTitle];

    
    [self.view addSubview:buttonView];
}

-(void)clearCacheYes{
    [delegate clearCacheYes];
    [self showToast:@"正在清除..."];
}

-(void)clearCacheNo{
    [delegate clearCacheNo];
}

- (void)showToast:(NSString *)contents
{
    iToast *toast = [iToast makeToast:contents];
    [toast setToastPosition:kToastPositionBottom];
    [toast setToastDuration:kToastDurationNormal];
    [toast show];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


@end
