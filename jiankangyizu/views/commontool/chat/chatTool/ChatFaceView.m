//
//  ChatFaceView.m
//  ViewDeckExample
//
//  Created by apple on 13-4-11.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import "ChatFaceView.h"

@implementation ChatFaceView
@synthesize faceBg,faceView2,faceScroll,faceScroll2,buttonView,sunnyLabel,othersLabel,delegate;

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
    
    UIButton *bg=[UIButton buttonWithType:UIButtonTypeCustom];
    bg.backgroundColor=[UIColor blackColor];
    bg.alpha=0.5;
    [bg addTarget:self action:@selector(disFaceAction) forControlEvents:UIControlEventTouchUpInside];
    bg.frame=CGRectMake(0, 0, kDeviceWidth, [[UIScreen mainScreen] bounds].size.height);
    [self.view addSubview:bg];
    
    //背景图片
    UIImage *bg2=[UIImage imageNamed:@"tb_alert_bg.png"];
    if ([[UIDevice currentDevice].systemVersion doubleValue] > 4.99) {
        UIEdgeInsets insets = UIEdgeInsetsMake(25, 35, 25, 35);
        bg2=[bg2 resizableImageWithCapInsets:insets];
        
    } else {
        bg2=[bg2 stretchableImageWithLeftCapWidth:35 topCapHeight:25];
        
    }
    faceBg=[[UIImageView alloc]initWithFrame:CGRectMake(5, 260, 310, 215)];
    faceBg.image=bg2;
    [self.view addSubview:faceBg];
    
    //表情视图
    faceView2=[[UIView alloc]initWithFrame:CGRectMake(10, 260, 300, 215)];
    faceView2.backgroundColor=[UIColor clearColor];
    [self.view addSubview:faceView2];
    //按钮视图
    buttonView=[[UIView alloc]initWithFrame:CGRectMake(0, 10, 300, 35)];
    buttonView.backgroundColor=[UIColor clearColor];
    [faceView2 addSubview:buttonView];

    
    faceScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 45, 300, 220)];
    faceScroll.backgroundColor=[UIColor clearColor];
    faceScroll.showsVerticalScrollIndicator=NO;
    int x=0;
    int y=0;
    for (int i=1; i<=15; i++) {
        NSString *faceName=@"";
        
        if (i<10) {
            faceName=[NSString stringWithFormat:@"h000%d.png",i];
        }else if(i<100){
            faceName=[NSString stringWithFormat:@"h00%d.png",i];
        }
        
        UIImage *face2=[UIImage imageNamed:faceName];
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(10+x*40, 5+y*45, 37.5, 42.5);
        [button setBackgroundImage:face2 forState:UIControlStateNormal];
        button.tag=i;
        [button addTarget:self action:@selector(selectFace:) forControlEvents:UIControlEventTouchUpInside];
        [faceScroll addSubview:button];
        
        x++;
        if (x==7) {
            x=0;
            y++;
        }
        
    }
    
    [faceScroll setContentSize:CGSizeMake(300, (y+1)*42.5)];
    [faceView2 addSubview:faceScroll];
    [self othersAction];
    
}

-(void)sunnyAction{
    if (faceScroll2) {
        faceScroll2.hidden=YES;
    }
    faceScroll.hidden=NO;
    sunny.selected=YES;
    others.selected=NO;
    sunnyLabel.textColor=[UIColor whiteColor];
    othersLabel.textColor=[UIColor blackColor];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.382];
    faceBg.frame=CGRectMake(5, 260, 310, 215);
    faceView2.frame=CGRectMake(10, 260, 300, 215);
    [UIView commitAnimations];
    
}

-(void)othersAction{
    if (faceScroll2==nil) {
        faceScroll2=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 45, 300, 335)];
        faceScroll2.backgroundColor=[UIColor clearColor];
        faceScroll2.showsVerticalScrollIndicator=NO;
        int x=0;
        int y=0;
        for (int i=1; i<=90; i++) {
            NSString *faceName=@"";
            
            if (i<10) {
                faceName=[NSString stringWithFormat:@"h00%d.png",i];
            }else if(i<100){
                faceName=[NSString stringWithFormat:@"h0%d.png",i];
            }else{
                faceName=[NSString stringWithFormat:@"h%d.png",i];
            }
            UIImage *face2=[UIImage imageNamed:faceName];
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=CGRectMake(5+x*32, 5+y*32, 32, 32);
            [button setBackgroundImage:face2 forState:UIControlStateNormal];
            button.tag=i;
            [button addTarget:self action:@selector(selectFace2:) forControlEvents:UIControlEventTouchUpInside];
            [faceScroll2 addSubview:button];
            x++;
            if (x==9) {
                x=0;
                y++;
            }
        }
        [faceScroll2 setContentSize:CGSizeMake(300, (y)*32)];
        [faceView2 addSubview:faceScroll2];
    }
    sunny.selected=NO;
    others.selected=YES;
    faceScroll2.hidden=NO;
    faceScroll.hidden=YES;
    sunnyLabel.textColor=[UIColor blackColor];
    othersLabel.textColor=[UIColor whiteColor];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.382];
    faceBg.frame=CGRectMake(5, 90, 310, 385);
    faceView2.frame=CGRectMake(10, 90, 310, 385);
    [UIView commitAnimations];
    
    
}

-(void)selectFace:(id)sender{
    UIButton *btn=(UIButton *)sender;
    NSString *faceName=@"";
    int i=btn.tag;
    if (i<10) {
        faceName=[NSString stringWithFormat:@"[y00%d]",i];
    }else if(i<100){
        faceName=[NSString stringWithFormat:@"[y0%d]",i];
    }
    [delegate selectFace:faceName];
}

-(void)selectFace2:(id)sender{
    UIButton *btn=(UIButton *)sender;
    NSString *faceName=@"";
    int i=btn.tag;
    if (i<10) {
        faceName=[NSString stringWithFormat:@"[h00%d]",i];
    }else if(i<100){
        faceName=[NSString stringWithFormat:@"[h0%d]",i];
    }else{
        faceName=[NSString stringWithFormat:@"[h%d]",i];
        
    }
    [delegate selectFace:faceName];
}

-(void)disFaceAction{
    [delegate disFaceAction];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


@end
