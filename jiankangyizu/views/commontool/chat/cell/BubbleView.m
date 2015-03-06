//
//  BubbleView.m
//  ViewDeckExample
//
//  Created by apple on 13-2-25.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import "BubbleView.h"
#import <QuartzCore/QuartzCore.h>

@implementation BubbleView
@synthesize fromSelf,bubbleImageView,noFaceImage,iconImgView,bubbleText,contentImage,time,timeBg,state,activityView,noRead,isSuccess,voiceImage,playImage,num,title,check;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.backgroundColor=[UIColor clearColor];
        
    }
    return self;
}

-(void)createView{
    UIImage *bubble = [UIImage imageNamed:fromSelf?@"chat_huikuang2.png":@"chat_lvkuang2.png"];
    UIImage *bubble_h = [UIImage imageNamed:fromSelf?@"chat_huikuang2_pressed.png":@"chat_lvkuang2_pressed.png"];
    if ([[UIDevice currentDevice].systemVersion doubleValue] > 4.99) {
        UIEdgeInsets insets = UIEdgeInsetsMake(25, 19, 11, 19);
        bubble=[bubble resizableImageWithCapInsets:insets];
        bubble_h=[bubble_h resizableImageWithCapInsets:insets];
    } else {
        bubble=[bubble stretchableImageWithLeftCapWidth:19 topCapHeight:25];
        bubble_h=[bubble_h stretchableImageWithLeftCapWidth:19 topCapHeight:25];
    }
    
//    stretchableImageWithLeftCapWidth:30 topCapHeight:50];//根据信息来源使用响应的图片
//    bubbleImageView = [[UIImageView alloc] initWithImage:bubble];
    bubbleImageView=[UIButton buttonWithType:UIButtonTypeCustom];
    [bubbleImageView setBackgroundImage:bubble forState:UIControlStateNormal];
    [bubbleImageView setBackgroundImage:bubble_h forState:UIControlStateHighlighted];
    [self addSubview:bubbleImageView];
    
    noFaceImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"noFace.png"]];
    [noFaceImage.layer setMasksToBounds:YES];
    [noFaceImage.layer setCornerRadius:3.0];
    [self addSubview:noFaceImage];
    
    iconImgView=[[UIImageView alloc]init];
    [iconImgView.layer setMasksToBounds:YES];
    [iconImgView.layer setCornerRadius:3.0];
    [self addSubview:iconImgView];
    
    contentImage=[[UIImageView alloc]init];
    [contentImage setUserInteractionEnabled:NO];
    [self addSubview:contentImage];
    
    voiceImage=[[UIImageView alloc]init];
    if (fromSelf) {
        UIImage *img1 = [UIImage imageNamed:@"chatto0.png"];  
        UIImage *img2 = [UIImage imageNamed:@"chatto1.png"];  
        UIImage *img3 = [UIImage imageNamed:@"chatto2.png"];
        voiceImage.animationImages = [NSArray arrayWithObjects:img1,img2,img3, nil];  
        voiceImage.animationDuration = 1;  
        [voiceImage startAnimating];
    }else{
        UIImage *img1 = [UIImage imageNamed:@"chatfrom0.png"];  
        UIImage *img2 = [UIImage imageNamed:@"chatfrom1.png"];  
        UIImage *img3 = [UIImage imageNamed:@"chatfrom2.png"];
        voiceImage.animationImages = [NSArray arrayWithObjects:img1,img2,img3, nil];  
        voiceImage.animationDuration = 1;  
        [voiceImage startAnimating];
        
    }
    [self addSubview:voiceImage];
    
    playImage=[[UIImageView alloc]init];
    playImage.frame=CGRectZero;
    [self addSubview:playImage];
    
    title=[[UILabel alloc]init];
    title.backgroundColor=[UIColor blackColor];
    title.frame=CGRectZero;
    [self addSubview:title];
    
    bubbleText=[[ChatLabel3 alloc]init];
    bubbleText.font2=14;
    [bubbleText setUserInteractionEnabled:NO];
    [self addSubview:bubbleText];
    
    state=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"send_fall.png"]];
    [self addSubview:state];
    [state setHidden:YES];
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.frame = CGRectMake(0.0f, 0.0f, 20.0f, 20.0f);
    //    [activityView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:activityView];
    [activityView startAnimating];
    
    timeBg=[[UIImageView alloc]initWithFrame:CGRectZero];
    timeBg.image=[[UIImage imageNamed:@"chat_shijianxianshi.png"]stretchableImageWithLeftCapWidth:20 topCapHeight:15];
    [self addSubview:timeBg];
    
    time=[[UILabel alloc]init];
    time.font=[UIFont systemFontOfSize:12];
    time.textColor=[UIColor whiteColor];
    time.backgroundColor=[UIColor clearColor];
    [self addSubview:time];
    
    noRead=[[UIImageView alloc]initWithFrame:CGRectZero];
    noRead.image=[UIImage imageNamed:@"chat_no_listen_point.png"];
    [self addSubview:noRead];
    
    /*
    num=0;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.3f
                                              target:self
                                            selector:@selector(repeatAnimation)
                                            userInfo:nil
                                             repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    */
}

-(void)repeatAnimation{
    if (num<3) {
        num++;
        if (fromSelf) {
            voiceImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"chatto%d.png",num]];
        }else{
            voiceImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"chatfrom%d.png",num]];
        }
        
    }else{
        num=0;
        if (fromSelf) {
            voiceImage.image=[UIImage imageNamed:@"chatto0.png"];
        }else{
            voiceImage.image=[UIImage imageNamed:@"chatfrom0.png"];
        }
    }
    
}

-(void)repeatAnimation2{
    if (fromSelf) {
        voiceImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"chatto2.png"]];
    }else{
        voiceImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"chatfrom2.png"]];
    }
    
}

-(void)createNewsView{
    UIImage *bubble = [UIImage imageNamed:@"horizon_bottom.png"];
    UIImage *bubble_h=[UIImage imageNamed:@"horizon_bottom.png"];
    if ([[UIDevice currentDevice].systemVersion doubleValue] > 4.99) {
        UIEdgeInsets insets = UIEdgeInsetsMake(28, 28, 65, 28);
        bubble=[bubble resizableImageWithCapInsets:insets];
        bubble_h=[bubble_h resizableImageWithCapInsets:insets];
    } else {
        bubble=[bubble stretchableImageWithLeftCapWidth:28 topCapHeight:28];
        bubble_h=[bubble_h stretchableImageWithLeftCapWidth:28 topCapHeight:28];
    }
    
    bubbleImageView=[UIButton buttonWithType:UIButtonTypeCustom];
    [bubbleImageView setBackgroundImage:bubble forState:UIControlStateNormal];
    [bubbleImageView setBackgroundImage:bubble_h forState:UIControlStateHighlighted];
    
    
    title=[[UILabel alloc]init];
    title.backgroundColor=[UIColor clearColor];
    title.font=[UIFont systemFontOfSize:16];
    title.numberOfLines=0;
    [bubbleImageView addSubview:title];
    
    time=[[UILabel alloc]initWithFrame:CGRectZero];
    time.font=[UIFont systemFontOfSize:12];
    time.textColor=[UIColor grayColor];
    time.backgroundColor=[UIColor clearColor];
    [bubbleImageView addSubview:time];
    
    contentImage=[[UIImageView alloc]init];
    contentImage.contentMode=UIViewContentModeScaleAspectFit;
    [contentImage setUserInteractionEnabled:NO];
    contentImage.backgroundColor=[UIColor clearColor];
    [bubbleImageView addSubview:contentImage];
    
    bubbleText=[[ChatLabel3 alloc]init];
    bubbleText.font2=14;
    [bubbleText setUserInteractionEnabled:NO];
    [bubbleImageView addSubview:bubbleText];
    
    check=[[UILabel alloc]init];
    check.backgroundColor=[UIColor clearColor];
    check.font=[UIFont systemFontOfSize:14];
    check.text=@"立即查看";
    [bubbleImageView addSubview:check];
    
    playImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bakchat_submenu_normal.png"]];
    playImage.frame=CGRectZero;//280, 16.5, 17, 17
    [bubbleImageView addSubview:playImage];
    
    [self addSubview:bubbleImageView];
    
    isSuccess=YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
